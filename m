Return-Path: <cyrus@holtmann.org>
From: Anton Weber <ant@antweb.me>
To: linux-bluetooth@vger.kernel.org
Cc: Anton Weber <ant@antweb.me>
Subject: [PATCH BlueZ 4/4] replay: Add config file parser and skip action
Date: Thu,  9 Aug 2012 19:36:13 +0200
Message-Id: <1344533773-12914-4-git-send-email-ant@antweb.me>
In-Reply-To: <1344533773-12914-1-git-send-email-ant@antweb.me>
References: <1344533773-12914-1-git-send-email-ant@antweb.me>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for config files to manipulate the loaded sequence.
A config file can be specified with the new -c command line parameter.

The config syntax is:
scope attr=value[,attr=value,...]

e.g.:
all delta=300,action=replay
1-4 action=emulate
1 delta=500
HCI_EVT_0x0e delta=0
HCI_CMD_0x03|0x0003 action=emulate
HCI_ACL action=replay

The inital version supports the attributes delta and action and
all scope types shown in the example.

HCISEQ_ACTION_SKIP allows to skip a packet in the sequence.
The action can be set in config files using "action=skip".
---
 Makefile.tools               |    1 +
 tools/replay/config-parser.c |  506 ++++++++++++++++++++++++++++++++++++++++++
 tools/replay/config-parser.h |   36 +++
 tools/replay/hciseq.h        |    3 +-
 tools/replay/main.c          |  117 +++++++++-
 tools/replay/main.h          |    2 -
 6 files changed, 661 insertions(+), 4 deletions(-)
 create mode 100644 tools/replay/config-parser.c
 create mode 100644 tools/replay/config-parser.h

diff --git a/Makefile.tools b/Makefile.tools
index 8b3c8d8..ba2db00 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -72,6 +72,7 @@ emulator_btvirt_SOURCES = emulator/main.c monitor/bt.h \
 tools_replay_btreplay_SOURCES = tools/replay/main.h tools/replay/main.c \
 					tools/replay/hciseq.h tools/replay/hciseq.c \
 					tools/replay/time.h tools/replay/time.c \
+					tools/replay/config-parser.h tools/replay/config-parser.c \
 					monitor/packet.h monitor/packet.c \
 					monitor/btsnoop.h monitor/btsnoop.c \
 					monitor/control.h monitor/control.c \
diff --git a/tools/replay/config-parser.c b/tools/replay/config-parser.c
new file mode 100644
index 0000000..5219eb9
--- /dev/null
+++ b/tools/replay/config-parser.c
@@ -0,0 +1,506 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *  Copyright (C) 2012       Anton Weber <ant@antweb.me>
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
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
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <sys/time.h>
+
+#include "config-parser.h"
+#include "lib/bluetooth.h"
+#include "lib/hci.h"
+#include "monitor/bt.h"
+
+#define MAXLINE 128
+#define MAX_ATTR_KEY 32
+#define MAX_ATTR_VAL 32
+
+static struct hciseq_list *seq;
+static struct hciseq_type_cfg *type_cfg;
+
+static bool verbose;
+static int line;
+
+struct scope_list {
+	struct scope_node *head;
+};
+
+struct scope_node {
+	int pos;
+	struct hciseq_attr *attr;
+	struct scope_node *next;
+};
+
+struct attr_list {
+	struct attr_node *head;
+};
+
+struct attr_node {
+	char key[MAX_ATTR_KEY];
+	char val[MAX_ATTR_VAL];
+	struct attr_node *next;
+};
+
+static void attr_list_delete(struct attr_list *list)
+{
+	struct attr_node *node, *next;
+
+	if (list == NULL)
+		return;
+
+	node = list->head;
+	free(list);
+	while (node != NULL) {
+		next = node->next;
+		free(node);
+		node = next;
+	}
+}
+
+static void scope_list_delete(struct scope_list *list)
+{
+	struct scope_node *node, *next;
+
+	if (list == NULL)
+		return;
+
+	node = list->head;
+	free(list);
+	while (node != NULL) {
+		next = node->next;
+		free(node);
+		node = next;
+	}
+}
+
+static struct attr_list *parse_attrstr(char *attrstr)
+{
+	struct attr_list *list = NULL;
+	struct attr_node *node;
+	char *res;
+
+	do {
+		if (list == NULL) {
+			if ((res = strtok(attrstr, "=")) == NULL) {
+				/* nothing to parse */
+				return NULL;
+			}
+
+			list = malloc(sizeof(*list));
+			node = malloc(sizeof(*node));
+			list->head = node;
+		} else {
+			if ((res = strtok(NULL, "=")) == NULL) {
+				/* nothing left to parse */
+				break;
+			}
+
+			node->next = malloc(sizeof(*node));
+			node = node->next;
+		}
+
+		strncpy(node->key, res, sizeof(node->key));
+		node->key[sizeof(node->key) - 1] = '\0';
+
+		if ((res = strtok(NULL, ",")) == NULL) {
+			fprintf(stderr, "Invalid attribute");
+			goto err;
+		}
+		strncpy(node->val, res, sizeof(node->val));
+		node->val[sizeof(node->val) - 1] = '\0';
+
+		node->next = NULL;
+	} while (res != NULL);
+
+	return list;
+
+err:
+	attr_list_delete(list);
+	return NULL;
+}
+
+static int apply_attr(struct scope_node *scope_node,
+		      struct attr_list *list)
+{
+	struct attr_node *attr_node = list->head;
+	struct hciseq_attr *attr = scope_node->attr;
+	long lval;
+
+	while (attr_node != NULL) {
+		if (strcmp(attr_node->key, "delta") == 0) {
+			/* delta */
+			lval = strtol(attr_node->val, NULL, 10);
+			if (errno == ERANGE || errno == EINVAL)
+				return 1;
+
+			if (verbose) {
+				printf("\t[%d] set delta to %ld\n",
+				       scope_node->pos, lval);
+			}
+
+			attr->ts_diff.tv_sec = 0;
+			attr->ts_diff.tv_usec = lval;
+		} else if (strcmp(attr_node->key, "action") == 0) {
+			/* action */
+			if (strcmp(attr_node->val, "replay") == 0) {
+				lval = HCISEQ_ACTION_REPLAY;
+				if (verbose)
+					printf("\t[%d] set action to 'replay'\n",
+					     scope_node->pos);
+			} else if (strcmp(attr_node->val, "emulate") == 0) {
+				lval = HCISEQ_ACTION_EMULATE;
+				if (verbose)
+					printf("\t[%d] set action to 'emulate'\n",
+					     scope_node->pos);
+			} else if (strcmp(attr_node->val, "skip") == 0) {
+				lval = HCISEQ_ACTION_SKIP;
+				if (verbose)
+					printf("\t[%d] set action to 'skip'\n",
+					     scope_node->pos);
+			} else {
+				return 1;
+			}
+
+			attr->action = lval;
+		}
+
+		attr_node = attr_node->next;
+	}
+
+	return 0;
+}
+
+static int apply_attr_scope(struct scope_list *scope,
+			    struct attr_list *attr)
+{
+	struct scope_node *node = scope->head;
+
+	while (node != NULL) {
+		apply_attr(node, attr);
+		node = node->next;
+	}
+
+	return 0;
+}
+
+static struct scope_list *get_scope_range(int from, int to)
+{
+	struct scope_list *list = NULL;
+	struct scope_node *scope_node;
+	struct hciseq_node *seq_node = seq->current;
+	int pos = 1;
+
+	/* forward to 'from' */
+	while (pos < from) {
+		seq_node = seq_node->next;
+		pos++;
+	}
+
+	/* create scope list for range */
+	while (pos <= to) {
+		if (verbose)
+			printf("\tadd packet [%d]\n", pos);
+
+		if (list == NULL) {
+			list = malloc(sizeof(*list));
+			scope_node = malloc(sizeof(*scope_node));
+			list->head = scope_node;
+		} else {
+			scope_node->next = malloc(sizeof(*scope_node));
+			scope_node = scope_node->next;
+		}
+		scope_node->attr = seq_node->attr;
+		scope_node->pos = pos;
+		scope_node->next = NULL;
+
+		seq_node = seq_node->next;
+		pos++;
+	}
+
+	return list;
+}
+
+static struct scope_list *get_scope_type(uint8_t type, void *filter1,
+					 void *filter2)
+{
+	struct scope_list *list = NULL;
+	struct scope_node *scope_node;
+	struct hciseq_node *seq_node = seq->current;
+	uint16_t opcode, node_opcode;
+	uint8_t node_ogf, ogf = 0x00;
+	uint16_t node_ocf, ocf = 0x0000;
+	uint8_t node_evt, evt = 0x00;
+	bool match;
+	int pos = 1;
+	struct hciseq_attr *attr;
+
+	if (type == BT_H4_CMD_PKT) {
+		ogf = *((uint8_t *) filter1);
+		ocf = *((uint16_t *) filter2);
+		opcode = cmd_opcode_pack(ogf, ocf);
+
+		if (opcode > 0x2FFF) {
+			attr = NULL;
+		} else {
+			attr = type_cfg->cmd[opcode];
+			if (attr == NULL) {
+				attr = malloc(sizeof(*attr));
+				type_cfg->cmd[opcode] = attr;
+			}
+		}
+	} else if (type == BT_H4_EVT_PKT) {
+		evt = *((uint8_t *) filter1);
+		attr = type_cfg->evt[evt];
+
+		if (attr == NULL) {
+			attr = malloc(sizeof(*attr));
+			type_cfg->evt[evt] = attr;
+		}
+	} else if (type == BT_H4_ACL_PKT) {
+		attr = type_cfg->acl;
+		if (attr == NULL) {
+			attr = malloc(sizeof(*attr));
+			type_cfg->acl = attr;
+		}
+	} else {
+		attr = NULL;
+	}
+
+	/* add matching packets in sequence */
+	while (seq_node != NULL) {
+		match = false;
+		if (((uint8_t *) seq_node->frame->data)[0] == type) {
+			if (type == BT_H4_CMD_PKT) {
+				node_opcode = *((uint16_t *)
+						(seq_node->frame->data + 1));
+				node_ogf = cmd_opcode_ogf(node_opcode);
+				node_ocf = cmd_opcode_ocf(node_opcode);
+				if (node_ogf == ogf && node_ocf == ocf)
+					match = true;
+			} else if (type == BT_H4_EVT_PKT) {
+				node_evt = ((uint8_t *) seq_node->frame->data)[1];
+				if (evt == node_evt)
+					match = true;
+			} else if (type == BT_H4_ACL_PKT) {
+				match = true;
+			}
+		}
+
+		if (match) {
+			if (verbose)
+				printf("\tadd packet [%d]\n", pos);
+
+			if (list == NULL) {
+				list = malloc(sizeof(*list));
+				scope_node = malloc(sizeof(*scope_node));
+				list->head = scope_node;
+			} else {
+				scope_node->next = malloc(sizeof(*scope_node));
+				scope_node = scope_node->next;
+			}
+			scope_node->attr = seq_node->attr;
+			scope_node->pos = pos;
+			scope_node->next = NULL;
+		}
+		seq_node = seq_node->next;
+		pos++;
+	}
+
+	/* add type config */
+	if (attr != NULL) {
+		if (list == NULL) {
+			list = malloc(sizeof(*list));
+			scope_node = malloc(sizeof(*scope_node));
+			list->head = scope_node;
+		} else {
+			scope_node->next = malloc(sizeof(*scope_node));
+			scope_node = scope_node->next;
+		}
+
+		scope_node->attr = attr;
+		scope_node->pos = 0;
+		scope_node->next = NULL;
+	}
+
+	return list;
+}
+
+static int parse_line(char *buf)
+{
+	char *scopestr, *attrstr;
+	struct scope_list *scope_list = NULL;
+	struct attr_list *attr_list;
+	uint8_t evt, ogf;
+	uint16_t ocf;
+	char *res;
+	int from, to;
+
+	line++;
+
+	/* split line into scope and attributes */
+	if ((scopestr = strtok(buf, " ")) == NULL)
+		return 1;
+
+	if ((attrstr = strtok(NULL, "\n")) == NULL)
+		return 1;
+
+	if (verbose)
+		printf("Parsing scope (%s)\n", scopestr);
+
+	if (strcmp(scopestr, "all") == 0) {
+		if (verbose)
+			printf("\tadd all\n");
+
+		scope_list = get_scope_range(0, seq->len);
+	} else if ((strncmp(scopestr, "HCI_", 4) == 0) && strlen(scopestr) >= 7) {
+		/* make sure scopestr is at least 7 chars long, so we can check for HCI_XXX */
+
+		if (strncmp(scopestr + 4, "ACL", 3) == 0) {
+			/* scope is HCI_ACL */
+			if (verbose)
+				printf("\tadd all HCI ACL data packets:");
+
+			scope_list = get_scope_type(BT_H4_ACL_PKT, NULL, NULL);
+		} else if (strncmp(scopestr + 4, "CMD", 3) == 0) {
+			/* scope is HCI_CMD_
+			 * length must be exactly 19 (e.g. HCI_CMD_0x03|0x0003) */
+			if (strlen(scopestr) != 19 || scopestr[12] != '|')
+				return 1;
+
+			if (sscanf(scopestr + 8, "0x%2hhx", &ogf) <= 0)
+				return 1;
+
+			if (sscanf(scopestr + 13, "0x%4hx", &ocf) <= 0)
+				return 1;
+
+			if (verbose)
+				printf("\tadd all HCI command packets with opcode (0x%2.2x|0x%4.4x):\n",
+				     ogf, ocf);
+
+			scope_list = get_scope_type(BT_H4_CMD_PKT, &ogf, &ocf);
+		} else if (strncmp(scopestr + 4, "EVT", 3) == 0) {
+			/* scope is CMD_EVT_
+			 * length must be exactly 12 (e.g. HCI_EVT_0x0e) */
+			if (strlen(scopestr) != 12)
+				return 1;
+
+			if (sscanf(scopestr + 8, "0x%2hhx", &evt) <= 0)
+				return 1;
+
+			if (verbose)
+				printf("\tadd all HCI event packets with event type (0x%2.2x):\n",
+				     evt);
+
+			scope_list = get_scope_type(BT_H4_EVT_PKT, &evt, NULL);
+		}
+	} else if (scopestr[0] >= 48 || scopestr[0] <= 57) {
+		/* first char is a digit */
+		if ((res = strtok(scopestr, "-")) == NULL)
+			return 1;
+
+		from = atoi(res);
+		if (from <= 0)
+			return 1;
+
+		if ((res = strtok(NULL, ":")) == NULL) {
+			/* just one packet */
+			if (verbose)
+				printf("\tadd packet single packet\n");
+
+			scope_list = get_scope_range(from, from);
+		} else {
+			/* range */
+			to = atoi(res);
+			if (to > seq->len)
+				return 1;
+
+			if (verbose)
+				printf("\tadd packets %d to %d\n", from, to);
+
+			scope_list = get_scope_range(from, to);
+		}
+
+	}
+
+	if (verbose)
+		printf("Parsing attributes (%s)\n", attrstr);
+
+	if ((attr_list = parse_attrstr(attrstr)) == NULL) {
+		return 1;
+	}
+
+	if (scope_list != NULL) {
+		apply_attr_scope(scope_list, attr_list);
+		scope_list_delete(scope_list);
+	} else {
+		if (verbose)
+			printf("Empty scope, skipping\n");
+	}
+
+	attr_list_delete(attr_list);
+
+	return 0;
+}
+
+int parse_config(char *path, struct hciseq_list *_seq,
+		 struct hciseq_type_cfg *_type_cfg, bool _verbose)
+{
+	char *buf;
+	FILE *file;
+
+	seq = _seq;
+	type_cfg = _type_cfg;
+	verbose = _verbose;
+	line = 0;
+
+	printf("Reading config file...\n");
+
+	buf = malloc(sizeof(char) * MAXLINE);
+	if (buf == NULL) {
+		fprintf(stderr, "Failed to allocate buffer\n");
+		return 1;
+	}
+
+	if ((file = fopen(path, "r")) == NULL) {
+		perror("Failed to open config file");
+		return 1;
+	}
+
+	while (fgets(buf, MAXLINE, file) != NULL) {
+		if (parse_line(buf)) {
+			fprintf(stderr, "Error parsing config file - line %d\n",
+				line);
+			free(buf);
+			return 1;
+		}
+	}
+
+	printf("Done\n\n");
+	fclose(file);
+	free(buf);
+
+	return 0;
+}
diff --git a/tools/replay/config-parser.h b/tools/replay/config-parser.h
new file mode 100644
index 0000000..265628d
--- /dev/null
+++ b/tools/replay/config-parser.h
@@ -0,0 +1,36 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *  Copyright (C) 2012       Anton Weber <ant@antweb.me>
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
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
+#include "hciseq.h"
+
+struct hciseq_type_cfg {
+	struct hciseq_attr *cmd[9216]; /*
+					 * opcodes 0x0000 - 0x23FF
+					 * (OGF 0x01 - 0x08)
+					 */
+	struct hciseq_attr *evt[256]; /* events 0x00 - 0xFF */
+	struct hciseq_attr *acl;
+};
+
+int parse_config(char *path, struct hciseq_list *_seq,
+		 struct hciseq_type_cfg *_type_cfg, bool _verbose);
diff --git a/tools/replay/hciseq.h b/tools/replay/hciseq.h
index 1454147..fa589a3 100644
--- a/tools/replay/hciseq.h
+++ b/tools/replay/hciseq.h
@@ -43,7 +43,8 @@ struct frame {
 
 enum hciseq_action {
 	HCISEQ_ACTION_REPLAY = 0,
-	HCISEQ_ACTION_EMULATE = 1
+	HCISEQ_ACTION_EMULATE = 1,
+	HCISEQ_ACTION_SKIP = 2
 };
 
 struct hciseq_list {
diff --git a/tools/replay/main.c b/tools/replay/main.c
index f108b25..9763b7a 100644
--- a/tools/replay/main.c
+++ b/tools/replay/main.c
@@ -41,6 +41,7 @@
 
 #include "main.h"
 #include "time.h"
+#include "config-parser.h"
 #include "lib/bluetooth.h"
 #include "lib/hci.h"
 #include "emulator/btdev.h"
@@ -56,6 +57,7 @@
 #define TIMING_DELTA 1
 
 static struct hciseq_list dumpseq;
+static struct hciseq_type_cfg type_cfg;
 
 static int fd;
 static int pos = 1;
@@ -281,6 +283,35 @@ static void btdev_recv(struct frame *frm)
 	btdev_receive_h4(btdev, frm->data, frm->data_len);
 }
 
+static struct hciseq_attr *get_type_attr(struct frame *frm)
+{
+	uint8_t pkt_type = ((const uint8_t *) frm->data)[0];
+	uint16_t opcode;
+	uint8_t evt;
+
+	switch (pkt_type) {
+	case BT_H4_CMD_PKT:
+		opcode = *((uint16_t *) (frm->data + 1));
+		if (opcode > 0x2FFF)
+			return NULL;
+		return type_cfg.cmd[opcode];
+	case BT_H4_EVT_PKT:
+		evt = *((uint8_t *) (frm->data + 1));
+
+		/* use attributes of opcode for 'Command Complete' events */
+		if (evt == 0x0e) {
+			opcode = *((uint16_t *) (frm->data + 4));
+			return type_cfg.cmd[opcode];
+		}
+
+		return type_cfg.evt[evt];
+	case BT_H4_ACL_PKT:
+		return type_cfg.acl;
+	default:
+		return NULL;
+	}
+}
+
 static bool check_match(struct frame *l, struct frame *r, char *msg)
 {
 	uint8_t type_l = ((const uint8_t *) l->data)[0];
@@ -341,6 +372,7 @@ static bool process_in()
 {
 	static struct frame frm;
 	static uint8_t data[HCI_MAX_FRAME_SIZE];
+	struct hciseq_attr *attr;
 	int n;
 	bool match;
 	char msg[MAX_MSG];
@@ -362,6 +394,38 @@ static bool process_in()
 	msg[0] = '\0';
 	match = check_match(dumpseq.current->frame, &frm, msg);
 
+	/* check type config */
+	attr = get_type_attr(&frm);
+	if (attr != NULL) {
+		if (attr->action == HCISEQ_ACTION_SKIP) {
+			if (match) {
+				printf("[%4d/%4d] SKIPPING\n", pos,
+				       dumpseq.len);
+				return 1;
+			} else {
+				printf("[ Unknown ] %s\n            ",
+				       msg);
+				dump_frame(&frm);
+				printf("            SKIPPING\n");
+				return 0;
+			}
+		}
+		if (attr->action == HCISEQ_ACTION_EMULATE) {
+			if (match) {
+				printf("[%4d/%4d] EMULATING\n", pos,
+				       dumpseq.len);
+			} else {
+				printf("[ Unknown ] %s\n            ",
+				       msg);
+				printf("EMULATING\n");
+			}
+
+			btdev_recv(&frm);
+
+			return match;
+		}
+	}
+
 	/* process packet if match */
 	if (match) {
 		printf("[%4d/%4d] ", pos, dumpseq.len);
@@ -381,12 +445,20 @@ static bool process_in()
 static bool process_out()
 {
 	uint8_t pkt_type;
+	struct hciseq_attr *attr;
 
 	/* emulator sends response automatically */
 	if (dumpseq.current->attr->action == HCISEQ_ACTION_EMULATE) {
 		return 1;
 	}
 
+	/* use type config if set */
+	attr = get_type_attr(dumpseq.current->frame);
+	if (attr != NULL) {
+		if (attr->action == HCISEQ_ACTION_SKIP || attr->action == HCISEQ_ACTION_EMULATE)
+			return true;
+	}
+
 	pkt_type = ((const uint8_t *) dumpseq.current->frame->data)[0];
 
 	switch (pkt_type) {
@@ -412,6 +484,15 @@ static void process()
 
 	gettimeofday(&last, NULL);
 	do {
+		if (dumpseq.current->attr->action == HCISEQ_ACTION_SKIP) {
+			printf("[%4d/%4d] SKIPPING\n            ", pos,
+			       dumpseq.len);
+			dump_frame(dumpseq.current->frame);
+			dumpseq.current = dumpseq.current->next;
+			pos++;
+			continue;
+		}
+
 		/* delay */
 		if (timing == TIMING_DELTA) {
 			/* consider exec time of process_out()/process_in() */
@@ -485,6 +566,19 @@ static void delete_list()
 	}
 }
 
+static void delete_type_cfg()
+{
+	int i;
+
+	for (i = 0; i < 12288; i++) {
+		free(type_cfg.cmd[i]);
+	}
+	for (i = 0; i < 256; i++) {
+		free(type_cfg.evt[i]);
+	}
+	free(type_cfg.acl);
+}
+
 static void usage(void)
 {
 	printf("hcireplay - Bluetooth replayer\n"
@@ -493,6 +587,7 @@ static void usage(void)
 	       "\t-d, --timing={none|delta}    Specify timing mode\n"
 	       "\t-m, --factor=<value>         Use timing modifier\n"
 	       "\t-t, --timeout=<value>        Use timeout when receiving\n"
+	       "\t-c, --config=<file>          Use config file\n"
 	       "\t-v, --verbose                Enable verbose output\n"
 	       "\t    --version                Give version information\n"
 	       "\t    --help                   Give a short usage message\n");
@@ -502,6 +597,7 @@ static const struct option main_options[] = {
 	{"timing", required_argument, NULL, 'd'},
 	{"factor", required_argument, NULL, 'm'},
 	{"timeout", required_argument, NULL, 't'},
+	{"config", required_argument, NULL, 'c'},
 	{"verbose", no_argument, NULL, 'v'},
 	{"version", no_argument, NULL, 'V'},
 	{"help", no_argument, NULL, 'H'},
@@ -512,11 +608,12 @@ int main(int argc, char *argv[])
 {
 	int dumpfd;
 	int i;
+	char *config = NULL;
 
 	while (1) {
 		int opt;
 
-		opt = getopt_long(argc, argv, "d:m:t:v",
+		opt = getopt_long(argc, argv, "d:m:t:c:v",
 						main_options, NULL);
 		if (opt < 0)
 			break;
@@ -535,6 +632,9 @@ int main(int argc, char *argv[])
 		case 't':
 			timeout = atoi(optarg);
 			break;
+		case 'c':
+			config = optarg;
+			break;
 		case 'v':
 			verbose = true;
 			break;
@@ -572,6 +672,20 @@ int main(int argc, char *argv[])
 	dumpseq.current = dumpseq.frames;
 	calc_rel_ts(&dumpseq);
 
+	/* init type config */
+	for (i = 0; i < 9216; i++)
+		type_cfg.cmd[i] = NULL;
+	for (i = 0; i < 256; i++)
+		type_cfg.evt[i] = NULL;
+	type_cfg.acl = NULL;
+
+	if (config != NULL) {
+		if (parse_config(config, &dumpseq, &type_cfg, verbose)) {
+			vhci_close();
+			return 1;
+		}
+	}
+
 	/* init emulator */
 	btdev = btdev_create(0);
 	btdev_set_send_handler(btdev, btdev_send, NULL);
@@ -595,6 +709,7 @@ int main(int argc, char *argv[])
 	vhci_close();
 	btdev_destroy(btdev);
 	delete_list();
+	delete_type_cfg();
 	printf("Terminating\n");
 
 	return EXIT_SUCCESS;
diff --git a/tools/replay/main.h b/tools/replay/main.h
index 2223789..e8b7365 100644
--- a/tools/replay/main.h
+++ b/tools/replay/main.h
@@ -23,8 +23,6 @@
  *
  */
 
-#include "hciseq.h"
-
 struct btsnoop_hdr {
 	uint8_t id[8];		/* Identification Pattern */
 	uint32_t version;	/* Version Number = 1 */
-- 
1.7.9.5

