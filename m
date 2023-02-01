Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0C9C38142
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Feb 2023 18:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbjBASsa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Feb 2023 13:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjBASs3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Feb 2023 13:48:29 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C46765F1E
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Feb 2023 10:48:26 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id bi36so1386568lfb.8
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Feb 2023 10:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ilT6DacsaBoyDLA3jIA9kzGniE8BMSycYQlFx0zi9eQ=;
        b=LyL7gv+ytthrnyDiJrFlyNF7IbWNPmR8dZMC4dQNg0Ikwud5fbUmkPb2Pfak7om2Ai
         E1DfA6wiLRLXfHgeTcl1H05HSp2vmZ72WltC6ktOI6Son0wxcIvMp0xIXqVfZivO4kXz
         ul55itP4v3gEtMYVFHx2CGbp1poBci8CG1ulMvVPu6dMYZeDufG+24I3sCYQR3xmOFAs
         Qgt1CD7SxndNcEadGwDbTcUYb75xgHu1uc2fAslGWuDrT7TCwQDI6/rE/jmrvuN4jyfS
         Nyef3eP+LPvX3pUKcqRjuYD8k7ZQ1soscGTDK1EFcc9O0U/r6bZrowLlpx+ki0jNjL0C
         UWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ilT6DacsaBoyDLA3jIA9kzGniE8BMSycYQlFx0zi9eQ=;
        b=vzFvCsZZy7ubTtsyATUuV2H4QR3bfZiXfZhf5/ox7brvEAu5S3viYUTJUTprZGpuIx
         tFomXMVUclPYyI12GdRqwp5boly2IAV41IuwCiLWAAuXsSX8yFYTs7UBMSZ0IL0Lyltd
         WktcfSOap9BL0dEAMkcdXp+H+kgefMN9J293OxKFMcImEAyP21o6YoNxRtlujTZgpPNx
         27PIGA+LwBa0iOm51pWXVDa+emVCfz8gXNFl708HIEbQgf8jof7iiKWaah9FyCz6SR3U
         oAswkRy0+G/MzeQQeu1RZZisev9fPCpIgHRkqbXyUnXZfZApr5/GKzXr1Ntje0fI3o3r
         YnEA==
X-Gm-Message-State: AO0yUKXV9PQQzoEg9ieMh3L5x5VxyU+Hcfo2lvEGm2uJfvDCsysRbBFK
        bSoqdaU1uDuAURSFAJpxUaIPmPoAwqpTBaVf1z1GWXO+
X-Google-Smtp-Source: AK7set8XkoHU7Q9nSQEcAvJ3Zs4pHROIWkEvVzWqhi6Z1tifpvK2CQkH4KhQKGuEncsAdWkw9BY7Gwi2VnLqKcCikDs=
X-Received: by 2002:a19:9209:0:b0:4d8:5137:a89d with SMTP id
 u9-20020a199209000000b004d85137a89dmr576775lfd.176.1675277304398; Wed, 01 Feb
 2023 10:48:24 -0800 (PST)
MIME-Version: 1.0
References: <20230131230105.139035-1-alex.coffin@matician.com>
 <CABBYNZ+wXYH8vag6Xk2X7U7U096_YENasq1cPCEo-0SD5ut_wA@mail.gmail.com> <CA+hUFcszm1UnoqeEsViR=0NO4M=rQMu-2DvaefJ70HDNR_9dtg@mail.gmail.com>
In-Reply-To: <CA+hUFcszm1UnoqeEsViR=0NO4M=rQMu-2DvaefJ70HDNR_9dtg@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 1 Feb 2023 10:48:12 -0800
Message-ID: <CABBYNZLOxU9WphAsjVMHdGYRJ1OF4OBsmRrZF9jMqRa5ktOj+g@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: fix use-after-delete
To:     Alexander Coffin <alex.coffin@matician.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alexander,

On Tue, Jan 31, 2023 at 6:39 PM Alexander Coffin
<alex.coffin@matician.com> wrote:
>
> Hi Luiz,
>
> I like your proposed patch, and think it is much better (and what
> should be used instead of mine) assuming that you have tested, and
> verified that no code requires allocating buffers on a closed channel.

I will prepare a proper patch then, but I don't have access to your
testing bot so it is probably a good idea that you test it yourself as
well.

> Regards,
> Alexander Coffin



-- 
Luiz Augusto von Dentz
