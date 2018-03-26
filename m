Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 5/6] tools/btmgmt: Return exit status for
 non-interactive
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <5ebabd54-eae8-a7d1-2c22-ffedca75d6f3@jp.fujitsu.com>
Message-ID: <3dba57ce-c82e-274d-df5b-a2a82aa03c14@jp.fujitsu.com>
Date: Mon, 26 Mar 2018 17:31:11 +0900
MIME-Version: 1.0
In-Reply-To: <5ebabd54-eae8-a7d1-2c22-ffedca75d6f3@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btmgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 122c46d0d..f60bb8b53 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -4416,7 +4416,7 @@ int main(int argc, char *argv[])
 
 	bt_shell_attach(fileno(stdin));
 	update_prompt(mgmt_index);
-	bt_shell_run();
+	status = bt_shell_run();
 
 	mgmt_cancel_all(mgmt);
 	mgmt_unregister_all(mgmt);
-- 
2.14.1

