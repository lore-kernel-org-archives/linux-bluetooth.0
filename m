Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EE129B22A
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 May 2025 20:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747859511; cv=none; b=QGJh8YQBaFABFod+WhFzpVUO1msMXb8NUJKfMVa8cmZU/J06SDerO5o4fTTVtdP30jWlR06dJ1p2vOMhrfZ9S+YUJYalDV43nh0Pr22ih0rX0Vt8kIbRRdCG7F6aRHvadNVZ/o0irOnYuMsY5aD3vPGUNBXNkcgXlAKqUAdMM8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747859511; c=relaxed/simple;
	bh=6fKuLvp2jnsYn6Ei2cXQZOjSUtTCPnB2o25WnxzXmN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mSfKRCAdXemL0Qpj7gZp8Lgio+PuAQMGLHdmjnsJrR/zgxs2eOn0tA4JtyWLzHAFyhHYh+xWpvf9L9KBlajaPs3wSIjHDPTjNbVvmvto5oR5FOFI/ZASZGHUaO5yjoSMvNjCo40j936T+xgeXV2/AOX8BHC2E+RyGW5kR0kzFvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9NCr25I; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9NCr25I"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54d6f93316dso8635241e87.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 May 2025 13:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747859508; x=1748464308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P9Z65ytnuBoIzSFdWSzq/aPulc+S8yiPLWdsb3TyjM0=;
        b=a9NCr25I4XMHTTP1fmFhUGiJh588itg3T+nEuFbGqQ4n1r5oWygfjj+8ND4eiIKoX6
         Mkdp2ArhBDJGssjnjA08AOEBm55ahjNL6zWTeA1iOsC8/bZu5EliRihnYXgX2bLrZwX1
         UFsLckG2fse53Ga9DInIw3D9lL63qSo1uHpulTNvIqsQ0syAWpckuf2WL5snBnvbJ+pG
         OtLEWxph49OQpLKGk2SOTFCXJQIUAOvPLskHowle+BT+IsX72y7W31/5cAmrexfaGkXq
         HcmSUnfv4dl6BdNoCijg+7MX/Iwgmvqy5d+FU5Rc7DMRY7DWK7L/Z3sk/Mdm9GS0inCr
         lrtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747859508; x=1748464308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P9Z65ytnuBoIzSFdWSzq/aPulc+S8yiPLWdsb3TyjM0=;
        b=LLV2UlbEJzAyrJUf1QoWlKCtyQdUEqCY8t3ZvMo5gNfiWjTp/UtaH4PRruxBKebkFm
         lheIG30v1CalHaeJmQempPL8CyOrxStPlHAiD7ULyO0pZJukZ34YcnRLBj7WPUK7j7xt
         zXPxLKstwJaExWWlCI/zurLsvlGpKfC4TGCfhfr+m8+DycuDOKD2tEF/AgM4cxDUiqn6
         A4ZzQwig2ATTvBqhI8rSkiCfrFPwWp72op9MirmEyjd2BGmg8xrxdqebB8jdR/DrRij4
         f/jwRWOuyzqLEMlVQainJVl4TMEGoKJWY+amJI2mV5LKeT2xcUUBbcFhLfRfv81L+TDz
         +WBQ==
X-Gm-Message-State: AOJu0YytLoVroXG5o1dN4t2qlHRmOXtMEP7bg08/rm9V5Td0m1B/lavm
	vDjLJ5meZ9UOHYTf6Tmaff5onryXv4V609EJT1PBD9QofqFM8xpbLoyDmu7zJNWxPTp2feJrQd2
	Inhf3zHXht6xk0qxeUrO1NfH7l6MjVw5Kf7Xg
X-Gm-Gg: ASbGncv7/ifLBh588DiYsd2eWP/+ybB9pP5jDTDNOK2YEL+aff+ftTIH09ZLuD3BzXZ
	sUS6bM260R/ZurMR+bhzM3vZYK1O4vl6smv7OXC5p3P5aa4x9tXK1Dgi5Jw2Xr1TcdkCw2TNafT
	ZTDfZvb8k4DdJgJrn0NWxY3uSgarMd9JLCJ3+mVZTDtw==
X-Google-Smtp-Source: AGHT+IGqY6ZpsuGsHC1Im1gLqoT8m518vX+5JPSrqE+t4q56G7u4A07CN89coJ/G87tuNdSna4ZoEiBotVbMS9Gplek=
X-Received: by 2002:a05:6512:2916:b0:54b:ed9:2cf8 with SMTP id
 2adb3069b0e04-550e7198ea2mr6830616e87.10.1747859507341; Wed, 21 May 2025
 13:31:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250520132733.1746996-1-hadess@hadess.net> <20250520132733.1746996-4-hadess@hadess.net>
 <CABBYNZ+MRhSyLokT6e=EykokK0S=Sy+hxoC3sqoPp3maUtZ6rA@mail.gmail.com> <e5a212501ffb9447c6d3668759a6af1571983bd7.camel@hadess.net>
In-Reply-To: <e5a212501ffb9447c6d3668759a6af1571983bd7.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 21 May 2025 16:31:35 -0400
X-Gm-Features: AX0GCFs8xsNyBRRDp7f_ooAJ3JIen6ACmVzhqwKVuAhwSqkZwwqNZrk9Oaq0tG8
Message-ID: <CABBYNZKY=Q45PiOm8fs+vFMWLWmyX41pzjq=wswoGzJ+zc6DLg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 4/4] device: Add user-readable messages for a
 number of errors
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Wed, May 21, 2025 at 5:34=E2=80=AFAM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> On Tue, 2025-05-20 at 10:36 -0400, Luiz Augusto von Dentz wrote:
> > Hi Bastien,
> >
> > On Tue, May 20, 2025 at 9:27=E2=80=AFAM Bastien Nocera <hadess@hadess.n=
et>
> > wrote:
> > >
> > > ---
> > >  src/device.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/src/device.c b/src/device.c
> > > index 0797e5ff5bb8..d1023f762474 100644
> > > --- a/src/device.c
> > > +++ b/src/device.c
> > > @@ -1922,9 +1922,9 @@ void device_request_disconnect(struct
> > > btd_device *device, DBusMessage *msg)
> > >                 DBusMessage *reply;
> > >
> > >                 if (device->bonding_status =3D=3D
> > > MGMT_STATUS_AUTH_FAILED)
> > > -                       err_str =3D ERR_BREDR_CONN_KEY_MISSING;
> > > +                       err_str =3D ":" ERR_BREDR_CONN_KEY_MISSING
> > > ":Link key missing";
> > >                 else
> > > -                       err_str =3D ERR_BREDR_CONN_CANCELED;
> > > +                       err_str =3D ":" ERR_BREDR_CONN_CANCELED
> > > ":Connection canceled";
> > >                 reply =3D btd_error_failed(device->connect, err_str);
> > >                 g_dbus_send_message(dbus_conn, reply);
> > >                 dbus_message_unref(device->connect);
> > > @@ -2545,7 +2545,8 @@ static DBusMessage *connect_profiles(struct
> > > btd_device *dev, uint8_t bdaddr_type
> > >
> > >         if (!btd_adapter_get_powered(dev->adapter)) {
> > >                 return btd_error_not_ready_str(msg,
> > > -
> > > ERR_BREDR_CONN_ADAPTER_NOT_POWERED);
> > > +                                       ":"
> > > ERR_BREDR_CONN_ADAPTER_NOT_POWERED
> > > +                                       ":Adapter not powered");
> > >         }
> > >
> > >         btd_device_set_temporary(dev, false);
> > > @@ -2564,7 +2565,8 @@ static DBusMessage *connect_profiles(struct
> > > btd_device *dev, uint8_t bdaddr_type
> > >                                 return
> > > dbus_message_new_method_return(msg);
> > >                         } else {
> > >                                 return
> > > btd_error_not_available_str(msg,
> > > -
> > > ERR_BREDR_CONN_PROFILE_UNAVAILABLE);
> > > +                                       ":"
> > > ERR_BREDR_CONN_PROFILE_UNAVAILABLE ":"
> > > +                                       "Exhausted the list of
> > > BR/EDR profiles to connect to");
> > >                         }
> > >                 }
> > >
> > > --
> > > 2.49.0
> >
> > I was afraid we would need to change these string again, also if we
> > need to encode more than human readable errors on on the message
> > something is already quite wrong, so I wonder if we shall instead
> > expand the error code itself e.g.:
> >
> > DBusMessage *btd_error_profile_unavailable_str(DBusMessage *msg,
> > const
> > char *str)
> > {
> >     return g_dbus_create_error(msg, ERROR_INTERFACE
> > ".ProfileUnavailable", str);
> > }
> >
> > That in my opinion uses the error reply better since we can isolate
> > what is considered a fixed string, and therefore part of the stable
> > API, and what could be considered a free format which is the error
> > message.
>
> So, for this example, a new error code
> org.bluez.Error.ProfileUnavailable to be added to
> doc/org.bluez.Device.rst right?
>
> Or would org.bluez.Error.Failed.ProfileUnavailable make it easier for
> front-ends to parse? gnome-bluetooth doesn't (currently) have any code
> to differentiate those, so it's not a problem on my side.

Don't think it adds anything to include a subdomain as
org.bluez.Error.Failed, except if you are saying that is going to
break if application don't except errors other than what is currently
documented, I would consider that a bug since otherwise we can't
really add any new errors.

> What about the human-readable strings, would you want bluetoothctl to
> translate the error code to something human-readable, or should we have
> a human-readable message right in src/device.c in this case.
>
> In short, does this work for you?
>
> DBusMessage *btd_error_failed_profile_unavailable(DBusMessage *msg)
> {
>     return g_dbus_create_error(msg, ERROR_INTERFACE
> ".Failed.ProfileUnavailable", "Exhausted the list of
> BR/EDR profiles to connect to");
> }

Except for the error just being .ProfileUnavailable that sounds good to me.

> >
> > >
> >



--=20
Luiz Augusto von Dentz
