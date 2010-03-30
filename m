Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, gustavo@padovan.org
Subject: [PATCH 3/4] Add txWindow and MaxTt to l2cap_options
Date: Tue, 30 Mar 2010 15:53:28 -0300
Message-Id: <1269975209-10044-3-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1269975209-10044-2-git-send-email-padovan@profusion.mobi>
References: <1269975209-10044-1-git-send-email-padovan@profusion.mobi>
 <1269975209-10044-2-git-send-email-padovan@profusion.mobi>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/l2cap.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/lib/l2cap.h b/lib/l2cap.h
index 648615d..e59cfdd 100644
--- a/lib/l2cap.h
+++ b/lib/l2cap.h
@@ -52,6 +52,8 @@ struct l2cap_options {
 	uint16_t	flush_to;
 	uint8_t		mode;
 	uint8_t		fcs;
+	uint8_t		max_tx;
+	uint16_t	txwin_size;
 };
 
 #define L2CAP_CONNINFO	0x02
-- 
1.6.4.4
