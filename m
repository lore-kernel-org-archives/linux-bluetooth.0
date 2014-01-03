Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] btinfo: Add missing socket close() on exit
Date: Fri,  3 Jan 2014 14:54:44 +0200
Message-Id: <1388753686-29400-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 tools/btinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/btinfo.c b/tools/btinfo.c
index 0f0dfad..aa4df5a 100644
--- a/tools/btinfo.c
+++ b/tools/btinfo.c
@@ -359,6 +359,8 @@ int main(int argc, char *argv[])
 
 			if (ioctl(fd, HCIDEVDOWN, hci_info.dev_id) < 0)
 				perror("Failed to power down controller");
+
+			close(fd);
 		}
 	}
 
-- 
1.8.3.2

