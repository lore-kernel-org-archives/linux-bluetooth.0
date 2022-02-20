Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96204C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Feb 2022 00:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiBTAG5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Feb 2022 19:06:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiBTAG4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Feb 2022 19:06:56 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF442205F2
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Feb 2022 16:06:35 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id d23so11948266lfv.13
        for <linux-bluetooth@vger.kernel.org>; Sat, 19 Feb 2022 16:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=0hbcmpUf78JELApq/uZGUHxOdgu+a7cYpjSUP5vKiJA=;
        b=pQtKg11hQ8cIFLYfVOrMbyr+xXHbrvEmFrlW31OccoLQ1bFYcijOgXIdKQrEA0TrFC
         iJFDr6TaCCXd7k+5cde2lkWs6T3edzcMslnoT3IGsF2X7BDnD/RbVaIDpVajClB5JgJg
         3tBjTRRXsJG4MCZ+4N/+fBaY7u98QxPhHgS7bma2Qmq2X/aFaFBZ/VzyKF22Hz0ntfOA
         J+iMaFW6RMuZ8dwMLcVX3up9opmJHwr5s3dczGyyFWKiKN3qQ56vD8IVfW1eaeQV8XEq
         ixoAZip0mAAmxxT5AAH9i1/g6sb6z/hhXhNn3is096QBem/Oep3EshQYD1RNeY8SRhdC
         ZWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=0hbcmpUf78JELApq/uZGUHxOdgu+a7cYpjSUP5vKiJA=;
        b=axOPU1vupEKthAFSjnuzHpkGC/MI3DC1KgMo1HDjfM112O+K8sWPV2VGM6a6qyvykE
         nyn/KD1X8MwWfYTOtaNUl3NBmeTIP5KG69TM42jTkqN51objD7ENhm2K7CAvCROEJ+KK
         7dxZL1OaRdI3ZxwVHfJBCdfe/zAVt8x+1BHQ8SgYXEirw63XVLWk1b3VzUAF0hsnmUa3
         GmJfMj1VmOv8gI0IBOChIuUL7Ys/smH5XixEJkhbH3IEtyMQ9Cr8pi7HZlHJDcEZKzd3
         AcfiJQdgiey07ZwWfsSdCFmSGIsQMZt49XL2vsnufOxj/iHGjz7Hb12BHLtHRZ/bvJom
         7thA==
X-Gm-Message-State: AOAM533rG4pPbeO0M+86erocGGhzHrBmWikxkx0xDetIzdtlZ4nI9Z80
        8JRBm6DU+nkZ9Z8WJuMck7tcsWOebvE=
X-Google-Smtp-Source: ABdhPJywKVJoqvKIqMP3qTgm1Nrj7MBnx1e4Zvgs83PSQzSl/3cedejS0Zi2Z72y2IZTqMUmU79NGw==
X-Received: by 2002:ac2:5e2f:0:b0:443:671b:cead with SMTP id o15-20020ac25e2f000000b00443671bceadmr9461226lfg.306.1645315594007;
        Sat, 19 Feb 2022 16:06:34 -0800 (PST)
Received: from ?IPV6:2a02:2168:8737:3600:b359:909a:13f:7c62? ([2a02:2168:8737:3600:b359:909a:13f:7c62])
        by smtp.gmail.com with ESMTPSA id j21sm690414lfr.139.2022.02.19.16.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Feb 2022 16:06:33 -0800 (PST)
Message-ID: <e2581b04-5c45-7a86-6bfc-bcab85900a62@gmail.com>
Date:   Sun, 20 Feb 2022 03:06:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: Lenovo Legion M600 wireless bluetooth mouse connected and paired
 yet not working
Content-Language: en-US
From:   Andrey Butirsky <butirsky@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
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
 <CABBYNZJg0qHO4gvLh8O44um68CzRMM4PE3OymRhGfiQ1kDZO1w@mail.gmail.com>
 <6de28c0c-82d5-648d-efb5-a483ede899e1@gmail.com>
In-Reply-To: <6de28c0c-82d5-648d-efb5-a483ede899e1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


On 20.02.2022 02:18, Andrey Butirsky wrote:
>> Btw, it could be due to:
>>
>> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=aa699cb762a02ec7409940ddcfe65b788de8270d 
>>
>>
>> There were some systems (afaik 32bits) with a problem with the header
>> copy we had.
> Can I check it somehow?

Oh, I built BlueZ from master so shouldn't be the case.
