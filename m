Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <gustavo@las.ic.unicamp.br>
To: linux-bluetooth@vger.kernel.org
Cc: gustavo@padovan.org
Subject: [PATCH 1/2] Add fcs to l2cap_options
Date: Sun,  9 Aug 2009 07:05:57 -0300
Message-Id: <1249812358-30344-1-git-send-email-gustavo@las.ic.unicamp.br>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Enable set of the FCS Option on userland. Need a kernel with support to
FCS.
---
 include/l2cap.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/l2cap.h b/include/l2cap.h
index 8bede46..23a4820 100644
--- a/include/l2cap.h
+++ b/include/l2cap.h
@@ -51,6 +51,7 @@ struct l2cap_options {
 	uint16_t	imtu;
 	uint16_t	flush_to;
 	uint8_t		mode;
+	uint8_t		fcs;
 };
 
 #define L2CAP_CONNINFO	0x02
-- 
1.6.3.3

