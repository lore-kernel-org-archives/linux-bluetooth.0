Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Ricardo Salveti <ricardo.salveti@linaro.org>
To: linux-bluetooth@vger.kernel.org
Cc: johan.hedberg@intel.com
Subject: [PATCH] Bluetooth: Check for available le pkts before sending frame
Date: Fri, 12 May 2017 22:13:33 -0300
Message-Id: <1494638013-6662-1-git-send-email-ricardo.salveti@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hci_sched_le only checks for the available le pkts before iterating over
the channel data queue, allowing hci data buffer overflow when quota is
larger than cnt (hci_chan_sent uses both le_cnt and acl_cnt when
calculating quota, both of which are only updated after hci_sched_le is
done with the channel data queue).

Bug found when using wl1835mod (96boards HiKey) with multiple BT LE
connections:
> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 1025
        Count: 2
> HCI Event: Data Buffer Overflow (0x1a) plen 1
        Link type: ACL (0x01)
> HCI Event: Data Buffer Overflow (0x1a) plen 1
        Link type: ACL (0x01)
> HCI Event: Data Buffer Overflow (0x1a) plen 1
        Link type: ACL (0x01)
> HCI Event: Data Buffer Overflow (0x1a) plen 1
        Link type: ACL (0x01)
> HCI Event: Data Buffer Overflow (0x1a) plen 1
        Link type: ACL (0x01)

Signed-off-by: Ricardo Salveti <ricardo.salveti@linaro.org>
---
 net/bluetooth/hci_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0568677..58e9ab2 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3938,7 +3938,7 @@ static void hci_sched_le(struct hci_dev *hdev)
 	tmp = cnt;
 	while (cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
-		while (quote-- && (skb = skb_peek(&chan->data_q))) {
+		while (cnt && quote-- && (skb = skb_peek(&chan->data_q))) {
 			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
 			       skb->len, skb->priority);
 
-- 
2.7.4

