Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66479E555
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Apr 2025 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744983090; cv=none; b=iehmeWqsNSCCu6HvMc7RMqvvx8BRMLXWPMg7GdoOhb6pufjvuuc75gKi96BYGmqeMaT+nII8hBPaIcuIbnjC9xUwHOd960xY65BsKSidGEoY5OD9SLgxmxzc4x/l74GlM7aSvqEQmDrwLdLTrkV+teCO3fY3q4neCKm3IHm/isw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744983090; c=relaxed/simple;
	bh=64k6KkZ8pMrluIHJNAzn1541qampYHBXDSaLkYUZO9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oJ/cPYj4xPBlqEWR2C3/RutsFRwgjFSYgmp/4UJFfNsEK6RDBv+JLhbNrTtDqJSImWa3UIBeq5NkqhD+vw3YxKVegZzmkBMV26pK5g3KBNL++9zJ3pleLA8yBlfpibCJz3u7HHl7UIcCPfIK7R+F70RF67R/4s42H/PvpqVnHNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z9wTa1jm; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9wTa1jm"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3105ef2a06cso17579411fa.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Apr 2025 06:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744983086; x=1745587886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtigxdwLMba5lu5y35LyF29/gCC7dws52Wwu4v3AKYY=;
        b=Z9wTa1jmesbHp2EFTq8erM4Qs7yiR2nT17AtO0F4FEfIaz/IglVYQ2JVAZ6YD8RS0U
         rDG2ZngYa6nB+sBUAsODK4vMg7GUWSdniJbg5Pwaec5+XxIgVzkxIoRqWT+Oo3il3hFK
         ahNKQ/kNFnQgkf4C4B51dPyKNGraMtYuEf/kw5pFCrKn62M/MlDNpiS66oLyKeT7uznI
         /UB5YHLkPGSsryX3P0BImJ8d+jU3IfEW6XMxzjCOd5hGRXHeus4vInXWrqWCz4pKP7Cb
         PAdj30w2+1nJwkgWnGUPvbDbjVu+CxUo4pkrKYQbHaTIVBpA9mDGek2psMWDw0zMUCgT
         qZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744983086; x=1745587886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtigxdwLMba5lu5y35LyF29/gCC7dws52Wwu4v3AKYY=;
        b=Q0ONtgQ2+jlPRxbeBcdESvvdpvCNk8KSbEsPh4QPh1gjyDoQpv48iTJgK1Wltcq7Dp
         l/32eVjMOTb86grnTZikzA+Nap9g3E/0mUAzrK2PRac7DlAMGHMUubtDiCom4xU9rxr+
         Df5kOU5sSJ3dQKDy9+wef3VH2LJUuMSLu9dDJi9I6obS8ZR24avZR+viQl+P2OxJv17Q
         d+qUnpYZK5q2M635p3qe18xlt1n6ocavE+KSiZm8SkqqKvSxo0Wgu/dvDha3nr4Knirn
         9eR1/BeUxDna1NAT+riIVKgEmBP6h8o/ZLpOspPg9dT+3tjDIKxaUswUcbLpXgcN1sKi
         yTIw==
X-Gm-Message-State: AOJu0YzT/+AhUi4rQl+5/gL3UWW9uU/MemtIDn0QozP3v8AAdTsLjIpu
	IdVuS1KsBirWGnCbjNy6LY1b//g4xbBf5NXj9AUnaTxW39BYWlScCNaDtQ1YT2cIQZp8Bq6QGe4
	m19hM+S337FQ/T7SotTdtLQQclNXoK3/G
X-Gm-Gg: ASbGnctO8zAqM7OK/pKGF2NBJU703YS4mA+KxJ389epQbqorZG/aHXfjcmm48qJc2eN
	w2jQHhVfm8wguxCW6bmn7NsygecuxctOpr851ARSUs3tTqqlICBpq/wieaU7Y60HXvhoQs/hXq1
	k5ryilcGEICoSwwoNmGxzO
X-Google-Smtp-Source: AGHT+IFViDpnbpQroXFAOoTZ1CRMUk27nX0pWfT7/vNhVGGYTEG0SCAu0o2S/9tG+W5/pQdvnWdaHEfsEiyY7ZEiv8s=
X-Received: by 2002:a05:651c:3228:b0:30c:aae:6d4a with SMTP id
 38308e7fff4ca-31090553f18mr9603201fa.26.1744983085928; Fri, 18 Apr 2025
 06:31:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416152039.971257-1-kernel.org@pileofstuff.org>
 <20250416152039.971257-3-kernel.org@pileofstuff.org> <db879066-a355-4b98-a802-7982e9736a2b@pileofstuff.org>
In-Reply-To: <db879066-a355-4b98-a802-7982e9736a2b@pileofstuff.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 18 Apr 2025 09:31:13 -0400
X-Gm-Features: ATxdqUGI9qy9IJ7abkAOSVxnmz6cnhI-zHDgTIuZHh2XvKev4MXj9gPlvwPLB9U
Message-ID: <CABBYNZ+X0V89V72Hv_T-4-Q3RyKtXpFDjdKjiBM+t-BTN+o59Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ 2/2] obexd: only run one instance at once
To: Andrew Sayers <andrew+antispam-20250418@pileofstuff.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Fri, Apr 18, 2025 at 5:12=E2=80=AFAM Andrew Sayers
<andrew+antispam-20250418@pileofstuff.org> wrote:
>
> On 16/04/2025 16:19, Andrew Sayers wrote:
> > Obex is a device-oriented protocol, so only one instance can run per de=
vice.
> > But Linux file security is user-oriented, so obexd should be a user ser=
vice.
> > Tell systemd to only run this service for the first non-system user to =
log in.
> >
> > Without this patch, errors like the following will occur if you
> > use the "switch account" feature of your desktop environment,
> > then log in with another account:
> >
> > Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:regi=
ster_profile() :1.2016 tried to register 00001133-0000-1000-8000-00805f9b34=
fb which is already registered
> > Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:regi=
ster_profile() :1.2016 tried to register 00001132-0000-1000-8000-00805f9b34=
fb which is already registered
> > Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:regi=
ster_profile() :1.2016 tried to register 0000112f-0000-1000-8000-00805f9b34=
fb which is already registered
> > Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:regi=
ster_profile() :1.2016 tried to register 00001104-0000-1000-8000-00805f9b34=
fb which is already registered
> > Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:regi=
ster_profile() :1.2016 tried to register 00001106-0000-1000-8000-00805f9b34=
fb which is already registered
> > Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:regi=
ster_profile() :1.2016 tried to register 00001105-0000-1000-8000-00805f9b34=
fb which is already registered
> > Mar 26 15:20:38 andrews-2024-laptop bluetoothd[873]: src/profile.c:regi=
ster_profile() :1.2016 tried to register 00005005-0000-1000-8000-0002ee0000=
01 which is already registered
> > Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestP=
rofile error: org.bluez.Error.NotPermitted, UUID already registered
> > Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestP=
rofile error: org.bluez.Error.NotPermitted, UUID already registered
> > Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestP=
rofile error: org.bluez.Error.NotPermitted, UUID already registered
> > Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestP=
rofile error: org.bluez.Error.NotPermitted, UUID already registered
> > Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestP=
rofile error: org.bluez.Error.NotPermitted, UUID already registered
> > Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestP=
rofile error: org.bluez.Error.NotPermitted, UUID already registered
> > Mar 26 15:20:38 andrews-2024-laptop obexd[1795560]: bluetooth: RequestP=
rofile error: org.bluez.Error.NotPermitted, UUID already registered
> >
> > The above errors indicate the service completely failed to register, so=
 this
> > does not change the user experience beyond removing the above messages.
> > Specifically, the first user who logs in to a multi-user system still r=
etains
> > obex access to devices paired by users who log in later.
> >
> > This is based on a pair of recent changes to the FluidSynth daemon:
> >
> > https://github.com/FluidSynth/fluidsynth/pull/1491
> > https://github.com/FluidSynth/fluidsynth/pull/1528
> >
> > This was discussed in the comments for a GitHub advisory available at
> > https://github.com/bluez/bluez/security/advisories/GHSA-fpgq-25xf-jcwv
> > but comments are not shown in the published version of the advisory.
> > To summarise the useful conversation with Luiz Augusto von Dentz:
> >
> > Obex requires access to the user's home directory, so an attacker can o=
nly
> > transfer files between locations the user controls.  That may be a prob=
lem
> > if the user who runs obexd is different to the user who paired the devi=
ce,
> > but solving that would involve pairing per-user, which causes other pro=
blems.
> > Bluetooth connections can be initiated by peripherals, so switching use=
r could
> > trigger re-pairing and cause the original user to lose access to the de=
vice.
> > This may seem reasonable for file access, but for example users would l=
ikely
> > object to constantly re-pairing their Bluetooth keyboard.
> >
> > Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
> > ---
> >   obexd/src/obex.service.in | 6 ++++++
> >   tools/bluez.tmpfiles.in   | 1 +
> >   2 files changed, 7 insertions(+)
> >
> > diff --git a/obexd/src/obex.service.in b/obexd/src/obex.service.in
> > index cf4d8c985..42d2185fb 100644
> > --- a/obexd/src/obex.service.in
> > +++ b/obexd/src/obex.service.in
> > @@ -1,10 +1,16 @@
> >   [Unit]
> >   Description=3DBluetooth OBEX service
> > +# This is a user-specific service, but bluetooth is a device-specific =
protocol.
> > +# Only run one instance at a time, even if multiple users log in at on=
ce:
> > +ConditionPathExists=3D!/run/lock/bluez/obexd.lock
> > +ConditionUser=3D!@system
> >
> >   [Service]
> >   Type=3Ddbus
> >   BusName=3Dorg.bluez.obex
> >   ExecStart=3D@PKGLIBEXECDIR@/obexd
> > +ExecStartPre=3Dtouch /run/lock/bluez/obexd.lock
> > +ExecStopPost=3Drm -f /run/lock/bluez/obexd.lock
>
> Recent experience with the equivalent FluidSynth patch shows that,
> if a package maintainer upgrades without adding the tmpfile,
> the above causes the service to fail in ways that users find confusing.
>
> One solution would be to prefix a '-' to make systemd ignore errors:
>
> +-ExecStartPre=3Dtouch /run/lock/bluez/obexd.lock
> +-ExecStopPost=3Drm -f /run/lock/bluez/obexd.lock
>
> That would reduce a missing tmpfile from a crash to just log spam.
> But if the tmpfile gains a more important use case in future,
> you might uncover bugs in distro's that never installed the tmpfile.
>
> An alternative would be to add a comment like:
>
> +# If the service fails on the following line, please ensure
> +# the bluez tmpfile has been installed in /usr/lib/tmpfiles.d/
> +ExecStartPre=3Dtouch /run/lock/bluez/obexd.lock
> +ExecStopPost=3Drm -f /run/lock/bluez/obexd.lock
>
> That wouldn't fix the problem, but would make it easier to debug,
> and hopefully nudge users to file a useful report with their distro.

Yeah, let's do that, can you send an update to the series?

> >
> >   [Install]
> >   Alias=3Ddbus-org.bluez.obex.service
> > diff --git a/tools/bluez.tmpfiles.in b/tools/bluez.tmpfiles.in
> > index e69de29bb..05b8ad65c 100644
> > --- a/tools/bluez.tmpfiles.in
> > +++ b/tools/bluez.tmpfiles.in
> > @@ -0,0 +1 @@
> > +d /run/lock/bluez 0777 root root



--=20
Luiz Augusto von Dentz
