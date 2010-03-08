Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Mar 2010 15:15:59 +0300
From: Dan Carpenter <error27@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Bing Zhao <bzhao@marvell.com>, Rahul Tank <rahult@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>,
	linux-bluetooth@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [patch] bluetooth: storing negative values as unsigned char
Message-ID: <20100308121559.GG6469@bicker>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

This is mostly cleanup.  There is only one caller and it just checks for 
non-zero return values.  Still "ret" should be int because we want to return 
-EINVAL on errors.

Signed-off-by: Dan Carpenter <error27@gmail.com>

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 53a43ad..49ec89c 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -66,7 +66,7 @@ int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb)
 {
 	struct btmrvl_adapter *adapter = priv->adapter;
 	struct btmrvl_event *event;
-	u8 ret = 0;
+	int ret = 0;
 
 	event = (struct btmrvl_event *) skb->data;
 	if (event->ec != 0xff) {
