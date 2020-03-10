Return-Path: <SRS0=NTC4=43=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D79EC10F27
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 15:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD6821D56
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Mar 2020 15:13:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNhBFVt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgCJPNq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Mar 2020 11:13:46 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35780 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgCJPNq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Mar 2020 11:13:46 -0400
Received: by mail-lf1-f66.google.com with SMTP id g4so4877015lfh.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Mar 2020 08:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=spzCKc8S6LfvFynZFO7ItpbSn1G2xLTSQ7Xhauukxnk=;
        b=dNhBFVt7TeLoUfaHFpOmBOqRwG50681Xtdaw8+ijVg7Q/yHazU9li3H6dyNpCbs39V
         +gkfgdTUXgB+U8oZDhDMT1tMBhGCAex0oSYfTP32l2m7czDNUFTKl+1VsTbkG1ANYLS6
         xVFi/2qk+ItEQx312YYxoHGeN/H85XI0jJgc/DOJzkp4+CZvwHK0ywBYrcweLg02n2tR
         gXhebn5XQ29zLlB/rnEC5WBnuK3HvXVAt80wNf2xUWGz5DwcktdjRW826nYBLlnCJYH9
         KJiyPerBvsDGsR1qYEGdMxe+aMDjHZUiODa/sFdMTN3tIZCKIj/9g7DBdrDBVcU16jX3
         /8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=spzCKc8S6LfvFynZFO7ItpbSn1G2xLTSQ7Xhauukxnk=;
        b=nODGyDt680d9H3Ku2k3zUh5kDnAobgYkUaOtVBNf37DXoqnqbjY4iXFsJe2QpH94Fw
         A721OaaHT7S0+qABluzYTK1kEdCPv6sJsyA2kTfggvOqU59HW4BWax+X/tEYGOcln6X2
         ITmvIFr8WGVLXghPxNDkBtIgdvyKtH4iGj21UYHVfgjSejCoCFjnRHJmAUnNMjKMNRbd
         Jq5+8+3PDR2d9LQbsagXYEeAAMtIeMDrbIImaOekZxNqpAI5wESpRUtuLX5QWrl2iKfH
         Z4uKcJ+sL38pTnpvV6YBy6GjtuEnYrlGJ07jR+XDD/JdThimkUa0DmDUg6xVIX7RW0cp
         F27w==
X-Gm-Message-State: ANhLgQ2VdwMi2b91uNe7XxOS/ZpossSHXl7Lptp6uxX5yMU6y4BbEWfe
        8i+NvBPfuYHuH3MTGkAaTkYLbQ2lxt5urFQyaSIRfQ==
X-Google-Smtp-Source: ADFU+vuTQOhLgkqcEOf8x+fxQmpfJmuDMx8cmmwWUMOgbU59rt/GvwEWDYRkDk9oNr3YLAECjHcStkFRyYRCf18hpU4=
X-Received: by 2002:ac2:5c5d:: with SMTP id s29mr12973816lfp.191.1583853221900;
 Tue, 10 Mar 2020 08:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200309214456.431153-1-marcel@holtmann.org>
In-Reply-To: <20200309214456.431153-1-marcel@holtmann.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Tue, 10 Mar 2020 11:13:30 -0400
Message-ID: <CALWDO_W3evZoauZJVzD8fB0HOZBFO8hZ7+pgseMvAgY46CwrRw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: bfusb: Switch from BT_ERR to bt_dev_err where possible
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Mon, Mar 9, 2020 at 5:45 PM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> All HCI device specific error messages shall use bt_dev_err to indicate
> the device name in the message.
>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  drivers/bluetooth/bfusb.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
> index 0e5954cac98e..5a321b4076aa 100644
> --- a/drivers/bluetooth/bfusb.c
> +++ b/drivers/bluetooth/bfusb.c
> @@ -133,8 +133,8 @@ static int bfusb_send_bulk(struct bfusb_data *data, struct sk_buff *skb)
>
>         err = usb_submit_urb(urb, GFP_ATOMIC);
>         if (err) {
> -               BT_ERR("%s bulk tx submit failed urb %p err %d",
> -                                       data->hdev->name, urb, err);
> +               bt_dev_err(data->hdev, "bulk tx submit failed urb %p err %d",
> +                          urb, err);
>                 skb_unlink(skb, &data->pending_q);
>                 usb_free_urb(urb);
>         } else
> @@ -232,8 +232,8 @@ static int bfusb_rx_submit(struct bfusb_data *data, struct urb *urb)
>
>         err = usb_submit_urb(urb, GFP_ATOMIC);
>         if (err) {
> -               BT_ERR("%s bulk rx submit failed urb %p err %d",
> -                                       data->hdev->name, urb, err);
> +               bt_dev_err(data->hdev, "bulk rx submit failed urb %p err %d",
> +                          urb, err);
>                 skb_unlink(skb, &data->pending_q);
>                 kfree_skb(skb);
>                 usb_free_urb(urb);
> @@ -247,7 +247,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
>         BT_DBG("bfusb %p hdr 0x%02x data %p len %d", data, hdr, buf, len);
>
>         if (hdr & 0x10) {
> -               BT_ERR("%s error in block", data->hdev->name);
> +               bt_dev_err(data->hdev, "error in block");
>                 kfree_skb(data->reassembly);
>                 data->reassembly = NULL;
>                 return -EIO;
> @@ -259,13 +259,13 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
>                 int pkt_len = 0;
>
>                 if (data->reassembly) {
> -                       BT_ERR("%s unexpected start block", data->hdev->name);
> +                       bt_dev_err(data->hdev, "unexpected start block");
>                         kfree_skb(data->reassembly);
>                         data->reassembly = NULL;
>                 }
>
>                 if (len < 1) {
> -                       BT_ERR("%s no packet type found", data->hdev->name);
> +                       bt_dev_err(data->hdev, "no packet type found");
>                         return -EPROTO;
>                 }
>
> @@ -277,7 +277,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
>                                 struct hci_event_hdr *hdr = (struct hci_event_hdr *) buf;
>                                 pkt_len = HCI_EVENT_HDR_SIZE + hdr->plen;
>                         } else {
> -                               BT_ERR("%s event block is too short", data->hdev->name);
> +                               bt_dev_err(data->hdev, "event block is too short");
>                                 return -EILSEQ;
>                         }
>                         break;
> @@ -287,7 +287,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
>                                 struct hci_acl_hdr *hdr = (struct hci_acl_hdr *) buf;
>                                 pkt_len = HCI_ACL_HDR_SIZE + __le16_to_cpu(hdr->dlen);
>                         } else {
> -                               BT_ERR("%s data block is too short", data->hdev->name);
> +                               bt_dev_err(data->hdev, "data block is too short");
>                                 return -EILSEQ;
>                         }
>                         break;
> @@ -297,7 +297,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
>                                 struct hci_sco_hdr *hdr = (struct hci_sco_hdr *) buf;
>                                 pkt_len = HCI_SCO_HDR_SIZE + hdr->dlen;
>                         } else {
> -                               BT_ERR("%s audio block is too short", data->hdev->name);
> +                               bt_dev_err(data->hdev, "audio block is too short");
>                                 return -EILSEQ;
>                         }
>                         break;
> @@ -305,7 +305,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
>
>                 skb = bt_skb_alloc(pkt_len, GFP_ATOMIC);
>                 if (!skb) {
> -                       BT_ERR("%s no memory for the packet", data->hdev->name);
> +                       bt_dev_err(data->hdev, "no memory for the packet");
>                         return -ENOMEM;
>                 }
>
> @@ -314,7 +314,7 @@ static inline int bfusb_recv_block(struct bfusb_data *data, int hdr, unsigned ch
>                 data->reassembly = skb;
>         } else {
>                 if (!data->reassembly) {
> -                       BT_ERR("%s unexpected continuation block", data->hdev->name);
> +                       bt_dev_err(data->hdev, "unexpected continuation block");
>                         return -EIO;
>                 }
>         }
> @@ -366,8 +366,7 @@ static void bfusb_rx_complete(struct urb *urb)
>                 }
>
>                 if (count < len) {
> -                       BT_ERR("%s block extends over URB buffer ranges",
> -                                       data->hdev->name);
> +                       bt_dev_err(data->hdev, "block extends over URB buffer ranges");
>                 }
>
>                 if ((hdr & 0xe1) == 0xc1)
> @@ -391,8 +390,8 @@ static void bfusb_rx_complete(struct urb *urb)
>
>         err = usb_submit_urb(urb, GFP_ATOMIC);
>         if (err) {
> -               BT_ERR("%s bulk resubmit failed urb %p err %d",
> -                                       data->hdev->name, urb, err);
> +               bt_dev_err(data->hdev, "bulk resubmit failed urb %p err %d",
> +                          urb, err);
>         }
>
>  unlock:
> @@ -477,7 +476,7 @@ static int bfusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
>         /* Max HCI frame size seems to be 1511 + 1 */
>         nskb = bt_skb_alloc(count + 32, GFP_KERNEL);
>         if (!nskb) {
> -               BT_ERR("Can't allocate memory for new packet");
> +               bt_dev_err(hdev, "Can't allocate memory for new packet");
>                 return -ENOMEM;
>         }
>
> --
> 2.24.1
>

LGTM.
