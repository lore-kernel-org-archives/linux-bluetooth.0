Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 04/10] tools: Fix resource leak closing sk
Date: Mon, 11 Aug 2014 10:50:39 +0300
Message-Id: <1407743445-1329-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1407743445-1329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1407743445-1329-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 tools/avinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/avinfo.c b/tools/avinfo.c
index 7d58e25..d9f809b 100644
--- a/tools/avinfo.c
+++ b/tools/avinfo.c
@@ -583,6 +583,7 @@ static int l2cap_connect(bdaddr_t *src, bdaddr_t *dst)
 
 	if (bind(sk, (struct sockaddr *) &l2a, sizeof(l2a)) < 0) {
 		printf("Bind failed. %s (%d)\n", strerror(errno), errno);
+		close(sk);
 		return -errno;
 	}
 
@@ -593,6 +594,7 @@ static int l2cap_connect(bdaddr_t *src, bdaddr_t *dst)
 
 	if (connect(sk, (struct sockaddr *) &l2a, sizeof(l2a)) < 0) {
 		printf("Connect failed. %s(%d)\n", strerror(errno), errno);
+		close(sk);
 		return -errno;
 	}
 
-- 
1.9.1

