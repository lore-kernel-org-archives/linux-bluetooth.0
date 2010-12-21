Return-Path: <cyrus@holtmann.org>
From: Michal Labedzki <michal.labedzki@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Michal Labedzki <michal.labedzki@tieto.com>
Subject: [PATCH v2 1/3] Filter device name in hciconfig.
Date: Tue, 21 Dec 2010 09:30:58 +0100
Message-ID: <1292920258-28989-1-git-send-email-michal.labedzki@tieto.com>
In-Reply-To: <1292840029-27770-2-git-send-email-michal.labedzki@tieto.com>
References: <1292840029-27770-2-git-send-email-michal.labedzki@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

No anymore work someting like "hciconfig tty1", "hciconfig qfg1" or
"hciconfig hci1hg" as "hci1".
---
 lib/hci.c         |   12 +++++++++++-
 tools/hciconfig.c |   30 +++++++++++++++++++++++++++++-
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/lib/hci.c b/lib/hci.c
index 3304daa..1d33e0e 100644
--- a/lib/hci.c
+++ b/lib/hci.c
@@ -54,6 +54,16 @@ typedef struct {
 	unsigned int val;
 } hci_map;
 
+static int is_number(const char *c)
+{
+	while (*c) {
+		if (!isdigit(*c))
+			return 0;
+		++c;
+	}
+	return 1;
+}
+
 static char *hci_bit2str(hci_map *m, unsigned int val)
 {
 	char *str = malloc(120);
@@ -889,7 +899,7 @@ int hci_devid(const char *str)
 	bdaddr_t ba;
 	int id = -1;
 
-	if (!strncmp(str, "hci", 3) && strlen(str) >= 4) {
+	if (!strncmp(str, "hci", 3) && strlen(str) >= 4 && is_number(str + 3)) {
 		id = atoi(str + 3);
 		if (hci_devba(id, &ba) < 0)
 			return -1;
diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index 995aca1..6d2d1a5 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -1721,6 +1721,33 @@ static void print_dev_info(int ctl, struct hci_dev_info *di)
 	printf("\n");
 }
 
+static int is_number(const char *c)
+{
+	while (*c) {
+		if (!isdigit(*c))
+			return 0;
+		++c;
+	}
+	return 1;
+}
+
+static int dev_name_filter(char *dev_name)
+{
+	int ret;
+
+	if ((strlen(dev_name) >= 4) && (!strncmp(dev_name, "hci", 3)) &&
+			(is_number(dev_name + 3)))
+		ret = atoi(dev_name + 3);
+	else if (is_number(dev_name))
+		ret = atoi(dev_name);
+	else {
+		fprintf(stderr, "No valid device name\n");
+		exit(1);
+	}
+
+	return ret;
+}
+
 static struct {
 	char *cmd;
 	void (*func)(int ctl, int hdev, char *opt);
@@ -1824,7 +1851,8 @@ int main(int argc, char *argv[])
 		exit(0);
 	}
 
-	di.dev_id = atoi(argv[0] + 3);
+	di.dev_id = dev_name_filter(argv[0]);
+
 	argc--; argv++;
 
 	if (ioctl(ctl, HCIGETDEVINFO, (void *) &di)) {
-- 
1.7.0.4

