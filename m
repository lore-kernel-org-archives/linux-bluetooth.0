Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] cltest: Fix memory leak
Date: Fri,  7 Feb 2014 19:28:43 -0300
Message-Id: <1391812125-19594-4-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1391812125-19594-1-git-send-email-andre.guedes@openbossa.org>
References: <1391812125-19594-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/cltest.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/cltest.c b/tools/cltest.c
index 16b7553..4ddb98a 100644
--- a/tools/cltest.c
+++ b/tools/cltest.c
@@ -205,8 +205,8 @@ static bool find_controllers(void)
 	dl = malloc(HCI_MAX_DEV * sizeof(struct hci_dev_req) + sizeof(uint16_t));
 	if (!dl) {
 		perror("Failed allocate HCI device request memory");
-		result = false;
-		goto done;
+		close(fd);
+		return false;
 	}
 
 	dl->dev_num = HCI_MAX_DEV;
@@ -243,6 +243,7 @@ static bool find_controllers(void)
 	}
 
 done:
+	free(dl);
 	close(fd);
 	return result;
 }
-- 
1.8.5.3

