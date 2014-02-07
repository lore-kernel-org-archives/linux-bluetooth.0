Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] amptest: Fix memory leak
Date: Fri,  7 Feb 2014 19:28:44 -0300
Message-Id: <1391812125-19594-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1391812125-19594-1-git-send-email-andre.guedes@openbossa.org>
References: <1391812125-19594-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/amptest.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/tools/amptest.c b/tools/amptest.c
index 16f15bc..6192f7e 100644
--- a/tools/amptest.c
+++ b/tools/amptest.c
@@ -496,6 +496,7 @@ static bool find_amp_controller(void)
 	struct hci_dev_list_req *dl;
 	struct hci_dev_req *dr;
 	int fd, i;
+	bool result;
 
 	fd = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);
 	if (fd < 0) {
@@ -515,8 +516,8 @@ static bool find_amp_controller(void)
 
 	if (ioctl(fd, HCIGETDEVLIST, (void *) dl) < 0) {
 		perror("Failed to get HCI device list");
-		close(fd);
-		return false;
+		result = false;
+		goto done;
 	}
 
 	for (i = 0; i< dl->dev_num; i++) {
@@ -541,9 +542,12 @@ static bool find_amp_controller(void)
 		}
 	}
 
-	close(fd);
+	result = true;
 
-	return true;
+done:
+	free(dl);
+	close(fd);
+	return result;
 }
 
 int main(int argc ,char *argv[])
-- 
1.8.5.3

