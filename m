Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A92AC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Oct 2022 23:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiJDXqt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Oct 2022 19:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiJDXqr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Oct 2022 19:46:47 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E32E12D3A
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Oct 2022 16:46:40 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y5so3679713lfl.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Oct 2022 16:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=whALt7pNVL+koxRXWTvV8NjAjJN74CteWKaDreVtPBI=;
        b=bWFdSiPieg1VEi5s/sGOVWR/fRpnWI1mFobPEqc/xK6CG03C+BKc+9KT7zIM5pKNq7
         giweksMEb2UEnlF501kvss0u7/VGQJiRphb5pia2fEHCcfxxEuZsyBX220kR59tZgDKz
         AGRgCtiEYv/PF1ztaZT8+mPWMIggV9ICTx2yB4QDzzR/xFek6XR5dRZv5UgDN7mu+jvM
         pXZVP+WfVFp7+0lsH4EWsyiGJRtY/9ldOUCKD6YXbVKc2gdzOFIu0TcFxIgD6VY7tnCv
         fdnpARonifkTdhd1GXo4sbYAJQCX90YfiwVzPEW4LMnMk8uHs+wXknxOGKz5ekaF0aGS
         Jgdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=whALt7pNVL+koxRXWTvV8NjAjJN74CteWKaDreVtPBI=;
        b=jflrSKj7Phpka3wH8v03hWJNAsw5s22z/YEa0o4TFNxi/F4MxU9n27+h9DclckBs4u
         rZ9zoFZwB80b1fIBp05V2EJNn84vaW2PhdFDuXKn5n64zWSCq++EQM4NHGPNkGzkmF8m
         5HirM6hKNtuKNKp0H9eoRDIGRnNsUxseP/7rZ/2uvjwjPscpPreMFjMMfleIPMVJYjNW
         R4kUdQkYiv4QLk2/iDRp1x7TvAOpQxKh1D6cyqg/nHEOogVvLMsLXTHHNqGS6lbIHEmk
         oCoyB5roo9eSmX3YdS1cRCZV3Xe1b2upG7loViIic13iuySV9EIg6h83I1KE0Zu4YjMz
         3qRQ==
X-Gm-Message-State: ACrzQf1VqfBbdKfpnl7p76R+SnXvk5kVTiAkEFTAuRujB322c3jNmi5V
        UFsR8qIVBaYapsBLLs4hN7xhdYG8rcqqFpFTUamNXgVm
X-Google-Smtp-Source: AMsMyM79D8NajJZKQCkSaGpkmanlpvHEFE1Xg0bHNFzW5X3CBx384P0CjmfEk57iKXW45js791nlIW32Y6Y840U1AuU=
X-Received: by 2002:a05:6512:2150:b0:4a2:2f09:9629 with SMTP id
 s16-20020a056512215000b004a22f099629mr5488152lfr.198.1664927198079; Tue, 04
 Oct 2022 16:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221004145351.13066-1-nicolas.cavallari@green-communications.fr>
In-Reply-To: <20221004145351.13066-1-nicolas.cavallari@green-communications.fr>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 4 Oct 2022 16:46:26 -0700
Message-ID: <CABBYNZJwti_jYq2ctGfgAeh3OS5ed7WqxwBhPhoxrL51Cciy2w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Work around SCO over USB HCI design defect
To:     Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Nicolas,

On Tue, Oct 4, 2022 at 7:54 AM Nicolas Cavallari
<nicolas.cavallari@green-communications.fr> wrote:
>
> The USB interface between the host and the bluetooth adapter used for
> SCO packets uses an USB isochronous endpoint with a fragmentation scheme
> that does not tolerate errors.  Except USB isochronous transfers do
> not provide a reliable stream with guaranteed delivery. (There is no
> retry on error, see USB spec v2.0 5.6 and 8.5.5.)
>
> To fragment a packet, the bluetooth HCI simply splits it in parts and
> transfer them as-is.  The receiver is expected to reconstruct the packet
> by assuming the first fragment contains the header and parsing its size
> field.  There is no error detection either.
>
> If a fragment is lost, the end result is that the kernel is no longer
> synchronized and will pass malformed data to the upper layers, since it
> has no way to tell if the first fragment is an actual first fragment or
> a continuation fragment.  Resynchronization can only happen by luck and
> requires an unbounded amount of time.
>
> The typical symptom for a HSP/HFP bluetooth headset is that the
> microphone stops working and dmesg contains piles of rate-limited
> "Bluetooth: hci0: SCO packet for unknown connection handle XXXX"
> errors for an indeterminate amount of time, until the kernel accidentally
> resynchronize.
>
> A workaround is to ask the upper layer to prevalidate the first fragment
> header.  This is not possible with user channels so this workaround is
> disabled in this case.
>
> This problem is the most severe when using an ath3k adapter on an i.MX 6
> board, where packet loss occur regularly, possibly because it is an USB1
> device connected on an USB2 hub and this is a special case requiring
> split transactions.

Interesting, but does this actually make it work if with the packet losses?

> Signed-off-by: Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
>
> ---
> v2: fix typos in commit description and expand it
>
>  drivers/bluetooth/btusb.c        |  7 +++++--
>  include/net/bluetooth/hci_core.h | 20 ++++++++++++++++++++
>  2 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 15caa6469538..f6256af98233 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -980,9 +980,12 @@ static int btusb_recv_isoc(struct btusb_data *data, void *buffer, int count)
>
>                 if (skb->len == HCI_SCO_HDR_SIZE) {
>                         /* Complete SCO header */
> -                       hci_skb_expect(skb) = hci_sco_hdr(skb)->dlen;
> +                       struct hci_sco_hdr *hdr = hci_sco_hdr(skb);
>
> -                       if (skb_tailroom(skb) < hci_skb_expect(skb)) {
> +                       hci_skb_expect(skb) = hdr->dlen;
> +
> +                       if (skb_tailroom(skb) < hci_skb_expect(skb) ||
> +                           !hci_conn_prevalidate_sco_hdr(data->hdev, hdr)) {
>                                 kfree_skb(skb);
>                                 skb = NULL;
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> index e7862903187d..d589b54e89e6 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1286,6 +1286,26 @@ static inline struct hci_conn *hci_lookup_le_connect(struct hci_dev *hdev)
>         return NULL;
>  }
>
> +static inline bool hci_conn_prevalidate_sco_hdr(struct hci_dev *hdev,
> +                                               struct hci_sco_hdr *hdr)
> +{
> +       __u16 handle;
> +
> +       if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL))
> +               // Can't validate, userspace controls everything.
> +               return true;
> +
> +       handle = hci_handle(__le16_to_cpu(hdr->handle));
> +
> +       switch (hci_conn_lookup_type(hdev, handle)) {
> +       case SCO_LINK:
> +       case ESCO_LINK:
> +               return true;
> +       default:
> +               return false;
> +       }
> +}

Don't really like to have this in hci_core.h, it is sort of messy
already beside this is probably too specific to USB so I'd go with
something like btusb_validate_sco_handle and add a comment explaining
why this is necessary.

>  int hci_disconnect(struct hci_conn *conn, __u8 reason);
>  bool hci_setup_sync(struct hci_conn *conn, __u16 handle);
>  void hci_sco_setup(struct hci_conn *conn, __u8 status);
> --
> 2.37.2
>


-- 
Luiz Augusto von Dentz
