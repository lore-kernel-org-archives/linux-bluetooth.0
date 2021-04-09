Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1722FC433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 17:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91A8610A6
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 17:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbhDIRkm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Apr 2021 13:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234049AbhDIRkm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Apr 2021 13:40:42 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC9AC061761
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Apr 2021 10:40:29 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id l12-20020a9d6a8c0000b0290238e0f9f0d8so6424796otq.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Apr 2021 10:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ThZUPnON2QavqY+ACh0OHXoH/B18LX5W4PgoLlXpIKw=;
        b=f6Oh6qpPAxl0TRVBYAo/UYespgUDSjlWxXKV9ZDhVR4CYYI3ZSsQBO6iwGJhW6dgTL
         Z85BqSAbGCLtpJINV0V2PLU8uEZnXm1hkn6fSmljZF08wC3WDvg+vf7LAciMlJUQc/nd
         vTYfNRVOi5VEy33BWyvgs4bdp4HiinJyC6uypYGKVSrY3nSnfCDB0qLSoctw/2LuiCcX
         o+rGaSbmsiyyFjtUYP7v8JVdTtD3RwM1BXnF7dnSEy65Jeeu8c5TusDemYxj3hylYuYL
         P0k2aQ0sTIqpvDlioW6vdnoEZGKW1nKb9rEZ3FICCDNUQwENXyoOJB1Ej1rMNZ5bzAUr
         8EEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ThZUPnON2QavqY+ACh0OHXoH/B18LX5W4PgoLlXpIKw=;
        b=STexdgd42PbTAxz9Y5BEPOJ+MI6fk0pe9OH+jbmuJBMEqRIUckiMlLVqEkZTdRZ9BI
         PwnnbF+/MjkbvzLa9N3yx0/+ebaRmAuoI1CH9rR1o3XC8AoWaWYGnmzWy05wZLG8ChaZ
         u7ekswEyPncxcp6OKddqsRnABevR4K9VzJgQYGKz2OAxryHwzi/oxP7+cy+tbzlRm1KN
         ypXS8l46ackHIvv5eYE/Wn+wapTWZUKDYiA3egKeQIUknddtT0Ao/aiscR4Nq+qZvBve
         c2+8QZbWVWM2e09032OoPBan1rB8he2JhrQuM73xprnH86XmJWAa/hg8lvwayJSGe8BB
         AlBQ==
X-Gm-Message-State: AOAM531livZMqJ1WTOILGQhTGD9X+rnHi1lSDyf6azVfmgdfRePoa3F/
        tmiliIHyFJncj0NevbYjF2WSfjDut2JzyB/vAhFUuICmKLdJNQ==
X-Google-Smtp-Source: ABdhPJx3JI/fEP2mqIFDG77BCsm1etzoITEpBAiZs/3kPHPMY9py1tpQuT3qbHBvfD5ppjkMfHYzI893SpcNpAHYfqk=
X-Received: by 2002:a05:6830:619:: with SMTP id w25mr13183516oti.371.1617990028259;
 Fri, 09 Apr 2021 10:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210409122405.29850-1-kiran.k@intel.com> <20210409122405.29850-4-kiran.k@intel.com>
In-Reply-To: <20210409122405.29850-4-kiran.k@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 9 Apr 2021 10:40:17 -0700
Message-ID: <CABBYNZLwHn3JX0yKFup6QN-=tEjKt2iaaxZpgy+DdH-Vr3oeAA@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] Bluetooth: cache local supported codec capabilities
To:     Kiran K <kiran.k@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Fri, Apr 9, 2021 at 5:21 AM Kiran K <kiran.k@intel.com> wrote:
>
> Cache the codec information in the driver and this data can
> be exposed to user space audio modules via getsockopt
>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
>  include/net/bluetooth/hci.h      | 11 +++++++++++
>  include/net/bluetooth/hci_core.h | 13 +++++++++++++
>  net/bluetooth/hci_core.c         | 31 +++++++++++++++++++++++++++++++
>  net/bluetooth/hci_event.c        | 31 +++++++++++++++++++++++++++++++
>  4 files changed, 86 insertions(+)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 34eb9f4b027f..6b4344639ff7 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1323,6 +1323,17 @@ struct hci_op_read_local_codec_caps {
>         __u8    direction;
>  } __packed;
>
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
> index fa0c68fd3306..974372644990 100644
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
> @@ -1843,6 +1852,10 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __le64 rand,
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
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 230aeedd6d00..578f417d1904 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3561,6 +3561,35 @@ void hci_conn_params_clear_disabled(struct hci_dev *hdev)
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
> @@ -3820,6 +3849,7 @@ struct hci_dev *hci_alloc_dev(void)
>         INIT_LIST_HEAD(&hdev->conn_hash.list);
>         INIT_LIST_HEAD(&hdev->adv_instances);
>         INIT_LIST_HEAD(&hdev->blocked_keys);
> +       INIT_LIST_HEAD(&hdev->local_codecs);
>
>         INIT_WORK(&hdev->rx_work, hci_rx_work);
>         INIT_WORK(&hdev->cmd_work, hci_cmd_work);
> @@ -4038,6 +4068,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
>         hci_conn_params_clear_all(hdev);
>         hci_discovery_filter_clear(hdev);
>         hci_blocked_keys_clear(hdev);
> +       hci_codec_list_clear(&hdev->local_codecs);
>         hci_dev_unlock(hdev);
>
>         hci_dev_put(hdev);
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index a16723c89dc6..f57ee199f0f3 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1033,6 +1033,33 @@ static void hci_cc_read_local_codecs_v2(struct hci_dev *hdev,
>         }
>  }
>
> +static void hci_cc_read_local_codec_caps(struct hci_dev *hdev,
> +                                        struct sk_buff *skb)
> +{
> +       struct hci_op_read_local_codec_caps *sent;
> +       struct hci_rp_read_local_codec_caps *rp;
> +
> +       rp = (void *)skb->data;

We should attempt to always use construct like the following when
checking the remaining/received bytes of packet:

 if (skb->len < sizeof(*rp))
    bt_dev_err

skb_pull(skb, sizeof(*rp));

Or perhaps introduce something like:

void *bt_skb_pull_mem(skb, len)
{
    void *data = skb->data;

    if (skb->len < len) {
        return NULL;
    }

    skb_pull(skb, len);

    return data;
}

That way we can use it like:

rp = bt_skb_pull_mem(skb, sizeof(*rp));
if (!rp)
     bt_dev_err

> +
> +       bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
> +
> +       if (rp->status)
> +               return;
> +
> +       sent = hci_sent_cmd_data(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS);
> +
> +       if (!sent)
> +               return;
> +
> +       hci_dev_lock(hdev);
> +
> +       bt_dev_info(hdev, "Adding Codec. No of caps: %u", rp->num_caps);

> +       hci_codec_list_add(&hdev->local_codecs, rp, skb->len - 2, sent);
> +
> +       hci_dev_unlock(hdev);
> +}
> +
>  static void hci_cc_read_clock(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>         struct hci_rp_read_clock *rp = (void *) skb->data;
> @@ -3591,6 +3618,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
>                 hci_cc_read_local_codecs_v2(hdev, skb);
>                 break;
>
> +       case HCI_OP_READ_LOCAL_CODEC_CAPS:
> +               hci_cc_read_local_codec_caps(hdev, skb);
> +               break;
> +
>         case HCI_OP_READ_FLOW_CONTROL_MODE:
>                 hci_cc_read_flow_control_mode(hdev, skb);
>                 break;
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
