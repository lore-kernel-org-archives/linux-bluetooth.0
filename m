Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 2/4] monitor: add config_file parser
Date: Tue, 12 Jun 2012 23:59:49 -0300
Message-Id: <1339556391-14637-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1339556391-14637-1-git-send-email-gustavo@padovan.org>
References: <1339556391-14637-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

parse_config() returns a list with the filter data for each controller
entry.
---
 Makefile.tools        |    5 +-
 monitor/config_file.c |  326 +++++++++++++++++++++++++++++++++++++++++++++++++
 monitor/config_file.h |   30 +++++
 monitor/list.c        |   44 +++++++
 monitor/list.h        |   32 +++++
 monitor/main.c        |    9 +-
 monitor/packet.h      |    7 +-
 7 files changed, 449 insertions(+), 4 deletions(-)
 create mode 100644 monitor/config_file.c
 create mode 100644 monitor/config_file.h
 create mode 100644 monitor/list.c
 create mode 100644 monitor/list.h

diff --git a/Makefile.tools b/Makefile.tools
index c93b263..641ae1c 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -60,7 +60,10 @@ monitor_btmon_SOURCES = monitor/main.c monitor/bt.h \
 					monitor/hcidump.h monitor/hcidump.c \
 					monitor/btsnoop.h monitor/btsnoop.c \
 					monitor/control.h monitor/control.c \
-					monitor/packet.h monitor/packet.c
+					monitor/packet.h monitor/packet.c \
+					monitor/config_file.h \
+					monitor/config_file.c \
+					monitor/list.h monitor/list.c
 monitor_btmon_LDADD = lib/libbluetooth-private.la
 
 emulator_btvirt_SOURCES = emulator/main.c monitor/bt.h \
diff --git a/monitor/config_file.c b/monitor/config_file.c
new file mode 100644
index 0000000..5ebbeae
--- /dev/null
+++ b/monitor/config_file.c
@@ -0,0 +1,326 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Collabora Ltd.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <stdio.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <string.h>
+#include <fcntl.h>
+#include <errno.h>
+
+#include <ctype.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <time.h>
+#include <sys/time.h>
+
+#include "config_file.h"
+#include "packet.h"
+
+#define TS_MASK	(PACKET_FILTER_SHOW_DATE | PACKET_FILTER_SHOW_TIME)
+
+#define error(fmt ,l, arg...) \
+		fprintf(stderr, "line %d: error: " fmt "\n",l, ## arg)
+
+#define SPACE " \n\t\r,"
+
+enum keyword_code {
+	OP_CONTROLLER,
+	OP_IGNORE,
+	OP_SHOW,
+	OP_HIDE,
+	OP_TIMESTAMPS,
+	OP_ERROR,
+};
+
+static struct keyword {
+	const char *string;
+	int code;
+} kw[] = {
+	{ "Controller",	OP_CONTROLLER	},
+	{ "Ignore",	OP_IGNORE	},
+	{ "Show",	OP_SHOW		},
+	{ "Hide",	OP_HIDE		},
+	{ "Timestamps",	OP_TIMESTAMPS	},
+	{ NULL,		OP_ERROR	}
+};
+
+static struct filter_options {
+	const char *string;
+	int bit;
+} filters[] = {
+	{ "HCI",	PACKET_FILTER_SHOW_HCI	},
+	{ "L2CAP",	PACKET_FILTER_SHOW_ACL	},
+	{ "SCO",	PACKET_FILTER_SHOW_SCO	},
+	{ NULL,		0			}
+};
+
+struct controller *controller;
+
+static void controllers_list_free(struct list *controllers_l)
+{
+	struct list *l, *tmp;
+
+	if (!controllers_l)
+		return;
+
+	for (l = controllers_l->next ; l != controllers_l ; ) {
+		tmp = l;
+
+		list_del(l);
+		l = l->next;
+
+		free(tmp->controller->value);
+		free(tmp->controller);
+		free(tmp);
+	}
+
+	free(controllers_l);
+}
+
+static char *find_token(char *line)
+{
+	int n;
+
+	if (line == NULL)
+		return NULL;
+
+	line += strspn(line, SPACE);
+	if (line[0] == '\0' || line[0] == '\n' || line[0] == '\r')
+		return NULL;
+
+	n = strcspn(line, SPACE);
+	if (n == 0)
+		return NULL;
+
+	line[n] = '\0';
+
+	return line;
+}
+
+static int create_controller(struct list *controllers_l, char *c)
+{
+	struct list *l;
+
+	l = calloc(1, sizeof(*l));
+	if (!l)
+		return -ENOMEM;
+
+	l->controller = calloc(1, sizeof(*l->controller));
+	if (!l->controller) {
+		free(l);
+		return -ENOMEM;
+	}
+
+	l->controller->value = strdup(c);
+
+	l->controller->filter = ~0UL;
+
+	list_append(controllers_l, l);
+
+	controller = l->controller;
+
+	return 0;
+}
+
+static int get_filter(char *s, unsigned long *f, int line)
+{
+	int i, found;
+
+	*f = 0L;
+
+	s = find_token(s + strlen(s) + 1);
+	if (!s)
+		error("no options specified", line);
+
+	do {
+		found = 0;
+		for (i = 0 ; filters[i].string ; i++) {
+			if (!strcasecmp(s, filters[i].string)) {
+				found = 1;
+				break;
+			}
+		}
+
+		if (!found) {
+			error("invalid filter parameter: %s", line, s);
+			return -EINVAL;
+		}
+
+		*f |= filters[i].bit;
+		s = find_token(s + strlen(s) + 1);
+	} while(s);
+
+	return 0;
+}
+
+static int parse_on_off(char *c, int line)
+{
+	char *state;
+	int ret;
+
+	state = find_token(c + strlen(c) + 1);
+	if (!strcasecmp(state, "on")) {
+		ret = 1;
+	} else if (!strcasecmp(state, "off")) {
+		ret = 0;
+	} else {
+		error("parameter should be 'on' or 'off'", line);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int process_keyword(struct list *controllers_l, char *key, int line)
+{
+	char *value;
+	unsigned long filter;
+	int i, v, err;
+
+	for (i = 0 ; kw[i].string ; i++) {
+		if (!strcasecmp(key, kw[i].string))
+			break;
+	}
+
+	if ((kw[i].code != OP_CONTROLLER) && !controller) {
+		error("no controller specified", line);
+		return -EINVAL;
+	}
+
+	err = 0;
+	switch (kw[i].code) {
+	case OP_CONTROLLER:
+		value = find_token(key + strlen(key) + 1);
+		if (!value) {
+			error("missing expected paramenter for 'Controller'",
+									line);
+			return -EINVAL;
+		}
+
+		err = create_controller(controllers_l, value);
+		break;
+	case OP_IGNORE:
+		controller->ignore = 1;
+		break;
+	case OP_SHOW:
+		if ((controller->filter | TS_MASK) != ~0UL) {
+			error("'Hide' option was specified, can't set 'Show'",
+									line);
+			return -EINVAL;
+		}
+
+		err = get_filter(key, &filter, line);
+		if (err)
+			return err;
+
+		controller->filter &= (0L | TS_MASK);
+
+		controller->filter |= filter;
+
+		break;
+
+	case OP_HIDE:
+		if ((controller->filter | TS_MASK) != ~0UL) {
+			error("'Show' option was specified, can't set 'Hide'",
+									line);
+			return -EINVAL;
+		}
+
+		err = get_filter(key, &filter, line);
+		if (err)
+			return err;
+
+		controller->filter &= ~filter;
+
+		break;
+	case OP_TIMESTAMPS:
+		v = parse_on_off(key, line);
+		if (v < 0)
+			return v;
+
+		if (v == 0)
+			controller->filter &= ~(PACKET_FILTER_SHOW_DATE |
+						PACKET_FILTER_SHOW_TIME);
+
+		break;
+	case OP_ERROR:
+		error("string not recognized: '%s'", line, key);
+		return -EINVAL;
+	}
+
+	return err;
+}
+
+struct list *parse_config(char *file)
+{
+	FILE *f;
+	struct stat s;
+	int line;
+	char buf[1024];
+	struct list *controllers_l;
+
+	if (stat(file, &s) < 0) {
+		fprintf(stderr, "failed to get file status '%s' (%d)\n", file,
+									errno);
+		return NULL;
+
+	}
+
+	f = fopen(file, "r");
+	if (!f) {
+		fprintf(stderr, "failed to open filter file '%s' (%d)\n", file,
+									errno);
+		return NULL;
+	}
+
+	/*Allocate list head */
+	controllers_l = calloc(1, sizeof(*controllers_l));
+	if (!controllers_l)
+		goto error;
+
+	list_init(controllers_l);
+
+	line = 1;
+	memset(buf, 0, sizeof(buf));
+	while (fgets(buf, sizeof(buf), f)) {
+		char *key = find_token(buf);
+
+		if (key && key[0] != '#') {
+			if (process_keyword(controllers_l, key, line) < 0)
+				goto error;
+		}
+
+		line++;
+		memset(buf, 0, sizeof(buf));
+	}
+
+	fclose(f);
+	return controllers_l;
+
+error:
+	controllers_list_free(controllers_l);
+	fclose(f);
+	return NULL;
+}
+
diff --git a/monitor/config_file.h b/monitor/config_file.h
new file mode 100644
index 0000000..9190e01
--- /dev/null
+++ b/monitor/config_file.h
@@ -0,0 +1,30 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Collabora Ltd.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+struct controller {
+	char *value;
+	unsigned long filter;
+	int ignore:1;
+};
+
+struct list *parse_config(char *file);
diff --git a/monitor/list.c b/monitor/list.c
new file mode 100644
index 0000000..8ac4647
--- /dev/null
+++ b/monitor/list.c
@@ -0,0 +1,44 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Collabora Ltd.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include "list.h"
+
+void list_init(struct list *l)
+{
+	l->next = l;
+	l->prev = l;
+}
+
+void list_append(struct list *head, struct list *l)
+{
+	l->next = head;
+	l->prev = head->prev;
+	head->prev->next = l;
+	head->prev = l;
+}
+
+void list_del(struct list *l)
+{
+	l->next->prev = l->prev;
+	l->prev->next = l->next;
+}
diff --git a/monitor/list.h b/monitor/list.h
new file mode 100644
index 0000000..046811c
--- /dev/null
+++ b/monitor/list.h
@@ -0,0 +1,32 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012  Collabora Ltd.
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+struct list {
+	struct list *next;
+	struct list *prev;
+	struct controller *controller;
+};
+
+void list_init(struct list *l);
+void list_append(struct list *head, struct list *l);
+void list_del(struct list *l);
diff --git a/monitor/main.c b/monitor/main.c
index 90e32c5..1379839 100644
--- a/monitor/main.c
+++ b/monitor/main.c
@@ -35,6 +35,7 @@
 #include "control.h"
 #include "hcidump.h"
 #include "btsnoop.h"
+#include "config_file.h"
 
 static void signal_callback(int signum, void *user_data)
 {
@@ -52,11 +53,13 @@ static void usage(void)
 		"Usage:\n");
 	printf("\tbtmon [options]\n");
 	printf("options:\n"
+		"\t-f, --filter <file>   Filter file\n"
 		"\t-b, --btsnoop <file>  Save dump in btsnoop format\n"
 		"\t-h, --help            Show help options\n");
 }
 
 static const struct option main_options[] = {
+	{ "filter",	required_argument, NULL, 'f'	},
 	{ "btsnoop",	required_argument, NULL, 'b'	},
 	{ "version",	no_argument,	   NULL, 'v'	},
 	{ "help",	no_argument,	   NULL, 'h'	},
@@ -73,11 +76,15 @@ int main(int argc, char *argv[])
 	for (;;) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "bvh", main_options, NULL);
+		opt = getopt_long(argc, argv, "f:bvh", main_options, NULL);
 		if (opt < 0)
 			break;
 
 		switch (opt) {
+		case 'f':
+			if (!parse_config(optarg))
+				return EXIT_FAILURE;
+			break;
 		case 'b':
 			btsnoop_open(optarg);
 			break;
diff --git a/monitor/packet.h b/monitor/packet.h
index 4c8b698..c8d011d 100644
--- a/monitor/packet.h
+++ b/monitor/packet.h
@@ -29,8 +29,11 @@
 #define PACKET_FILTER_SHOW_INDEX	(1 << 0)
 #define PACKET_FILTER_SHOW_DATE		(1 << 1)
 #define PACKET_FILTER_SHOW_TIME		(1 << 2)
-#define PACKET_FILTER_SHOW_ACL_DATA	(1 << 3)
-#define PACKET_FILTER_SHOW_SCO_DATA	(1 << 4)
+#define PACKET_FILTER_SHOW_HCI		(1 << 3)
+#define PACKET_FILTER_SHOW_ACL		(1 << 4)
+#define PACKET_FILTER_SHOW_SCO		(1 << 5)
+#define PACKET_FILTER_SHOW_ACL_DATA	(1 << 6)
+#define PACKET_FILTER_SHOW_SCO_DATA	(1 << 7)
 
 void packet_set_filter(unsigned long filter);
 
-- 
1.7.10.2

