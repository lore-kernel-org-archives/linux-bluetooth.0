Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1611D69E
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Sep 2024 01:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726104252; cv=none; b=TEV9lvYMTXjGIrfAlSZcIE5X4EA/k/ICEeSILYx0ay9mky68l8nNj0vumbHWixtNrOXVLcOVKFrMXOcVDnVmj6Jr+aqb4zDIQKYzbIwTZQSCtry/CXRc21oKILNuMpgDWiS/mah/Kd1wIo9hMdGQJf+r90GvBKwY0UCQM6FgScI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726104252; c=relaxed/simple;
	bh=psQL52j4FUySAERLWqcEW8pSr6hG1wUM138pkJzdGE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fq6ub+vsIqNTe6hZd7GVMJ6BAnw39P7euwSg+4gzNm6x1tQ+EenB1pA+bDAeuWEcKbm3n3lkh7Wu9WPpjyF+XpxvjWSL456EmVVnz9g2V0l1wFpiXf8fqEKQUHFn5Sh+u8qt+6Qe8wuYipuvzSUhAdeXoz2m2QfDEDY8l9igHcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbSv4x+B; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbSv4x+B"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2f754d4a6e4so4815781fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Sep 2024 18:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726104249; x=1726709049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCqHRlmgPSP+cEjmDcQ0sEpJ4ow9Ou35H7EI6cEtDjI=;
        b=mbSv4x+BizZyxy/1Oo8op8+TxK0J44XdSYCqw3QWJLFK7BLCmrHQmmDiC+2zNMMtPN
         yIMO0urNQhhiKcEbhQJDqlrGqFfhdbBbaU4sORb/DAVgw2lt+5IL99XxitfDdK4XjISC
         K68nmjTt3cBNwGDHid7a3ECZpLmw3mtlH1dDgg7VautBMpk1HEJCMwobj9izIeXsAu+l
         AxyN3rLhbBh1EFGddlQwal8+sNlTYP9xf2c32zXyG2lppCNxtvjcUnb8iRWGaKnQB2Pa
         v2XuYnr1PgSdBPNl1j1td3hIsA2KMU2p/HP+0hVv1stln6HX9DXxyKHev1JQUpw5Exwb
         tz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726104249; x=1726709049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wCqHRlmgPSP+cEjmDcQ0sEpJ4ow9Ou35H7EI6cEtDjI=;
        b=JpK2Dn+sOiUaw66Sjc5nmjBoBYqHwkob3dPUbiwTIOQsmhlGKim3ZqLxM15D4P0lf7
         Wr0x21wwI+LiiY6j9OH9FgbTo8dynHa4ITEJmx6gbmsIEhOjMdZxJvJ6uZSkpae5OXBL
         GWsmnuvP/SxIv9s2M89CSR/1kCArwOnq7Pdau4viusL5fN6xQPmnARzlX4gEl939u5ba
         pt+iesRHCV4iO+zLkTHc5j055Fm/Gmib6X1Uj2f3IVKsqaZj0vBXRw4j7ZJoafOvfwbg
         YPje8oJdWsmOayL2BRCwRPbKnC/67i2rGNu05BylK4MGGaimb7E8KWPVZ5GGtmwl7cEq
         o2Qg==
X-Gm-Message-State: AOJu0YwYQBXXu7oYqDSfNUneZzBUgI1V4iiTifGBIdUaFAspHNfJeg1R
	GpFxu6p41n17OX625dI0N2adK41UFi8e2qUefilIHqlWEZa32kbALLE+BXBTOPlC79zhl+HCWEW
	iFuZXDZcEneCE8iRlPxBZu3Yf2JpL5w==
X-Google-Smtp-Source: AGHT+IHrSyB0oA40VxRJqso3Hd5MoQH5g4tx4/KBsTFFeI/uyqzWtn0Mvl62BV7nSTqxhkaUgXeMHZfuCQvJ74NFDRA=
X-Received: by 2002:a2e:a583:0:b0:2f7:58bc:f47e with SMTP id
 38308e7fff4ca-2f787dad4f2mr5394701fa.5.1726104248115; Wed, 11 Sep 2024
 18:24:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f06506cb-c55f-4007-9df5-da7b6b268440@horse64.org>
In-Reply-To: <f06506cb-c55f-4007-9df5-da7b6b268440@horse64.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 11 Sep 2024 21:23:55 -0400
Message-ID: <CABBYNZJhFEi5x1a36EuCqpqGewLMxmOiOA73NmoPaX=BqdooWw@mail.gmail.com>
Subject: Re: Question: pairing code not showing anymore for device that was
 previously pairable
To: Ellie <el@horse64.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ellie,

On Wed, Sep 11, 2024 at 6:28=E2=80=AFPM Ellie <el@horse64.org> wrote:
>
> Hi everyone,
>
> My apologies if this is the wrong place to send this question to. But my
> question is, what do I do if a bluetooth keyboard no longer shows the
> pairing passkey code on pair? The model is a "Royal Kludge RK61-US"
> keyboard. It used to show the pairing code and then pair fine. I ested
> this with two different bluetooth controllers on two different Linux
> machines of mine.

It used to show a passkey and now it doesn't?

> But since I moved to a different distribution with different bluetooth
> tools and kernel versions, now kernel 6.10.8 with
> bluetoothctl/bluetoothd 5.77, it no longer shows the pairing code and
> bluetoothctl just thinks it pairs without showing a passkey. And during
> that, the keyboard itself keeps flashing in pairing mode and won't
> finish pairing like the Linux side seems to think it did, and I'm
> guessing it's waiting for the code which never seems to show up in
> bluetoothctl:
>
> [bluetooth]# scan on
> [bluetooth]# SetDiscoveryFilter success
> [bluetooth]# Discovery started
> [bluetooth]# [CHG] Controller 70:D8:C2:14:8B:23 Discovering: yes
> [bluetooth]# [NEW] Device C5:F9:E9:90:F6:8A RK61-5.0
> [bluetooth]# pair C5:F9:E9:90:F6:8A
> [bluetooC5:F9:E9:90:F6:8A9:E9:90:F6:8A
> Attempting to connect to C5:F9:E9:90:F6:8A
> [bluetooth]# [CHG] Device C5:F9:E9:90:F6:8A WakeAllowed: yes
> [blueC5:F9:E9:90:F6:8A9:E9:90:F6:8A
> Attempting to pair with C5:F9:E9:90:F6:8A
> [CHG] Device C5:F9:E9:90:F6:8A Connected: yes
> [RK61-5.0]# Connection successful
> [RK61-5.0]# [CHG] Device C5:F9:E9:90:F6:8A Bonded: yes
> [RK61-5.0]# [NEW] Primary Service (Handle 0x0000)
>         /org/bluez/hci0/dev_C5_F9_E9_90_F6_8A/service000a
>         0000180a-0000-1000-8000-00805f9b34fb
>         Device Information
> [RK61-5.0]# [NEW] Characteristic (Handle 0x0000)
>         /org/bluez/hci0/dev_C5_F9_E9_90_F6_8A/service000a/char000b
>         00002a29-0000-1000-8000-00805f9b34fb
>         Manufacturer Name String
> [RK61-5.0]# [NEW] Characteristic (Handle 0x0000)
>         /org/bluez/hci0/dev_C5_F9_E9_90_F6_8A/service000a/char000d
>         00002a28-0000-1000-8000-00805f9b34fb
>         Software Revision String
> [RK61-5.0]# [NEW] Characteristic (Handle 0x0000)
>         /org/bluez/hci0/dev_C5_F9_E9_90_F6_8A/service000a/char000f
>         00002a50-0000-1000-8000-00805f9b34fb
>         PnP ID
> [RK61-5.0]# [NEW] Primary Service (Handle 0x0000)
>         /org/bluez/hci0/dev_C5_F9_E9_90_F6_8A/service0011
>         0000180f-0000-1000-8000-00805f9b34fb
>         Battery Service
> [RK61-5.0]# [NEW] Characteristic (Handle 0x0000)
>         /org/bluez/hci0/dev_C5_F9_E9_90_F6_8A/service0011/char0012
>         00002a19-0000-1000-8000-00805f9b34fb
>         Battery Level
> [RK61-5.0]# [NEW] Descriptor (Handle 0x0000)
>         /org/bluez/hci0/dev_C5_F9_E9_90_F6_8A/service0011/char0012/desc00=
14
>         00002902-0000-1000-8000-00805f9b34fb
>         Client Characteristic Configuration
> [RK61-5.0]# [CHG] Device C5:F9:E9:90:F6:8A UUIDs:
> 00001800-0000-1000-8000-00805f9b34fb
> [RK61-5.0]# [CHG] Device C5:F9:E9:90:F6:8A UUIDs:
> 0000180a-0000-1000-8000-00805f9b34fb
> [RK61-5.0]# [CHG] Device C5:F9:E9:90:F6:8A UUIDs:
> 0000180f-0000-1000-8000-00805f9b34fb
> [RK61-5.0]# [CHG] Device C5:F9:E9:90:F6:8A UUIDs:
> 00001812-0000-1000-8000-00805f9b34fb
> [RK61-5.0]# [CHG] Device C5:F9:E9:90:F6:8A ServicesResolved: yes
> [RK61-5.0]# [CHG] Device C5:F9:E9:90:F6:8A Paired: yes
> [RK61-5.0]# [CHG] Device C5:F9:E9:90:F6:8A Modalias: usb:v000Ep3412d6701

It shows as paired above, I wonder if it is using JustWork pairing
method but it sounds really weird if before it used a passkey.

> Is this some sort of regression maybe, or am I supposed to try some
> special option? Am I supposed to do something with some active probe
> command in bluetoothctl to get the passkey code to show? My apologies
> for these beginner questions, but from all I could find online it seems
> like the code is meant to show up during above process but it doesn't.

We probably need the btmon traces to check if the passkey method is
really being used, maybe something else is at play like some other
pairing agent with different IO capabilities.

> I already tried the different controller modes "dual", "bredr", "le",
> and it seems like it's an "le" type device since with "bredr" it doesn't
> show up. Other than that, the modes didn't seem to make a difference.
>
> Sadly, I didn't write down the exact software versions of kernel etc.
> that I previously used when everything worked. :-|
>
> Regards,
>
> Ellie
>


--=20
Luiz Augusto von Dentz
