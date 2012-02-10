Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 20/22] hciconfig: Fix using old-style initializers
Date: Fri, 10 Feb 2012 18:40:05 -0300
Message-Id: <1328910007-25604-21-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/hciconfig.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index a7249db..5d01bd9 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -503,7 +503,7 @@ static void cmd_lm(int ctl, int hdev, char *opt)
 
 static void cmd_aclmtu(int ctl, int hdev, char *opt)
 {
-	struct hci_dev_req dr = { dev_id: hdev };
+	struct hci_dev_req dr = { .dev_id = hdev };
 	uint16_t mtu, mpkt;
 
 	if (!opt)
@@ -523,7 +523,7 @@ static void cmd_aclmtu(int ctl, int hdev, char *opt)
 
 static void cmd_scomtu(int ctl, int hdev, char *opt)
 {
-	struct hci_dev_req dr = { dev_id: hdev };
+	struct hci_dev_req dr = { .dev_id = hdev };
 	uint16_t mtu, mpkt;
 
 	if (!opt)
-- 
1.7.8.1

