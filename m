Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677A8C56202
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 04:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2130724695
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 04:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SuG4oIwy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgKQErj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Nov 2020 23:47:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgKQErj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Nov 2020 23:47:39 -0500
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1156BC0617A7
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 20:47:39 -0800 (PST)
Received: by mail-vs1-xe44.google.com with SMTP id l22so10408194vsa.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 20:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L7m+R+koEguKLWpxL2JVG0IyVLbQrESNiPN54YRj9Rs=;
        b=SuG4oIwymPfk9byMYdCeR2QmCbZEgRwQqt2CjpNBsyc0Ck2/oqeQ3pwxLZYbM0Ksy+
         7B8slIofR4LOz1c5LWl8d+3wmcMsM8103uMEty3PjVtE8mw1ly83i7JNGRkDyD4rnaCo
         vz7mmqIuFi3JtyE3nTKSHLSGau0rCEG4szBFA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L7m+R+koEguKLWpxL2JVG0IyVLbQrESNiPN54YRj9Rs=;
        b=Y2VCAf74bvevr5dWBQP35hssPyBmS0qOfpMAhtwWxouP8Sl0MopE5NAOksLTumqV6R
         BiMPKnA0fIfxd4SvHrdzmQmnHiqk6uJZz0Dy5L4n2HyVrDb4APfkBbIzBCsNtKH4A4w3
         HEi58dhi/ZiLUJg4PItRAHsKSgnvBNgXTLJIuuntKMuAzbLRFtt1nsCr+zWIekrJ/77w
         Pb/JpN7D2LRvfxu4q4Cvy/1lsh0Z+AYy6TA0XO4SwDsNOzfgVt6Nt+s6Dohm3BSoq5pN
         O8D5LXB5et6cRRXY0o5ix37n8o8Oq8gYZFyq1UtRnTFmqBMJCt8W10bztEkqEfbo/GEb
         ZbCA==
X-Gm-Message-State: AOAM533LFTFJv9710kv8oVOSCi+r75NPHQ1LSnojZfq1fFch0biWt6dL
        NQAlMUBHx9FC3oSbheUvtHjjySqRqftrqG+4u8la0Q==
X-Google-Smtp-Source: ABdhPJwbLItZUJyDuZvYGnw+dEfZRYZgAyBaA4QQv2gGiAlRhXdLYe2SeDwctmuXMSo7ARilETQIfqqD0l/bSNA/VKU=
X-Received: by 2002:a67:1485:: with SMTP id 127mr10471181vsu.59.1605588457958;
 Mon, 16 Nov 2020 20:47:37 -0800 (PST)
MIME-Version: 1.0
References: <1605463143-4635-1-git-send-email-gubbaven@codeaurora.org>
In-Reply-To: <1605463143-4635-1-git-send-email-gubbaven@codeaurora.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon, 16 Nov 2020 20:47:27 -0800
Message-ID: <CANFp7mW=UvL_ONxFaTXKkY4byZRLLf0Tu8cesXhJNN36bqNDQA@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Handle spurious wakeup from SoC
To:     Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Hemantg <hemantg@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>, hbandi@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Venkata,

I think this code would be simplified by using a delayed_work struct
instead of a timer.

Based on your commit description:

On Sun, Nov 15, 2020 at 9:59 AM Venkata Lakshmi Narayana Gubba
<gubbaven@codeaurora.org> wrote:
>
> Added timer to handle spurious wakeup from SoC.
> Timer is started when wake indicator is received from SoC.
> Timer is restarted when valid data is received from SoC.
> Timer is stopped when sleep indicator is received from SoC.
> SSR is triggered upon timer expiry.
>
> Signed-off-by: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>

in function qca_ibs_wake_ind: (timer started when wake indicator is
received from SoC)
  queue_delayed_work(qca->workqueue, &qca->spurious_wake,
IBS_SOC_SPURIOUS_WAKE_TIMEOUT_MS)

in function qca_ibs_sleep_ind: (Timer is stopped when sleep indicator
is received from SoC.)
  cancel_delayed_work(qca->workqueue, &qca->spurious_wake);

in  qca_recv_acl_data, qca_recv_sco_data and qca_recv_event: (Timer is
restarted when valid data is received from SoC.)
  if (!test_bit(QCA_IBS_DISABLED, &qca->flags))
    mod_delayed_work(qca->workqueue, &qca->spurious_wake,
IBS_SOC_SPURIOUS_WAKE_TIMEOUT_MS)

and finally in qca_ibs_spurious_wake_timeout (originally named
hci_ibs_spurious_wake_timeout in your patch): (SSR is triggered upon
timer expiry.)
  if (!test_bit(QCA_HW_ERROR_EVENT, &qca->flags))
    hci_reset_dev(hu->hdev);

That should trigger qca_hw_error so you don't need to duplicate the
crash dump triggering + waiting in multiple places (and if you get the
spurious wake bug WHILE doing SSR, it won't re-trigger the same
restart over and over).

Abhishek


> ---
>  drivers/bluetooth/hci_qca.c | 99 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 97 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 5cc7b16..6953001 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -48,6 +48,7 @@
>  #define IBS_WAKE_RETRANS_TIMEOUT_MS    100
>  #define IBS_BTSOC_TX_IDLE_TIMEOUT_MS   200
>  #define IBS_HOST_TX_IDLE_TIMEOUT_MS    2000
> +#define IBS_SOC_SPURIOUS_WAKE_TIMEOUT_MS 10000
>  #define CMD_TRANS_TIMEOUT_MS           100
>  #define MEMDUMP_TIMEOUT_MS             8000
>  #define IBS_DISABLE_SSR_TIMEOUT_MS     (MEMDUMP_TIMEOUT_MS + 1000)
> @@ -147,7 +148,9 @@ struct qca_data {
>         bool tx_vote;           /* Clock must be on for TX */
>         bool rx_vote;           /* Clock must be on for RX */
>         struct timer_list tx_idle_timer;
> +       struct timer_list spurious_wake_timer;
>         u32 tx_idle_delay;
> +       u32 spurious_wake;
>         struct timer_list wake_retrans_timer;
>         u32 wake_retrans;
>         struct workqueue_struct *workqueue;
> @@ -156,6 +159,7 @@ struct qca_data {
>         struct work_struct ws_rx_vote_off;
>         struct work_struct ws_tx_vote_off;
>         struct work_struct ctrl_memdump_evt;
> +       struct work_struct spurious_wake_timeout;
>         struct delayed_work ctrl_memdump_timeout;
>         struct qca_memdump_data *qca_memdump;
>         unsigned long flags;
> @@ -229,6 +233,7 @@ static void qca_regulator_disable(struct qca_serdev *qcadev);
>  static void qca_power_shutdown(struct hci_uart *hu);
>  static int qca_power_off(struct hci_dev *hdev);
>  static void qca_controller_memdump(struct work_struct *work);
> +static void qca_wq_spurious_wake_timeout(struct work_struct *work);
>
>  static enum qca_btsoc_type qca_soc_type(struct hci_uart *hu)
>  {
> @@ -530,6 +535,15 @@ static void hci_ibs_wake_retrans_timeout(struct timer_list *t)
>                 hci_uart_tx_wakeup(hu);
>  }
>
> +static void hci_ibs_spurious_wake_timeout(struct timer_list *t)
> +{
> +       struct qca_data *qca = from_timer(qca, t, spurious_wake_timer);
> +       struct hci_uart *hu = qca->hu;
> +
> +       bt_dev_warn(hu->hdev, "hu %p spurious wake timeout in %d state", hu, qca->rx_ibs_state);
> +
> +       queue_work(qca->workqueue, &qca->spurious_wake_timeout);
> +}
>
>  static void qca_controller_memdump_timeout(struct work_struct *work)
>  {
> @@ -584,6 +598,7 @@ static int qca_open(struct hci_uart *hu)
>         INIT_WORK(&qca->ws_rx_vote_off, qca_wq_serial_rx_clock_vote_off);
>         INIT_WORK(&qca->ws_tx_vote_off, qca_wq_serial_tx_clock_vote_off);
>         INIT_WORK(&qca->ctrl_memdump_evt, qca_controller_memdump);
> +       INIT_WORK(&qca->spurious_wake_timeout, qca_wq_spurious_wake_timeout);
>         INIT_DELAYED_WORK(&qca->ctrl_memdump_timeout,
>                           qca_controller_memdump_timeout);
>         init_waitqueue_head(&qca->suspend_wait_q);
> @@ -615,6 +630,9 @@ static int qca_open(struct hci_uart *hu)
>         timer_setup(&qca->tx_idle_timer, hci_ibs_tx_idle_timeout, 0);
>         qca->tx_idle_delay = IBS_HOST_TX_IDLE_TIMEOUT_MS;
>
> +       timer_setup(&qca->spurious_wake_timer, hci_ibs_spurious_wake_timeout, 0);
> +       qca->spurious_wake = IBS_SOC_SPURIOUS_WAKE_TIMEOUT_MS;
> +
>         BT_DBG("HCI_UART_QCA open, tx_idle_delay=%u, wake_retrans=%u",
>                qca->tx_idle_delay, qca->wake_retrans);
>
> @@ -694,6 +712,7 @@ static int qca_close(struct hci_uart *hu)
>         skb_queue_purge(&qca->rx_memdump_q);
>         del_timer(&qca->tx_idle_timer);
>         del_timer(&qca->wake_retrans_timer);
> +       del_timer(&qca->spurious_wake_timer);
>         destroy_workqueue(qca->workqueue);
>         qca->hu = NULL;
>
> @@ -710,7 +729,7 @@ static int qca_close(struct hci_uart *hu)
>   */
>  static void device_want_to_wakeup(struct hci_uart *hu)
>  {
> -       unsigned long flags;
> +       unsigned long flags, wake_timeout;
>         struct qca_data *qca = hu->priv;
>
>         BT_DBG("hu %p want to wake up", hu);
> @@ -731,6 +750,10 @@ static void device_want_to_wakeup(struct hci_uart *hu)
>                  * receiving the wake up indicator awake rx clock.
>                  */
>                 queue_work(qca->workqueue, &qca->ws_awake_rx);
> +               if (!test_bit(QCA_SSR_TRIGGERED, &qca->flags)) {
> +                       wake_timeout = msecs_to_jiffies(qca->spurious_wake);
> +                       mod_timer(&qca->spurious_wake_timer, jiffies + wake_timeout);
> +               }
>                 spin_unlock_irqrestore(&qca->hci_ibs_lock, flags);
>                 return;
>
> @@ -777,9 +800,11 @@ static void device_want_to_sleep(struct hci_uart *hu)
>                 qca->rx_ibs_state = HCI_IBS_RX_ASLEEP;
>                 /* Vote off rx clock under workqueue */
>                 queue_work(qca->workqueue, &qca->ws_rx_vote_off);
> +               del_timer(&qca->spurious_wake_timer);
>                 break;
>
>         case HCI_IBS_RX_ASLEEP:
> +               del_timer(&qca->spurious_wake_timer);
>                 break;
>
>         default:
> @@ -955,6 +980,16 @@ static int qca_ibs_wake_ack(struct hci_dev *hdev, struct sk_buff *skb)
>
>  static int qca_recv_acl_data(struct hci_dev *hdev, struct sk_buff *skb)
>  {
> +       struct hci_uart *hu = hci_get_drvdata(hdev);
> +       struct qca_data *qca = hu->priv;
> +       u32 wake_timeout;
> +
> +       if (!test_bit(QCA_IBS_DISABLED, &qca->flags) &&
> +           !test_bit(QCA_SSR_TRIGGERED, &qca->flags)) {
> +               wake_timeout = msecs_to_jiffies(qca->spurious_wake);
> +               mod_timer(&qca->spurious_wake_timer, jiffies + wake_timeout);
> +       }
> +
>         /* We receive debug logs from chip as an ACL packets.
>          * Instead of sending the data to ACL to decode the
>          * received data, we are pushing them to the above layers
> @@ -966,6 +1001,22 @@ static int qca_recv_acl_data(struct hci_dev *hdev, struct sk_buff *skb)
>         return hci_recv_frame(hdev, skb);
>  }
>
> +static int qca_recv_sco_data(struct hci_dev *hdev, struct sk_buff *skb)
> +{
> +       struct hci_uart *hu = hci_get_drvdata(hdev);
> +       struct qca_data *qca = hu->priv;
> +       u32 wake_timeout;
> +
> +       if (!test_bit(QCA_IBS_DISABLED, &qca->flags) &&
> +           !test_bit(QCA_SSR_TRIGGERED, &qca->flags)) {
> +               wake_timeout = msecs_to_jiffies(qca->spurious_wake);
> +               mod_timer(&qca->spurious_wake_timer, jiffies + wake_timeout);
> +       }
> +
> +       return hci_recv_frame(hdev, skb);
> +}
> +
> +
>  static void qca_controller_memdump(struct work_struct *work)
>  {
>         struct qca_data *qca = container_of(work, struct qca_data,
> @@ -1134,6 +1185,7 @@ static int qca_controller_memdump_event(struct hci_dev *hdev,
>         struct qca_data *qca = hu->priv;
>
>         set_bit(QCA_SSR_TRIGGERED, &qca->flags);
> +       del_timer(&qca->spurious_wake_timer);
>         skb_queue_tail(&qca->rx_memdump_q, skb);
>         queue_work(qca->workqueue, &qca->ctrl_memdump_evt);
>
> @@ -1144,6 +1196,7 @@ static int qca_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>         struct hci_uart *hu = hci_get_drvdata(hdev);
>         struct qca_data *qca = hu->priv;
> +       u32 wake_timeout;
>
>         if (test_bit(QCA_DROP_VENDOR_EVENT, &qca->flags)) {
>                 struct hci_event_hdr *hdr = (void *)skb->data;
> @@ -1174,6 +1227,12 @@ static int qca_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
>             (get_unaligned_be16(skb->data + 2) == QCA_SSR_DUMP_HANDLE))
>                 return qca_controller_memdump_event(hdev, skb);
>
> +       if (!test_bit(QCA_IBS_DISABLED, &qca->flags) &&
> +           !test_bit(QCA_SSR_TRIGGERED, &qca->flags)) {
> +               wake_timeout = msecs_to_jiffies(qca->spurious_wake);
> +               mod_timer(&qca->spurious_wake_timer, jiffies + wake_timeout);
> +       }
> +
>         return hci_recv_frame(hdev, skb);
>  }
>
> @@ -1200,7 +1259,7 @@ static int qca_recv_event(struct hci_dev *hdev, struct sk_buff *skb)
>
>  static const struct h4_recv_pkt qca_recv_pkts[] = {
>         { H4_RECV_ACL,             .recv = qca_recv_acl_data },
> -       { H4_RECV_SCO,             .recv = hci_recv_frame    },
> +       { H4_RECV_SCO,             .recv = qca_recv_sco_data },
>         { H4_RECV_EVENT,           .recv = qca_recv_event    },
>         { QCA_IBS_WAKE_IND_EVENT,  .recv = qca_ibs_wake_ind  },
>         { QCA_IBS_WAKE_ACK_EVENT,  .recv = qca_ibs_wake_ack  },
> @@ -1567,6 +1626,40 @@ static void qca_cmd_timeout(struct hci_dev *hdev)
>         mutex_unlock(&qca->hci_memdump_lock);
>  }
>
> +static void qca_wq_spurious_wake_timeout(struct work_struct *work)
> +{
> +       struct qca_data *qca = container_of(work, struct qca_data,
> +                                           spurious_wake_timeout);
> +       struct hci_uart *hu = qca->hu;
> +
> +       bt_dev_info(hu->hdev, "mem_dump_status: %d", qca->memdump_state);
> +
> +       set_bit(QCA_SSR_TRIGGERED, &qca->flags);
> +       if (qca->memdump_state == QCA_MEMDUMP_IDLE) {
> +               set_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
> +               qca_send_crashbuffer(hu);
> +               qca_wait_for_dump_collection(hu->hdev);
> +       } else if (qca->memdump_state == QCA_MEMDUMP_COLLECTING) {
> +               /* Let us wait here until memory dump collected or
> +                * memory dump timer expired.
> +                */
> +               bt_dev_info(hu->hdev, "waiting for dump to complete");
> +               qca_wait_for_dump_collection(hu->hdev);
> +       }
> +
> +       mutex_lock(&qca->hci_memdump_lock);
> +       if (qca->memdump_state != QCA_MEMDUMP_COLLECTED) {
> +               qca->memdump_state = QCA_MEMDUMP_TIMEOUT;
> +               if (!test_bit(QCA_HW_ERROR_EVENT, &qca->flags)) {
> +                       /* Inject hw error event to reset the device
> +                        * and driver.
> +                        */
> +                       hci_reset_dev(hu->hdev);
> +               }
> +       }
> +       mutex_unlock(&qca->hci_memdump_lock);
> +}
> +
>  static int qca_wcn3990_init(struct hci_uart *hu)
>  {
>         struct qca_serdev *qcadev;
> @@ -1816,6 +1909,8 @@ static void qca_power_shutdown(struct hci_uart *hu)
>
>         qcadev = serdev_device_get_drvdata(hu->serdev);
>
> +       del_timer(&qca->spurious_wake_timer);
> +
>         /* From this point we go into power off state. But serial port is
>          * still open, stop queueing the IBS data and flush all the buffered
>          * data in skb's.
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
>
