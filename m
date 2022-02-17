Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06675C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Feb 2022 13:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240651AbiBQNHM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Feb 2022 08:07:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240647AbiBQNHL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Feb 2022 08:07:11 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58D6EA763
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 05:06:55 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id o9so8227188ljq.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Feb 2022 05:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=f6C7qvpZAiYH/yPQDDigtwhT5/d+I3uypZCFdwWapdo=;
        b=GFL1Tgo5fFRDneZY7z0RErw4mFDYR12hsxTxfMBh1morhKqsaioSIsg9BROYY9AnX+
         Dg9qZX90INqtMYwyG5a0VusVbnI//HvKYmUNittf6K5E1bo/NiSZf1lPTYALDU5iXG7U
         uvCl2PtIlm+/eWjPkS40YMONNQNvqGBQ7K1thZ1eQgI2DZWAbZdYuEJG2sFiqN20ppW/
         uXVRnzd7MkgmEdBsfLZaWaIxyJdnMuJvE0RnV+pjFthTKdjb6zE7huYs7l4WI/xu8wtb
         pqS6fqsCdf+/gU48zsrqYDQp6Sn4u/Yd1GgsXEQnH1sq5ofUoWvQMeaMSRJ56uAJW3Wy
         czMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=f6C7qvpZAiYH/yPQDDigtwhT5/d+I3uypZCFdwWapdo=;
        b=pdoqZWTfZGXe0lMI3GWHow58uTQR7vUjMkeh3FFxz/5FvVyx21up2l81MckSfa8Vxc
         PrmKRLEBC3p7SO6jgkxisoKdSiNT6LDbM5Jz3EX7JvTo0Z62aiLydhR1CuGqXNOkwoy6
         v7LSelWBySmHmCRUoVNx5oMDq6D1pOWp4yTkO3khqqEreGcbp4u5Mq9egc/1dYLcrdOL
         ZbT/ehj/RvvCilpBReayX/3AoL9Mk4h5jlNX3GtYYPs5zX9sTht3rGSo7E/mmXfCsQb1
         5wKlmIsQt4pP8RnsNZrLHoNN2RZNFzFVnUp2y/kCPohzukO4uQpZd10vFt+nZf1Gg5QQ
         rolw==
X-Gm-Message-State: AOAM533gFoKUgav5uqv8IV7D6t69fi2uYYlDu94mrW14zFKKPaMGAz5p
        B6z5UfIBz3KMpX+GsRZhWkZsnbI6u0U=
X-Google-Smtp-Source: ABdhPJy0cjKYVIYauJexjxYQoAZjCn1M4el4hQe+f5nORbNzMKf3xQKbAklQD7ngQw9zTY086sb68g==
X-Received: by 2002:a2e:9949:0:b0:23c:4c33:54b with SMTP id r9-20020a2e9949000000b0023c4c33054bmr2083560ljj.253.1645103214154;
        Thu, 17 Feb 2022 05:06:54 -0800 (PST)
Received: from ?IPV6:2a02:2168:8737:3600:cd2a:e1fa:1ed7:c576? ([2a02:2168:8737:3600:cd2a:e1fa:1ed7:c576])
        by smtp.gmail.com with ESMTPSA id u20sm1280792lfo.294.2022.02.17.05.06.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Feb 2022 05:06:53 -0800 (PST)
Message-ID: <58080949-4139-3dda-cb2a-d89f20713ffb@gmail.com>
Date:   Thu, 17 Feb 2022 16:06:52 +0300
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

Could you clarify do you mean usual BlueZ dedicated driver just built 
from bluetooth-next for my kernel or some non-existent driver one yet 
had to write?

In the latter case, do you have some sample drivers maybe one could easy 
to adopt?


