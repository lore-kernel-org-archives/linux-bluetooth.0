Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 03/10] emulator: Fix resource leak closing fd
Date: Mon, 11 Aug 2014 10:50:38 +0300
Message-Id: <1407743445-1329-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1407743445-1329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1407743445-1329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 emulator/b1ee.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/emulator/b1ee.c b/emulator/b1ee.c
index 17a60fc..3fb867d 100644
--- a/emulator/b1ee.c
+++ b/emulator/b1ee.c
@@ -203,6 +203,7 @@ static int do_connect(const char *node, const char *service)
 
 		if (connect(fd, res->ai_addr, res->ai_addrlen) < 0) {
 			perror("Failed to connect");
+			close(fd);
 			continue;
 		}
 
-- 
1.9.1

