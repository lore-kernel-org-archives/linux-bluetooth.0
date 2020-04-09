Return-Path: <SRS0=GeDB=5Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B52C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 21:08:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62C3720692
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 21:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A+gCGgk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727300AbgDIVIr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Apr 2020 17:08:47 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:44945 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbgDIVIr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Apr 2020 17:08:47 -0400
Received: by mail-ed1-f67.google.com with SMTP id cb27so1713153edb.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2020 14:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GxS408+UV2gpDvxvD3/brI/Th016BAR4nzkq2aNoLq4=;
        b=A+gCGgk7JVUHZQ6jruFGiiY8qAzxVrK5An+72i+uqM+jDI+DsVqlAN6eIbnAhi3njv
         WCgquBTPY94UHVqpLYPOlA6nc+rrQBm5Y17hUsGws1SdmLc1odYM3J60GWa2e/C6Ejrh
         vW3rsFAVDctGF2iXo4hi5Jkk8/lPN8UpbmKz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GxS408+UV2gpDvxvD3/brI/Th016BAR4nzkq2aNoLq4=;
        b=kD1G9SkzHKGzuhUx0uegDDA1A4tDZLHHJeBfF+LWbyLXbmZaKEzD9szqq14e7BQo/H
         ubFPYjU17vzngzeAxZJV7xSmdRehF01CnSbIasjMlzE5jnxWuXYExTK2Wc4YexLEJPKV
         zp/8shA254ON8D/AC0hcNVyUPGXLEUq2cYmjzdySTRnEICDWHFd1ti8FUHYpYAk2bnuM
         rvnJdE3ItziSkx7Y2wfzkCLqaRXwUESbpZqirFGgRsC+6ZB0gu+vnVY05Txypy9kyalW
         CxY43tDVHrLrCzqK2AipqFeF84fAk60Sl+wOvJIJixWFb5gfU1ePA70Gi59jj4ksx7dI
         xCTg==
X-Gm-Message-State: AGi0Pub2eKiaCAt++X89Ikk4Xag+VWq8bTyeqWbZDhIq9ILsam6kEetq
        MBpGnIrLWO80gMN8K8wInIZv6kF9zfQ=
X-Google-Smtp-Source: APiQypJDHfW69ak5PhUhJXbT9s2ACReLR6G5LMtmlu90DB+KgI2y0tuS7u0HyZi8HsLgDMeTAOBDzA==
X-Received: by 2002:a50:f0dc:: with SMTP id a28mr2008334edm.57.1586466525232;
        Thu, 09 Apr 2020 14:08:45 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id k9sm12928edl.35.2020.04.09.14.08.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2020 14:08:44 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id a81so291973wmf.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2020 14:08:44 -0700 (PDT)
X-Received: by 2002:a1c:a553:: with SMTP id o80mr1894867wme.154.1586466523542;
 Thu, 09 Apr 2020 14:08:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200401221434.12185-1-sonnysasaka@chromium.org>
 <ACB5D50F-BAD5-435A-AD1C-58A16878C310@holtmann.org> <CAOxioNnBq3J_F63RNHZfQzKOcwSmVy2igJ6zCfgBH+zcL1kaCw@mail.gmail.com>
 <CABBYNZKnoUoA=01o1fZL25=Pvmq-L8VZehPB80p9fErm=GF+Gg@mail.gmail.com>
In-Reply-To: <CABBYNZKnoUoA=01o1fZL25=Pvmq-L8VZehPB80p9fErm=GF+Gg@mail.gmail.com>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Thu, 9 Apr 2020 14:08:31 -0700
X-Gmail-Original-Message-ID: <CAO271mnx6pQD9S94kMzHHbt8JGOmNy-C3bS7jSGXoSD_kZD7XA@mail.gmail.com>
Message-ID: <CAO271mnx6pQD9S94kMzHHbt8JGOmNy-C3bS7jSGXoSD_kZD7XA@mail.gmail.com>
Subject: Re: [PATCH 1/5] D-Bus API changes for managing SDP records
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Thanks for the feedback, Luiz. We will explore the ways you all suggested.

On Thu, Apr 9, 2020 at 11:35 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sonny,
>
> On Thu, Apr 9, 2020 at 11:28 AM Sonny Sasaka <sonnysasaka@chromium.org> w=
rote:
> >
> > Hi Marcel,
> >
> > This was needed to support emulation of Android apps's Bluetooth API
> > on top of BlueZ. Android expects to be able to access the SDP database
> > of a remote device via its HAL interface
> > (https://android.googlesource.com/platform/system/bt/+/master/include/h=
ardware/bt_sdp.h#38).
>
> I suppose you could read the cache directly, though there is no
> guarantee that we won't change the format of that, btw I suppose
> services handled by the daemon should not be exposed to the Android
> side otherwise you may have conflicts so going with Profile interface
> is probably the way to go, but you will need to know the UUIDs that
> would be handled by Android.
>
> > Thanks for the feedback, we will revisit this and see if a redesign
> > based on your suggestion is possible.
> >
> > On Thu, Apr 9, 2020 at 11:05 AM Marcel Holtmann <marcel@holtmann.org> w=
rote:
> > >
> > > Hi Sonny,
> > >
> > > > This defines the DBus API that we'll use with BlueZ to create, remo=
ve
> > > > and get service records.
> > > > ---
> > > > doc/adapter-api.txt | 46 ++++++++++++++++++++++++++++++++++++++++++=
+++
> > > > doc/device-api.txt  | 37 ++++++++++++++++++++++++++++++++++++
> > > > 2 files changed, 83 insertions(+)
> > > >
> > > > diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> > > > index acae032d9..6e4c37fc9 100644
> > > > --- a/doc/adapter-api.txt
> > > > +++ b/doc/adapter-api.txt
> > > > @@ -204,6 +204,52 @@ Methods          void StartDiscovery()
> > > >                                        org.bluez.Error.NotReady
> > > >                                        org.bluez.Error.Failed
> > > >
> > > > +             uint32 CreateServiceRecord(dict record)
> > > > +
> > > > +                     This method creates an entry with the local S=
DP server
> > > > +                     for this adapter for the specified record. Th=
is method
> > > > +                     will only create the SDP record and not start=
 listening
> > > > +                     on any ports. It is up to the caller of the m=
ethod to
> > > > +                     ensure the validity of the service record. Th=
is record
> > > > +                     will not be parsed for any validation but wil=
l instead
> > > > +                     directly be inserted into the local SDP serve=
r=E2=80=99s
> > > > +                     records.
> > > > +
> > > > +                     The return value from this method will be the=
 32 bit
> > > > +                     handle for the created service record.
> > > > +
> > > > +                     The record dictionary will have dictionary en=
tries of
> > > > +                     the format: {id : (type, size, value)}, where=
,
> > > > +
> > > > +                     uint16 id:      The 16 bit attribute ID for a=
n
> > > > +                                     attribute.
> > > > +                     uint8 type:     This will contain the type of=
 the
> > > > +                                     attribute value. Attribute ty=
pe values
> > > > +                                     are defined in the Bluetooth =
spec in
> > > > +                                     Volume 3, Part B, 3.2.
> > > > +                     uint32 size:    This is the size of the attri=
bute
> > > > +                                     value.
> > > > +                     variant value:  This will contain the attribu=
te value
> > > > +                                     for a given attribute_id. Thi=
s variant
> > > > +                                     can either contain a primitiv=
e type, or
> > > > +                                     if type is SEQUENCE, an array=
 of struct
> > > > +                                     of the signature (type, size,=
 value).
> > > > +
> > > > +                     Possible errors: org.bluez.Error.NotReady
> > > > +                                      org.bluez.Error.AlreadyExist=
s
> > > > +                                      org.bluez.Error.Failed
> > > > +                                      org.bluez.Error.InvalidArgum=
ents
> > > > +
> > > > +             void RemoveServiceRecord(uint32 handle)
> > > > +
> > > > +                     This method removes the SDP record with the g=
iven
> > > > +                     handle from the local SDP server.
> > > > +
> > > > +                     Possible errors: org.bluez.Error.NotReady
> > > > +                                      org.bluez.Error.DoesNotExist
> > > > +                                      org.bluez.Error.Failed
> > > > +                                      org.bluez.Error.InvalidArgum=
ents
> > > > +
> > >
> > > so when design the BlueZ 5.x APIs, we on purpose didn=E2=80=99t do th=
is. You are suppose to use doc/profile-api.txt for these kind of things.
> > >
> > > I am not in favor of dangling SDP records where we have no lifetime g=
uarantee of the service behind it.
> > >
> > > If you look at profiles/iap/main.c then you see how you could write a=
 vendor profile just as easily. That one is the skeleton for iOS accessory =
protocol over Bluetooth.
> > >
> > > > Properties    string Address [readonly]
> > > >
> > > >                       The Bluetooth device address.
> > > > diff --git a/doc/device-api.txt b/doc/device-api.txt
> > > > index ceb68d2f6..e8f2c670d 100644
> > > > --- a/doc/device-api.txt
> > > > +++ b/doc/device-api.txt
> > > > @@ -120,6 +120,43 @@ Methods          void Connect()
> > > >                       Possible errors: org.bluez.Error.DoesNotExist
> > > >                                        org.bluez.Error.Failed
> > > >
> > > > +             array{array{dict}} GetServiceRecords()
> > > > +
> > > > +                     This method returns the complete service reco=
rds of all
> > > > +                     discovered BR/EDR services of the connected d=
evice till
> > > > +                     now. The return value will be an array of an =
array of
> > > > +                     dictionary entries. Each nested array of dict=
ionary
> > > > +                     entries will contain one service record. Each=
 pair in
> > > > +                     the returned dictionary entries will represen=
t an
> > > > +                     attribute in the service record.
> > > > +
> > > > +                     The dictionary entries in the returned array =
of entries
> > > > +                     will be of the format: {id : (type, size, val=
ue)} where,
> > > > +
> > > > +                     uint16 id:      The 16 bit attribute ID for a=
n
> > > > +                                     attribute.
> > > > +                     uint8 type:     This will contain the type of=
 the
> > > > +                                     attribute value. Attribute ty=
pe values
> > > > +                                     are defined in the Bluetooth =
spec in
> > > > +                                     Volume 3, Part B, 3.2.
> > > > +                     uint32 size:    This is the size of the attri=
bute
> > > > +                                     value.
> > > > +                     variant value:  This will contain the attribu=
te value
> > > > +                                     for a given attribute_id. Thi=
s variant
> > > > +                                     can either contain a primitiv=
e type, or
> > > > +                                     if type is SEQUENCE, an array=
 of struct
> > > > +                                     of the signature (type, size,=
 value).
> > > > +
> > > > +                     Since the service record contains the service=
 UUID and
> > > > +                     name, these fields do not need to be given se=
parately.
> > > > +                     This method should be called after the Servic=
eResolved
> > > > +                     property for this object has been set to true=
 otherwise
> > > > +                     it may return a partial or stale cached list.
> > > > +
> > > > +                     Possible errors: org.bluez.Error.NotReady
> > > > +                                      org.bluez.Error.NotConnected
> > > > +                                      org.bluez.Error.Failed
> > > > +
> > >
> > > These two things are not related and do not belong in the same patch.=
 However what is your goal behind this API since even here we tried not to =
give raw SDP to the application. It is all baked into the Profile API.
> > >
> > > Regards
> > >
> > > Marcel
> > >
>
>
>
> --
> Luiz Augusto von Dentz
