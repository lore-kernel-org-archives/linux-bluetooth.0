Return-Path: <SRS0=mSPA=5P=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F4FBC43331
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 22:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22EFE20658
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Mar 2020 22:24:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWHCtu+l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgC3WY0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:24:26 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34076 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728944AbgC3WY0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Mar 2020 18:24:26 -0400
Received: by mail-ot1-f65.google.com with SMTP id m2so5225117otr.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Mar 2020 15:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=BVo94qd9GztFfEYYm3629BsLjmWl4gLxDUmbdSSXweI=;
        b=MWHCtu+lisW+ZDEteHNBBWZqWtRklQ8Arn1Go7er/otOnfdu400ATEd4O8En25FXCW
         +sZx7AOqIrm/oZLoCyLzH0xSgTQFv2KCju7Y2rL6fb3/45pN/hlXMwPl7hwDAJMwJePk
         yr0dzfyLXu9G5MhezMsWajc9XTr6QqqzNNPhHYlkoGbpOuISqSqSXadphrtXBNjUezN2
         bg/FbXWbDDF7TcVC8Tlz9qubQ+e7+o/WbvN2z5zuYDckujeXz7/Hi6hHSKvhG5dUX0Tv
         //ySA79fFHWtF8xiNsDd8Fc/k1GnuQXSqcTPOsu+UrWg9IsRIUwb9yQz3v7hNfwXpvEx
         FHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=BVo94qd9GztFfEYYm3629BsLjmWl4gLxDUmbdSSXweI=;
        b=VafyAdYUu0YH7NAzcumkYLVNZR0dc5WKME/Agu5PJXfDw6SHp6kfTPLE6jPhFWfNTH
         z6cLacHfdovcIrrGLCn60VEBUQOfZ36YLASJTDUnNtR0EyJTqFkqLVRU6HA4TNIl4kkc
         ouKSDpABD6FevNy17ws0EhOKUoc+lpRusqiW2ponuLfpRpoON+DWzI8JzcsjgKYJ9Ckm
         CYos3yLsZ55b9M6U/mTBcge7M9ayMUv79CECfT/scdWPDRlfehsLgcbkR4qsrhRPD+ge
         5dTuBo0IkXQum4LINaelPdecYAdG1uLEFzjyUgM0gaDwtZmNVJd4bQdIf8Pa9GB5nK1P
         /AVQ==
X-Gm-Message-State: ANhLgQ0EK38qO+0GEMR9JCJo71/DsWAvPy9j9DiAbzrWskC9sFZJQFZS
        dpGr336S8A1zFY3IivqunM+W+OxBV/l3EE7qlM14lJMx
X-Google-Smtp-Source: ADFU+vvHkaWE/TrnprCCA3aSi31D5EBYCiIuoMgvp2Dx4uBXkncoeohQf+CWqbqH50dTrjj3AdojtXwJ8BVzOffOdqU=
X-Received: by 2002:a4a:2cc6:: with SMTP id o189mr1000950ooo.20.1585607065538;
 Mon, 30 Mar 2020 15:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200320204038.11799-1-luiz.dentz@gmail.com>
In-Reply-To: <20200320204038.11799-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 30 Mar 2020 15:24:14 -0700
Message-ID: <CABBYNZ+=DVXVQAwPWFYKeM-dgPkCvxDjWUtXdB55v9uCD+MXEA@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] lib: Add definitions for Enhanced Credits Based Mode
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Mar 20, 2020 at 1:40 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> ---
>  lib/bluetooth.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/lib/bluetooth.h b/lib/bluetooth.h
> index d14217eac..4a52ecb78 100644
> --- a/lib/bluetooth.h
> +++ b/lib/bluetooth.h
> @@ -141,6 +141,14 @@ struct bt_voice {
>  #define BT_PHY_LE_CODED_TX     0x00002000
>  #define BT_PHY_LE_CODED_RX     0x00004000
>
> +#define BT_MODE                        15
> +
> +#define BT_MODE_BASIC          0x00
> +#define BT_MODE_ERTM           0x01
> +#define BT_MODE_STREAMING      0x02
> +#define BT_MODE_LE_FLOWCTL     0x03
> +#define BT_MODE_EXT_FLOWCTL    0x04
> +
>  /* Connection and socket states */
>  enum {
>         BT_CONNECTED = 1, /* Equal to TCP_ESTABLISHED to make net code happy */
> --
> 2.21.1
>

Applied.

-- 
Luiz Augusto von Dentz
