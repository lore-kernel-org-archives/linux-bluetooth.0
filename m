Return-Path: <cyrus@holtmann.org>
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: kernel-janitors@vger.kernel.org,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Russell King - ARM Linux <linux@arm.linux.org.uk>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH 6/9] Bluetooth: btmrvl: add missing of_node_put
Date: Sat, 24 Oct 2015 16:42:32 +0200
Message-Id: <1445697755-26341-7-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1445697755-26341-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1445697755-26341-1-git-send-email-Julia.Lawall@lip6.fr>
List-ID: <linux-bluetooth.vger.kernel.org>

for_each_compatible_node performs an of_node_get on each iteration, so
a break out of the loop requires an of_node_put.

A simplified version of the semantic patch that fixes this problem is as
follows (http://coccinelle.lip6.fr):

// <smpl>
@@
expression e;
local idexpression n;
@@

 for_each_compatible_node(n, ...) {
   ... when != of_node_put(n)
       when != e = n
(
   return n;
|
+  of_node_put(n);
?  return ...;
)
   ...
 }
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/bluetooth/btmrvl_main.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 6ba2286..6af9173 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -516,14 +516,17 @@ static int btmrvl_check_device_tree(struct btmrvl_private *priv)
 		ret = of_property_read_u8_array(dt_node, "btmrvl,cal-data",
 						cal_data + BT_CAL_HDR_LEN,
 						BT_CAL_DATA_SIZE);
-		if (ret)
+		if (ret) {
+			of_node_put(dt_node);
 			return ret;
+		}
 
 		BT_DBG("Use cal data from device tree");
 		ret = btmrvl_download_cal_data(priv, cal_data,
 					       BT_CAL_DATA_SIZE);
 		if (ret) {
 			BT_ERR("Fail to download calibrate data");
+			of_node_put(dt_node);
 			return ret;
 		}
 	}
