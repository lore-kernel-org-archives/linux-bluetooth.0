Return-Path: <SRS0=CZwu=R4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6890C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Mar 2019 12:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB6D2085A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Mar 2019 12:40:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gj3fdKvY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730989AbfCYMkR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:40:17 -0400
Received: from mail-ua1-f42.google.com ([209.85.222.42]:33594 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730858AbfCYMkQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Mar 2019 08:40:16 -0400
Received: by mail-ua1-f42.google.com with SMTP id g8so2930611uaj.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Mar 2019 05:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9mirj53OvnM9eDQxR+x4o7Ln0+V09rGpkwlnKhCdzLM=;
        b=Gj3fdKvYXT/h8nhh9kk9kiLe0AXSzV9vtgxbT2txVgXOqBgJLyfg+ZIeC7Kp9Dk+Gy
         iItkjtlJ8Qa77IOwyIutr7DE/E24dGtWbBWpMQ5DMu+A8soZ9TFqsGNZl8BJgwCVU2bi
         dckUiSrz/54KXQz77wpieoFKTTBsUsQRcPHIyH0BWuyqGKfeJ4Li8jXCu7I6AEg5jPuS
         kCm2Wt3U4njD0+rUX+Yr7KHwCdf96hj+CiFwQsWktDCCGOlmLFKZjzQ2k7kk/oG361OG
         owzRcimWhCCjexiCaNF1heh9YgAkwsxdEQ8avFE8DwVKH1sEePm3ziKgkxuF2bleELKo
         SkZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9mirj53OvnM9eDQxR+x4o7Ln0+V09rGpkwlnKhCdzLM=;
        b=VYICDHlZUB+JpoCSgZF6k7kr2uCGx5PYsDd0sJ4/uyo2sB/uoiy7z381YtkDYu+ULc
         ipFEx9SPEAMdwJP9JOUq2/Lg3DmjXP9lDwAhgi47Cu8uClQNI1IgoWZ+wBHI8s9Oyz4e
         G54g8Wro8NcqXdIKl8dnQCvhQhWcauxsdZDTvKcBbieC7ObCXG4O8NkT1mTSgEdB6gm6
         SOQS2gdzeJiQvanX7oSCSX6XaesPIFiDSeMv5YlzNHJ+Zhmzlw1+uzyaXjYrWLA0sv2S
         gYzYO5lgTnr6ANQYMTsGeTqEn7GcPf/uc23tZz+e8RxslHj9ZSKCBtN6L8G5y4ebogps
         J/+g==
X-Gm-Message-State: APjAAAV+7CqgVPqczHkrPkGCIDn3kwURWaW36e4pcIcVmTQgO6cWfFK0
        lsXLMbUUkt15CZwzt3KdTjMWwR3CP9+2zbxLz88=
X-Google-Smtp-Source: APXvYqxtAgETx8KlmvdaJMACMjDcn7KbJKLsTYIOLu+hwwKpwMI954wtNHWGaDCUWsap7Jf6BDg8yFnNDwqS2USZK5E=
X-Received: by 2002:ab0:61da:: with SMTP id m26mr13939320uan.140.1553517615920;
 Mon, 25 Mar 2019 05:40:15 -0700 (PDT)
MIME-Version: 1.0
References: <CABLzjm-SLs_AzgS2S=3ogN=P9Jk9OjBuSMaNFTpXawrAsNfe+g@mail.gmail.com>
 <CAO1O6sfDYV9q5z2b64SS1MDSuXUYS6fvxQWc00NsX_1qLxEorQ@mail.gmail.com>
In-Reply-To: <CAO1O6sfDYV9q5z2b64SS1MDSuXUYS6fvxQWc00NsX_1qLxEorQ@mail.gmail.com>
From:   Alexandre Augusto <alexandre.a.giron@gmail.com>
Date:   Mon, 25 Mar 2019 09:40:04 -0300
Message-ID: <CABLzjm_jO8=vVjSosWh=PjLpoeZuY8BSYPkSxKwomY4AYBPLGA@mail.gmail.com>
Subject: Re: Information about HCI LE Rand command
To:     Emil Lenngren <emil.lenngren@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks Emil.

The reason I asked is that I am researching ways to provide that
"minimum entropy required", and I was not able to find details about
the number generation.

Best regards,
Alexandre Giron

Em seg, 25 de mar de 2019 =C3=A0s 09:23, Emil Lenngren
<emil.lenngren@gmail.com> escreveu:
>
> Hi Alexandre,
>
> Den m=C3=A5n 25 mars 2019 kl 13:03 skrev Alexandre Augusto
> <alexandre.a.giron@gmail.com>:
> >
> > Hello,
> >
> > I would like to know, if possible, information about the bluez LE Rand
> > command (ocf 0x0018) at HCI code. How does it generate the number? Is
> > it vendor-specific (or secret)?
>
> According to the Bluetooth core specification, it shall be a "A pseudo
> random number generator compliant with [FIPS PUB 140-2]
> (http://csrc.nist.gov/publications/fips/fips140-2/fips1402annexc.pdf)"
> which shall be seeded "with at least the minimum entropy required by
> the pseudo random number generator". What algorithm each Bluetooth
> controller actually uses is therefore vendor specific. I guess most
> controllers will use some SHA-based or AES-based algorithm. Note that
> it is not the host (BlueZ) that generates the number; it just asks the
> controller to generate it for the host.
>
> /Emil



--=20
Alexandre Augusto Giron
Professor da UTFPR
