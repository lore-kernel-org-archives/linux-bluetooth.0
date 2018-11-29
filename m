Return-Path: <SRS0=ddeR=OI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4374C43441
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Nov 2018 10:32:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 682652081C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Nov 2018 10:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GFLzc2D/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 682652081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeK2VhK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Nov 2018 16:37:10 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34805 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbeK2VhK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Nov 2018 16:37:10 -0500
Received: by mail-oi1-f195.google.com with SMTP id h25so1200376oig.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Nov 2018 02:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FVhkHEeH38eqswJeXqElAeReQoOOxrt3hgE8FqS+8NE=;
        b=GFLzc2D/1Gogdsxu29yTbgkuxnd9obravhMSIJsIuLNim0JIVzgwPJVqtZd6WpQUmB
         XNjycyw+3dzz0sTmAZuefnDn7Zb79QvXkaILSKV9MlyDhvhz3x2R+z8/zRW4ZMziGmHC
         C8ZlUvd9baidksnfL1oYmUhIMUVfzw/rDwFmzcN8BkjlSq8A2qIv0AsOnpX8NAfRm7fc
         2cgzrO3LH5kdzNIuZJrRSP13G6AuLKaY8PqD47vzG0gIyHYrXhNcBabXXVKnheJAl2Bv
         jfPgjRCgZo/sENXP63IGkuJZCzz7sarIjJUgUx0F1AMMOxFDJe0pFwMW5NEv47K0ruAo
         xMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVhkHEeH38eqswJeXqElAeReQoOOxrt3hgE8FqS+8NE=;
        b=AeBErF1IZYGsz+bqAPK1LK70e+iJEfSgng70+iMYU5OPAJ/wH3SOZGKv/N3TYCnueM
         1EIQTkEnTZdypI+0ABxNc+JsPtM2A8hpkA7c2fwk1dK9Oy8l0rDtWZBqxgSKqv53fQn2
         FlBborGn7Bg8rt3LR+Uhz0oBtPubwg4OQpyk6Ob4AK3qsc5+HYcPTHmQlOTqnBSdD+od
         ZjscH7WWh3SzjmJYaaA/IB4+Zkn5n/Munp/flRyzRKChVyO6yDz4x1496iDxXUbB+zgo
         CI/LR2AbZNfKsZoEebJePXiiU9MNchNQhuA5DYRTT7VLfbqlMGBVoBV5Ib4uLNlNYwOj
         edRA==
X-Gm-Message-State: AA+aEWYzY/GhcDUdPd8qXCGGz7VRdJNhafA8sboZaLXbn2+r6fv9Ow2V
        pHfqUUm2+dvYrOk6Ya9yOIah/Zz65tdN3c9AyOS1Cg==
X-Google-Smtp-Source: AFSGD/UxtL8QyLGUJ8+Qn6Hd4lINjnWm6DzzTwJn5kqtnHFto/SQk19ZTnO0m4WUBGYdebeuwGBvIds9q6S/6FOYTOc=
X-Received: by 2002:aca:aa0d:: with SMTP id t13mr534701oie.273.1543487537037;
 Thu, 29 Nov 2018 02:32:17 -0800 (PST)
MIME-Version: 1.0
References: <20181127093746.7414-1-johan.hedberg@gmail.com>
In-Reply-To: <20181127093746.7414-1-johan.hedberg@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 29 Nov 2018 12:32:04 +0200
Message-ID: <CABBYNZJnY6DGyXaOD1JvBidtae74BhwtmrYia8Q6NNwX-EVftQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Fix unnecessary error message for HCI request completion
To:     Johan Hedberg <johan.hedberg@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Johan,
On Tue, Nov 27, 2018 at 11:39 AM Johan Hedberg <johan.hedberg@gmail.com> wrote:
>
> From: Johan Hedberg <johan.hedberg@intel.com>
>
> In case a command which completes in Command Status was sent using the
> hci_cmd_send-family of APIs there would be a misleading error in the
> hci_get_cmd_complete function, since the code would be trying to fetch
> the Command Complete parameters when there are none.
>
> Avoid the misleading error and silently bail out from the function in
> case the received event is a command status.
>
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
>  net/bluetooth/hci_event.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index ef9928d7b4fb..ac2826ce162b 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5711,6 +5711,12 @@ static bool hci_get_cmd_complete(struct hci_dev *hdev, u16 opcode,
>                 return true;
>         }
>
> +       /* Check if request ended in Command Status - no way to retreive
> +        * any extra parameters in this case.
> +        */
> +       if (hdr->evt == HCI_EV_CMD_STATUS)
> +               return false;
> +
>         if (hdr->evt != HCI_EV_CMD_COMPLETE) {
>                 bt_dev_err(hdev, "last event is not cmd complete (0x%2.2x)",
>                            hdr->evt);
> --
> 2.17.2

Ack.


-- 
Luiz Augusto von Dentz
