Return-Path: <SRS0=5+i7=ZL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FD7C432C0
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 04:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C5722317
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Nov 2019 04:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ioImJG6X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbfKSEfv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Nov 2019 23:35:51 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:42125 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727217AbfKSEfv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Nov 2019 23:35:51 -0500
Received: by mail-wr1-f46.google.com with SMTP id a15so22130726wrf.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Nov 2019 20:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IuSxRTDkdpU7Cn/WUzd+79+FxfE3hMrpGq3zD2a6UUY=;
        b=ioImJG6X4vTUJNN55NHpUU4PX7yHgEoyNmF78UWfIbzT24Fa+XkzzClUu/33FSCXRH
         FnodZkmn4w0AbjUMm939CxNWW5G4QMklL+QzL0OLiw4AdV3ivgLrhzRgtPfhKHjmofUa
         7nDDKfH91HvRqV1sOSP/rc6/KOwAHMTcjQ8jL2j9XZ2LCwlzpbaZFhft2VBy/bzywFMw
         GmOy9wjY5iC6pRIL+XBrmhcABp8HKlIEVPtqiWXSFLayIa5yBIMvYPNR2zCyGDYof6RR
         tUQUk2o/m/dHAoNHCVySzXwSJLa4dDpKTL+BN56lpWkKw1LL18hnLYsP2kDVlMeaAwKR
         BqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IuSxRTDkdpU7Cn/WUzd+79+FxfE3hMrpGq3zD2a6UUY=;
        b=FM2/NQx4R7QwnD4GepiWOIvQH/R8l8pDaMxAspv4Jg6OIddl59Vl2L3xpyAeEJCgCU
         8afc/xm3sV+sshfk/o0teONxxQvBbetFCTV9SUJjeyG3+O7XF6kJMev/r0D3TdJlXC25
         Pr2ZeZ4YYbJrp8iiUii4cvWz+0y/IE/yMDqia3YtYiydE4iJyoNXih52yhivOEDBmSMp
         SjNUVg7w2bX9bqPu8wv7gjSSqRMZoOmCWzmnepqO/vkoVokAIv2vyUpFCu0pOdfCqOnW
         amV5nrGvbPK7ACIMg7ZpUiO/i1GqFvEyR2IJxPUT6l31IperPHsI4AzdIeibdhwHH+tr
         TCxQ==
X-Gm-Message-State: APjAAAU+oV6fpLPy7sJfQ1hpSCNrkZxHh3TRiI6+pT9z8vIvvsJ6Cnxb
        SbuWyTYJdQnzvHVoGx5he3uwcAtF
X-Google-Smtp-Source: APXvYqyb1IhXFyLY6eppTswyKoDFASFJ0S7YicS8X037EzXsiiKM0HdEwCyJVs94RWuXwYGZD8tGUg==
X-Received: by 2002:a5d:460b:: with SMTP id t11mr36116016wrq.185.1574138149202;
        Mon, 18 Nov 2019 20:35:49 -0800 (PST)
Received: from mamamia.internal (a89-183-91-150.net-htp.de. [89.183.91.150])
        by smtp.gmail.com with ESMTPSA id h205sm1730273wmf.35.2019.11.18.20.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2019 20:35:48 -0800 (PST)
Subject: Re: "local-[bd|mac]-address" inconsistency?
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-bluetooth@vger.kernel.org
References: <57775d51-7de2-a32c-8b23-aba611483f51@gmail.com>
 <20191118201551.GJ27773@google.com>
From:   Andre Heider <a.heider@gmail.com>
Message-ID: <bf8ee1f1-4462-dd7b-d259-665267563022@gmail.com>
Date:   Tue, 19 Nov 2019 05:35:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191118201551.GJ27773@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 18/11/2019 21:15, Matthias Kaehlcke wrote:
> Hi Andre,
> 
> On Mon, Nov 18, 2019 at 09:20:35AM +0100, Andre Heider wrote:
>> Hi,
>>
>> when passing both addresses through device-tree in the same way:
>> $ hexdump /proc/device-tree/soc/ethernet@5020000/local-mac-address
>> 0000000 0702 3d96 53d4
>>
>> $ hexdump /proc/device-tree/soc/serial@5000400/bluetooth/local-bd-address
>> 0000000 0703 3d96 53d4
>>
>> I get this for eth (which is consistent with u-boot):
>> link/ether 02:07:96:3d:d4:53
>>
>> But for bt it's in reverse order:
>> Controller 53:D4:3D:96:07:03
>>
>> Is this intended?
> 
> Kind of.
> 
> In both cases the address is specified in the binary format used by BT/NW
> stack.
> 
> When BT addresses are printed they are converted from LSB to MSB.
> 
>> Do I really have to pass the bdaddr from u-boot in another way?
> 
> One could make a case that we don't care what the 'internal' format is and
> that the BD_ADDR should be specified in MSB format in the DT, and the kernel
> would be in charge of converting it to LSB. However I fear it is too late to
> consider a change at this point, since the binding has been in the kernel for
> 6 months with the current format and existing devices may rely on it.
> 

Feared as much...

Thanks for your time,
Andre
