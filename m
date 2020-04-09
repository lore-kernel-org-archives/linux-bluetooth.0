Return-Path: <SRS0=GeDB=5Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035CFC2BA19
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 18:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967A6206F7
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 18:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsG6S0Ia"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbgDISf2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Apr 2020 14:35:28 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36834 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgDISf2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Apr 2020 14:35:28 -0400
Received: by mail-ot1-f66.google.com with SMTP id l23so11515463otf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2020 11:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=U+ekVZOu9Fc7FgEbSUGjtDwsRA0E8YgDgqLUjeYg9j8=;
        b=BsG6S0IaPZTz1VMqNulVVpUm1yEvcOCn9zsm3YKMV5J3zgSz0/pOJLZJLSGGFLv4WV
         FCKaPfYEzl+NiV4Q9TpN7pNLA4D9WU4nNODDIp3XOEnZcpuVXWa67fxC2125JyKtrAPC
         zyRlKxZ+CrArqH3aGnJd8zJMvEseswqMN7jJw8nbW8Tu4ja4VN7Q0v9A2tdfzTYY7ssQ
         jneLxJu9MP2+ufll/XQb5NYyEaakCjOMunfU5lu6mAxQfJDlnIHoySzgSqZXWxfUSDYt
         bHEULja9qhvt2vfMnmlh5TawjaBdE118afzfwZVdIPrwlH5K+tlpH0/6dLtb2eDpG+U/
         O7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=U+ekVZOu9Fc7FgEbSUGjtDwsRA0E8YgDgqLUjeYg9j8=;
        b=YIFWPrGb7WYbBk3i2FB9NHGQwYoHXFvkz2XoaSRKj3BxcWvnVq/0WIA7dKD8GA7mP7
         Kwbx6FTkyJTMQHy+9t3L/w0vZRlQnu0TVxmhGZ6NBwh8J2s21isvs3vQN3IKFcO+isMp
         PODEO3IcFryZLA1c7rx1qXVgQPVKKqpkwRaYF++IUFfGz0vte4ELSr0Ta9558nZAg3jj
         WX/nPK5dZpTKi3xNQdBYI1o92McVROGYZH3BfJN/xKak9YjuOUjaH3iORiGR7EaCuBq+
         0Qe4Epsi8Zb38EA+hyLcRFV4qcUZ8d577Znqz3V0k3EetFFVsIykq7Ki09ZgmNnaxdOH
         dgeA==
X-Gm-Message-State: AGi0PuawGsGW+H0rMfP7pDGu3T1v7Usb4K8LwUKZNt8LIrMWjZEgu5sR
        9IjWBuuAbL/+4wRgT1c8QaJ4D8DVZ/tN5KsVPYM=
X-Google-Smtp-Source: APiQypJ8D7alstx6jSrnVRGs3Q2wuxwHuenO3GBS5TwcKZWGeNmIHMqOVdPCF7/aQOFD7XOfwg/jeC25HpYnny78mcw=
X-Received: by 2002:a4a:929b:: with SMTP id i27mr1083867ooh.95.1586457327575;
 Thu, 09 Apr 2020 11:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200401221434.12185-1-sonnysasaka@chromium.org>
 <ACB5D50F-BAD5-435A-AD1C-58A16878C310@holtmann.org> <CAOxioNnBq3J_F63RNHZfQzKOcwSmVy2igJ6zCfgBH+zcL1kaCw@mail.gmail.com>
In-Reply-To: <CAOxioNnBq3J_F63RNHZfQzKOcwSmVy2igJ6zCfgBH+zcL1kaCw@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 9 Apr 2020 11:35:14 -0700
Message-ID: <CABBYNZKnoUoA=01o1fZL25=Pvmq-L8VZehPB80p9fErm=GF+Gg@mail.gmail.com>
Subject: Re: [PATCH 1/5] D-Bus API changes for managing SDP records
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Rahul Chaturvedi <rkc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Thu, Apr 9, 2020 at 11:28 AM Sonny Sasaka <sonnysasaka@chromium.org> wro=
te:
>
> Hi Marcel,
>
> This was needed to support emulation of Android apps's Bluetooth API
> on top of BlueZ. Android expects to be able to access the SDP database
> of a remote device via its HAL interface
> (https://android.googlesource.com/platform/system/bt/+/master/include/har=
dware/bt_sdp.h#38).

I suppose you could read the cache directly, though there is no
guarantee that we won't change the format of that, btw I suppose
services handled by the daemon should not be exposed to the Android
side otherwise you may have conflicts so going with Profile interface
is probably the way to go, but you will need to know the UUIDs that
would be handled by Android.

> Thanks for the feedback, we will revisit this and see if a redesign
> based on your suggestion is possible.
>
> On Thu, Apr 9, 2020 at 11:05 AM Marcel Holtmann <marcel@holtmann.org> wro=
te:
> >
> > Hi Sonny,
> >
> > > This defines the DBus API that we'll use with BlueZ to create, remove
> > > and get service records.
> > > ---
> > > doc/adapter-api.txt | 46 ++++++++++++++++++++++++++++++++++++++++++++=
+
> > > doc/device-api.txt  | 37 ++++++++++++++++++++++++++++++++++++
> > > 2 files changed, 83 insertions(+)
> > >
> > > diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> > > index acae032d9..6e4c37fc9 100644
> > > --- a/doc/adapter-api.txt
> > > +++ b/doc/adapter-api.txt
> > > @@ -204,6 +204,52 @@ Methods          void StartDiscovery()
> > >                                        org.bluez.Error.NotReady
> > >                                        org.bluez.Error.Failed
> > >
> > > +             uint32 CreateServiceRecord(dict record)
> > > +
> > > +                     This method creates an entry with the local SDP=
 server
> > > +                     for this adapter for the specified record. This=
 method
> > > +                     will only create the SDP record and not start l=
istening
> > > +                     on any ports. It is up to the caller of the met=
hod to
> > > +                     ensure the validity of the service record. This=
 record
> > > +                     will not be parsed for any validation but will =
instead
> > > +                     directly be inserted into the local SDP server=
=E2=80=99s
> > > +                     records.
> > > +
> > > +                     The return value from this method will be the 3=
2 bit
> > > +                     handle for the created service record.
> > > +
> > > +                     The record dictionary will have dictionary entr=
ies of
> > > +                     the format: {id : (type, size, value)}, where,
> > > +
> > > +                     uint16 id:      The 16 bit attribute ID for an
> > > +                                     attribute.
> > > +                     uint8 type:     This will contain the type of t=
he
> > > +                                     attribute value. Attribute type=
 values
> > > +                                     are defined in the Bluetooth sp=
ec in
> > > +                                     Volume 3, Part B, 3.2.
> > > +                     uint32 size:    This is the size of the attribu=
te
> > > +                                     value.
> > > +                     variant value:  This will contain the attribute=
 value
> > > +                                     for a given attribute_id. This =
variant
> > > +                                     can either contain a primitive =
type, or
> > > +                                     if type is SEQUENCE, an array o=
f struct
> > > +                                     of the signature (type, size, v=
alue).
> > > +
> > > +                     Possible errors: org.bluez.Error.NotReady
> > > +                                      org.bluez.Error.AlreadyExists
> > > +                                      org.bluez.Error.Failed
> > > +                                      org.bluez.Error.InvalidArgumen=
ts
> > > +
> > > +             void RemoveServiceRecord(uint32 handle)
> > > +
> > > +                     This method removes the SDP record with the giv=
en
> > > +                     handle from the local SDP server.
> > > +
> > > +                     Possible errors: org.bluez.Error.NotReady
> > > +                                      org.bluez.Error.DoesNotExist
> > > +                                      org.bluez.Error.Failed
> > > +                                      org.bluez.Error.InvalidArgumen=
ts
> > > +
> >
> > so when design the BlueZ 5.x APIs, we on purpose didn=E2=80=99t do this=
. You are suppose to use doc/profile-api.txt for these kind of things.
> >
> > I am not in favor of dangling SDP records where we have no lifetime gua=
rantee of the service behind it.
> >
> > If you look at profiles/iap/main.c then you see how you could write a v=
endor profile just as easily. That one is the skeleton for iOS accessory pr=
otocol over Bluetooth.
> >
> > > Properties    string Address [readonly]
> > >
> > >                       The Bluetooth device address.
> > > diff --git a/doc/device-api.txt b/doc/device-api.txt
> > > index ceb68d2f6..e8f2c670d 100644
> > > --- a/doc/device-api.txt
> > > +++ b/doc/device-api.txt
> > > @@ -120,6 +120,43 @@ Methods          void Connect()
> > >                       Possible errors: org.bluez.Error.DoesNotExist
> > >                                        org.bluez.Error.Failed
> > >
> > > +             array{array{dict}} GetServiceRecords()
> > > +
> > > +                     This method returns the complete service record=
s of all
> > > +                     discovered BR/EDR services of the connected dev=
ice till
> > > +                     now. The return value will be an array of an ar=
ray of
> > > +                     dictionary entries. Each nested array of dictio=
nary
> > > +                     entries will contain one service record. Each p=
air in
> > > +                     the returned dictionary entries will represent =
an
> > > +                     attribute in the service record.
> > > +
> > > +                     The dictionary entries in the returned array of=
 entries
> > > +                     will be of the format: {id : (type, size, value=
)} where,
> > > +
> > > +                     uint16 id:      The 16 bit attribute ID for an
> > > +                                     attribute.
> > > +                     uint8 type:     This will contain the type of t=
he
> > > +                                     attribute value. Attribute type=
 values
> > > +                                     are defined in the Bluetooth sp=
ec in
> > > +                                     Volume 3, Part B, 3.2.
> > > +                     uint32 size:    This is the size of the attribu=
te
> > > +                                     value.
> > > +                     variant value:  This will contain the attribute=
 value
> > > +                                     for a given attribute_id. This =
variant
> > > +                                     can either contain a primitive =
type, or
> > > +                                     if type is SEQUENCE, an array o=
f struct
> > > +                                     of the signature (type, size, v=
alue).
> > > +
> > > +                     Since the service record contains the service U=
UID and
> > > +                     name, these fields do not need to be given sepa=
rately.
> > > +                     This method should be called after the ServiceR=
esolved
> > > +                     property for this object has been set to true o=
therwise
> > > +                     it may return a partial or stale cached list.
> > > +
> > > +                     Possible errors: org.bluez.Error.NotReady
> > > +                                      org.bluez.Error.NotConnected
> > > +                                      org.bluez.Error.Failed
> > > +
> >
> > These two things are not related and do not belong in the same patch. H=
owever what is your goal behind this API since even here we tried not to gi=
ve raw SDP to the application. It is all baked into the Profile API.
> >
> > Regards
> >
> > Marcel
> >



--=20
Luiz Augusto von Dentz
