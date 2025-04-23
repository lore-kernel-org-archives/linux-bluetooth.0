Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072F427F4D9
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745418541; cv=none; b=LCHK7gxOeoyzg4MSDgj1cBSSdIX9/x70nIneZAm4Rx5gggWubpZ7RglSxiShJnQML/cblJw3JHUh1O3lf/hWkB/sp1ozaQoBxI5zZ03cj+AXQrwQzpVlpZg+7vbCD5fPUGAeQrBbeK17RvY+NVvVHL39cntugD2lAznMyjJZK4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745418541; c=relaxed/simple;
	bh=gELOe3zH5CE7VJ8k9NHhX1M+i7E4SDbp2ETviZsNX6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qJzaGRqQ5LMUCUE8wiBdutwes1ELx5lY9iydL3j/H5lPNE+LptbL4uak1CTdBzCKHGrSOCdKaLWNRCwqXv8AUMuXSJGfC9CmXDn6ACwEZxnqdCQlP7TPuqvkVATaqZ8h7+S+/K859nFi2L1RD6K0UT88DgeUtoHkJl9cfYi5Pas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FKBGABdC; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FKBGABdC"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3104ddb8051so58816421fa.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 07:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745418538; x=1746023338; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/37q08q21hIJJx64ZscOPv/YH6uvXQDzyXHHpMgGsxA=;
        b=FKBGABdCufIUoeo2Xtn/vr9eICCIg2Nt+LAAn5p1HV/oSQr+amOpdsESZ0napm0jQ4
         wtTfkKI+hF2NKw2DFDDPhZd70/IW/DDYzmPCcxBXtmk19O/w9l6a4u1sCjYEwhgMjVIL
         bGNoUvppB8e290YbdxSsoTcXMz8dVeHS2VE81b3+ccG3UsDAQT8s+0JRgfjmSQYMxpA6
         1p8nnWKBgLcTlak/w3jxHbtnYk7Xf92ivo2AxiSWGdzGuXkxTe2Hq+dzBjNoDpHnM73i
         sJmrDhseDHuR1yYkzmiuFlL3RaSJ97948SlqgTyjWTVsDrqNcgxzkSBbi5v6+BUFKd8Y
         BnmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745418538; x=1746023338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/37q08q21hIJJx64ZscOPv/YH6uvXQDzyXHHpMgGsxA=;
        b=jApjNXYgosGXkcHWz2LRoHdWWhCbzFB9Jp+GTT2PYG4XbPoy27SxHI1Je0O73pW0mk
         VxvE3APB56oH1+ovN0Vyzb5nxQDqJs4NCVcUjz85jbg9LHgs1c4xtJDpdBekv7gk6S5Q
         offDnDQ3jhydTwYWW2N2JKoqxPDEwVKXPp+PgAYz/inboDgKzirDXOR/2xRIOEThwoKS
         w0BO70YrEHkka3hI0XnVbF07PbFc+PZoxYIBZx8w3aQu03umTNzSX6VmH8try7AXRG2m
         X5OamsPVZ9fMaBfaTXwgkAk/gPqhA+7CnJdIpEPVzvUaD8y4Ld5zhFS9j1MmOQNVMT2t
         hxxg==
X-Gm-Message-State: AOJu0Yx8j7sx8ohwoPPJmjYPAa0i33d+Sqj/f0ahHik/sVVzAo9NiKpe
	pFzKZ9L4KE7L1Sz28u0vlRSefS0T2ofS8RYMfAHk3GY+mY8dUYIP2Q6t2v56w7WnPgUamKi1zPN
	TNuBa4yNUcu/oYyJ/oIgH6QwvrVNhhLt36piDHw==
X-Gm-Gg: ASbGncswpWVavGMySoNhsR11tD3E8YfwKewanX3CnXMsLKQfF+sf7Vl9W/imWH8FW9t
	yI1ABY4N/lH1PAUqYoUWoZ7U8B57gfcIVHLpiE5y6xfdk6tZ7iOxacONaX4mRXa53yYkAtNEc61
	y15rh0tIoFh8cSaVtPOXTY
X-Google-Smtp-Source: AGHT+IENIB1yeKtXTgm7X25wPOVQuWgHu3vwleTWPGGZ7XPS4jaH4OV7IisyVfYLKZ2X1TJJvW6wUX49PC969drIv7Y=
X-Received: by 2002:a2e:a914:0:b0:30b:c91d:35cb with SMTP id
 38308e7fff4ca-310904c99dfmr61675321fa.4.1745418537633; Wed, 23 Apr 2025
 07:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA_e4kpzwje7r-ufYj49uhKVO8dqE=7mC52UeFMfouEvH6VdZw@mail.gmail.com>
In-Reply-To: <CAA_e4kpzwje7r-ufYj49uhKVO8dqE=7mC52UeFMfouEvH6VdZw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 23 Apr 2025 10:28:45 -0400
X-Gm-Features: ATxdqUGkzwNG71CPLmhqbQqSVj7ip9wqcyHVyUQ539qVZu_fafofIzTOYmtsCTk
Message-ID: <CABBYNZLCnDJ9W9Gr90pN+jcXAu9XBXgkzt5A2ZLtRz0E6KR8zg@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BBUG=5D=5BLE=5D_Disconnect_after_LL=5FPERIPHERAL=5FFEATURE?=
	=?UTF-8?Q?=5FREQ_=E2=86=92_LL=5FUNKNOWN=5FRSP_=28Pi_Zero_2_W_peripheral_vs_nRF52840_?=
	=?UTF-8?Q?central=29?=
To: Faranak Karimi <faranakkarimi.iot@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Faranak,

On Wed, Apr 23, 2025 at 5:33=E2=80=AFAM Faranak Karimi
<faranakkarimi.iot@gmail.com> wrote:
>
>
> Hello BlueZ maintainers,
>
> I am seeing a systematic link-loss the moment a Nordic nRF52840 (central)
> connects to a Raspberry Pi Zero 2 W running BlueZ in *peripheral* role.
> BlueZ disconnects immediately after the peer replies =E2=80=9CUnsupported=
 Remote
> Feature / Unsupported LMP Feature (0x1a)=E2=80=9D to an
> LL_PERIPHERAL_FEATURE_REQ.  Per Core Spec v5.4, that feature exchange is
> optional, so a simple UNKNOWN_RSP should not abort the connection.

This was introduced a really long time ago:

commit 0fe29fd1cd77ffbdb8e36ec1715868d9d8011c9b
Author: Marcel Holtmann <marcel@holtmann.org>
Date:   Wed Apr 8 09:05:27 2015 -0700

    Bluetooth: Read LE remote features during connection establishment

    When establishing a Bluetooth LE connection, read the remote used
    features mask to determine which features are supported. This was
    not really needed with Bluetooth 4.0, but since Bluetooth 4.1 and
    also 4.2 have introduced new optional features, this becomes more
    important.

    This works the same as with BR/EDR where the connection enters the
    BT_CONFIG stage and hci_connect_cfm call is delayed until the remote
    features have been retrieved. Only after successfully receiving the
    remote features, the connection enters the BT_CONNECTED state.

    Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
    Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>

We don't seem to be doing anything with conn->features so perhaps
!status can be just ignored, that said it sort of weird coming from
nordic, or perhaps it only responds like that when connection as
central?

> Environment
> -----------
> =E2=80=A2 HW=E2=80=83 Raspberry Pi Zero 2 W (CYW43438 controller, BT 4.2)
> =E2=80=A2 Kernel=E2=80=83=E2=9F=A86.12.20+rpt-rpi-v8=E2=9F=A9
> =E2=80=A2 BlueZ=E2=80=835.66
> =E2=80=A2 bluetoothd started as: `bluetoothd -d -n`
> =E2=80=A2 Peer=E2=80=83Nordic nRF52840-DK, Zephyr 3.6.0, SoftDevice Contr=
oller v1.6.0
> =E2=80=A2 Pi role=E2=80=83Peripheral; simple GATT server advertising via
>   `bluez-peripheral 0.1.7` Python script
> =E2=80=A2 BR/EDR disabled (`controller-mode =3D le` in main.conf)
>
> Steps to reproduce
> ------------------
> 1. On the Pi
>    bluetoothd -d -n &
>    python3 advert.py       # advertises, no security required
>
> 2. On the nRF52840 central firmware: scan for =E2=80=9CExample-Peripheral=
=E2=80=9D and connect.
>
> 3. Capture on the Pi with btmon (excerpt below).
>
> > HCI Event: LE Connection Complete (0x3e) plen 19          # handle 0x00=
40
> < HCI Command: LE Read Remote Used Features (0x08|0x0016)
> > LE Meta Event: Read Remote Used Features (0x04)
>     Status: Unsupported Remote Feature (0x1a)
> < HCI Command: Disconnect (0x01|0x0006)
>     Reason: Remote User Terminated Connection (0x13)
>
> An over-the-air sniffer trace shows the same thing at Link Layer level: P=
i (peripheral) sends LL_PERIPHERAL_FEATURE_REQ, the nRF52840 responds LL_UN=
KNOWN_RSP, and the Pi immediately terminates the link (PDU log attached).
>
> Expected result
>
> The connection should stay up; BlueZ should tolerate LL_UNKNOWN_RSP for P=
ERIPHERAL_FEATURE_REQ and continue without feature-exchange.
>
> Actual result
>
> BlueZ disconnects with reason 0x13 as soon as the UNKNOWN_RSP appears.
>
> Things I=E2=80=99ve tried
>
> Connecting the same Pi peripheral to an Android 14 phone works fine (phon=
e supports the PFR procedure).
>
> Connecting the nRF52840 central to another nRF52840 peripheral also works=
, so the central side is capable of normal operation.
>
> Questions
>
> Is the immediate disconnect on 0x1a intentional?
>
> If it is unintended, would a patch that ignores UNKNOWN_RSP for LL_PERIPH=
ERAL_FEATURE_REQ be welcome? (Happy to test/submit.)
>
> If it is intended, can I disable the LL_PERIPHERAL_FEATURE_REQ from being=
 sent in the first place?
>
> Attachments
>
> btmon_nrf52840_fail.log =E2=80=93 full bluetoothd -d+btmon output
>
> Ras_dongle_Unsuccessful_connection.pcapng =E2=80=93 sniffer trace
> (same files referenced in the Nordic DevZone thread=C2=B9)
>
> Many thanks for any guidance!
>
> Best regards, Faranak Karimi, IDmelon Technologies, Faranakkarimi.iot@gma=
il.com
>
> =E2=80=93=E2=80=93=E2=80=93 =C2=B9 https://devzone.nordicsemi.com/f/nordi=
c-q-a/120846/bluetooth-le-unsupported-remote-feature-0x1a-error-when-connec=
ting-nrf52840-central-to-raspberry-pi-zero-2w-peripheral Emil Lenngren sugg=
ested asking here because =E2=80=9Cthe connection can of course be kept ali=
ve despite this problem=E2=80=9D and the PFR procedure is optional .
>
>


--=20
Luiz Augusto von Dentz
