Return-Path: <SRS0=GeDB=5Z=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44AE6C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 18:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092C120753
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Apr 2020 18:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GI6L5+AD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgDISZ7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Apr 2020 14:25:59 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:34384 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgDISZ6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Apr 2020 14:25:58 -0400
Received: by mail-oi1-f194.google.com with SMTP id d3so732669oic.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2020 11:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7fTzJ5tfj5ExZwXwteiQrkiqhtjp20LhhzMRc9ACEfI=;
        b=GI6L5+ADpX+f64Zx9wPY3MaLGWJfnPc4EKfWRrFHecEp1dhnMsAhkdhDob3BPX56Vg
         VjDllnA39OmZpzZvLyp3DnxbUzo3n/0VEd74PehLm7qT5/oa0Vz3/9bqkiWVysGxZvmK
         cg1p21RQFY8VObkQ2FwWzdoLa0HUVSw/P8938=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7fTzJ5tfj5ExZwXwteiQrkiqhtjp20LhhzMRc9ACEfI=;
        b=ugGCwqLmEYMnIXpvMBTCPf15WQYcgr2EUzwpbY3q8w7AZNQkJiScUioc7NiYNvZCN3
         43kHru0HxGZC2Lp+Q6SaL3gNHlV70rDQVDIJuE3LbJLEwaUML5yIA9urezhYz5X+hGGk
         IO6oLUCPUHueaelilOlPDXRbcwwcHXBbCe7tsSj0hCc6TrLALqy6VUzXsSzdE6jF6Ptl
         irUpbxZGScIs0U+OqpSQpssqmb3AOdg+WjSjd+XWQgX64mvH4AUBOdAasv33rR1qxcvo
         NzaPZf+B3SH02lX6gS0SJPdyFDpeVCBwyNNjUI2cvZgUH/dqq/qgJR2X2+eM1JSgzLF6
         kfdw==
X-Gm-Message-State: AGi0PuaY9xlDxCu7QTh6poJ+rUz9IUBXS+DkfVhtDgjKON+90nhDo1lz
        PxFB2EFuVWXF4vwfxwWBvcst6LZTrOo3rSse27UBfCzfK1M=
X-Google-Smtp-Source: APiQypJNTY3d37Hl/nPY36dV2QhhkY5eIDk+M0L0GB1cvSBbzWolK9uqdqrISSE90hTCkNVpiAD9uzsmA9oPCf+ObPA=
X-Received: by 2002:aca:dd55:: with SMTP id u82mr523207oig.27.1586456758276;
 Thu, 09 Apr 2020 11:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200401221434.12185-1-sonnysasaka@chromium.org> <ACB5D50F-BAD5-435A-AD1C-58A16878C310@holtmann.org>
In-Reply-To: <ACB5D50F-BAD5-435A-AD1C-58A16878C310@holtmann.org>
From:   Sonny Sasaka <sonnysasaka@chromium.org>
Date:   Thu, 9 Apr 2020 11:25:46 -0700
Message-ID: <CAOxioNnBq3J_F63RNHZfQzKOcwSmVy2igJ6zCfgBH+zcL1kaCw@mail.gmail.com>
Subject: Re: [PATCH 1/5] D-Bus API changes for managing SDP records
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Rahul Chaturvedi <rkc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

This was needed to support emulation of Android apps's Bluetooth API
on top of BlueZ. Android expects to be able to access the SDP database
of a remote device via its HAL interface
(https://android.googlesource.com/platform/system/bt/+/master/include/hardw=
are/bt_sdp.h#38).

Thanks for the feedback, we will revisit this and see if a redesign
based on your suggestion is possible.

On Thu, Apr 9, 2020 at 11:05 AM Marcel Holtmann <marcel@holtmann.org> wrote=
:
>
> Hi Sonny,
>
> > This defines the DBus API that we'll use with BlueZ to create, remove
> > and get service records.
> > ---
> > doc/adapter-api.txt | 46 +++++++++++++++++++++++++++++++++++++++++++++
> > doc/device-api.txt  | 37 ++++++++++++++++++++++++++++++++++++
> > 2 files changed, 83 insertions(+)
> >
> > diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> > index acae032d9..6e4c37fc9 100644
> > --- a/doc/adapter-api.txt
> > +++ b/doc/adapter-api.txt
> > @@ -204,6 +204,52 @@ Methods          void StartDiscovery()
> >                                        org.bluez.Error.NotReady
> >                                        org.bluez.Error.Failed
> >
> > +             uint32 CreateServiceRecord(dict record)
> > +
> > +                     This method creates an entry with the local SDP s=
erver
> > +                     for this adapter for the specified record. This m=
ethod
> > +                     will only create the SDP record and not start lis=
tening
> > +                     on any ports. It is up to the caller of the metho=
d to
> > +                     ensure the validity of the service record. This r=
ecord
> > +                     will not be parsed for any validation but will in=
stead
> > +                     directly be inserted into the local SDP server=E2=
=80=99s
> > +                     records.
> > +
> > +                     The return value from this method will be the 32 =
bit
> > +                     handle for the created service record.
> > +
> > +                     The record dictionary will have dictionary entrie=
s of
> > +                     the format: {id : (type, size, value)}, where,
> > +
> > +                     uint16 id:      The 16 bit attribute ID for an
> > +                                     attribute.
> > +                     uint8 type:     This will contain the type of the
> > +                                     attribute value. Attribute type v=
alues
> > +                                     are defined in the Bluetooth spec=
 in
> > +                                     Volume 3, Part B, 3.2.
> > +                     uint32 size:    This is the size of the attribute
> > +                                     value.
> > +                     variant value:  This will contain the attribute v=
alue
> > +                                     for a given attribute_id. This va=
riant
> > +                                     can either contain a primitive ty=
pe, or
> > +                                     if type is SEQUENCE, an array of =
struct
> > +                                     of the signature (type, size, val=
ue).
> > +
> > +                     Possible errors: org.bluez.Error.NotReady
> > +                                      org.bluez.Error.AlreadyExists
> > +                                      org.bluez.Error.Failed
> > +                                      org.bluez.Error.InvalidArguments
> > +
> > +             void RemoveServiceRecord(uint32 handle)
> > +
> > +                     This method removes the SDP record with the given
> > +                     handle from the local SDP server.
> > +
> > +                     Possible errors: org.bluez.Error.NotReady
> > +                                      org.bluez.Error.DoesNotExist
> > +                                      org.bluez.Error.Failed
> > +                                      org.bluez.Error.InvalidArguments
> > +
>
> so when design the BlueZ 5.x APIs, we on purpose didn=E2=80=99t do this. =
You are suppose to use doc/profile-api.txt for these kind of things.
>
> I am not in favor of dangling SDP records where we have no lifetime guara=
ntee of the service behind it.
>
> If you look at profiles/iap/main.c then you see how you could write a ven=
dor profile just as easily. That one is the skeleton for iOS accessory prot=
ocol over Bluetooth.
>
> > Properties    string Address [readonly]
> >
> >                       The Bluetooth device address.
> > diff --git a/doc/device-api.txt b/doc/device-api.txt
> > index ceb68d2f6..e8f2c670d 100644
> > --- a/doc/device-api.txt
> > +++ b/doc/device-api.txt
> > @@ -120,6 +120,43 @@ Methods          void Connect()
> >                       Possible errors: org.bluez.Error.DoesNotExist
> >                                        org.bluez.Error.Failed
> >
> > +             array{array{dict}} GetServiceRecords()
> > +
> > +                     This method returns the complete service records =
of all
> > +                     discovered BR/EDR services of the connected devic=
e till
> > +                     now. The return value will be an array of an arra=
y of
> > +                     dictionary entries. Each nested array of dictiona=
ry
> > +                     entries will contain one service record. Each pai=
r in
> > +                     the returned dictionary entries will represent an
> > +                     attribute in the service record.
> > +
> > +                     The dictionary entries in the returned array of e=
ntries
> > +                     will be of the format: {id : (type, size, value)}=
 where,
> > +
> > +                     uint16 id:      The 16 bit attribute ID for an
> > +                                     attribute.
> > +                     uint8 type:     This will contain the type of the
> > +                                     attribute value. Attribute type v=
alues
> > +                                     are defined in the Bluetooth spec=
 in
> > +                                     Volume 3, Part B, 3.2.
> > +                     uint32 size:    This is the size of the attribute
> > +                                     value.
> > +                     variant value:  This will contain the attribute v=
alue
> > +                                     for a given attribute_id. This va=
riant
> > +                                     can either contain a primitive ty=
pe, or
> > +                                     if type is SEQUENCE, an array of =
struct
> > +                                     of the signature (type, size, val=
ue).
> > +
> > +                     Since the service record contains the service UUI=
D and
> > +                     name, these fields do not need to be given separa=
tely.
> > +                     This method should be called after the ServiceRes=
olved
> > +                     property for this object has been set to true oth=
erwise
> > +                     it may return a partial or stale cached list.
> > +
> > +                     Possible errors: org.bluez.Error.NotReady
> > +                                      org.bluez.Error.NotConnected
> > +                                      org.bluez.Error.Failed
> > +
>
> These two things are not related and do not belong in the same patch. How=
ever what is your goal behind this API since even here we tried not to give=
 raw SDP to the application. It is all baked into the Profile API.
>
> Regards
>
> Marcel
>
