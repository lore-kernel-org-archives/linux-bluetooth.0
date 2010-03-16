Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 2/3] Add txWindow and MaxTt to l2cap_options
Date: Mon, 15 Mar 2010 21:27:58 -0300
Message-Id: <1268699279-2961-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1268699279-2961-1-git-send-email-gustavo@padovan.org>
References: <1268699279-2961-1-git-send-email-gustavo@padovan.org>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/l2cap.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/lib/l2cap.h b/lib/l2cap.h
index 648615d..1f9f3d3 100644
--- a/lib/l2cap.h
+++ b/lib/l2cap.h
@@ -52,6 +52,8 @@ struct l2cap_options {
 	uint16_t	flush_to;
 	uint8_t		mode;
 	uint8_t		fcs;
+	uint8_t		txwin_size;
+	uint8_t		max_tx;
 };
 
 #define L2CAP_CONNINFO	0x02
-- 
1.6.4.4
