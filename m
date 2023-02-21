Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67744C61DA3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Feb 2023 22:08:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjBUWIr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Feb 2023 17:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjBUWIq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Feb 2023 17:08:46 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 722E5BBA1
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Feb 2023 14:08:44 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id f41so7569304lfv.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Feb 2023 14:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tmaAFo+nFslY+zi1KbD+235pqzR8vld8pQVbeQj2iq4=;
        b=TA0cpzdP3P+6F4o98ycHufzOvWHNmgPDd9dOg8X/MNBEVUPfX6KidyY0TqhbHnttd1
         XQwnxv8p/3/IOswR3VqVZh+Djx1sIjfQ0Wud18YiaaGcAUpULg7kfOjBZ55eDFh+szi4
         mk6/0KZwPM08sFklOF7wsp0aO8UETKgatX9DqkaWL++mLJME65MNlXYfOpc+b5Q5E2/4
         ytzXGyiavmLzYkMVe1IWtQeSixEd6nJ8c/Fb8ztGfdaxorW0oFb+j81Hj95uylm57h1J
         khxvS7Fe0JJRg3saFOrW6A3QAYVZc2JPk9gIZsAYHP7GqwwwReXub4xNrgyvnyBNg1F0
         VrrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tmaAFo+nFslY+zi1KbD+235pqzR8vld8pQVbeQj2iq4=;
        b=bKB9DDhc1thv7C04ITOW01iUTJLfrbv9hm4l6GjJskIIq20P0iKYwaCqpus9YdX0M7
         5Rppjd9auHSWX72rnDZHNUnMSvXmc/4a5EMqKPtPhRAVilP4cs+BiU4LBzgETkIR482H
         CqsAsd01BF5OUbpfcRZXFRYe9ZPgAqcCoFVTVZots7TzoPcHTr6RwNgf4u0QaYmyA+kQ
         o4lpJ7hb8F9bXc3GEIfbMxJtb7h/4dGV/k9imHp/1NqkarV8x6sTKlKGXuxqOh9oXdTe
         jyiaAcJjTfAvirigu47dg9E0YXm/Hg6azXWCOXguBS+ko9WJ0YwBx2rz6Q1Xqk2j3Xbb
         8TBg==
X-Gm-Message-State: AO0yUKXKdKHRWlses/sr9zUSUro+XYBb3OYLXbr95oODq08HXFwPSvSj
        dYRxPNElH/xF6xFC+VR01EU+okrS82vPvi6T3ZPzy3lf0U4=
X-Google-Smtp-Source: AK7set8oOM8OB/Qo/ZN0Cc2WG7/hcWHJLnCM3qSTbD8ppNAc647yhOh4kEirCmOVXEMKaxXLhaeHXTBYnTE/ffoqirE=
X-Received: by 2002:ac2:530a:0:b0:4db:4604:6325 with SMTP id
 c10-20020ac2530a000000b004db46046325mr2123165lfh.8.1677017322501; Tue, 21 Feb
 2023 14:08:42 -0800 (PST)
MIME-Version: 1.0
References: <1fd2d4523c139deda93aab2c31f1508d79c32472.1676921889.git.pav@iki.fi>
In-Reply-To: <1fd2d4523c139deda93aab2c31f1508d79c32472.1676921889.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 21 Feb 2023 14:08:31 -0800
Message-ID: <CABBYNZ+kGVtCXN1X7ZOG64mLfWfXBah_Qo5+cy2dGWQMbNidoA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: ISO: fix timestamped HCI ISO data packet parsing
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Mon, Feb 20, 2023 at 11:42 AM Pauli Virtanen <pav@iki.fi> wrote:
>
> Use correct HCI ISO data packet header struct when the packet has
> timestamp. The timestamp, when present, goes before the other fields
> (Core v5.3 4E 5.4.5), so the structs are not compatible.
>
> Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>
> Notes:
>     My hardware doesn't seem to produce timestamped packets, so this is not
>     properly tested, except to the extent that it doesn't break the
>     non-timestamped code path.
>
>     Regardless, the current state of things looks wrong, so sending this to
>     the list in any case.

Perhaps we should first attempt to enable this in the emulator, Id use
BT_HCI_CMD_LE_READ_ISO_TX_SYNC as hint that the host is interested in
knowing the timestamp:

https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/emulator/btdev.c#n5752

>  net/bluetooth/iso.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 2dabef488eaa..cb959e8eac18 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -1621,7 +1621,6 @@ static void iso_disconn_cfm(struct hci_conn *hcon, __u8 reason)
>  void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
>  {
>         struct iso_conn *conn = hcon->iso_data;
> -       struct hci_iso_data_hdr *hdr;
>         __u16 pb, ts, len;
>
>         if (!conn)
> @@ -1643,6 +1642,8 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
>                 }
>
>                 if (ts) {
> +                       struct hci_iso_ts_data_hdr *hdr;
> +
>                         /* TODO: add timestamp to the packet? */

Perhaps we should use skb_set_delivery_time to set the timestamp as
received by the controller? That said I don't know if the unit would
be compatible.

>                         hdr = skb_pull_data(skb, HCI_ISO_TS_DATA_HDR_SIZE);
>                         if (!hdr) {
> @@ -1650,15 +1651,19 @@ void iso_recv(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
>                                 goto drop;
>                         }
>
> +                       len = __le16_to_cpu(hdr->slen);
>                 } else {
> +                       struct hci_iso_data_hdr *hdr;
> +
>                         hdr = skb_pull_data(skb, HCI_ISO_DATA_HDR_SIZE);
>                         if (!hdr) {
>                                 BT_ERR("Frame is too short (len %d)", skb->len);
>                                 goto drop;
>                         }
> +
> +                       len = __le16_to_cpu(hdr->slen);
>                 }
>
> -               len    = __le16_to_cpu(hdr->slen);
>                 flags  = hci_iso_data_flags(len);
>                 len    = hci_iso_data_len(len);
>
> --
> 2.39.2
>


-- 
Luiz Augusto von Dentz
