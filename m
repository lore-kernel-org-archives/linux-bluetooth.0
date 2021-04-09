Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7EAC433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 17:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E978610A3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Apr 2021 17:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbhDIRPn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Apr 2021 13:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbhDIRPm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Apr 2021 13:15:42 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C04EC061760
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Apr 2021 10:15:28 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 101-20020a9d0d6e0000b02902816815ff62so505425oti.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Apr 2021 10:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YsGx5WpKFFlvGSMTwpXNxBD6YkC6mTr6sth5Z11B1Xg=;
        b=hkAH0wWetpkkTkZdKU1ZYWwzT5QjEk9MFUjtuxEM4zzGGKHFGEkxMQeSFTfrIv/99E
         860OPD7IQK/ANXtDTPbBlMuLpfmjO2OkcfCUKP9835RT1DaOPR/8fEXycPRFXKmN1yys
         WzT5MPS/sJEVoY48OoO0Tcdz+6vgE25TeZD1v7LzDdpFxzgEXyg7oEgYCQ7ok3An1OAO
         HBp6SaPzUIpIdHu4iGFN0vRPDySlpLfnzU9YZhx0ZlGgizvBJ2sE+EloWBm6uf+9OBcl
         /9BHsnd3dBkyUfAThhLOHywIF14XQnIUZRFFEX3BEayyPPTFMtaY0zky044RuuVRMtsW
         sG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YsGx5WpKFFlvGSMTwpXNxBD6YkC6mTr6sth5Z11B1Xg=;
        b=HzOrhuST1I5Brg8Z6REv0u/+/bdiuG26Wb4DftrEvHzpN/OeKn7eYPKmfzfUiMo3mZ
         t8ZtFyQEptQsznf/gVLOtOGJsAKZOsJa8NdtCN2mTByFqxjy518dEu2ZNYUwThswiHgm
         zKGWiJkYiCSy0Kfl+OLGkMxPO9QH2iV+8X26mKo5LmnP0HruceUpnE8RaHzCKFfktL/I
         PEfeXw310T+XjAe2RpAN02Jws8nE7YosKEQC2G4FrrdX0xd2QgRKFq/KPz9jl/7yOWAl
         QY0Ld05YB/ldpj9oTIIFln4olECbUCy6bkAV2zW0nmrR4tFY+DLkRLwinxPcXGYsX11n
         qgJA==
X-Gm-Message-State: AOAM533iKjAZDB6RxzturJIGj6SeOOFnS9vBPsRnr61gYjI4pRejW5S0
        NCEqTib8tE88cC5MF11VXiHi5c8HACT/UCfCy4c=
X-Google-Smtp-Source: ABdhPJzQmsy9Y4TIF8qhFP0U5p77n4YQLYpOViTSoTaSrmnLDgXzWi7jVYkZabQ2we3ibRNLYnuWh9bqeRNOBaj16vw=
X-Received: by 2002:a9d:7cd2:: with SMTP id r18mr13517766otn.240.1617988527694;
 Fri, 09 Apr 2021 10:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210409122405.29850-1-kiran.k@intel.com> <20210409122405.29850-3-kiran.k@intel.com>
In-Reply-To: <20210409122405.29850-3-kiran.k@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 9 Apr 2021 10:15:16 -0700
Message-ID: <CABBYNZKBuUAB9-Sq72F_XJr57woD4tC2N01jtNnSLhsRsXkomw@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] Bluetooth: add support to enumerate local supports
 codecs v2
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
> Add support for HCI_Read_Local_Supported_Codecs_V2 and query codec
> capabilities
>
> snoop:
> > HCI Event: Command Complete (0x0e) plen 20
>       Read Local Supported Codecs V2 (0x04|0x000d) ncmd 1
>         Status: Success (0x00)
>         Number of supported codecs: 7
>           Codec: u-law log (0x00)
>           Logical Transport Type: 0x02
>             Codec supported over BR/EDR SCO and eSCO
>           Codec: A-law log (0x01)
>           Logical Transport Type: 0x02
>             Codec supported over BR/EDR SCO and eSCO
>           Codec: CVSD (0x02)
>           Logical Transport Type: 0x02
>             Codec supported over BR/EDR SCO and eSCO
>           Codec: Transparent (0x03)
>           Logical Transport Type: 0x02
>             Codec supported over BR/EDR SCO and eSCO
>           Codec: Linear PCM (0x04)
>           Logical Transport Type: 0x02
>             Codec supported over BR/EDR SCO and eSCO
>           Codec: Reserved (0x08)
>           Logical Transport Type: 0x03
>             Codec supported over BR/EDR ACL
>             Codec supported over BR/EDR SCO and eSCO
>           Codec: mSBC (0x05)
>           Logical Transport Type: 0x03
>             Codec supported over BR/EDR ACL
>             Codec supported over BR/EDR SCO and eSCO
>         Number of vendor codecs: 0
> ......
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
>  include/net/bluetooth/hci.h      |  2 +
>  include/net/bluetooth/hci_core.h | 10 ++++
>  net/bluetooth/hci_core.c         |  4 +-
>  net/bluetooth/hci_event.c        | 98 ++++++++++++++++++++++++++++++++
>  4 files changed, 113 insertions(+), 1 deletion(-)
>
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index e3f7771fe84f..34eb9f4b027f 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -1314,6 +1314,8 @@ struct hci_rp_read_local_pairing_opts {
>         __u8     max_key_size;
>  } __packed;
>
> +#define HCI_OP_READ_LOCAL_CODECS_V2    0x100d
> +
>  #define HCI_OP_READ_LOCAL_CODEC_CAPS   0x100e
>  struct hci_op_read_local_codec_caps {
>         __u8    codec_id[5];
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index c73ac52af186..fa0c68fd3306 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1848,4 +1848,14 @@ void hci_copy_identity_address(struct hci_dev *hdev, bdaddr_t *bdaddr,
>  #define SCO_AIRMODE_CVSD       0x0000
>  #define SCO_AIRMODE_TRANSP     0x0003
>
> +#define LOCAL_CODEC_ACL_MASK   BIT(0)
> +#define LOCAL_CODEC_SCO_MASK   BIT(1)
> +#define LOCAL_CODEC_LECIS_MASK BIT(2)
> +#define LOCAL_CODEC_LEBIS_MASK BIT(3)

Not need to use the LE prefix, just CIS and BIS alone should be clear.

> +
> +#define LOCAL_CODEC_ACL                0x00
> +#define LOCAL_CODEC_SCO                0x01
> +#define LOCAL_CODEC_LECIS      0x02
> +#define LOCAL_CODEC_LEBIS      0x03

Ditto.

>  #endif /* __HCI_CORE_H */
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index fd12f1652bdf..230aeedd6d00 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -839,7 +839,9 @@ static int hci_init4_req(struct hci_request *req, unsigned long opt)
>                 hci_set_event_mask_page_2(req);
>
>         /* Read local codec list if the HCI command is supported */
> -       if (hdev->commands[29] & 0x20)
> +       if (hdev->commands[45] & 0x04)
> +               hci_req_add(req, HCI_OP_READ_LOCAL_CODECS_V2, 0, NULL);
> +       else if (hdev->commands[29] & 0x20)
>                 hci_req_add(req, HCI_OP_READ_LOCAL_CODECS, 0, NULL);
>
>         /* Read local pairing options if the HCI command is supported */
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index ceed5a5d332b..a16723c89dc6 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -939,6 +939,100 @@ static void hci_cc_read_local_codecs(struct hci_dev *hdev,
>         }
>  }
>
> +static void hci_cc_read_local_codecs_v2(struct hci_dev *hdev,
> +                                       struct sk_buff *skb)
> +{
> +       __u8 num_codecs, transport;
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
> +       num_codecs = skb->data[0];
> +
> +       bt_dev_info(hdev, "Number of standard codecs: %u", num_codecs);
> +
> +       skb_pull(skb, 1);
> +       ptr = (__u8 *)skb->data;
> +
> +       skb_pull(skb, num_codecs * 2);

The above would likely cause crashes if the event is malformed
(num_codecs exceeds the skb->len).

> +       while (num_codecs--) {
> +               caps.codec_id[0] = *ptr++;
> +               transport = *ptr++;

Like I said in the other patch, let's not use another pointer to
advance in the packet when we can use skb_pull after checking the
skb->len.

> +               caps.direction = 0x00;
> +
> +               if (transport & LOCAL_CODEC_ACL_MASK) {
> +                       caps.transport = LOCAL_CODEC_ACL;
> +                       hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS, sizeof(caps),
> +                                    &caps);
> +               }
> +
> +               if (transport & LOCAL_CODEC_SCO_MASK) {
> +                       caps.transport = LOCAL_CODEC_SCO;
> +                       hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS, sizeof(caps),
> +                                    &caps);
> +               }
> +
> +               if (transport & LOCAL_CODEC_LEBIS_MASK) {
> +                       caps.transport = LOCAL_CODEC_LEBIS;
> +                       hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS, sizeof(caps),
> +                                    &caps);
> +               }
> +
> +               if (transport & LOCAL_CODEC_LECIS_MASK) {
> +                       caps.transport = LOCAL_CODEC_LECIS;
> +                       hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS, sizeof(caps),
> +                                    &caps);
> +               }
> +       }
> +
> +       /* enumerate vendor specific codecs */
> +       num_codecs = skb->data[0];
> +       skb_pull(skb, 1);
> +
> +       bt_dev_info(hdev, "Number of vendor specific codecs: %u", num_codecs);
> +
> +       ptr = (__u8 *)skb->data;
> +
> +       while (num_codecs--) {
> +               caps.codec_id[0] = 0xFF;
> +               memcpy(&caps.codec_id[1], ptr, 4);
> +               ptr += 4;
> +               transport = *ptr++;
> +               caps.direction = 0x00;
> +
> +               if (transport & LOCAL_CODEC_ACL_MASK) {
> +                       caps.transport = LOCAL_CODEC_ACL;
> +                       hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS, sizeof(caps),
> +                                    &caps);
> +               }
> +
> +               if (transport & LOCAL_CODEC_SCO_MASK) {
> +                       caps.transport = LOCAL_CODEC_SCO;
> +                       hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS, sizeof(caps),
> +                                    &caps);
> +               }
> +
> +               if (transport & LOCAL_CODEC_LEBIS) {
> +                       caps.transport = LOCAL_CODEC_LEBIS;
> +                       hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS, sizeof(caps),
> +                                    &caps);
> +               }
> +
> +               if (transport & LOCAL_CODEC_LECIS_MASK) {
> +                       caps.transport = LOCAL_CODEC_LECIS;
> +                       hci_send_cmd(hdev, HCI_OP_READ_LOCAL_CODEC_CAPS, sizeof(caps),
> +                                    &caps);
> +               }
> +       }
> +}
> +
>  static void hci_cc_read_clock(struct hci_dev *hdev, struct sk_buff *skb)
>  {
>         struct hci_rp_read_clock *rp = (void *) skb->data;
> @@ -3493,6 +3587,10 @@ static void hci_cmd_complete_evt(struct hci_dev *hdev, struct sk_buff *skb,
>                 hci_cc_read_local_codecs(hdev, skb);
>                 break;
>
> +       case HCI_OP_READ_LOCAL_CODECS_V2:
> +               hci_cc_read_local_codecs_v2(hdev, skb);
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
