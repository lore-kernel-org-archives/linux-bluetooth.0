Return-Path: <SRS0=imY+=7D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF5BEC433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 22:05:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D6BF206F6
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 22:05:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+QbQQSS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbgEUWFx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 18:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728327AbgEUWFx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 18:05:53 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFA7C061A0E
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 15:05:52 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id s198so7595370oie.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 15:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=jHoFVJHXPbghNXTep9Kc9zeR5QzsIsW3PO4Zc9F+hjQ=;
        b=o+QbQQSSiLjl+dLHBtBHKcFmgKVaFqjvX76q+5WaS1BQseLS/9f7ZmNmBZZncn8Bo5
         EE3ylgPtCdGuoOjlNimsA/f8rKTdpSfzyZU+x8jx1pASJWtcBwUWrpeDESyjX/lmayqy
         F9v5W9omIrW8rP3ji6fIwVilZahHX6s2izRdy3zo5wTf714fpKBOQ2nhJojxQCe4tnD7
         BMdE4ouWgdcw4JuGcMphe11Y57SB++yK+nyug4e1nalouOP5lZZMa0j7ZiKKnclunh1j
         H7bbrtPG+9fYFVR/dkjwtkdlqzuOFHD0fVEuoML8oBVx+3XR7iu889v7DmkostFV+dz7
         PnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=jHoFVJHXPbghNXTep9Kc9zeR5QzsIsW3PO4Zc9F+hjQ=;
        b=jnESoZA+K5Gj9ALmYuIwL0TDUWZ5Qh24dB2n75cDf0BtBj6KjC0yLaDClHsn2EP1DE
         XwPxlRNtzC7PCWn/pRNuTuX5QhALp811a+pugs2+zpO97N4V7oRPaDbfxewhcepkbPzp
         VowPwOy+CCvc9zKuLnG269B2rDn2BiyMgEr0xPpjNyiZcnR35/t70/L1lIFIfvpZRxYR
         scaPYeNA/Tk5MeFfixHyUnCJMsNfbV4sKr6qkSIItbuatydXxFw0wWOXcSKTDMAtw9lY
         GT7V4FkrRgu6ZqV/YwcUQ5fnNHY/iuBG4MKsisAc15bHjxbe4hkFZ0CUHpmOGOLRiy6/
         rCxA==
X-Gm-Message-State: AOAM531Kmit8W3qw5m2cUVwudN4ipGTAGX1pP7W8OYSdQg6oKBf5S6Z7
        VfNi/qfeJ3ntfqbfSiW306mwQylp9551ePZRW5Q=
X-Google-Smtp-Source: ABdhPJwtjAJIcB6Spr54TPMxEI8FJ3UGtOMmNIRJ5kdO0XiuQAducPGYFVTCLm0TBmO5+vMXHn+fYKw7BaSzydLEcbU=
X-Received: by 2002:aca:6747:: with SMTP id b7mr567088oiy.110.1590098751962;
 Thu, 21 May 2020 15:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200521145757.245774-1-alainm@chromium.org> <CABBYNZKU4JVHxL5NEaMFgf6-aAOrG4re=T0Yat9b=viz57PcsQ@mail.gmail.com>
 <CALWDO_UQhU5QxZ1eRNWZtAtkcghWEBM5eVeujxhROSr7PG_P=w@mail.gmail.com>
In-Reply-To: <CALWDO_UQhU5QxZ1eRNWZtAtkcghWEBM5eVeujxhROSr7PG_P=w@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 21 May 2020 15:05:38 -0700
Message-ID: <CABBYNZ+8ed4qXarr647Q2SKkvqdT3N5AccP4L5a35e--9ybzgg@mail.gmail.com>
Subject: Re: [BlueZ PATCH v3] doc:adding definitions for load default params
 mgmt op
To:     Alain Michaud <alainmichaud@google.com>
Cc:     Alain Michaud <alainm@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Alain,

On Thu, May 21, 2020 at 1:12 PM Alain Michaud <alainmichaud@google.com> wro=
te:
>
> Hi Luiz,
>
>
> On Thu, May 21, 2020 at 12:26 PM Luiz Augusto von Dentz <luiz.dentz@gmail=
.com> wrote:
>>
>> Hi Alain,
>>
>> On Thu, May 21, 2020 at 8:05 AM Alain Michaud <alainm@chromium.org> wrot=
e:
>> >
>> > This change adds the definition for the load default parameter command=
.
>> > In particular, this command is used to load default parameters for
>> > various operations in the kernel. This mechanism is also expandable to
>> > future values that may be necessary.
>> >
>> > This will allow bluetoothd to load parameters from a conf file that ma=
y
>> > be customized for the specific requirements of each platforms.
>> >
>> > ---
>> > rebase against current master
>> >
>> >  doc/mgmt-api.txt | 62 +++++++++++++++++++++++++++++++++++++++++++++++=
+
>> >  1 file changed, 62 insertions(+)
>> >
>> > diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
>> > index 6ee01fed8..c6575e654 100644
>> > --- a/doc/mgmt-api.txt
>> > +++ b/doc/mgmt-api.txt
>> > @@ -3223,6 +3223,68 @@ Set Experimental Feature Command
>> >                                 Invalid Index
>> >
>> >
>> > +Load Default Controller Parameter Command
>> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>> > +
>> > +       Command Code:           0x004b
>> > +       Controller Index:       <controller id>
>> > +       Command Parameters:     Parameter_Count (2 Octets)
>> > +                               Parameter1 {
>> > +                                       Parameter_Type (2 Octet)
>> > +                                       Value_Length (1 Octet)
>> > +                                       Value (0-255 Octets)
>> > +                               }
>> > +                               Parameter2 { }
>> > +                               ...
>> > +       Return Parameters:
>> > +
>> > +       This command is used to feed the kernel a list of default cont=
roller
>> > +       parameters.
>> > +
>> > +       Currently defined Parameter_Type values are:
>> > +
>> > +               0x0000  BR/EDR Page Scan Type
>> > +               0x0001  BR/EDR Page Scan Interval
>> > +               0x0002  BR/EDR Page Scan Window
>> > +               0x0003  BR/EDR Inquiry Scan Type
>> > +               0x0004  BR/EDR Inquiry Scan Interval
>> > +               0x0005  BR/EDR Inquiry Scan Window
>> > +               0x0006  BR/EDR Link Supervision Timeout
>> > +               0x0007  BR/EDR Page Timeout
>> > +               0x0008  BR/EDR Min Sniff Interval
>> > +               0x0009  BR/EDR Max Sniff Interval
>> > +               0x000a  LE Advertisement Min Interval
>> > +               0x000b  LE Advertisement Max Interval
>> > +               0x000c  LE Multi Advertisement Rotation Interval
>> > +               0x000d  LE Scanning Interval for auto connect
>> > +               0x000e  LE Scanning Window for auto connect
>> > +               0x000f  LE Scanning Interval for HID only
>> > +               0x0010  LE Scanning Window for HID only
>>
>> I remember commenting that we don't have profile information on the
>> kernel so Im not sure how you are planning to detect the when the
>> device is HID or not?
>
> I expect we'll need to add an Add Device flag to carry that information d=
own into the kernel.  The hid profile already sends an op, so it's relative=
ly trivial to carry that information in so we can apply specific scanning r=
equirements for that case (which are less aggressive and therefore have les=
s of an impact to Wifi and BT performance).

Well if we will need to feed that information of the profile type we
might as well just feed the intervals directly, that way any profile
that needs some different parameters than the default can all use the
same command and we don't have to grow this list when a new profile
want to use different parameters.

>>
>>
>> > +               0x0012  LE Scanning Interval for wake scenarios
>> > +               0x0013  LE Scanning Window for wake scenarios
>> > +               0x0014  LE Scanning Interval for discovery
>> > +               0x0015  LE Scanning Window for discovery
>> > +               0x0016  LE Scanning Interval for adv monitoring
>> > +               0x0017  LE Scanning Window for adv monitoring
>> > +               0x0018  LE Scanning Interval for connect
>> > +               0x0019  LE Scanning Window for connect
>> > +               0x001a  LE Min Connection Interval
>> > +               0x001b  LE Max Connection Interval
>> > +               0x001c  LE Connection Connection Latency
>> > +               0x001d  LE Connection Supervision Timeout
>> > +
>> > +       This command can be used when the controller is not powered an=
d
>> > +       all settings will be programmed once powered.  Note that these=
 only
>> > +       control the default parameters.  Higher level Apis may influen=
ce the
>> > +       effective value used.
>> > +
>> > +       This command generates a Command Complete event on success or
>> > +       a Command Status event on failure.
>> > +
>> > +       Possible errors:        Invalid Parameters
>> > +                               Invalid Index
>> > +
>> > +
>> >  Command Complete Event
>> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> >
>> > --
>> > 2.26.2.761.g0e0b3e54be-goog
>> >
>>
>>
>> --
>> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz
