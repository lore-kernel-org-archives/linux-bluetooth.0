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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39C3C433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 17:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E64F610F7
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 17:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbhDIRCa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Apr 2021 13:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbhDIRC2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Apr 2021 13:02:28 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39E6C061760
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Apr 2021 10:02:11 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id w21-20020a9d63950000b02901ce7b8c45b4so6332158otk.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Apr 2021 10:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AlcmUeHXPpsvej4Ys+csMJ9Vx7vt7TLl9vqazEWvbgI=;
        b=dP6LAYrTKsr5VMtAJSbuZCwr7G8prXL/PO8nV4Q6JX0HzWzGoih74jlxyLOxCgaQyW
         3q1sgd4PfaSvQeTyRrtt9thWA1v4FK98HdpuA0DW5OoV+qFk6E/VL4jXeMrBcrd8QI2k
         lK8RR2Ds0jCU24SBDZujDnVY3gPBL6cXrmsmGyBkLYRkAtlptQNyXGrW4t3HtMv5oz8u
         U5C1mWTYsTp5uDYQprGZ/cbMXqpbWhP2vgNBQuhIjT1MTOzXhhhRfgIi6P3Gc2aPmSpQ
         QwtnEDtiOv/jfZnMTO15UrtAvGhC902XTWteoX9MpRPJ3QOdVOlqlXDjL2dawN+MnYBu
         z40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AlcmUeHXPpsvej4Ys+csMJ9Vx7vt7TLl9vqazEWvbgI=;
        b=LZKA6Q3ilOml7t40epKpTPqxh5jRtez6ZtIE9YaHkKTAt8GRGhR4+Q8NrumttZpyT9
         CuCUt+ObpAYRbduUawmc4TBAjipLX/+SQy9xrVhOvUPnVLr1GY66JE14fo9+nnb2bZR4
         U60LjdDT7TT2XdYFkpHxo6sl7nHrTiQm48hISoMnGLL/QH1Cd0fUJnnjVVED8SzYkrdC
         BfP0JcjlkNliN5h6qDa4h5FPMzyjjtEYoHLvNV/lV6XEXWSoHBZlhaDJdtllzBTdo50V
         AXnPwesogGADfjmh/7r9YWijViGjSWRux2GOfjp0jsc0gjD8xA1DZy7g0XMNYO2JEMG8
         Xsiw==
X-Gm-Message-State: AOAM531vxkSaYuX9o4mEoBm3tSFABJ35HDgrst0qQbSSDofgMbjpPQBl
        EAmplg+ci2coXnlXhLr70uTNF5xZ8FA6dyeBYeQ=
X-Google-Smtp-Source: ABdhPJxAAPQpFCTQAyW3/wK2tbhO4KCGq41Xiuqr/kz0kK1oJRpn3y+y4TF/8eyG7eAB8usi4792Pg/09LdKEh8/IjU=
X-Received: by 2002:a9d:7cd2:: with SMTP id r18mr13470730otn.240.1617987731252;
 Fri, 09 Apr 2021 10:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210409122405.29850-1-kiran.k@intel.com> <20210409122405.29850-2-kiran.k@intel.com>
In-Reply-To: <20210409122405.29850-2-kiran.k@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 9 Apr 2021 10:02:00 -0700
Message-ID: <CABBYNZLm5jqbzDVNLRG4G1bSgK8AwCPmz_gjGZ92Oo2EZxfpvQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] Bluetooth: add support to enumerate codec capabilities
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
> add support to enumerate local supported codec capabilities
>
> < HCI Command: Read Local Suppor.. (0x04|0x000e) plen 7
>         Codec: mSBC (0x05)
>         Logical Transport Type: 0x00
>         Direction: Input (Host to Controller) (0x00)
> > HCI Event: Command Complete (0x0e) plen 12
>       Read Local Supported Codec Capabilities (0x04|0x000e) ncmd 1
>         Status: Success (0x00)
>         Number of codec capabilities: 1
>          Capabilities #0:
>         00 00 11 15 02 33
>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
> ---
>  include/net/bluetooth/hci.h |  7 +++++
>  net/bluetooth/hci_event.c   | 56 +++++++++++++++++++++++++++++++++++++
>  2 files changed, 63 insertions(+)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index ea4ae551c426..e3f7771fe84f 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1314,6 +1314,13 @@ struct hci_rp_read_local_pairing_opts {
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
>  #define HCI_OP_READ_PAGE_SCAN_ACTIVITY 0x0c1b
>  struct hci_rp_read_page_scan_activity {
>         __u8     status;
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 016b2999f219..ceed5a5d332b 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -887,6 +887,58 @@ static void hci_cc_read_data_block_size(struct hci_dev *hdev,
>                hdev->block_cnt, hdev->block_len);
>  }
>
> +static void hci_cc_read_local_codecs(struct hci_dev *hdev,
> +                                    struct sk_buff *skb)
> +{
> +       __u8 num_codecs;
> +       __u8 *ptr;
> +       struct hci_op_read_local_codec_caps caps;
> +
> +       bt_dev_dbg(hdev, "status 0x%2.2x", skb->data[0]);
> +
> +       if (skb->data[0])
> +               return;
> +
> +       /* enumerate standard codecs */
> +       skb_pull(skb, 1);

After each skb_pull check the expected length against skb->len.

> +       num_codecs = skb->data[0];
> +
> +       bt_dev_dbg(hdev, "Number of standard codecs: %u", num_codecs);
> +
> +       skb_pull(skb, 1);

Ditto.

> +       ptr = (__u8 *)skb->data;
> +
> +       skb_pull(skb, num_codecs);
> +
> +       while (num_codecs--) {
> +               caps.codec_id[0] = *ptr++;

Lets just use skb_pull to advance on the codecs ids, that way we can
properly check the remaining length with use of skb->len.

> +               caps.transport = 0x00;
> +               caps.direction = 0x00;
> +
> +               hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS, sizeof(caps),
> +                            &caps);
> +       }
> +
> +       /* enumerate vendor specific codecs */
> +       num_codecs = skb->data[0];
> +       skb_pull(skb, 1);
> +
> +       bt_dev_dbg(hdev, "Number of vendor specific codecs: %u", num_codecs);
> +
> +       ptr = (__u8 *)skb->data;
> +
> +       while (num_codecs--) {
> +               caps.codec_id[0] = 0xFF;
> +               memcpy(&caps.codec_id[1], ptr, 4);
> +               ptr += 4;
> +               caps.transport = 0x00;
> +               caps.direction = 0x00;
> +
> +               hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS, sizeof(caps),
> +                            &caps);
> +       }
> +}
> +
>  static void hci_cc_read_clock(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>         struct hci_rp_read_clock *rp = (void *) skb->data;
> @@ -3437,6 +3489,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
>                 hci_cc_read_data_block_size(hdev, skb);
>                 break;
>
> +       case HCI_OP_READ_LOCAL_CODECS:
> +               hci_cc_read_local_codecs(hdev, skb);
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
