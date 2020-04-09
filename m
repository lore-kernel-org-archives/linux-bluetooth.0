Return-Path: <SRS0=GeDB=5Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BA7C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 21:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C001720692
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 21:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="avvD5+Wa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbgDIVF5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Apr 2020 17:05:57 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45239 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgDIVF5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Apr 2020 17:05:57 -0400
Received: by mail-ed1-f65.google.com with SMTP id m12so1706128edl.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2020 14:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=D5XJkx6+Y2ICVIFL0vTLRr64b9SHNkA+m1ZXNsfgSio=;
        b=avvD5+WamL1ViZqZ4j6xHrYqX2z6ZHbewMXpT5c2VnGSxG1fXJXNKvlzNtFBsVoSCv
         zP6bz48sMCIZojWE4xw2AzNay9X8HjtrEspZ/dqFBsPebN77EODwHmVqWs715PNPQKU7
         rWdddSj6ef2viETVF8bAPpqrci/+0Z/TTqC+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=D5XJkx6+Y2ICVIFL0vTLRr64b9SHNkA+m1ZXNsfgSio=;
        b=FnWSnuYLJmYPeBzCiCUa5HzUsPxNnueQvs7C56t4Nop0DgAmewQ+JFHCJ0xFMXCCTS
         vmEfnN17ZQPwDIsCgLQwzcec7nlNDaWQ/XIB0I20Nz49zkKXzPuHuD9dFEgLKjjBIJhc
         Ch7O7gjxqgL9WQALNsspF/OYuseFs377HYzHZACN3r7ojafJxIHneE74rD+vcKP9uen5
         Qd8hiafNu/AUP8Bx/fBQ/JQwjgcK2/4YwCMUUxbF7CLDW35T4IZ9LM8RFQjGHQglizcK
         GA6IEBvvwhV70kLOdg/Sf/9QQnxKUqA5nbQFs2vR9hQwNCp+0JarhtpJ+Y5+a5tlwaDh
         eLAg==
X-Gm-Message-State: AGi0PuZe7Ij1scFVNj/B2Wpq2WpgMiGc1uzpVuu56OudyyuzIM+10O5H
        sox4GRia17Vc5H/yWLq3f2xZLkaSuMI=
X-Google-Smtp-Source: APiQypKkjPlC9s+u5qz9lpqZEwoHPWO9HWFhuQArD+nKQJwiXe5p7yXEyboq89AGXI5bdE4r6w14FQ==
X-Received: by 2002:a17:906:4cd2:: with SMTP id q18mr1005967ejt.70.1586466353684;
        Thu, 09 Apr 2020 14:05:53 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id p12sm13432edx.43.2020.04.09.14.05.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 14:05:52 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id i10so7367255wrv.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2020 14:05:52 -0700 (PDT)
X-Received: by 2002:a5d:42c1:: with SMTP id t1mr1022360wrr.215.1586466352166;
 Thu, 09 Apr 2020 14:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200401221320.12105-1-sonnysasaka@chromium.org> <6A574E50-BBF3-4967-9C93-6F4B6DAFB47D@holtmann.org>
In-Reply-To: <6A574E50-BBF3-4967-9C93-6F4B6DAFB47D@holtmann.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Thu, 9 Apr 2020 14:05:40 -0700
X-Gmail-Original-Message-ID: <CAO271m=Rqq7QS6R362xLQWjbo6_ZLYPo-ttvevJmjqJ73HbAVQ@mail.gmail.com>
Message-ID: <CAO271m=Rqq7QS6R362xLQWjbo6_ZLYPo-ttvevJmjqJ73HbAVQ@mail.gmail.com>
Subject: Re: [PATCH] device: Add device type property
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Eric Caruso <ejcaruso@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks for the feedback, Marcel. Will come back with the modified
patches based on your suggestions.

On Thu, Apr 9, 2020 at 11:12 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Sonny,
>
> > This allows us to gather information about whether a device
> > supports BR/EDR, BLE, or both. It appears as DBus Property
> > "Type" on the org.bluez.Device1 interface.
> > ---
> > doc/device-api.txt |  5 +++++
> > src/device.c       | 31 +++++++++++++++++++++++++++++++
> > 2 files changed, 36 insertions(+)
>
> my preference is not to combine API documentation patches with code.
>
> >
> > diff --git a/doc/device-api.txt b/doc/device-api.txt
> > index 65d8fee37..ceb68d2f6 100644
> > --- a/doc/device-api.txt
> > +++ b/doc/device-api.txt
> > @@ -158,6 +158,11 @@ Properties       string Address [readonly]
> >
> >                       The Bluetooth class of device of the remote devic=
e.
> >
> > +             string Type [readonly, optional]
> > +
> > +                     The carriers supported by this remote device. If =
it
> > +                     exists, it can be one of "BR/EDR", "LE", or "DUAL=
".
> > +
>
> So all values need to be lower case. That is just how we design all API.
>
> If we do this, then I think the name =E2=80=9CBearer=E2=80=9D might be be=
tter. Also it might be better as array{string} actually.
>
> Regards
>
> Marcel
>
