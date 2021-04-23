Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A1AC433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 12:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41B6F613DE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 12:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242491AbhDWMjo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Apr 2021 08:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhDWMjo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Apr 2021 08:39:44 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F910C061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Apr 2021 05:39:07 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id mh2so52117252ejb.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Apr 2021 05:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5QpV5oD8mS7jc28dhSqO/5QznMT23TdLlcUrhO1hD84=;
        b=lZC4EOyDcDY5yx+cdB1odk4+MUUIUjymptOY4qRubj0IICHU5rFaIgC0qBqt3iAwSe
         WGZUvrZKN3667RT0fW+yzZTyXUpy7V3f2fSk6ZFf/Wwi469TSaDVgp3CmVejnsp2cije
         EamCSBdxty6JGkf5OUnJ74moM8Olt41ITjdsO9ufjNGIRqJL/AwsEWbu7nSpulUw1gPB
         ifwQCfKUjvKpoFSaY3VvG85+Ek2Kv7jlo+1kySDZHScR5V2Be+IENSNSEAKjdF1UA/fb
         nSy6cKI8Vx7x5PGRX+aXJVT/65iXu/uDCIaawB12rAtv55kdik2mxKHfOwkp39lBDgYL
         EPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5QpV5oD8mS7jc28dhSqO/5QznMT23TdLlcUrhO1hD84=;
        b=FxxTitdcYujliPSeSqT/kBq1r/ZlFW3loOGofbRIYidsqn+SM7uRvC50dLG4wA+MgI
         AZ9Oj0Tk1S6PyWz7I3JVDysKpnyFEzDdech7pEZJstMUiRSFwiyg257eBxuVubYWIMZQ
         6MFSr2zZLY8jbX8B7+/oCJzrlNCR+Dq0LiCZyRCSxmyZvcYivtFos/y98PBkNhwwZqVa
         IFQBZEpu71bRlBqPEcFhySCN0QW5dnaFJho/r39xx3iKHx23KIMPdDqvMNyeNkMHNqwm
         iCYPr7NiFp6MLBAxi9FLMdzOc6vld1gHj0S0fpvXpT2E1RXu96DRdx3WPHFOYu5Un9r8
         hxNg==
X-Gm-Message-State: AOAM533TnIfWEXgrS6pW+rmmr8rANP/6XfGCxM7M1DvJoA6Nl8QbwwGB
        RItkHjYnVTagqe5krp3gAvKWFtLZUlNgqpA80oA=
X-Google-Smtp-Source: ABdhPJzRr6/+gucTzOiWT5/1eCLPH/wmphWv+Rzi7llLJdrGqUXVVCj4sVBi3ypBed89X/HYveENqGcW6wQPvMsOsWs=
X-Received: by 2002:a17:906:8a79:: with SMTP id hy25mr3983282ejc.461.1619181545629;
 Fri, 23 Apr 2021 05:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210423122732.30657-1-imackinnon@gmail.com> <AC9EA0E8-2285-4154-9BF5-B4C7ACEE28ED@holtmann.org>
In-Reply-To: <AC9EA0E8-2285-4154-9BF5-B4C7ACEE28ED@holtmann.org>
From:   Ian Mackinnon <imackinnon@gmail.com>
Date:   Fri, 23 Apr 2021 14:38:54 +0200
Message-ID: <CAK+oUyaoGEAkXDj-AOqXkxq8B6i8xAR13a40YCNsq46y4f4OAQ@mail.gmail.com>
Subject: Re: [PATCH] Load Broadcom firmware for Dell Bluetooth device 413c:8197.
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T:  Bus=01 Lev=02 Prnt=02 Port=03 Cnt=02 Dev#=  4 Spd=12   MxCh= 0
D:  Ver= 2.00 Cls=ff(vend.) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=413c ProdID=8197 Rev= 1.12
S:  Manufacturer=Dell Computer Corp
S:  Product=DW380 Bluetooth Module
S:  SerialNumber=74E54354F609
C:* #Ifs= 4 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=ff(vend.) Sub=01 Prot=01 Driver=btusb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=btusb
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:* If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=01 Driver=(none)
