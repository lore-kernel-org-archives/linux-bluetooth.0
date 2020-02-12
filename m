Return-Path: <SRS0=IUpk=4A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70DDBC2BA83
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Feb 2020 11:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F44120675
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Feb 2020 11:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtUlF6bg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgBLLl7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:41:59 -0500
Received: from mail-ua1-f52.google.com ([209.85.222.52]:40902 "EHLO
        mail-ua1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgBLLl7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Feb 2020 06:41:59 -0500
Received: by mail-ua1-f52.google.com with SMTP id g13so730447uab.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Feb 2020 03:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fnu/13z25f0DT9xa6qYaeuyQlvYh2AZIf7rT6zOFQS8=;
        b=rtUlF6bgpR1IG40/CeXtc8TPbYTN7uCTJXDS7vNi3MuHQQZ1jUy0toxjFkG9iVhS1b
         zB5dYplkosgiNSuXLtXneDtkwiyNEv3JxACga1KeeJvQMAvifn7FW0U7r/BPRo5l6zDS
         6cP/4Z9SSHy5FFvYlN7ruBlb6Xja+f1apPBBBkdwfcTqVo8vMk+XeDm48xT9KEREDYj1
         khZfglccTl912RiOZpRj3VesbwjAdlBwYYSAa4q42n4OBsb4qxlel6/hTn4Dc1dw2c7H
         0DQ7Cm9AllEjw5YidXT1H0irgM1YuuPLhMRStnL4X/3Z9UFSC1SAcPcNSNN5O2a8MeKg
         mKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fnu/13z25f0DT9xa6qYaeuyQlvYh2AZIf7rT6zOFQS8=;
        b=hFD0of1cA91gQ6m3TJrf5s3r3JhaqxJ/UaE2ay/SFlnjrdM4+xyQZnYfKL8Kkry2rm
         tzDZdFolteLOIQP5Gr9vJGkIbaFhF4CmO2Er1jfxE1ugRLqRKMgAjpUKKZImuEG/fdZI
         KRnqaYCNb8FmyYBGfrIDUf4HEosItFFdSgKWyG486Py19XDi8OmX8rIvEzc//0LrnG5K
         65Funid7Y+VxAs3nvlR20q3jsYOMCyC9wKSpu4RBEIMfQgk3ZJ+ACIx9NmHJUiVeiTZ1
         jdWbRJUJiXiHhMMjzdOemRsrZJ8SoOCXH92+zelUR1oJdNgKAmLReJ/AuCwzU63jJ2Os
         JAFQ==
X-Gm-Message-State: APjAAAVPWW5MIH8O40TehGmNBIOeF/x7hN/PK5vM1BIX9gGTBo8Kg29d
        oZHMdEClhEpiQyb4Eg/9JWgPRGR3jfCsjhFkeDg=
X-Google-Smtp-Source: APXvYqy5PFn2FPEpBAu8F+kyXj5ImaFYoY7++QIbA6/iUrjbi/LUmWT4WgrjMtdOM2k+Wbqk9/GbTM/snk8UFZw3DTI=
X-Received: by 2002:ab0:32ce:: with SMTP id f14mr4141717uao.54.1581507718504;
 Wed, 12 Feb 2020 03:41:58 -0800 (PST)
MIME-Version: 1.0
References: <CAP6wrbWGcAh2yjwWQZvjjVReH3gMFLK9yPbp20QvqBDAdZSBgw@mail.gmail.com>
 <CAMCGoNwT=FjtN+N+koed2=buvdDUF1-Uk7BywdrUtbzLdP=8NA@mail.gmail.com>
In-Reply-To: <CAMCGoNwT=FjtN+N+koed2=buvdDUF1-Uk7BywdrUtbzLdP=8NA@mail.gmail.com>
From:   Marcin Kozlowski <marcinguy@gmail.com>
Date:   Wed, 12 Feb 2020 12:41:47 +0100
Message-ID: <CAP6wrbWfRitm2dWP2ZmcmcwkZQMbmp_ntD_NqdZxKOREX72UVQ@mail.gmail.com>
Subject: Re: GAP ACL L2CAP Data Packets fragmentation over HCI in Android Bluetooth
To:     Matias Karhumaa <matias.karhumaa@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Matias,

Thanks for your answer.

Yes, I am testing on rooted device with LineageOS ROM (without patch).
I think LOS devices generally didn't get the patch yet (wasn't patched
in the Repo as as checked it out few days ago), unfortunately ...

I guess many devices will never get the fix, unless you take it in
your own hands with custom Rom etc.

Good BT has to be on, you need to be in the proximity and BT ADDR has
to be known, I can imagine for real attacks you need to know the ROP
chains (function addresses on the device, which will vary from device
to device and builds), maybe chain attacks, use other tricks, also
Samsung Devices have KNOX/RKP etc. Recently read that Android
vulnerabilities are in high demand, higher than Apple phones, since
Android improved a lot in security. I think this will not be too easy
in practical life, but I might be wrong.

Above can be wrong :)

I am looking into this for fun and to learn new things about Android.

For me enough would be to crash the BT process.

Could be there is much to todo, many hops to jump through, asking in
this group to see, if maybe I am missing something obvious.

BT self learner. I am surely missing core knowledge about it (learnt
many thing in past 24 hrs), hence my email to this group. From briefly
looking into this, could not figure out how this:

https://android.googlesource.com/platform/system/bt/+/3cb7149d8fed2d7d77ceaa95bf845224c4db3baf/hci/src/packet_fragmenter.cc#220

can happen, especially based on my simple tests? As I wrote in my
previous email.

Any insights, guidance will be greatly appreciated.


Thanks,

On Wed, Feb 12, 2020 at 12:20 PM Matias Karhumaa
<matias.karhumaa@gmail.com> wrote:
>
> Hi Marcin,
>
> Most obvious question first: are you testing against device that does not have the fix for this vulnerability yet?
>
> There are still huge amount of devices out there without access to the fix. This is why full technical report has not been published yet.
>
> Best regards,
> Matias Karhumaa
>
> ke 12. helmik. 2020 klo 12.38 Marcin Kozlowski <marcinguy@gmail.com> kirjoitti:
>>
>> Hi list,
>>
>> Hope is ok to ask here. Can somebody give some insight when this can
>> happen: https://android.googlesource.com/platform/system/bt/+/3cb7149d8fed2d7d77ceaa95bf845224c4db3baf/hci/src/packet_fragmenter.cc#220
>>
>> Tried sending fragmented GAP ACL L2CAP packets via HCI, but I cannot
>> imagine how this condition (in packet_fragmenter.cc#220) can be met:
>>
>> https://stackoverflow.com/questions/60116790/sending-gap-acl-l2cap-data-packets
>>
>> Anybody knows? Can shed some more light on this?
>>
>> Thanks,
