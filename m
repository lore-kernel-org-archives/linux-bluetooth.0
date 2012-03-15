Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv4 02/30] Bluetooth: Add send function to chan ops
Date: Thu, 15 Mar 2012 14:29:53 +0200
Message-Id: <1331814621-13905-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index c107944..260f93e 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -505,6 +505,8 @@ struct l2cap_ops {
 
 	struct l2cap_chan	*(*new_connection) (void *data);
 	int			(*recv) (void *data, struct sk_buff *skb);
+	int			(*send) (struct l2cap_chan *chan,
+				struct msghdr *msg, size_t len, u32 priority);
 	void			(*close) (void *data);
 	void			(*state_change) (void *data, int state);
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
-- 
1.7.9.1

