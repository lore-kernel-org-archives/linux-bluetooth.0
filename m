Return-Path: <cyrus@holtmann.org>
From: Tomas Winkler <tomas.winkler@intel.com>
To: stable@kernel.org,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, Sergio Luis <sergio@larces.uece.br>
Subject: [PATCH 1/2] btsdio: free sk_buff with kfree_skb
Date: Sat, 14 Feb 2009 13:02:05 +0200
Message-Id: <1234609326-583-2-git-send-email-tomas.winkler@intel.com>
In-Reply-To: <1234609326-583-1-git-send-email-tomas.winkler@intel.com>
References: <1234609326-583-1-git-send-email-tomas.winkler@intel.com>
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-bluetooth.vger.kernel.org>

From: Sergio Luis <sergio@larces.uece.br>

free sk_buff with kfree_skb, instead of kree

Signed-off-by: Sergio Luis <sergio@larces.uece.br>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 drivers/bluetooth/btsdio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

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
 
-- 
1.6.0.6

---------------------------------------------------------------------
Intel Israel (74) Limited

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.
