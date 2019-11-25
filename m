Return-Path: <SRS0=LhHL=ZR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6EEC432C0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Nov 2019 18:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 161AA2082F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Nov 2019 18:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DGzG2cqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729306AbfKYSQB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Nov 2019 13:16:01 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36355 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727928AbfKYSQB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Nov 2019 13:16:01 -0500
Received: by mail-qk1-f194.google.com with SMTP id d13so13648254qko.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Nov 2019 10:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wl1BDenVoX1ylWPWtjXZADMmdApHWUQFYSVc2/tEE9U=;
        b=DGzG2cqJ4HVqPUoQxOSuCd+fOrO3BoWfOi0LYldZkPU4Yzl9ag4L2+BbkmZ24qEiDk
         489EDoLFowJWLerevZsHb1DsDbXIw6t3K3RV35KNr0YMVpTCDJPNyF3HBgTz9Guj448a
         +bg5TFBgTqpSHleEVtnHf1lymzpDpGw6csLMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wl1BDenVoX1ylWPWtjXZADMmdApHWUQFYSVc2/tEE9U=;
        b=W95zlWxZjNx3CKfLl9QwcacncALhE5ZO88H4tQdsaPV8L5GwbxkSNEe7JZSeoBCFO+
         5AC979OS2QwAJsOm/gJ3u6TiHctWPsFTFSNu129wGmcdIJv/cAk9EiI4M5A3KlBJE14P
         aW3JpyRyQF+YsWWS5NZJqDkDeBF4fHDjnQqTYwDAe3RXzrsdiEqUcibf5qHoAPkD6vYp
         uKWS33wT7NrMdqlzX1BZXgzuIa/t9kykrB99b6f7W5Np38c1Mol+Y7hbSthpA1Fh72np
         ryKI3aRXLUkGRDLlqFC2r1Ej898XQwNkl319Yu0f/ee20bOp0lPaUXwtuKLLD/kMNIqM
         BRtw==
X-Gm-Message-State: APjAAAXYgtVNeTUqrtXMJEzM0TBc55xdzxZLnTFbm4qGlzNzcuhmTUMG
        kcUtviZsuNzjGq93RsXPP4shvNcn/+U7DXMfG2I5mHf+
X-Google-Smtp-Source: APXvYqzFDCKFJJhh5jHarOs11OwA5Xat3BEwoLBKa2Wh1w/2cgeSKTmebUwo1fo7hIrpzxTrjZCwwICzhkm2YqBoqhU=
X-Received: by 2002:a37:5b02:: with SMTP id p2mr27029082qkb.419.1574705760514;
 Mon, 25 Nov 2019 10:16:00 -0800 (PST)
MIME-Version: 1.0
References: <20191123100111.219190-3-marcel@holtmann.org>
In-Reply-To: <20191123100111.219190-3-marcel@holtmann.org>
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date:   Mon, 25 Nov 2019 10:15:49 -0800
Message-ID: <CANFp7mV89ZY=dNeY=QqB3FG1NLrWMdQ-CWxG0rtWBQMVxcXMvw@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: net: bluetooth: update broadcom-bluetooth
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Sat, Nov 23, 2019 at 2:01 AM Marcel Holtmann <marcel@holtmann.org> wrote:
>
> From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>
> Add documentation for brcm,bt-pcm-int-params vendor specific
> configuration of the SCO PCM settings.
>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  .../devicetree/bindings/net/broadcom-bluetooth.txt         | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> index f16b99571af1..065f2e117eca 100644
> --- a/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> +++ b/Documentation/devicetree/bindings/net/broadcom-bluetooth.txt
> @@ -30,6 +30,12 @@ Optional properties:
>     - "lpo": external low power 32.768 kHz clock
>   - vbat-supply: phandle to regulator supply for VBAT
>   - vddio-supply: phandle to regulator supply for VDDIO
> + - brcm,bt-pcm-int-params: configure PCM parameters via a 5-byte array
> +    - sco-routing: PCM, Transport, Codec, I2S
Consider, 0 = PCM to show 0-indexing.
> +    - pcm-interface-rate: 128KBps, 256KBps, 512KBps, 1024KBps, 2048KBps
> +    - pcm-frame-type: short, long
> +    - pcm-sync-mode: slave, master
> +    - pcm-clock-mode: slave, master
>
>
>  Example:
> @@ -41,5 +47,6 @@ Example:
>         bluetooth {
>                 compatible = "brcm,bcm43438-bt";
>                 max-speed = <921600>;
> +               brcm,bt-pcm-int-params = [1 2 0 1 1];
>         };
>  };
> --
> 2.23.0
>
Looks mostly good.
