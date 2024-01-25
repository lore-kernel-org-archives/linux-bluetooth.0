Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B9667A17
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706193069; cv=none; b=TXkD5mdlyFE8pMbFoIywNAJIEcSdu17WYnBkbZN6n7Sqy0o0PX/5lar0XXG4B6SYEFQozT/rMleMcSlpkM1HnpkLLYUUubKoJIrYxhgKFdvAFdJ5pd4HVxUvQsV57tMdIKIlZ30lpV2xGHXDGJIImLCDMoF7uyG5mwRZpgH/lFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706193069; c=relaxed/simple;
	bh=6G3wLYmPlT9gPDy1pV7AGAtrUy/t2qA82IE4QoskQWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4WeM8yVgCHmaN+2cFvMptx4VaJMz/I0Kvl7YeN6b7Qllmuu4ftWdmePkMrUrHXmJrfKfc8c7jLCDT00QJ6PRdoYjurZMFg7ydbDOEn1lCdH6ZNQCIWky6D0GVUKRnStqOSXoqUD9wz/VYkLypm03n/cDV5VQ9TsQrRd9cwfO0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzVSrAk3; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzVSrAk3"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33926ccbc80so4361812f8f.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 06:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706193065; x=1706797865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sFPaXhTHCFOuwEindCMvIJ/B6iM55ZV6WYswliZCmCE=;
        b=UzVSrAk3DfEJMxMYFSXuQNkHmavE9t7tpO1XZPxRUdu2rVvmjsC30cY3YXKziIp0Oy
         Owy20YsH3naF8qf2AOVfm7F6WHE4TT6tQGEAWDL1dSnKZ4IrjgkFydmqg+CVwfScqmFt
         /yKiulhgag2gSEIt9wg1qttc7M7Sg3BiN+TtlraSWi6O2+XPgww7c6rDB47TezbHaDgl
         FdRzUYa/DGnZj2s1ZB4XMFdg+zEXjIcWGogRZkfnKBDG1DCKn66STJXkakzYrvbXwxL3
         iOcc3LBLzj3QcU1/FU4SL9Duqn72L189qtA+qazzW63etmBl5op/QSBdjwM1jLt6/xRk
         pEWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706193065; x=1706797865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFPaXhTHCFOuwEindCMvIJ/B6iM55ZV6WYswliZCmCE=;
        b=GpBgeKVl5rfEtR0/KbW56CTxcEOrAs6U78nHmD1zFGp7fHl2QTmDxUPWp9uPFYXTbn
         KPWV4lUAB6/U4znwCwFToCK+VTle/W4/XMkbSjBMYl5LPrluY2rnzlUGZ4XFiYDR1YAH
         gISAsRUX9LeWQC6g5+NGjObEaZeX70tvTcdHIIpc4/3AXCP2PD6GSLT45mZ/AdMnVogF
         ZCP2q8Gitr0J2+Iu/pxxIvfuQu9c5FiRfz+gKSsk2zgsxbPD33UGbAQu4dAFlVsPcveS
         msgRTBvHi8wAy2nLgGGG3haq3XH16G0lEUYPKrPnrMD3jbYmLsYgr9b9c7ETASHPtLxq
         H5jg==
X-Gm-Message-State: AOJu0YzFw/3OcPrj9Nu7F62k4r0toqx3hdvC7390YyQMy8ZK97Iiyw3n
	pvfT1vEECn0g4D45qZYeY+yPJAfdWDzNLE7ct6Vh/OHs1W8tpK0apKAKKYnyGydMUWXnUcJ6VTT
	qI2TyGqqyrUlfYoX1NeGWizeAIow=
X-Google-Smtp-Source: AGHT+IHpQ4UcdYWWQvwutnO/x4ylvYw9WAGoijyH6c4rFNLWG6Z4GhsuvUBQKfFkoHHHtIzbDOLpZDT3UFylKmrdxk8=
X-Received: by 2002:a5d:624b:0:b0:337:c595:88f5 with SMTP id
 m11-20020a5d624b000000b00337c59588f5mr1015090wrv.16.1706193065455; Thu, 25
 Jan 2024 06:31:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO1O6sdTVEH-qHxWEPX3E2ia1yQ_HNTfZFEQck4144hO0iX5AA@mail.gmail.com>
 <CABBYNZJucRWbun3hJAcjA0EZOFVWn1vPZXvfgb-4SsC8r_pO8Q@mail.gmail.com>
In-Reply-To: <CABBYNZJucRWbun3hJAcjA0EZOFVWn1vPZXvfgb-4SsC8r_pO8Q@mail.gmail.com>
From: Emil Lenngren <emil.lenngren@gmail.com>
Date: Thu, 25 Jan 2024 15:30:53 +0100
Message-ID: <CAO1O6sdyiVZrVhhD+pAnjbtdYoGyTqTjaVnO0qBJLjxk21NxDQ@mail.gmail.com>
Subject: Re: Wrong order of ACL Data and HCI Event packets for HCI over USB
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz and thanks for the quick answer!

In the meantime I modified the remote device's code to add a short
delay after connection establishment that also seems to work around
the issue.

Do you have any idea if this design flaw will be fixed in the
specification? Seems like a pretty bad one to me...

/Emil

Den tors 25 jan. 2024 kl 15:25 skrev Luiz Augusto von Dentz
<luiz.dentz@gmail.com>:
>
> Hi Emil,
>
> On Thu, Jan 25, 2024 at 8:51=E2=80=AFAM Emil Lenngren <emil.lenngren@gmai=
l.com> wrote:
> >
> > Hi. I have a quite annoying issue on my Ubuntu 22.04 computer with an
> > Intel Bluetooth controller (8087:0033, Intel Wi-Fi 6E (6GHz) AX211 2x2
> > Bluetooth 5.2 Wireless Card).
> > Very often BLE connections to a particular device behaves incorrectly
> > (ATT timeout by remote device) because the initial ATT Exchange MTU
> > Request arrives to the host (BlueZ) just before the LE Enhanced
> > Connection Complete event arrives, and is therefore dropped. I guess
> > this is due to separate endpoints and therefore separate flows are
> > used in the HCI USB protocol, but have no idea how/if this can be
> > fixed?
> >
> > See btmon log:
> >
> > < HCI Command: LE Set Extended Advertising En.. (0x08|0x0039) plen 6
> > #11 [hci0] 8.102056
> >        Extended advertising: Enabled (0x01)
> >        Number of sets: 1 (0x01)
> >        Entry 0
> >          Handle: 0x01
> >          Duration: 0 ms (0x00)
> >          Max ext adv events: 0
> > > HCI Event: Command Complete (0x0e) plen 4                           #=
12 [hci0] 8.104041
> >      LE Set Extended Advertising Enable (0x08|0x0039) ncmd 2
> >        Status: Success (0x00)
> > @ MGMT Event: Command Complete (0x0001) plen 4
> > {0x0001} [hci0] 8.104053
> >      Add Extended Advertising Data (0x0055) plen 1
> >        Status: Success (0x00)
> >        Instance: 1
> > > ACL Data RX: Handle 3585 flags 0x02 dlen 7                         #1=
3 [hci0] 21.049023
> >      ATT: Exchange MTU Request (0x02) len 2
> >        Client RX MTU: 247
> > > HCI Event: LE Meta Event (0x3e) plen 31                            #1=
4 [hci0] 21.049304
> >      LE Enhanced Connection Complete (0x0a)
> >        Status: Success (0x00)
> >        Handle: 3585
> >        Role: Peripheral (0x01)
> >        Peer address type: Public (0x00)
> >        Peer address: (removed)
> >        Local resolvable private address: 00:00:00:00:00:00 (Non-Resolva=
ble)
> >        Peer resolvable private address: 00:00:00:00:00:00 (Non-Resolvab=
le)
> >        Connection interval: 25.00 msec (0x0014)
> >        Connection latency: 0 (0x0000)
> >        Supervision timeout: 700 msec (0x0046)
> >        Central clock accuracy: 0x00
> > @ MGMT Event: Device Connected (0x000b) plen 13
> > {0x0001} [hci0] 21.049366
> >        LE Address: (removed)
> >        Flags: 0x00000000
> >        Data length: 0
> > < HCI Command: LE Read Remote Used Features (0x08|0x0016) plen 2
> > #15 [hci0] 21.049405
> >        Handle: 3585
> > > HCI Event: LE Meta Event (0x3e) plen 4                             #1=
6 [hci0] 21.050229
> >      LE Channel Selection Algorithm (0x14)
> >        Handle: 3585
> >        Algorithm: #2 (0x01)
> > > HCI Event: LE Meta Event (0x3e) plen 6                             #1=
7 [hci0] 21.051290
> >      LE Advertising Set Terminated (0x12)
> >        Status: Success (0x00)
> >        Handle: 1
> >        Connection handle: 3585
> >        Number of completed extended advertising events: 0
> > > HCI Event: LE Meta Event (0x3e) plen 11                            #1=
8 [hci0] 21.052293
> >      LE Data Length Change (0x07)
> >        Handle: 3585
> >        Max TX octets: 251
> >        Max TX time: 2120
> >        Max RX octets: 251
> >        Max RX time: 2120
> > > HCI Event: Command Status (0x0f) plen 4                            #1=
9 [hci0] 21.053228
> >      LE Read Remote Used Features (0x08|0x0016) ncmd 1
> >        Status: Success (0x00)
>
> This is a design flaw in the Bluetooth Core Specification, it defines
> different USB endpoints for data and events but since they don't come
> with any timestamp from the controller the host has no idea about
> their order. That said we do provide a workaround that can be enabled
> with the use of the following config option:
>
> config BT_HCIBTUSB_POLL_SYNC
>     bool "Enable USB poll_sync for Bluetooth USB devices by default"
>     depends on BT_HCIBTUSB
>     default y
>     help
>       poll_sync synchronizes the USB data and event endpoints by
>       prioritizing the later.
>
>       Say Y here to enable USB poll_sync for Bluetooth USB devices by
>       default.
>
> --
> Luiz Augusto von Dentz
