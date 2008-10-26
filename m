Return-Path: <cyrus@holtmann.org>
Message-ID: <4904194D.1080806@larces.uece.br>
Date: Sun, 26 Oct 2008 04:16:29 -0300
From: Sergio Luis <sergio@larces.uece.br>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [patch 1/2] btsdio: free sk_buff with kfree_skb
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

free sk_buff with kfree_skb, instead of kree
 
Signed-off-by: Sergio Luis <sergio@larces.uece.br>
Cc: Marcel Holtmann <marcel@holtmann.org>

drivers/bluetooth/btsdio.c         |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btsdio.c b/drivers/bluetooth/btsdio.c
index 58630cc..cda6c7c 100644
--- a/drivers/bluetooth/btsdio.c
+++ b/drivers/bluetooth/btsdio.c
@@ -152,7 +152,7 @@ static int btsdio_rx_packet(struct btsdio_data *data)
 
 	err = sdio_readsb(data->func, skb->data, REG_RDAT, len - 4);
 	if (err < 0) {
-		kfree(skb);
+		kfree_skb(skb);
 		return err;
 	}
 
