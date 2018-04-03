Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 3 Apr 2018 20:13:03 +0800
From: kbuild test robot <lkp@intel.com>
To: sean.wang@mediatek.com
Cc: kbuild-all@01.org, robh+dt@kernel.org, mark.rutland@arm.com,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        devicetree@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sean Wang <sean.wang@mediatek.com>
Subject: [RFC PATCH] Bluetooth: hci_mediatek: mtk_recv_frame() can be static
Message-ID: <20180403121303.GA72575@lkp-sb04>
References: <f0e0a0b7f1dc3845dc6eafb4ccd60284d1675f8d.1522736996.git.sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <f0e0a0b7f1dc3845dc6eafb4ccd60284d1675f8d.1522736996.git.sean.wang@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


Fixes: 9f2aacacb185 ("Bluetooth: hci_mediatek: Add protocol support for MediaTek serial devices")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 hci_mediatek.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_mediatek.c b/drivers/bluetooth/hci_mediatek.c
index 7ac1e7aa..ab02b8b 100644
--- a/drivers/bluetooth/hci_mediatek.c
+++ b/drivers/bluetooth/hci_mediatek.c
@@ -319,7 +319,7 @@ static int mtk_close(struct hci_uart *hu)
 	return 0;
 }
 
-int mtk_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
+static int mtk_recv_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_event_hdr *hdr = (void *)skb->data;
 	struct hci_uart *hu = hci_get_drvdata(hdev);
