Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673CFC433FE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Nov 2022 20:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbiKCU1E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Nov 2022 16:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbiKCU1E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Nov 2022 16:27:04 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4CB1B9DE
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Nov 2022 13:27:03 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id d3so3675861ljl.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Nov 2022 13:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ovoqAeo3m6MA5GREZCa/Jl3Lba4ZdHcyUR4yNXmYBhQ=;
        b=NLoc+cTW/U8pRxi2+noRTKeRksZSIU117q7H6WQth6boKTCW+guuJiFTIz4O+SYou0
         sIKth3uMO4GdZ/OmLvY6p0C+gkiPqhCxqBMElfIqIXhd/o56SCjSvRR4oL8LiUK7s6GB
         O67lITQ+L6l4aISSW9CMt7SlneAVhyeP/EUnrpmFJbFRpSBOMvi3K+flmSW3bpP7L/CO
         ZE23ryPkAAT01xH9LXIbqPuYkBNe4Xtoq/WbyzaBhyuk4pMrEzWs5LQAGYOxfBR0+uCb
         dFPMQVIMd/e26K2WCiT4rsXislf09AVesGFFFgFLRf1j+Sd/Vicy6kfSuU55Jv1Sx2Lb
         XSbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ovoqAeo3m6MA5GREZCa/Jl3Lba4ZdHcyUR4yNXmYBhQ=;
        b=u0D1720fopFAjlrjmQMsEOJiT8g1/uRyyJqZuL+Zth9J969gEIXjzmswlA04Ym5tOF
         j1dKzFACnMVvx9XmYsm5uR8jIeSy8HF9uy785Y41yR6BREVt9V9qlenllqC1na7jjxxI
         IgekVuqkJixVsmLskdafBettrvhZfExKWapa3OQEODUfU959hxYP2EXYQaxQk72JwhA6
         6cvWN7w5B60MOQvQylBstQ3EuJa6PxdrCwyw9+ldlTEh1GqT6eVOCeTBWyq+AFq8pLxo
         2h5bxqWMOF3GpCWdaelPcYQ52R7zVsjZv1Lv5uYo9A+hRkFfUj86UZTwCf5CMlL0bIAg
         gLkA==
X-Gm-Message-State: ACrzQf1TXS38oEG3as2MNC+4jYz61pDJIIfDSYGYvC8ZDgjfLl11Ie4T
        5NOXNrSPRUv3KoV0uzWWoQv1Kkto/SYPLYvqrrXByOHNo+0=
X-Google-Smtp-Source: AMsMyM4kwR1OBFO6FAU9DdfbIRC92yuyR0q4+zf0Kh4MCLmHpBazkTFHCgf6qRedcrplQlq8qa7Btm+3snCCCcix9pU=
X-Received: by 2002:a2e:8743:0:b0:277:10a8:3e8f with SMTP id
 q3-20020a2e8743000000b0027710a83e8fmr11628696ljj.423.1667507221363; Thu, 03
 Nov 2022 13:27:01 -0700 (PDT)
MIME-Version: 1.0
References: <20221102101224.1463549-1-hadess@hadess.net>
In-Reply-To: <20221102101224.1463549-1-hadess@hadess.net>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 3 Nov 2022 13:26:49 -0700
Message-ID: <CABBYNZKXvcUjyuf1DzjB=NX1xVt8bynZQ9KNrOOYGQMtPt5PKA@mail.gmail.com>
Subject: Re: [BlueZ] main.conf: Add comment about LA Audio BAP UUIDs
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Bastien,

On Wed, Nov 2, 2022 at 3:22 AM Bastien Nocera <hadess@hadess.net> wrote:
>
> ---
>  src/main.conf | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/src/main.conf b/src/main.conf
> index 2796f155e..fbe0a97be 100644
> --- a/src/main.conf
> +++ b/src/main.conf
> @@ -125,6 +125,8 @@
>  # 330859bc-7506-492d-9370-9a6f0614037f (BlueZ Experimental Bluetooth Quality Report)
>  # a6695ace-ee7f-4fb9-881a-5fac66c629af (BlueZ Experimental Offload Codecs)
>  # 6fbaf188-05e0-496a-9885-d6ddfdb4e03e (BlueZ Experimental ISO socket)
> +# 00002bcb-0000-1000-8000-00805f9b34fb (BlueZ Experimental LE Audio BAP source)
> +# 00002bc9-0000-1000-8000-00805f9b34fb (BlueZ Experimental LE Audio BAP sink)
>  # Defaults to false.
>  #KernelExperimental = false

Not really following, these UUID are actually part of LE Audio
standard, they are not experimental, or perhaps you want to document
what UUIDs can be registered using MediaEndpoint?

> --
> 2.37.3
>


-- 
Luiz Augusto von Dentz
