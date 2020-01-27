Return-Path: <SRS0=tmcz=3Q=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7B1C2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jan 2020 22:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2A02465B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Jan 2020 22:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BGOzcB37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgA0WNv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Jan 2020 17:13:51 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:32923 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgA0WNv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Jan 2020 17:13:51 -0500
Received: by mail-ot1-f67.google.com with SMTP id b18so10089798otp.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2020 14:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=09pgRkPeAgsGqkC5hx7mG60vWz6Ja3+gilOqWEzmgU0=;
        b=BGOzcB37I8ZBhFr31ODyjubjzxpu3zIkCx/98oYtlNjTfxqeMpqQEsoXwK4cHaU1Gm
         CFUVTXELYBppU7n+qZyYq6BPwBE42Tsn+5XcbvzjK0jm6aDBQDGREpZyGNkMOYvLwRwr
         YoPHI1PyQEGmdAf/GzvseGaL/s3qKHstFXqw0DbEvktpwsCDYZpVzDk7SuYqyHi0eC5n
         qZshaQL6hRQV3JFqs4+mUc6JqwPcue14mTKjw4cIen6GnMMQWH3cGFU7psjOVdIcLnTw
         dX6sjlmQfj9lr5GHaTpOsRQa3TxsXR1kw7m75oNFEbWj/fvryFhOapV5k4dH57si1S8n
         XNPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=09pgRkPeAgsGqkC5hx7mG60vWz6Ja3+gilOqWEzmgU0=;
        b=UOyHAlSR0N781aa7A77aC2HsermH97au51AnKxWflCAazLdNfLr//0wUBtKwO+IAb7
         1Ofujs1djpb/V++ePMYIkAqxnSTskqhxyLy1XCM2HcM190bJPafQBDOz4t8b8cmJP/vI
         TDh+LS0W9sDBnuk3NgCRLL9obS7JU0VmrO8ZsB/7KzE8kTAdog150DXicCwFZ0U01DKl
         yyzDGW+2jKx771eY0oS7oekKG99dQ0dDHfoA9Co759+2sfE2lBLFg4hh1jT09UtQ2wtM
         7gGnWPfy44F9NJuJhhsELaFLtKYKkpqAIt7udzxslbX2WNApDjerd7Ft5yoYcSi4DGWr
         WYvg==
X-Gm-Message-State: APjAAAWdVKwBy4IPinS1hCOTv0MtaIOrtnhoDd1FyBdcVExT9YsBI1O+
        BSnQ7VmXkwBiaAdIb9zev6Ce62nK4psywhBWlHFcFigo
X-Google-Smtp-Source: APXvYqzKpdpjNg4MawM0462Os5BCO7/0iCe1sNGPV2QpVuyAhADzqzFghefy1TXUF7asyqFo2/8eVpSCrd1OlXAK55M=
X-Received: by 2002:a05:6830:14c9:: with SMTP id t9mr5726853otq.177.1580163228375;
 Mon, 27 Jan 2020 14:13:48 -0800 (PST)
MIME-Version: 1.0
References: <20200127191133.5144-1-luiz.dentz@gmail.com>
In-Reply-To: <20200127191133.5144-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 27 Jan 2020 14:13:36 -0800
Message-ID: <CABBYNZKnJzEpAeyQPoeOxeFSOL1F90MfXyNJ0ndGj9A1s9Vgdg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix inconsistent returns 'hdev->lock'
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Mon, Jan 27, 2020 at 11:11 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> If Set CIG Parameters fails the hdev->lock was left locked.
>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>  net/bluetooth/hci_event.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index c40ae10e7b9a..bea39d5f6936 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -3168,7 +3168,7 @@ static void hci_cc_le_set_cig_params(struct hci_dev *hdev, struct sk_buff *skb)
>                         conn->state = BT_CLOSED;
>                         hci_connect_cfm(conn, rp->status);
>                         hci_conn_del(conn);
> -                       return;
> +                       goto unlock;
>                 }
>
>                 conn->handle = __le16_to_cpu(rp->handle[i++]);
> @@ -3183,6 +3183,7 @@ static void hci_cc_le_set_cig_params(struct hci_dev *hdev, struct sk_buff *skb)
>                         break;
>         }
>
> +unlock:
>         rcu_read_unlock();
>
>         hci_dev_unlock(hdev);
> --
> 2.21.0

Please ignore this, the original patch is not in bluetooth-next yet.


-- 
Luiz Augusto von Dentz
