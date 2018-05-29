Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/shell: Disable argument count check if optarg are detected
Date: Tue, 29 May 2018 11:31:43 +0300
Message-Id: <20180529083143.31359-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Command which start with optional arguments might be using optargs
format in which case checking argument count check does not work so
this disables it which shall make things btmgmt work:

[mgmt]# add-adv --help
Usage: add-adv [options] <instance_id>
Options:
	 -u, --uuid <uuid>         Service UUID
	 -d, --adv-data <data>     Advertising Data bytes
	 -s, --scan-rsp <data>     Scan Response Data bytes
	 -t, --timeout <timeout>   Timeout in seconds
	 -D, --duration <duration> Duration in seconds
	 -c, --connectable         "connectable" flag
	 -g, --general-discov      "general-discoverable" flag
	 -l, --limited-discov      "limited-discoverable" flag
	 -n, --scan-rsp-local-name "local-name" flag
	 -a, --scan-rsp-appearance "appearance" flag
	 -m, --managed-flags       "managed-flags" flag
	 -p, --tx-power            "tx-power" flag
e.g.:
	add-adv -u 180d -u 180f -d 080954657374204C45 1
[mgmt]# add-adv -u 180d -u 180f -d 080954657374204C45 1
Instance added: 1
---
 src/shared/shell.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/shared/shell.c b/src/shared/shell.c
index e7f17e021..97d91577e 100644
--- a/src/shared/shell.c
+++ b/src/shared/shell.c
@@ -295,6 +295,7 @@ static int cmd_exec(const struct bt_shell_menu_entry *entry,
 	size_t len;
 	char *man, *opt;
 	int flags = WRDE_NOCMD;
+	bool optargs = false;
 
 	if (!entry->arg || entry->arg[0] == '\0') {
 		if (argc > 1) {
@@ -323,6 +324,7 @@ static int cmd_exec(const struct bt_shell_menu_entry *entry,
 			goto optional;
 		}
 		man = strndup(opt, man - opt + 1);
+		optargs = true;
 	}
 
 	if (parse_args(man, &w, "<>", flags) < 0) {
@@ -355,7 +357,7 @@ optional:
 	free(opt);
 
 	/* Check if there are too many arguments */
-	if ((unsigned) argc - 1 > w.we_wordc && !w.we_offs) {
+	if (!optargs && ((unsigned int) argc - 1 > w.we_wordc && !w.we_offs)) {
 		print_text(COLOR_HIGHLIGHT, "Too many arguments: %d > %zu",
 					argc - 1, w.we_wordc);
 		goto fail;
-- 
2.17.0

