Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66988C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 22:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbiBPWgR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Feb 2022 17:36:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234060AbiBPWgR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Feb 2022 17:36:17 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB7B250384
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 14:36:02 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id bx31so5626496ljb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 14:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=L2XOBELbHv+EuWLZVpKFvNB150NWh8Nm4wce+iA2D/4=;
        b=Rjp8IhwO5ZaT7lgQ/6tVX0LXid13jfWhOXk5fXmb7emnhS6nbD0ozDla3ZEP/2xfhR
         6Fk7pl5YAN2R3bm8V/ojdIlHu+UeF/+0zzUvqOgQk47PH+avNGHSvhxj1rZDvhyNxK83
         Z0wxCdOme5KI0GY0EDPgyqadtMUVokI8UmY5InvwKJ6/bWEeR6XJy7AEwJcWkm1IDanS
         F3mLXZX3RQEG9qT9EthwCCqx9LYdN2HOlaf3hkqH0vEu7AooFWA34DlqRF9iXMOfwsyt
         gesnASCpZarKLeln21LGRhFpAjDJ/jeR1kmBGtX7swDA13r2JTWKscUel1VyIo+BXxip
         tmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=L2XOBELbHv+EuWLZVpKFvNB150NWh8Nm4wce+iA2D/4=;
        b=uNMmhPjQMpyoQJFw1BV707N2+5aRF+GzuSjqUJHbVCRaNfs/bexDjPk4/IYjpH9qZ0
         l3KWkSbbCrfWoSE1xNh9w9E5Uo9/Y752rsT+RjQ7sYAnbMbH36t3VPUVBktX3c6JuICc
         E/+/QW0wJfHg798Kbyy8ohJJURCNtcG2IBHPEMZAHa1rr5l34UDCcJkL0saOGcOLJVux
         7hl4ng/UistIdFM2rBM6wNWACC0WHjVF4XiTetymdCmjMoDpN9JZfFbRYob7303Ss2fD
         cwfy+RxSKxrjmfYzM0m62TQFwF5eMt44TBMn5N+VNprh68jBfgPbCt6PhqmFUSD6qn76
         yXLA==
X-Gm-Message-State: AOAM530MXEbpRJOHiC7PP9Rluec0D44N9YeG6HE/4+it2F0NG2m+ynk7
        mcNyLSAX08WONWQ55e5mQ8epH7uINQM=
X-Google-Smtp-Source: ABdhPJwBXnIZiGt+vwO42JufuZOtmFkPxX6qqW5ancAgy0c/JW//XlRSW1bGfzRFjUWPCQ5kEFlPgg==
X-Received: by 2002:a2e:aaa3:0:b0:244:e280:3b0d with SMTP id bj35-20020a2eaaa3000000b00244e2803b0dmr137743ljb.63.1645050960966;
        Wed, 16 Feb 2022 14:36:00 -0800 (PST)
Received: from ?IPV6:2a02:2168:8737:3600:64fc:d235:9024:8319? ([2a02:2168:8737:3600:64fc:d235:9024:8319])
        by smtp.gmail.com with ESMTPSA id i16sm900874ljb.117.2022.02.16.14.36.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 14:36:00 -0800 (PST)
Message-ID: <b7a2b073-fd69-36a4-6ce0-cb1b942ccde6@gmail.com>
Date:   Thu, 17 Feb 2022 01:35:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:97.0) Gecko/20100101
 Thunderbird/97.0
Subject: Re: Lenovo Legion M600 wireless bluetooth mouse connected and paired
 yet not working
Content-Language: en-US
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <f610b069-07ab-1004-e8f1-b84533593c92@gmail.com>
 <CABBYNZLA6bRCxd=Tse_XbUT8ReBo4QjvstSassfQAcTX+Fk9_g@mail.gmail.com>
 <b50b9b75-96ea-0d93-3687-3a79cdec5419@gmail.com>
 <CABBYNZKAUMOZ8vhk2ATPOaVHbcqCTg-DMD2vypkx_CTOjeVg2g@mail.gmail.com>
 <6bec2be7-a411-c5bf-6e5d-b3efee33b834@gmail.com>
 <CABBYNZLAZGoB1JKW63SNJuFB-4raDvHjjEk4w8y0K1MLwe4b7A@mail.gmail.com>
From:   Andrey Butirsky <butirsky@gmail.com>
In-Reply-To: <CABBYNZLAZGoB1JKW63SNJuFB-4raDvHjjEk4w8y0K1MLwe4b7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 17.02.2022 00:08, Luiz Augusto von Dentz wrote:
>> It's BlueZ Version: 5.60-0ubuntu2.2, Ubuntu 21.10
> I try upgrading or better yet use the head since we have some fixes like:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/profiles/input/hog-lib.c?id=0516d2527ea83c8fa209d52c564ce99408a00fbe

Tried BlueZ 5.63 on my Fedora installation, no luck. Will try to build 
head if no better idea..

