Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1494638013-6662-1-git-send-email-ricardo.salveti@linaro.org>
References: <1494638013-6662-1-git-send-email-ricardo.salveti@linaro.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sun, 14 May 2017 19:00:32 +0300
Message-ID: <CABBYNZ+mv6v_UN-LFzGCnpzk7EFWUhrHh0KGSwfSv1Pq5Pya1g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Check for available le pkts before sending frame
To: Ricardo Salveti <ricardo.salveti@linaro.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Johan Hedberg <johan.hedberg@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ricardo,

On Sat, May 13, 2017 at 4:13 AM, Ricardo Salveti
<ricardo.salveti@linaro.org> wrote:
> hci_sched_le only checks for the available le pkts before iterating over
> the channel data queue, allowing hci data buffer overflow when quota is
> larger than cnt (hci_chan_sent uses both le_cnt and acl_cnt when
> calculating quota, both of which are only updated after hci_sched_le is
> done with the channel data queue).
>
> Bug found when using wl1835mod (96boards HiKey) with multiple BT LE
> connections:
>> HCI Event: Number of Completed Packets (0x13) plen 5
>         Num handles: 1
>         Handle: 1025
>         Count: 2
>> HCI Event: Data Buffer Overflow (0x1a) plen 1
>         Link type: ACL (0x01)
>> HCI Event: Data Buffer Overflow (0x1a) plen 1
>         Link type: ACL (0x01)
>> HCI Event: Data Buffer Overflow (0x1a) plen 1
>         Link type: ACL (0x01)
>> HCI Event: Data Buffer Overflow (0x1a) plen 1
>         Link type: ACL (0x01)
>> HCI Event: Data Buffer Overflow (0x1a) plen 1
>         Link type: ACL (0x01)
>
> Signed-off-by: Ricardo Salveti <ricardo.salveti@linaro.org>
> ---
>  net/bluetooth/hci_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 0568677..58e9ab2 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3938,7 +3938,7 @@ static void hci_sched_le(struct hci_dev *hdev)
>         tmp = cnt;
>         while (cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
>                 u32 priority = (skb_peek(&chan->data_q))->priority;
> -               while (quote-- && (skb = skb_peek(&chan->data_q))) {
> +               while (cnt && quote-- && (skb = skb_peek(&chan->data_q))) {
>                         BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
>                                skb->len, skb->priority);
>
> --
> 2.7.4

This does indeed seems wrong but I think this can also affect the
quote since hci_chan_sent does attempt to access the acl_cnt/le_cnt
which may lead to return the wrong quote, though checking cnt would
fix that as well, because of this perhaps we should actually have the
cnt as a pointer so we can update the real cnt in place similarly to
what is done for ACL_LINK/acl_cnt:

 net/bluetooth/hci_core.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7655b40..8c4c785 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3955,7 +3955,7 @@ static void hci_sched_le(struct hci_dev *hdev)
 {
  struct hci_chan *chan;
  struct sk_buff *skb;
- int quote, cnt, tmp;
+ int quote, *cnt, tmp;

  BT_DBG("%s", hdev->name);

@@ -3970,9 +3970,9 @@ static void hci_sched_le(struct hci_dev *hdev)
  hci_link_tx_to(hdev, LE_LINK);
  }

- cnt = hdev->le_pkts ? hdev->le_cnt : hdev->acl_cnt;
- tmp = cnt;
- while (cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
+ cnt = hdev->le_pkts ? &hdev->le_cnt : &hdev->acl_cnt;
+ tmp = *cnt;
+ while (*cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
  u32 priority = (skb_peek(&chan->data_q))->priority;
  while (quote-- && (skb = skb_peek(&chan->data_q))) {
  BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
@@ -3987,18 +3987,13 @@ static void hci_sched_le(struct hci_dev *hdev)
  hci_send_frame(hdev, skb);
  hdev->le_last_tx = jiffies;

- cnt--;
+ *cnt--;
  chan->sent++;
  chan->conn->sent++;
  }
  }

- if (hdev->le_pkts)
- hdev->le_cnt = cnt;
- else
- hdev->acl_cnt = cnt;
-
- if (cnt != tmp)
+ if (*cnt != tmp)
  hci_prio_recalculate(hdev, LE_LINK);
 }


-- 
Luiz Augusto von Dentz
