Return-Path: <SRS0=Gf0L=6V=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD56C38A2A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 20:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6527621582
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 May 2020 20:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYhICMlB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgEGUB1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 May 2020 16:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGUB0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 May 2020 16:01:26 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFC4C05BD43
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2020 13:01:26 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id f11so7753224ljp.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 May 2020 13:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Z5lCUHy01ZzBB0bl8e2rA065G968+1/h1OGz8LSzsjM=;
        b=hYhICMlB6kRXQ+9aHCtQYzplrL7c/MKOYSeJ+BGw+73uyCzHC6wVicRCUOCMHmOK/R
         kQZqClQloGwhSTZ865jQkWCVOiVqTiDLN6Wv23U7D1hSgsYYJvBPWE6enUynzGPJ+n0B
         DLNgBN27dPQt9zyDriJOD0coTN2RGnwZ8cs7gc74jLGsWOJL9/pL2IUE1yaXGZqIV2P4
         0M61xkytBXAAiXZByTCCqZzR0KJ45LXOvBXY5EYFpDuOf+/xQYE67+rJkdQ5CW4kRhj6
         HZ5Nwa/sMvs8Yu5Rgf9RWiESbTT+gQtIUMxl5BwAeDQOa+C4vSZgEeK9RGKYByYUdLVv
         vXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Z5lCUHy01ZzBB0bl8e2rA065G968+1/h1OGz8LSzsjM=;
        b=WL2N36VaVcgBTHUi2sHWv150x9rgP7gHYm+pV2cqRhK5K/4kKaHEgL+bze6LSMPuhJ
         BQqw3dMcWt6dH26t8zHLlaPlzvvV1F+TVyWRr0+rpxjgucLB6LoQobVZnzFBDOe8ulpw
         vKlL1wtTi5e8LmD1ePC43s68U6AEqPALk29VCG5ETxbcOSlt9vYrmhDiYEuCAEzwS8as
         EZOMJxvNIPUtt7pi8c/z1uxWlX5Bm6ctM4tJr5UGWpXR5DAccfxGm1VFpWMgIpOjO6KW
         lpqNcjbfG0hRhm81Kh7Y/eIzSZcUCcL9Awc2M+jmkJJHaoWw+jZHYdS1DoMv5AP/GBNH
         4I4Q==
X-Gm-Message-State: AGi0PubBnFdQj6fETyDFIWyQiygwPq+uChIUmexkyx2RXf3Uo7HrTm+R
        vzvNZF97DJQicd38OEI4LLl90o7Kzrvtk773GW0JHyqhRWM=
X-Google-Smtp-Source: APiQypJuIu83VWTCFpZ6R7rbeO1LjY5DRs03QB22KLv7fuQs8c5dEO/2VcCQA/4RbW4uzHiJk0NvhHwp7wer1yzIki4=
X-Received: by 2002:a2e:a313:: with SMTP id l19mr9556014lje.133.1588881684544;
 Thu, 07 May 2020 13:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <3057615.CFlnn7pYAm@g550jk>
In-Reply-To: <3057615.CFlnn7pYAm@g550jk>
From:   Barry Byford <31baz66@gmail.com>
Date:   Thu, 7 May 2020 21:01:12 +0100
Message-ID: <CAAu3APacN9HMZqtNZ2SEFLXVLH2LqRZWxDhR+DT2AWqVo7bEFQ@mail.gmail.com>
Subject: Re: ManufacturerData while discovering
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

I believe this is a known behavior. Here is a link to where it has
been discussed previously on this mailing list:
https://marc.info/?l=linux-bluetooth&m=158225950522806

On Thu, 7 May 2020 at 20:28, Luca Weiss <luca@z3ntu.xyz> wrote:
>
> Hello,
> I've been trying to get frequent manufacturer data from advertisements from a
> BLE device into an application of mine. Unfortunately it looks like I only get
> new ManufacturerData about every 15 seconds while discovering/scanning. The
> manufacturer data from the device changes frequently (at least once per
> second) so I need updates to this data more frequently than the 15 seconds.
>
> I couldn't find any reference on how I could achieve this in the documentation
> so any help would be welcome.
>
> Regards
> Luca
>
>
