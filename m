Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20704C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Mar 2022 10:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiCIKXD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Mar 2022 05:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiCIKXC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Mar 2022 05:23:02 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491551704D1
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Mar 2022 02:22:01 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id z11so2807344lfh.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Mar 2022 02:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :references:content-language:in-reply-to:content-transfer-encoding;
        bh=9m2U8KOG6tl8vyf34g+VX62wdSPRwrkm5LQmTXWDZXs=;
        b=IUHNQLlVe+Z6PSoiX6xRKAEwuqYHolTyd70i8/KRh7cIYt27ZPJ0Po7a8eCOh46Ecb
         DQQp/q5MBWXrnBf2BnD2K0L0wbJmFJDZnO9k0nMoqAgnRxyuyHXFwD5yuTq51E42s2Wx
         GDNxAe4t/xSwqLXPgwUCn2cuRGBuYdzAZ6jz0ufxlOnSwDQeF0pd6c4Ayb+hR20kx7/s
         2M4sdai/RpRxq44FGdQF+GV/tV8NfhiW1aoQ5YraK9VetIMbl57bn+xgtYymrPxwVMFD
         1y52Nkda55XOLAlvhiuXQ55aH9IyKfDddfYyG6Skz0w/Sivxl1QePRRT/m+MQ2D2i3V7
         GWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:references:content-language:in-reply-to
         :content-transfer-encoding;
        bh=9m2U8KOG6tl8vyf34g+VX62wdSPRwrkm5LQmTXWDZXs=;
        b=YjwoZiVIq1rwXHg3ikTFt4+8wjQcOGlASw6ALxwRV5Tc7435bWxz9TjOFYzhwVJqPs
         c/CIVM8z90u6ChFa56ysZ9E1s/xlGnCQ99eNjOLiFF8kj9IYZe5jrm8Q6zdGNIilgTP9
         P+06IM2+t2RJagdH7tpyHtW3SQZQPCshNYDMP/k22DCIxdl6y4dnbJgNiiG4bKquPksA
         e2hEaHCtwLVOEB5CWDAZ6eBDVrBHhcMYZ1FlgR+yjKjZIrRJ676xgitAIQWB1ujVuLot
         W+ioLW/QAjK9Lkq/XeOPGrAciG0rIJtIJKwHfiHWiu9ItvgtiqwXzSX5DkoGBkyLOOvk
         guLA==
X-Gm-Message-State: AOAM530vEqf0p5GX03j5dwGnPUBggUDjDfU/2Utght9XpRn62PQrk8VR
        3byC6/iAj7M+vltAvfkCwIw=
X-Google-Smtp-Source: ABdhPJwpZgmTcODOIGxHSjoipWIkTHFOMo8Sm6HuCKESNkI+qDpEF9w3oQ3I7XYfed52An94+SDjJg==
X-Received: by 2002:ac2:5e86:0:b0:436:c46c:bad7 with SMTP id b6-20020ac25e86000000b00436c46cbad7mr13769293lfq.578.1646821319597;
        Wed, 09 Mar 2022 02:21:59 -0800 (PST)
Received: from ?IPV6:2a02:2168:8737:3600:fb2d:666f:f13c:5eef? ([2a02:2168:8737:3600:fb2d:666f:f13c:5eef])
        by smtp.gmail.com with ESMTPSA id u5-20020a2eb805000000b0023cfa330e59sm307028ljo.83.2022.03.09.02.21.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 02:21:59 -0800 (PST)
Message-ID: <1acf466b-1cc7-faf9-23f4-f4e97c82a377@gmail.com>
Date:   Wed, 9 Mar 2022 13:21:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Andrey Butirsky <butirsky@gmail.com>
Subject: Lenovo Legion M600 wireless bluetooth mouse connected and paired yet
 not working
To:     Bastien Nocera <hadess@hadess.net>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <f610b069-07ab-1004-e8f1-b84533593c92@gmail.com>
 <CABBYNZLA6bRCxd=Tse_XbUT8ReBo4QjvstSassfQAcTX+Fk9_g@mail.gmail.com>
 <b50b9b75-96ea-0d93-3687-3a79cdec5419@gmail.com>
 <CABBYNZKAUMOZ8vhk2ATPOaVHbcqCTg-DMD2vypkx_CTOjeVg2g@mail.gmail.com>
 <6bec2be7-a411-c5bf-6e5d-b3efee33b834@gmail.com>
 <CABBYNZLAZGoB1JKW63SNJuFB-4raDvHjjEk4w8y0K1MLwe4b7A@mail.gmail.com>
 <b7a2b073-fd69-36a4-6ce0-cb1b942ccde6@gmail.com>
 <CABBYNZKjUYAqctfpap2f36TcBuJFk0wX5P8jkUjpw1qqupeb0A@mail.gmail.com>
 <72b3b0ee-cca0-3804-ce78-1345c4590963@gmail.com>
 <CABBYNZJL4YCpXHL8ihSFh04fEGAqcB7K8a9aR22E6TwB2Wj0Tg@mail.gmail.com>
 <12462d5d-b140-6b08-2e72-d8fd77105086@gmail.com>
 <1494b7b733480882272c16c402115c247bd7dd61.camel@hadess.net>
Content-Language: en-US
In-Reply-To: <1494b7b733480882272c16c402115c247bd7dd61.camel@hadess.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On March 8, 2022 1:30:00 PM GMT+03:00, Bastien Nocera 
<hadess@hadess.net> wrote:

    Can you please try using "hid-recorder" to capture the HID output out
    of the device? It would show us whether we're receiving any events from
    the device, and allow us to test whether there are problems at the HID
    level on other machines.

Sorry I had to return the mouse to store.
It's a pity because the hardware itself is rather good, but I had only 
14 days to decide.
