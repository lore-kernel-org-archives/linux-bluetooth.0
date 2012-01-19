Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv3 07/34] Bluetooth: Add send function to chan ops
Date: Thu, 19 Jan 2012 11:19:56 +0200
Message-Id: <1326964823-26747-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1326964823-26747-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 34a882b..3c7406f 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -504,6 +504,8 @@ struct l2cap_ops {
 
 	struct l2cap_chan	*(*new_connection) (void *data);
 	int			(*recv) (void *data, struct sk_buff *skb);
+	int			(*send) (struct l2cap_chan *chan,
+				struct msghdr *msg, size_t len, u32 priority);
 	void			(*close) (void *data);
 	void			(*state_change) (void *data, int state);
 };
-- 
1.7.4.1

