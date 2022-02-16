Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE229C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 23:55:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238541AbiBPXzl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Feb 2022 18:55:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiBPXzk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Feb 2022 18:55:40 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B0128A137
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 15:55:27 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id d23so6773621lfv.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 15:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=/f575h3SMBRGH77JQq/jNbBckxgojn2f6RQzsxWGs+c=;
        b=Go0xGBMAhsOvIivzYVmUCog/T6Gt7kBIxoI+QxxC8Qvy8JfO92c/hdIo5vvjtw9HaI
         x9kRFwfMtECI5HtGpeqgDn2ARtA9YDla/TEwPfdy0L5i72nKLWSQKZCS71hs/kUyHaeC
         3nBefSEwyLMcQmA9gdgefOaVoNi81u3SYT060nr4bOqUfMA36EcLVbbR5KF3pfNNuGOr
         Izxi2fbopZ+VCsAWl6JIUYCEaHGUfVozFXfXycwOv1PTGiM9RrgdXW3AT6o+reC12BkG
         zEbjIWy7twXkatyPTHzIcbBbGpXUrydz5JIGPf945/y8fv1fja8kfP06laiKHGnpAglh
         /k3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=/f575h3SMBRGH77JQq/jNbBckxgojn2f6RQzsxWGs+c=;
        b=wL/WvQYp0Ep0SVQN4fq+sF/N7qUaO5zDiBnbxGI3DmOhyXSujZWsZ0g2IX0xOLuSrZ
         0vn36+l8fOWHmLR07sJForkZ1N8Yhq7aybiTisBi6MrC8Ld8JRKCXmYLrKiT4XJehIKr
         vah+i52Z1TC6nr6fu9NRjYUomhMmGFlvjwoZikfoJyutwR2L3m/J7UK1i6jPP8J0Zkr/
         lo9A7x3Y48BECt4tAS9f9yD+GcrPgsCCoF/13JdFExZcbmO782xhbMAuHddpOTOmkM2X
         1arvT4HqMC2HMZRu48u2PBWtM/DCCMJWA3xC8X+guwT2dPcB7PACHt5qIaHgnPxXwxor
         r3Rg==
X-Gm-Message-State: AOAM530heEvu6qVWylifTAaq+YDJ1eZ9jT6LE1ytH7+XbVngM2BD2XoF
        rD4WHKq/CfFOuq7uk3pSCPFl2yATLi8=
X-Google-Smtp-Source: ABdhPJzK4wfViIMR9eg50+ZMRy8G3/UqZ11uvvkxog3kVed6LWN1P/sJMwGdj/WxDb3B4RwibG9ing==
X-Received: by 2002:ac2:4acb:0:b0:43d:91a1:fa46 with SMTP id m11-20020ac24acb000000b0043d91a1fa46mr347444lfp.66.1645055726104;
        Wed, 16 Feb 2022 15:55:26 -0800 (PST)
Received: from ?IPV6:2a02:2168:8737:3600:f639:53a4:91b6:8b19? ([2a02:2168:8737:3600:f639:53a4:91b6:8b19])
        by smtp.gmail.com with ESMTPSA id x16sm786260ljd.44.2022.02.16.15.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 15:55:25 -0800 (PST)
Message-ID: <a69c86c4-e4ee-ed87-c2b9-f0b59a0a729a@gmail.com>
Date:   Thu, 17 Feb 2022 02:55:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
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
From:   Andrey Butirsky <butirsky@gmail.com>
Subject: Re: Lenovo Legion M600 wireless bluetooth mouse connected and paired
 yet not working
In-Reply-To: <CABBYNZKjUYAqctfpap2f36TcBuJFk0wX5P8jkUjpw1qqupeb0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 17.02.2022 02:10, Luiz Augusto von Dentz wrote:
> Hi Andrey,
>
> On Wed, Feb 16, 2022 at 2:36 PM Andrey Butirsky <butirsky@gmail.com> wrote:
>> Tried BlueZ 5.63 on my Fedora installation, no luck. Will try to build
>> head if no better idea..
> If that doesn't work I'm afraid you will need a dedicated kernel
> driver in order to deal with its HID reports since BlueZ just forwards
> the reports to the kernel.

That doesn't seem to work (meaning mouse doesn't move) .

Do you know where to get dedicated driver installation instructions?

