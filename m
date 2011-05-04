Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, <linux-bluetooth@vger.kernel.org>
CC: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH] Update params description of PIN Code Request
Date: Wed, 4 May 2011 10:54:00 +0200
Message-ID: <1304499240-4966-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

---
 doc/mgmt-api.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 45f6a64..353705e 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -484,6 +484,8 @@ Controller Index:	<controller id>
 Event Parameters	Address (6 Octets)
 			Secure (1 Octet)
 
+	Secure: 0x01  secure PIN code required
+		0x00  secure PIN code not required
 
 User Confirmation Request Event
 ===============================
-- 
1.7.1
