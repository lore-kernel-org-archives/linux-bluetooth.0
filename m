Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CA0C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Feb 2022 20:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiBPU0w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Feb 2022 15:26:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiBPU0p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Feb 2022 15:26:45 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8F7FD39
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 12:26:30 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id y6so8594214ybc.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Feb 2022 12:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iOeVnApMASNcjsKPI9gTYyuBgtGasfnDFV1/VqE56Eo=;
        b=amjGPuSObPnxmrqr4dJjD3p3PxH2qdmyIOdfFaKumQdcfy/pz5KgUMWDQxWEBlYvYT
         Y3nz6ohnfdhbE5F2Jq5fztSX8gOnmONahape6AkCJm50o+TzcmxX1uUjTpoeocvWWKwX
         AqXNToxjhS4uZg2WNAzm5WbuXLhkZxX+ohkw+mXavGSL+dzpyD1UTr/lqkirA8PJdGDi
         k28KckBYYk4UWLvy3ITON/EwyG55LHZWiuXsXlFlRTbPE8WI3/q51z3QrDp8v1LJNXbb
         5/RGzDXAsa55XIuIQuRQqumuzL3IoZ92WAQS6KB58Zl2Bc52nw9Zz3/k4x/NY8gpHv9k
         lueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iOeVnApMASNcjsKPI9gTYyuBgtGasfnDFV1/VqE56Eo=;
        b=P3+gD74JSaMJbJT0WAXLHnGJi5SvGSrCIAnin6c1K7aVO2UsW/tYdSilCD7278vAyf
         Wq9gg47A0CE3QT2m53sAqJUwSFwaV9DXJ78cIsilWB7/Smz5p2BtERLQrEokPvVHvtDZ
         dcYLrO8e1JxbdStxmuevU+euQCIJi6oItaGVk+6tboOhF8+LcCgSVKVDQpjVYniv/lrc
         u+qzYQlSihw1Vk1qhxhH1erCqUJM459BWNweLCYZBjYTRAfkWlkHOdY1W+t5hKrkVP4U
         rRPUJeJ/lR/nX8PgqQ2HO228uLT75Cd1buDPyC6DFCpRzj48tmYzKEO4ER/4dwII9zra
         dhcg==
X-Gm-Message-State: AOAM530Muny2TbXru9PXYEb5HIFORt0K/PCEbyl4FzpNUpsg76oRq91e
        FRYyQlgfVhvalYooX06XaVC8beM22zX5FYk162ZdN3qSBdkuKg==
X-Google-Smtp-Source: ABdhPJw49NTRElZ/Q5GHoTmuIWHYtoWRph+5clH7NaoRv9WyFJeuEyTby7FBJA6juQ4BtTU35f1/1amRSkQlOtuEkvM=
X-Received: by 2002:a25:add5:0:b0:61d:c906:f4b7 with SMTP id
 d21-20020a25add5000000b0061dc906f4b7mr3730874ybe.284.1645043189152; Wed, 16
 Feb 2022 12:26:29 -0800 (PST)
MIME-Version: 1.0
References: <f610b069-07ab-1004-e8f1-b84533593c92@gmail.com>
 <CABBYNZLA6bRCxd=Tse_XbUT8ReBo4QjvstSassfQAcTX+Fk9_g@mail.gmail.com> <b50b9b75-96ea-0d93-3687-3a79cdec5419@gmail.com>
In-Reply-To: <b50b9b75-96ea-0d93-3687-3a79cdec5419@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 16 Feb 2022 12:26:18 -0800
Message-ID: <CABBYNZKAUMOZ8vhk2ATPOaVHbcqCTg-DMD2vypkx_CTOjeVg2g@mail.gmail.com>
Subject: Re: Lenovo Legion M600 wireless bluetooth mouse connected and paired
 yet not working
To:     Andrey Butirsky <butirsky@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Andrey,

On Wed, Feb 16, 2022 at 8:03 AM Andrey Butirsky <butirsky@gmail.com> wrote:
>
> On 16.02.2022 02:22, Luiz Augusto von Dentz wrote:
> > Hi Andrey,
> >
> > Please collect the HCI with use of btmon.
>
>
> Hi Luiz, thanks for your response!
>
> In btmon I see a lot of
>
>  > ACL Data RX: Handle 3585 flags 0x02 dlen 14
>
> events when I move the mouse.
>
> Full log is attached in snoop and text formats.
>
> Also I pressed all the buttons present on the mouse.

So we are receiving the reports:

> ACL Data RX: Handle 3585 flags 0x02 dlen 14
      ATT: Handle Value Notification (0x1b) len 9
        Handle: 0x002c
          Data: 01000000020000

So I suspect there is something in the HID/uHID not working then, what
version of BlueZ are you using?

-- 
Luiz Augusto von Dentz
