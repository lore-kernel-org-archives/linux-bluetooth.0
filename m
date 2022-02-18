Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E4DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Feb 2022 11:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbiBRLzS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Feb 2022 06:55:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbiBRLzR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Feb 2022 06:55:17 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23509253BD7
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 03:55:01 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id bn33so3925501ljb.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Feb 2022 03:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc
         :references:from:subject:in-reply-to:content-transfer-encoding;
        bh=LpTSlOI5yVEKnbppnJaKaIMeR05a7qhhYy/oeJHL2FQ=;
        b=BK94jbNHfsjH/XHtcQPW/2qpNWomTnUcAIRy3out6Dm99dC5IDcVoEQowbosnkJurh
         Ix8StOCyFqwaKraQfhM0N2W7mc7bKplN9vwPDJJStEoe019SYJpBK7aVC2rK1TbeP4jH
         /oSXRbwQyNL+YvrTv3WdjAlauESCKBqwov82eqC4npEc+udoikvoHAluPsh3sEbhhVqD
         KINnoIlVdvhwXkw4Rdzi5nXFXITNQ3fNKpr+ItwtpqZG2GqVRKXGhdB8fyqIzVQf856Q
         Mzddazsvsfuz0waFtsAcMHHTBfkmuE4xNMU9tBUOC6W7Kecmbe9qOKrd2M+VtkDyx7Ei
         nM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=LpTSlOI5yVEKnbppnJaKaIMeR05a7qhhYy/oeJHL2FQ=;
        b=oKtJhXlts1UYOveJGsDzxD97ihNQCLxgPcsLdeHvZ1Pu8Yv4KinIjy5ve3wZo7CLAS
         p/4wmaZkEIGubSP4hgXJCMq26PpUSs8md3b73cCai5td2SK7xmdRUQ488LxDOQflRzAk
         gDP4oeehRirPmJfRBkI/M6iE3ZUzjAbhdCfkb+Ny9T+Q2oBx9nLAZhSsBwCuv1aleuPs
         rktxxp7NQjqxrLPNqsBPqujvkcknBVIV/gCc/OgZLuigCYcFjKewOryrCumtdEXAghUK
         vAP7WvXacp7te7BZN79dj5GBdXeRZA+ykFURhYjsEC58Z1+JYQtSWGOr0KeTpgYC/Wqx
         lFtg==
X-Gm-Message-State: AOAM531ryJZAbClJtSMCYGldfqKTjgqDcLfzDS7QNVLfQvnbp3+6Mu5P
        RWwGwEA9NKndcpTWioM/XSD2Iy4gxTY=
X-Google-Smtp-Source: ABdhPJxgXte6Rv5Qxs3q4rwNkjRU4GkxGVh+SNkoA+ybU/TCeVWMqSEdwDil7yRbCmiL1PGjtIF/tg==
X-Received: by 2002:a05:651c:a09:b0:239:8f43:ad53 with SMTP id k9-20020a05651c0a0900b002398f43ad53mr5568944ljq.458.1645185299355;
        Fri, 18 Feb 2022 03:54:59 -0800 (PST)
Received: from ?IPV6:2a02:2168:8737:3600:cd2a:e1fa:1ed7:c576? ([2a02:2168:8737:3600:cd2a:e1fa:1ed7:c576])
        by smtp.gmail.com with ESMTPSA id bt24sm232105lfb.246.2022.02.18.03.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 03:54:58 -0800 (PST)
Message-ID: <72b3b0ee-cca0-3804-ce78-1345c4590963@gmail.com>
Date:   Fri, 18 Feb 2022 14:54:58 +0300
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

Important addition: the mouse does work on Android 8.10.

Does it mean Android has that special HID driver that missed on Linux? 
8.10 came out long before the mouse even existed..

Do you have explanation?

