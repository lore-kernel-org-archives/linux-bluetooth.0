Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAF81428FA
	for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jul 2024 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720898543; cv=none; b=DfPH3qd+CPwzjt0WakwP4C4OPn1V465qcA8cUQEIMe/uwnCeff9uSoFFtED2a8c/q3yr7dVqlVEn+YhgClOLS8F7/ojRm+efZH3mUKTdykeHRR6Z7ogPZ/aHfeXRavIfg3kAlmGDwzFmYCBvkJxX0K8jzWLQBkRHY6c4JRqzDzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720898543; c=relaxed/simple;
	bh=iNe8J4/K5YOr8YfRh/Rl62+qGldMD5PBBX4Plt1AfpU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Q030FyThb2kS5/Xk/PHopZfQK7k/mHCazOI5eFqC70Rqg78S0KX69HIiN+CX7OGkK2aY/NU6jjnKplRZg3jVFrvCpZZMf9hdWRrCH4PP++VilKaOF4d+Ivv9Z8qIl+0AyT0t2yZO5U25rmyJGhmPGk/C1jWqlfpdifFmiDs2Les=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSM9Ep68; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSM9Ep68"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52ea79e689eso4291662e87.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Jul 2024 12:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720898540; x=1721503340; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVIbQb4ZBpaQekof7/208YYrsZFr5otf9BXJcHrf4Bc=;
        b=HSM9Ep68B3refp7sfAMD7vkoQ0brnJY+erHN+LsDF0b4v76gAgenWlmlze3oewHCuD
         WFVdsknV86BHjEss5dpVAQ7Q3kEipOoP1040P59RNoI5JOnIZkRVY48j60j15tPTkvBA
         FyRnvn0SLXO8yIPv877lzD+Jrlpxgh1kIzUynqHSGfByIAhPYWfOkB1bR9+m0rkqX9bk
         WsMc1ZjE35AqxDOYe8EGAkJhpjsZ4S/W5iBtISrAp7Ul4mRU9g1TTKDEEQirrpqMUwlt
         1oSr8Gvo9MZGHHAWZfQofKVgPjTeLr/6bKWHknUVWE0PRxGADRhMJPP+4XqufwcJVbSp
         0oXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720898540; x=1721503340;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVIbQb4ZBpaQekof7/208YYrsZFr5otf9BXJcHrf4Bc=;
        b=MmI7qj5l9PmfWlm9QWt+G1gdLf38LI/BbWEfr+B9NdeWEL9bL1qXV4AHVq3K7tRk9Y
         KAu0T3aJ1WylEv12XyLNEeZE4LAaftFiOn43+S9n34rrnzKlSw7EmYZPV4ozXsllxyhL
         c9Q67cF0a6DezM3FGPbiYhMJ+V16aYFZCAOViFHk9y9XO/BzWpsuTCHnpHdu8edmrhnB
         jj9NEhy/kIT0GV50HgVRHPlQrKBBTYVWChbXf9w2e4zCNeesOv161P6hAHSFob05mnwo
         anLV+fpol9k2T0/6KaVvHsXl7Prl9zHCfTxLGfiJ2SzAYVdAoTjxpeYa1FTgLc7ZxMDi
         lPWQ==
X-Gm-Message-State: AOJu0YwB9CXYa5rEiuJ4AalP93pp6F1pRMKhQjX6pbgaxLgK7LRksBby
	6Wfm7a201k3bO9HqjM9qG4jepC5w7EaWX146m0eWsRrCn8WftpnBijGLBq9HmmR8fTfPOa3MR78
	oBreJQFRFy+ynNuSqOmQtx7BXVKGS3th+
X-Google-Smtp-Source: AGHT+IFc+c7EJz0sMKHAzmUCbEzfdcGbZg4WzwlqEJeiHNoAPvTtcfYFgPZma2vHzahb8ceaBaix1pnhx1FYiL4/B4E=
X-Received: by 2002:a05:6512:3b08:b0:52c:df83:a740 with SMTP id
 2adb3069b0e04-52eb99a3404mr13311030e87.30.1720898539513; Sat, 13 Jul 2024
 12:22:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGKjw9+40dSve_4u5RgUQUVXykESDsQ5kktOFN-EV-6o5NnUKQ@mail.gmail.com>
In-Reply-To: <CAGKjw9+40dSve_4u5RgUQUVXykESDsQ5kktOFN-EV-6o5NnUKQ@mail.gmail.com>
From: Patrice Duroux <patrice.duroux@gmail.com>
Date: Sat, 13 Jul 2024 21:22:08 +0200
Message-ID: <CAGKjw9L3F75NKzqgb=0S05tCUe_+23DA3u-=X_i7nCaLoOJ=KA@mail.gmail.com>
Subject: Re: no longer able to connect to a Plantronics headset
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Problem solved. This was due to my headset device.
Most desktop user interfaces glossing over this doesn't help detect
and so to solve the (stupid) problem.

Le dim. 7 juil. 2024 =C3=A0 18:50, Patrice Duroux
<patrice.duroux@gmail.com> a =C3=A9crit :
>
> Hi,
>
> In the past (same laptop and headset) it has worked but it is no more
> working after upgrading my current system (more details to follow).
> The device scanning is able to list a lot of devices in my environment
> but not the desired one and finally I used btmon to get more output.
>
> Any help would be appreciated.
>
> Regards,
> Patrice
>
> --
> $ uname -a
> Linux kos-moceratops 6.9.7-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.9.7-1
> (2024-06-27) x86_64 GNU/Linux
>
> $ sudo dmesg | grep -i blue
> [   11.381833] Bluetooth: Core ver 2.22
> [   11.381853] NET: Registered PF_BLUETOOTH protocol family
> [   11.381854] Bluetooth: HCI device and connection manager initialized
> [   11.381857] Bluetooth: HCI socket layer initialized
> [   11.381859] Bluetooth: L2CAP socket layer initialized
> [   11.381863] Bluetooth: SCO socket layer initialized
> [   12.124487] Bluetooth: hci0: Bootloader revision 0.3 build 0 week 24 2=
017
> [   12.125484] Bluetooth: hci0: Device revision is 1
> [   12.125486] Bluetooth: hci0: Secure boot is enabled
> [   12.125487] Bluetooth: hci0: OTP lock is enabled
> [   12.125488] Bluetooth: hci0: API lock is enabled
> [   12.125489] Bluetooth: hci0: Debug lock is disabled
> [   12.125489] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> [   12.128514] Bluetooth: hci0: Found device firmware: intel/ibt-20-1-3.s=
fi
> [   12.128580] Bluetooth: hci0: Boot Address: 0x24800
> [   12.128581] Bluetooth: hci0: Firmware Version: 132-3.24
> [   12.194702] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [   12.194705] Bluetooth: BNEP filters: protocol multicast
> [   12.194707] Bluetooth: BNEP socket layer initialized
> [   12.311050] Bluetooth: hci0: Failed to send firmware data (-19)
> [   12.311087] Bluetooth: hci0: sending frame failed (-19)
> [   12.311093] Bluetooth: hci0: FW download error recovery failed (-108)
> [   12.311139] Bluetooth: hci0: sending frame failed (-19)
> [   12.311154] Bluetooth: hci0: Reading supported features failed (-19)
> [   12.311157] Bluetooth: hci0: Error reading debug features
> [   12.311158] Bluetooth: hci0: HCI LE Coded PHY feature bit is set,
> but its usage is not supported.
> [12819.555606] Bluetooth: hci0: Bootloader revision 0.3 build 0 week 24 2=
017
> [12819.556628] Bluetooth: hci0: Device revision is 1
> [12819.556638] Bluetooth: hci0: Secure boot is enabled
> [12819.556641] Bluetooth: hci0: OTP lock is enabled
> [12819.556644] Bluetooth: hci0: API lock is enabled
> [12819.556646] Bluetooth: hci0: Debug lock is disabled
> [12819.556649] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> [12819.564727] Bluetooth: hci0: Found device firmware: intel/ibt-20-1-3.s=
fi
> [12819.564776] Bluetooth: hci0: Boot Address: 0x24800
> [12819.564777] Bluetooth: hci0: Firmware Version: 132-3.24
> [12821.811205] Bluetooth: hci0: Waiting for firmware download to complete
> [12821.811547] Bluetooth: hci0: Firmware loaded in 2194161 usecs
> [12821.811732] Bluetooth: hci0: Waiting for device to boot
> [12821.826744] Bluetooth: hci0: Device booted in 14765 usecs
> [12821.827778] Bluetooth: hci0: Found Intel DDC parameters: intel/ibt-20-=
1-3.ddc
> [12821.829646] Bluetooth: hci0: Applying Intel DDC parameters completed
> [12821.830657] Bluetooth: hci0: Firmware revision 0.3 build 132 week 3 20=
24
> [12821.832658] Bluetooth: hci0: HCI LE Coded PHY feature bit is set,
> but its usage is not supported.
> [12821.897877] Bluetooth: MGMT ver 1.22
> [12821.927208] Bluetooth: RFCOMM TTY layer initialized
> [12821.927213] Bluetooth: RFCOMM socket layer initialized
> [12821.927215] Bluetooth: RFCOMM ver 1.11
>
> $ sudo btmon
> Bluetooth monitor ver 5.73
> btmon[166569]: =3D Note: Linux version 6.9.7-amd64 (x86_64)
>
>          0.917019
> btmon[166569]: =3D Note: Bluetooth subsystem version 2.22
>
>          0.917020
> =3D New Index: 5C:80:B6:E9:D7:DD (Primary,USB,hci0)
>
>   [hci0] 0.917021
> =3D Open Index: 5C:80:B6:E9:D7:DD
>
>   [hci0] 0.917021
> =3D Index Info: 5C:80:B6:E9:D7:DD (Intel Corp.)
>
>   [hci0] 0.917021
> bluetoothd[166074]: @ MGMT Open: bluetoothd (privileged) version 1.22
>
> {0x0001} 0.917022
> > HCI Event: Connect Request (0x04) plen 10                              =
                                                                   #1 [hci0=
] 17.029619
>         Address: E4:22:A5:BC:E9:A3 (PLANTRONICS, INC.)
>         Class: 0x240404
>           Major class: Audio/Video (headset, speaker, stereo, video, vcr)
>           Minor class: Wearable Headset Device
>           Rendering (Printing, Speaker)
>           Audio (Speaker, Microphone, Headset)
>         Link type: ACL (0x01)
> < HCI Command: Reject Connection Request (0x01|0x000a) plen 7
>                                                                     #2
> [hci0] 17.029727
>         Address: E4:22:A5:BC:E9:A3 (PLANTRONICS, INC.)
>         Reason: Connection Rejected due to Unacceptable BD_ADDR (0x0f)
> > HCI Event: Command Status (0x0f) plen 4                                =
                                                                   #3 [hci0=
] 17.030438
>       Reject Connection Request (0x01|0x000a) ncmd 1
>         Status: Success (0x00)
> > HCI Event: Connect Complete (0x03) plen 11                             =
                                                                   #4 [hci0=
] 17.112704
>         Status: Connection Rejected due to Unacceptable BD_ADDR (0x0f)
>         Handle: 65535
>         Address: E4:22:A5:BC:E9:A3 (PLANTRONICS, INC.)
>         Link type: ACL (0x01)
>         Encryption: Disabled (0x00)
>
> <... cut repeating the same ...>
