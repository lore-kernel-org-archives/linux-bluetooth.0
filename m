Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF465C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Feb 2022 21:22:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237547AbiBRVWp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Feb 2022 16:22:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbiBRVWp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Feb 2022 16:22:45 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1539E36B52
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 13:22:28 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id p5so21877647ybd.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 13:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=KZD8eZkv2yULGcf02dESYLtrpbCgiTofP6UydtRdBT4=;
        b=mjDUGUf0qVDMh8CV+mxdENuNm3vyQf05BAUbVKfpkH3URQIc6gOko8aPafqNfrQ7LE
         aIg5jWdbPypXl3zOydw6WHhcRcf8g99Sv5TkdXyieOLTDCTOjeX1zZvuTD4UVPptJXQv
         54ROVRa+5Ia7CF6X+p07AOMCBic8Ij/WGyR2X7I4G4Nztoyyb14e35dkzgszXz6PzFrc
         fIMxn1Rd8H/e8FDPmnWGHTicm2EG6rxJwTRHK6oqsyIHbz7xWWPqjowpqH1g7fF1Iz77
         TlEzminKR/6m8kQKpfRLvJuKhgqfcCUKEh7evtTaTSlztd4Lre470eM7moQVgxi4VqJr
         8Gwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=KZD8eZkv2yULGcf02dESYLtrpbCgiTofP6UydtRdBT4=;
        b=1nvCqNR+MU81RL269LrTB1YcGRhXsuYB7kSpWJxzPrJ8nBgYXTDnv63sN9ct9Q1LEt
         qHuGJr9LwIrLyRHEfuG8vVu0bIStcC799cBkvRPRQrlfZvCK+3f63JQJ+MqiN7SOPjZl
         ZtAytT1Hvb4ommZs6/tciZjWcrzjEVsDumm07k3yyoZS8sdHGNbMwh6ReBarGkcBOriw
         lD6wqrtQP8+LAHrOTdcD9kuaG+7ylKmFfMS1Z30TMX9Ve+PQ4V4lftwv7/zEePLBCZgW
         9DdgUl3SwVPvxlz/TKAtWt2WK1x/+4RjsPEpfnOv0XTk+erK3PZBbHFs8I8Gb6yn7wQo
         DoEw==
X-Gm-Message-State: AOAM5336yt3V0jB5YlIFDXKjB7sefV2SLqa7zS2ZfUivKgPvnCvRuCet
        LBvPUxBcrDlb/ReLNfKUwlICxWmdXxnW7NxPp+jbZzek
X-Google-Smtp-Source: ABdhPJzQCUboiKCRi9XJDG8msiSp+xbvD/47TSSMKJP7ukjYvV7+mjQFBIO/7kp8mZUp7Nhqdy8vrcWlWHk2jzpEWBg=
X-Received: by 2002:a25:8546:0:b0:61e:1d34:ec71 with SMTP id
 f6-20020a258546000000b0061e1d34ec71mr8908079ybn.259.1645219347096; Fri, 18
 Feb 2022 13:22:27 -0800 (PST)
MIME-Version: 1.0
References: <20220217233902.3093404-1-luiz.dentz@gmail.com> <620f1098.1c69fb81.a39bb.dd75@mx.google.com>
In-Reply-To: <620f1098.1c69fb81.a39bb.dd75@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 18 Feb 2022 13:22:16 -0800
Message-ID: <CABBYNZLpuMqA_PHF_5RcD06e+RCa6Yu1dKLkLZMn+90FAaXawA@mail.gmail.com>
Subject: Re: [BlueZ,1/2] main.conf: Introduce MaxControllers
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, Feb 17, 2022 at 7:20 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=615589
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      3.20 seconds
> GitLint                       PASS      2.11 seconds
> Prep - Setup ELL              PASS      51.36 seconds
> Build - Prep                  PASS      0.78 seconds
> Build - Configure             PASS      10.27 seconds
> Build - Make                  PASS      1447.42 seconds
> Make Check                    PASS      12.29 seconds
> Make Check w/Valgrind         PASS      524.58 seconds
> Make Distcheck                PASS      273.84 seconds
> Build w/ext ELL - Configure   PASS      10.39 seconds
> Build w/ext ELL - Make        PASS      1438.64 seconds
> Incremental Build with patchesPASS      2933.71 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth
>

Pushed.
-- 
Luiz Augusto von Dentz
