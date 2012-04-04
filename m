Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ 1/4] Add Bluetooth address type in sockaddr_l2
Date: Wed,  4 Apr 2012 17:16:08 -0300
Message-Id: <1333570571-29650-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the address type information to sockaddr_l2 structure,
allowing the userspace to inform the remote address type required for
LE Create Connection command.
---
 lib/l2cap.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/l2cap.h b/lib/l2cap.h
index 5806aaa..5ce94c4 100644
--- a/lib/l2cap.h
+++ b/lib/l2cap.h
@@ -43,6 +43,7 @@ struct sockaddr_l2 {
 	unsigned short	l2_psm;
 	bdaddr_t	l2_bdaddr;
 	unsigned short	l2_cid;
+	uint8_t		l2_bdaddr_type;
 };
 
 /* L2CAP socket options */
-- 
1.7.8.5

