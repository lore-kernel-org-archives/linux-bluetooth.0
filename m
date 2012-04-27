Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/9] tools: Fix tab misuse
Date: Fri, 27 Apr 2012 10:36:45 -0400
Message-Id: <1335537412-26478-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1335537412-26478-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1335537412-26478-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/hciattach_ath3k.c |    2 +-
 tools/sdptool.c         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/hciattach_ath3k.c b/tools/hciattach_ath3k.c
index 803cf46..23208c6 100644
--- a/tools/hciattach_ath3k.c
+++ b/tools/hciattach_ath3k.c
@@ -900,7 +900,7 @@ int ath3k_post(int fd, int pm)
 	}
 
 	/* send vendor specific command with Sleep feature Enabled */
-	if (hci_send_cmd(dd, OGF_VENDOR_CMD, HCI_SLEEP_CMD_OCF,	1, &pm) < 0)
+	if (hci_send_cmd(dd, OGF_VENDOR_CMD, HCI_SLEEP_CMD_OCF, 1, &pm) < 0)
 		perror("PM command failed, power management Disabled");
 
 	nanosleep(&tm, NULL);
diff --git a/tools/sdptool.c b/tools/sdptool.c
index db9ac0d..4e9da64 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -3468,7 +3468,7 @@ static int add_gatt(sdp_session_t *session, svc_info_t *si)
 
 	ret = sdp_device_record_register(session, &interface, &record,
 							SDP_RECORD_PERSIST);
-	if (ret	< 0)
+	if (ret < 0)
 		printf("Service Record registration failed\n");
 	else
 		printf("Generic Attribute Profile Service registered\n");
-- 
1.7.5.4

