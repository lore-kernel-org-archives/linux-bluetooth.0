Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BA135CBA1
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 22:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762899844; cv=none; b=ZADLwPdZC6KZ4B5Mtion3iR87XMVOOBajD7092iXtgdJLgvC8IdJOKaTs8CwPwHVWBzJdyQPk8yat8n6oF60ntVlcpXn3zY/FP8bpVvRBJ/BZzSHtgYhZmlupAsF9o8FLEccKohhO+BgOFpEJivAib/TAtZimMbEGH+f9POVYWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762899844; c=relaxed/simple;
	bh=hGoobkqnJrepHEm5OVnyYIi42lCLT9hQaGBkpHmCX8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FWjxXmtstrHN07UMovMzi1zTuuRlTkJ3FRmqB2neE/EO/fNkLRrJ5aO7ECZJPQ2GoG6t1ffywo2NiBNuL8iIy+jerKkOWC4FduBkO9oAmz28k0CO3J43vadWWUR4Z49CYiA44nyNDavoRuGY1082Si4zVbr3b9U6hLxLyMpNpZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMB+G/r6; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMB+G/r6"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso252903a12.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 14:24:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762899840; x=1763504640; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BBlDRXigBnOxap8DuPEEIYeiQYYLzW6BDRish8HEJuY=;
        b=EMB+G/r6h0SzXk+5AhnLSXi8xQMeuE4MRqf3FEw6T9DsWKmI9/5HQ6W0sRQPZ4nsLL
         FL12tKjq64Vq5nggtPxCV5MVwzXElL/prVmdBjVXiTEXjaHACV9OiiX9EXV7TfGBnRsU
         3VQNpzpj9xlEG0B9D9NTdWZ8+A1WJ/QbdjLvbUJmUF2NOeQshdpwseRhtqDkZaH4NbOG
         7wuzVblA3GbA8+u7375Nla6/S7gJKC9PQI68UmdczWDSabZzuxEnZ4pkDyWTCzjUGtNm
         hO0PIMbBSMIhwPvfHUdIb4K1DRPneDMuGkWSIqlR7vatXBgFEpO8PI+UnUzzp9z1rC9x
         +ymA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762899840; x=1763504640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BBlDRXigBnOxap8DuPEEIYeiQYYLzW6BDRish8HEJuY=;
        b=bcixpTtVERlE2BqfJf4bMGYZ3xzwM7hAg9O7BCW/MNqvmuw0eEfV4MLJtYUCrn5P1M
         UgNHws1Lop7vKfNAIqTs7Aig9aHV3Hue+OxOrTQB6cJlyTNO9v5vI2undVVeNmksvgUj
         wQ0mrOkCh8llcyThXcIb1u5YsDUFz7MjZKjhd5ip85IZdHQ9JlAF8ulyCHlU/RwCcgyU
         V5oTXJNNQqfrEBzvtbZ8LKL6/KzMsf8flskxmUAGMYVgQb/8XxKfkRX477Uzb/y6Zmo3
         YAmcFn6cwBhXzsuCvfyCW24CsPFcS8YPJkhbG08+E80B8YO8+VU4ys1R/x7j/xwAuD7t
         IEfQ==
X-Gm-Message-State: AOJu0Yz73tu6wkSHQl7S3kshJNMBg9dnL3VFvjEppEXBROoKPsnlrmxj
	JJC4K9Yxu/tD3vyMjtfCQtIs+gkGiI055OCKyAhTdMZwsCVvhAWSU3pGX+wcDcmyIfl3CFgWLOj
	NRox8mtX3zM+BgphCtQBtXAyN7QNvNGk=
X-Gm-Gg: ASbGncvC+0Y/hJOhZTqlw/s29Hu3miM1YYT+NMABztOf1E9uO/wzJwFVXDbLcghYM/d
	Gg7f3phoSHnHop0OyOhAXavuXPL0WIifSeIz3ekZqAR5wLKwCcXRcnM9SEJVfB54UZoIec3pAIj
	tTqr0Im6+XT9gO9aHJQ+V4HTigphDSQoxczWyCBOjmX+rYadeExPCzRQAsHibK9ZSUQTsDBdhag
	LDsx3//2ebhj2FfoiMts9RktON1mCAdPNmVmzvPNzC4H55YEEjbxbufx/MJ+Br8NNSSfFClVmsr
	GkZMJtuylXriBWXh2xvpDQOu0Yy8xPqZs+jz48ycN7hj
X-Google-Smtp-Source: AGHT+IF+eDy7EGyqOtHDWx130+12Gcjp8nnk/sBfldICKmAsAkk6zpQpwPoPBHae2ID5WPCtZ5W28L4cN/Ud+Twfmew=
X-Received: by 2002:a05:6402:1ed1:b0:640:a356:e797 with SMTP id
 4fb4d7f45d1cf-6431a4b7579mr762375a12.13.1762899840282; Tue, 11 Nov 2025
 14:24:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251111212201.1130-1-andrew.smirnov@gmail.com> <CABBYNZK-+g8KsXB51rxH-Oaq7a4nBL1uN5NhKAn2tF9uoOLUsA@mail.gmail.com>
In-Reply-To: <CABBYNZK-+g8KsXB51rxH-Oaq7a4nBL1uN5NhKAn2tF9uoOLUsA@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 11 Nov 2025 14:23:48 -0800
X-Gm-Features: AWmQ_bkhQyyacOlvM1A4m7EiCL3mqOPspS2Q9hsWtJ9cFB57eqQuY0rvGYnm4Z0
Message-ID: <CAHQ1cqHVQMetMAOr=8vd=aPPWxfseJm2DZau3POE7VfouBZafw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] device: Limit the number of retries on auth failures
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 11, 2025 at 2:14=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Andrey,
>
> On Tue, Nov 11, 2025 at 4:25=E2=80=AFPM Andrey Smirnov <andrew.smirnov@gm=
ail.com> wrote:
> >
> > Currently BlueZ has no retry limit on reconnection attempts in case of
> > authentication failures. This leads to a very unpleasant user
> > experince with, for example, XBox controller. The scenario is as
> > follows:
> >
> > 1. Host A is running BlueZ and XBox controller is paired and connected
> >    to it.
> > 2. Host A shuts down (for example)
> > 3. XBox controller is put into pairing mode and is paired to a Host B
> > 4. Host B is powered down
> > 5. Host A is powered on
> > 6. XBox controller is powered on
> > 7. Host A/BlueZ will start spamming XBox controller with connection
> >    attempts in an endless loop
> >
> > What happens under the hood is:
> >
> > 1. BlueZ starts up, sees that there's LTK saved for XBox controller,
> >    so it adds it to kernels autoconnect list
> > 2. Once XBox controller is on and advertising, kernel connects to it
> > 3. BlueZ tries to elevate the security level, but is rejected by the
> >    controller with "Key or PIN missing" because the controller is alrea=
dy
> >    paired to another host.
> > 4. Controller disconnects, controller goes back to advertising, goto 2
> >
> > To avoid this, let's add a simple auth failure counter and disable
> > autoconnect for the device once we go past the failure threshold.
>
> Ok, but then it won't auto connect ever again, so we would have to
> somehow inform application auto-connect is disabled,
>

Do you have suggestions/preferences for how this should be
implemented? Probably a D-Bus signal?

> we can't really
> remove the pairing either since this could be an impersonation attack.

I see, it makes sense. Haven't considered that. Disregard #2 from my
questions list.

> > ---
> >
> > I don't really expect this to be the final form of this change, so
> > this is more of an RFC to get some feedback from upstream.
> >
> > I'd also love to get some feedback on the following:
> >
> > 1. Ideally I'd also want to add an exponential backoff to the retries,
> > but I'm not familiar enough with BlueZ code to know how to go about
> > that. Anyone has any advise what would be the best way to implement
> > it? Assuming there's no objection to that.
> >
> > 2. It seems like another imporvement on this front would be for BlueZ
> > to get the "Key or PIN is missing" error code and react to that by
> > removing the stored LTK info. Does that seem reasonable? If yes, it
> > looks like the kernel actually doesn't pass that error code to the
> > userspace. Is that right? Does anyone know why and what's the best way
> > to go about fixing that?
> >
> > Thanks!
> >
> >
> >  src/device.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/src/device.c b/src/device.c
> > index 91b6cc0c6..434bdf721 100644
> > --- a/src/device.c
> > +++ b/src/device.c
> > @@ -77,6 +77,7 @@
> >  #endif
> >
> >  #define RSSI_THRESHOLD         8
> > +#define AUTH_FAILURES_THRESHOLD        5
> >
> >  static DBusConnection *dbus_conn =3D NULL;
> >  static unsigned service_state_cb_id;
> > @@ -306,6 +307,8 @@ struct btd_device {
> >         time_t          name_resolve_failed_time;
> >
> >         int8_t          volume;
> > +
> > +       uint32_t        auth_failures;
> >  };
> >
> >  static const uint16_t uuid_list[] =3D {
> > @@ -7113,9 +7116,15 @@ void device_bonding_complete(struct btd_device *=
device, uint8_t bdaddr_type,
> >                         btd_device_set_temporary(device, true);
> >
> >                 device_bonding_failed(device, status);
> > +
> > +               if (device->auth_failures > AUTH_FAILURES_THRESHOLD)
> > +                       device_set_auto_connect(device, FALSE);
> > +
> >                 return;
> >         }
> >
> > +       device->auth_failures =3D 0;
> > +
> >         device_auth_req_free(device);
> >
> >         /* Enable the wake_allowed property if required */
> > @@ -7320,6 +7329,8 @@ void device_bonding_failed(struct btd_device *dev=
ice, uint8_t status)
> >         struct bonding_req *bonding =3D device->bonding;
> >         DBusMessage *reply;
> >
> > +       device->auth_failures++;
> > +
> >         DBG("status %u", status);
> >
> >         if (!bonding)
> > --
> > 2.34.1
> >
>
>
> --
> Luiz Augusto von Dentz
