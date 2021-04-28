Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE0EC433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Apr 2021 22:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC3C161412
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Apr 2021 22:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhD1WKy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Apr 2021 18:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhD1WKy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Apr 2021 18:10:54 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C7AC06138B
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Apr 2021 15:10:07 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 82so75954836yby.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Apr 2021 15:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ghAEmVxQ1BBuzwsjDqFLPlSrw03WczBC5HroCRx+z6o=;
        b=RTd9jj3UpEjArGONYwhfKqMSTGturZBjuDE90ciljTcJo7R3of0naGpQpNJtnWpRbs
         BR0Ai/f+XaiQsrjKHXkqizrW4iz2mSkwCVLoV5ErqMhIWE+5zsXEUtPfLhDo0egTwKZS
         9w9RLSV4Pi2xW3gGnGs53M//2FwIkxYmFWuYBBMp9uJBL+kvj3pDabPVMHmXRb8BGw+c
         Sa9cp1U2OwBnE7OCj7IvrqY91zzT4e7gWUqQcReCqhLP1404j8FNiNdx/p0Kyz6CaVlp
         Bb/jFCNz+3ES8gg38IQ/4SZ74FYYZVU4afBaKOP2OugKpdkwKQq3sBokj0/x5edRVm4h
         DCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ghAEmVxQ1BBuzwsjDqFLPlSrw03WczBC5HroCRx+z6o=;
        b=maAwNtMUVTd1OkqWFXx8aF35ixIS3MoARJVbaeHiqNP3qcsV5y1qmAhyVINBTDwh4h
         OBwf+Ez1UOfV2BWCgDqT6tW38kjtq5wAW9xLTVUlj/SaMyLVKRhVpPwr3clTiPuUsRwa
         j/xDVQeZCDq3CbvNxWBApUMqCnQ2QoDqWhfL0EUvOR/cKsuirYbVqiLTLcGzNXMhVI56
         S2HHoWID0XelVCYq7iTmskrmbbx015STD54sRw/3iLAMK1lVbcUx2uDiIIZBePIX51JS
         y9yskfnccVmIsEF4wuqmLsWMK8DFOhQxvinVcbpCuMwUFS/WocX5/+YTD2MnXhXZPtQy
         hqwA==
X-Gm-Message-State: AOAM532R8ZFnh0tzdzL6zdITDvpeSk1aKCjYuR50xlxzJn78M+kK2iOG
        WYLdsIUyqol/Bz73/CIdMf+yJJ6O2zw5O0AbxF4=
X-Google-Smtp-Source: ABdhPJw2i5pHQEZxHOf6cP16iEVxwrJ2Fb9FneaPwZ4HYdXHDTPaqeHlN7rddfn0/fSFUg84oH8EmpZaODeR1j0nf0c=
X-Received: by 2002:a5b:645:: with SMTP id o5mr2414468ybq.347.1619647806552;
 Wed, 28 Apr 2021 15:10:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210428140132.30316-1-kiran.k@intel.com>
In-Reply-To: <20210428140132.30316-1-kiran.k@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 28 Apr 2021 15:09:55 -0700
Message-ID: <CABBYNZK044znKcW9boBmZoGiHkkjRq-7ZqifisZ13_EZ9hg-=g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] Bluetooth: enumerate local supported codec and
 cache details
To:     Kiran K <kiran.k@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Wed, Apr 28, 2021 at 7:57 AM Kiran K <kiran.k@intel.com> wrote:
>
> Move reading of supported local codecs into a separate init function,
> query codecs capabilities and cache the data
>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
> * changes in v4
>   - convert  reading of codecs and codecs caps calls from async to sync
> * changes in v3
>   move codec enumeration into a new init function
> * changes in v2
>   add skb length check before accessing data
>
>  include/net/bluetooth/hci.h      |  18 ++++
>  include/net/bluetooth/hci_core.h |  23 +++++
>  net/bluetooth/hci_core.c         | 144 ++++++++++++++++++++++++++++++-
>  3 files changed, 181 insertions(+), 4 deletions(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index ea4ae551c426..2f7f8c6f7d63 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1314,6 +1314,24 @@ struct hci_rp_read_local_pairing_opts {
>         __u8     max_key_size;
>  } __packed;
>
> +#define HCI_OP_READ_LOCAL_CODEC_CAPS   0x100e
> +struct hci_op_read_local_codec_caps {
> +       __u8    codec_id[5];
> +       __u8    transport;
> +       __u8    direction;
> +} __packed;
> +
> +struct hci_codec_caps {
> +       __u8    len;
> +       __u8    caps[];
> +} __packed;
> +
> +struct hci_rp_read_local_codec_caps {
> +       __u8    status;
> +       __u8    num_caps;
> +       struct hci_codec_caps caps[];
> +} __packed;
> +
>  #define HCI_OP_READ_PAGE_SCAN_ACTIVITY 0x0c1b
>  struct hci_rp_read_page_scan_activity {
>         __u8     status;
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index 8f5f390363f5..b40c7ed38d18 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -131,6 +131,14 @@ struct bdaddr_list {
>         u8 bdaddr_type;
>  };
>
> +struct codec_list {
> +       struct list_head list;
> +       u8      transport;
> +       u8      codec_id[5];
> +       u8      num_caps;
> +       struct hci_codec_caps caps[];
> +};
> +
>  struct bdaddr_list_with_irk {
>         struct list_head list;
>         bdaddr_t bdaddr;
> @@ -534,6 +542,7 @@ struct hci_dev {
>         struct list_head        pend_le_conns;
>         struct list_head        pend_le_reports;
>         struct list_head        blocked_keys;
> +       struct list_head        local_codecs;
>
>         struct hci_dev_stats    stat;
>
> @@ -1843,9 +1852,23 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
>
>  void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
>                                u8 *bdaddr_type);
> +int hci_codec_list_add(struct list_head *list, struct hci_rp_read_local_codec_caps *rp,
> +                      __u32 len,
> +                      struct hci_op_read_local_codec_caps *sent);
> +void hci_codec_list_clear(struct list_head *codec_list);
>
>  #define SCO_AIRMODE_MASK       0x0003
>  #define SCO_AIRMODE_CVSD       0x0000
>  #define SCO_AIRMODE_TRANSP     0x0003
>
> +#define LOCAL_CODEC_ACL_MASK   BIT(0)
> +#define LOCAL_CODEC_SCO_MASK   BIT(1)
> +#define LOCAL_CODEC_CIS_MASK   BIT(2)
> +#define LOCAL_CODEC_BIS_MASK   BIT(3)
> +
> +#define LOCAL_CODEC_ACL                0x00
> +#define LOCAL_CODEC_SCO                0x01
> +#define LOCAL_CODEC_CIS                0x02
> +#define LOCAL_CODEC_BIS                0x03
> +
>  #endif /* __HCI_CORE_H */
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index fd12f1652bdf..7201967b6e9c 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -838,10 +838,6 @@ static int hci_init4_req(struct hci_request *req, unsigned long opt)
>         if (hdev->commands[22] & 0x04)
>                 hci_set_event_mask_page_2(req);
>
> -       /* Read local codec list if the HCI command is supported */
> -       if (hdev->commands[29] & 0x20)
> -               hci_req_add(req, HCI_OP_READ_LOCAL_CODECS, 0, NULL);
> -
>         /* Read local pairing options if the HCI command is supported */
>         if (hdev->commands[41] & 0x08)
>                 hci_req_add(req, HCI_OP_READ_LOCAL_PAIRING_OPTS, 0, NULL);
> @@ -907,6 +903,113 @@ static int hci_init4_req(struct hci_request *req, unsigned long opt)
>         return 0;
>  }
>
> +static void hci_read_codec_capabilities(struct hci_dev *hdev, __u8 *codec_id,
> +                                       __u8 transport, bool is_vendor_codec)
> +{
> +       struct hci_op_read_local_codec_caps caps;
> +       struct hci_rp_read_local_codec_caps *rp;
> +       struct sk_buff *skb;
> +
> +       memset(&caps, 0, sizeof(caps));
> +
> +       if (is_vendor_codec) {
> +               caps.codec_id[0] = 0xFF;
> +               memcpy(&caps.codec_id[1], codec_id, 4);
> +       } else {
> +               caps.codec_id[0] = codec_id[0];
> +       }
> +
> +       caps.direction = 0x00;
> +       caps.transport = transport;
> +
> +       skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS, sizeof(caps),
> +                            &caps, HCI_CMD_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               bt_dev_err(hdev, "Failed to read local supported codecs v2 (%ld)",
> +                          PTR_ERR(skb));
> +               return;
> +       }
> +
> +       if (skb->len < sizeof(*rp))
> +               goto error;
> +
> +       rp = (void *)skb->data;
> +
> +       if (rp->status)
> +               goto error;
> +
> +       hci_dev_lock(hdev);
> +       hci_codec_list_add(&hdev->local_codecs, rp, skb->len - 2, &caps);
> +       hci_dev_unlock(hdev);
> +
> +error:
> +       kfree_skb(skb);
> +}
> +
> +static void hci_read_supported_codecs(struct hci_dev *hdev)
> +{
> +       struct sk_buff *skb;
> +       __u8 num_codecs;
> +
> +       skb = __hci_cmd_sync(hdev, HCI_OP_READ_LOCAL_CODECS, 0, NULL,
> +                            HCI_CMD_TIMEOUT);
> +
> +       if (IS_ERR(skb)) {
> +               bt_dev_err(hdev, "Failed to read local supported codecs (%ld)",
> +                          PTR_ERR(skb));
> +               return;
> +       }
> +
> +       if (skb->len < 1 || skb->data[0])
> +               goto error;
> +
> +       skb_pull(skb, 1);

We better use a skb_pull with a sizeof of the struct we expect, here
you are probably reading the status but for someone else might not
understand what you doing here.

> +
> +       if (skb->len < 1)
> +               goto error;
> +
> +       /* enumerate standard codecs */
> +       num_codecs = skb->data[0];
> +
> +       skb_pull(skb, 1);

Ditto, use skb_pull(sbk, sizeof(num_codecs)).

> +
> +       if (num_codecs && skb->len  < num_codecs)
> +               goto error;

The check above might be easier if we use flex_array_size so we
perform the check for the entire array, and then on the while loop you
just access each element by index like Im doing in the patch bellow:

https://patchwork.kernel.org/project/bluetooth/patch/20210419171257.3865181-11-luiz.dentz@gmail.com/

> +       while (num_codecs--) {
> +               hci_read_codec_capabilities(hdev, skb->data, LOCAL_CODEC_ACL,
> +                                           false);
> +               skb_pull(skb, 1);
> +       }

Same thing here.

> +       /* enumerate vendor specific codecs */
> +       if (skb->len < 1)
> +               goto error;
> +
> +       num_codecs = skb->data[0];
> +
> +       skb_pull(skb, 1);
> +
> +       if (num_codecs && skb->len < (num_codecs * 4))
> +               goto error;
> +
> +       while (num_codecs--) {
> +               hci_read_codec_capabilities(hdev, skb->data, LOCAL_CODEC_ACL,
> +                                           true);
> +               skb_pull(skb, 4);
> +       }

Btw, the code for reading vendor and standard seems exactly the same
so perhaps it is worth moving these lines above under another function
e.g. hci_codec_list_parse which can then take a boolean saying is
vendor or not and from there call hci_read_codec_capabilities.

> +error:
> +       kfree_skb(skb);
> +}
> +
> +static void hci_init5_req(struct hci_dev *hdev)
> +{
> +       /* Read local codec list if the HCI command is supported */
> +       if (hdev->commands[29] & 0x20)
> +               hci_read_supported_codecs(hdev);
> +}
> +
>  static int __hci_init(struct hci_dev *hdev)
>  {
>         int err;
> @@ -937,6 +1040,8 @@ static int __hci_init(struct hci_dev *hdev)
>         if (err < 0)
>                 return err;
>
> +       hci_init5_req(hdev);
> +
>         /* This function is only called when the controller is actually in
>          * configured state. When the controller is marked as unconfigured,
>          * this initialization procedure is not run.
> @@ -3559,6 +3664,35 @@ void hci_conn_params_clear_disabled(struct hci_dev *hdev)
>         BT_DBG("All LE disabled connection parameters were removed");
>  }
>
> +int hci_codec_list_add(struct list_head *list, struct hci_rp_read_local_codec_caps *rp,
> +                      __u32 len,
> +                      struct hci_op_read_local_codec_caps *sent)
> +{
> +       struct codec_list *entry;
> +
> +       entry = kzalloc(sizeof(*entry) + len, GFP_KERNEL);
> +       if (!entry)
> +               return -ENOMEM;
> +
> +       memcpy(entry->codec_id, sent->codec_id, 5);
> +       entry->transport = sent->transport;
> +       entry->num_caps = rp->num_caps;
> +       if (rp->num_caps)
> +               memcpy(entry->caps, rp->caps, len);
> +       list_add(&entry->list, list);
> +
> +       return 0;
> +}
> +
> +void hci_codec_list_clear(struct list_head *codec_list)
> +{
> +       struct codec_list *c, *n;
> +
> +       list_for_each_entry_safe(c, n, codec_list, list) {
> +               list_del(&c->list);
> +               kfree(c);
> +       }
> +}
>  /* This function requires the caller holds hdev->lock */
>  static void hci_conn_params_clear_all(struct hci_dev *hdev)
>  {
> @@ -3818,6 +3952,7 @@ struct hci_dev *hci_alloc_dev(void)
>         INIT_LIST_HEAD(&hdev->conn_hash.list);
>         INIT_LIST_HEAD(&hdev->adv_instances);
>         INIT_LIST_HEAD(&hdev->blocked_keys);
> +       INIT_LIST_HEAD(&hdev->local_codecs);
>
>         INIT_WORK(&hdev->rx_work, hci_rx_work);
>         INIT_WORK(&hdev->cmd_work, hci_cmd_work);
> @@ -4036,6 +4171,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
>         hci_conn_params_clear_all(hdev);
>         hci_discovery_filter_clear(hdev);
>         hci_blocked_keys_clear(hdev);
> +       hci_codec_list_clear(&hdev->local_codecs);
>         hci_dev_unlock(hdev);
>
>         hci_dev_put(hdev);
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
