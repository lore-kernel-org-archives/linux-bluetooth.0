Return-Path: <cyrus@holtmann.org>
From: Alexander Aring <alex.aring@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: linux-wpan@vger.kernel.org,
	kernel@pengutronix.de,
	marcel@holtmann.org,
	werner@almesberger.net,
	mkl@pengutronix.de,
	Alexander Aring <alex.aring@gmail.com>
Subject: [RFC bluetooth-next 2/2] ieee802154: socket: add BUILD_BUG_ON for cast check
Date: Sat, 10 Jan 2015 23:33:26 +0100
Message-Id: <1420929206-5771-3-git-send-email-alex.aring@gmail.com>
In-Reply-To: <1420929206-5771-1-git-send-email-alex.aring@gmail.com>
References: <1420929206-5771-1-git-send-email-alex.aring@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds an overdue BUILD_BUG_ON size check that the
"struct sockaddr_ieee802154" is never greater than the
"struct sockaddr". The IEEE 802.15.4 will cast the "struct sockaddr" to
struct sockaddr_ieee802154" at several places.

Signed-off-by: Alexander Aring <alex.aring@gmail.com>
---
 net/ieee802154/socket.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ieee802154/socket.c b/net/ieee802154/socket.c
index 2878d8c..9c09291 100644
--- a/net/ieee802154/socket.c
+++ b/net/ieee802154/socket.c
@@ -1085,6 +1085,9 @@ static int __init af_ieee802154_init(void)
 {
 	int rc = -EINVAL;
 
+	BUILD_BUG_ON(sizeof(struct sockaddr_ieee802154) >
+		     sizeof(struct sockaddr));
+
 	rc = proto_register(&ieee802154_raw_prot, 1);
 	if (rc)
 		goto out;
-- 
2.2.1
