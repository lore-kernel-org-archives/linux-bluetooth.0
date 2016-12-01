Return-Path: <bianpan2016@163.com>
From: Pan Bian <bianpan2016@163.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pan Bian <bianpan2016@163.com>
Subject: [PATCH 1/1] bluetooth: propagate the error code
Date: Thu,  1 Dec 2016 14:23:29 +0800
Message-Id: <1480573409-18520-1-git-send-email-bianpan2016@163.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Fix bug https://bugzilla.kernel.org/show_bug.cgi?id=188551. A negative
return value means there are errors, while 0 indicates success. However,
in function bpa10x_send_frame(), it returns 0 no matter whether
usb_submit_urb() returns a negative value. As a result, the caller of
bpa10x_send_frame() may not detect the submission error. In this patch,
use "return err;" at the end to propagate the error.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/bluetooth/bpa10x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index a9932fe..d2bebee 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -355,7 +355,7 @@ static int bpa10x_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 
 	usb_free_urb(urb);
 
-	return 0;
+	return err;
 }
 
 static int bpa10x_set_diag(struct hci_dev *hdev, bool enable)
-- 
1.9.1
