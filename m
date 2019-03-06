Return-Path: <SRS0=crNx=RJ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35BB8C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Mar 2019 15:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F140C20675
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Mar 2019 15:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8cSXJDY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfCFPOV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Mar 2019 10:14:21 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36814 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727760AbfCFPOV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Mar 2019 10:14:21 -0500
Received: by mail-wm1-f67.google.com with SMTP id j125so6290891wmj.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Mar 2019 07:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=eP3QHrx5RsfqkSWT35DRPvQurOWkd5YmGB5Xov9Fnig=;
        b=E8cSXJDYUTHDoE4XABlVSWxNtaafKKSQig5mHUJYjrDEXjwuSUgL4deHkMwEiphk+L
         KJAcZ/DML4Yjf6dbPwKMmE7efRFi8+mPryrY7AhQp26j4Jxr+QhoSeG0S3p/Jl8ZBmNX
         N2CvAjRgPXsfMIiHqBCOVAjPGZZKVwtj3ScOpZMgwf4qbHcUkexmMMy6FltJ4eHjjLA0
         SF24OrcVyJwAOsW85zmScLPoHrJ0sraCbqNT3984zIJ1BnvMpjaGrm9Qu4dMU9sc1m/g
         0k85lZ+zGg3SHL1qqvZY0PqkXYn2fHljDp2dj5HkhS1L9DScXccNZMZvzjeV0UUg8cZM
         bELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=eP3QHrx5RsfqkSWT35DRPvQurOWkd5YmGB5Xov9Fnig=;
        b=NwrdUBXYzAHdHbrPvrG7og5q6xbPnyk+gsb66Z6YZj2pcelXSVxOIhod/NL2rnQia+
         P8u6I1ORa3i09vP2dKEp35nezM5xgTrvOCCmUD6EmRPkHlGXQLQpuup6TbIzCsHG6ZHW
         yo3YYWo0zqaXZ2L/BekDjsduBfW/RnTG88IsnJ1/o/LOGem9bSeVf7nW3TWHjaV+yNkd
         fzxrVy9pvxtacXYlDJiRnCn7QqTmubYH0cLGeBfyjlW9qdLq68FbRFwG5NlKCwx+gVIl
         vn1YqmJFQTs8AQql85lIJsd79m8x9yNUJvkLmLLhAm8IbnBuhl2w5o0cPqpFmmPoszEM
         5e4w==
X-Gm-Message-State: APjAAAUJDrxTANZhmOkXAwJK8gGLP4CgUxC5b9QTUdxCBA13XvFQ8nXV
        5lCwE6O8Kqa20Fl11CtuyIu7R7yD
X-Google-Smtp-Source: APXvYqwpxJzHI6tR3soFSmaVyjZVlkw0QOGNomLpX6jW5slGW1yvP6mHw8bAHwcOiF+c/Hfw3/+GEQ==
X-Received: by 2002:a1c:1a86:: with SMTP id a128mr2731902wma.67.1551885258640;
        Wed, 06 Mar 2019 07:14:18 -0800 (PST)
Received: from [192.168.0.1] (cpc149624-rdng29-2-0-cust819.15-3.cable.virginm.net. [82.15.3.52])
        by smtp.googlemail.com with ESMTPSA id f68sm4650224wmg.5.2019.03.06.07.14.17
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Mar 2019 07:14:17 -0800 (PST)
Subject: Re: Error setting UUIDs discovery filter on big endian systems
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <150d16d9-9149-a463-e285-aaea10bed6e4@gmail.com>
 <CABBYNZJbT3fv8tq7JvBjiDuE2W+p__uceBSkduYtrChq0i8WFA@mail.gmail.com>
 <f2edc2ca-9ed3-c436-b43c-81b0560d7f56@gmail.com>
 <b6ae709c-e62a-9c03-7abb-a8b4800361e6@gmail.com>
 <CABBYNZL2F3JaZA27azU8Z2OZ_4CsnosT+Scsrhn9YAA-3i=iaQ@mail.gmail.com>
 <a90cfd1f-95aa-6b2e-9aab-66d5b950bb59@gmail.com>
 <CABBYNZ+CQ_RQgxAavzKCyhGcy0rNPnZkG_fW6mSO0j0Q3Y+cTg@mail.gmail.com>
From:   Matt <mwtaylor@gmail.com>
Message-ID: <8e85abc1-6661-547c-3aab-a60dd8b4a7b2@gmail.com>
Date:   Wed, 6 Mar 2019 15:14:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+CQ_RQgxAavzKCyhGcy0rNPnZkG_fW6mSO0j0Q3Y+cTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 06/03/2019 14:14, Luiz Augusto von Dentz wrote:
> Hi Matt,
> On Wed, Mar 6, 2019 at 3:48 PM Matt <mwtaylor@gmail.com> wrote:
>> On 06/03/2019 11:10, Luiz Augusto von Dentz wrote:
>>> Looks like the kernel is indeed assuming the length is in LE:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/net/bluetooth/mgmt.c#n3958
>> Thanks for pointing me to this line, removing the __le16_to_cpu() does
>> seem to fix the UUIDs filter scanning on my big endian hardware, I'm not
>> sure why it is needed, perhaps removing it would break LE hardware or
>> some other case but I would imagine __le16_to_cpu() would do nothing in
>> the LE case anyway. I have made this patch to my kernel (4.9) that seems
>> to be all is needed for me to fix the issue (no changes to bluez):
> Check the patch Ive just sent, your initial fix is actually correct
> but since you change it to little endian you had to convert it back
> when calculating the length of message otherwise you end up with an
> invalid size.

The patch you sent works, thanks. (Sorry, I missed it as I wasn't 
subscribed to the mailing list but looking at the archive.)

>
> The kernel is actually assuming Little Endian as this is a convention
> for Bluetooth protocols.

Ok, that would explain it then.

Many thanks for your help,

Matt

