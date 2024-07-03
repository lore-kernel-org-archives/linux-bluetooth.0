Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E56018307B
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 14:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015908; cv=none; b=akolSheSI28dMnH89eR3yo8qEuXdMKrn5e6Ssy+fRZ2BjvlKt1VPxEaPU/gUGtM/nelHMNdZVIz22sDCTsQcFBJCg0kskhb4WoTfhpomPIYYmm52fQC2TPtisK2cU9Gq+APDybuVq9RyRnBLANP9fPc+kvc5siYL99xCu4CXS4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015908; c=relaxed/simple;
	bh=sicoO+WzXjuSfjRx3CSg/tU5bCnsp1nHT0Qke8JG0qQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ov3p/nrGOZ85Fx/TLudAED0OQu4L/tMuA1voPmS0vCNe/U4M6LzTkeCldu8k+Khum3Z0fHkbi7uKFzMsAsShkUTOupYSuMXG+RxNAQE40zFOaR9iE4pI5xGd2xUfMVBfXCVb1K6kTWFJ49qdXbYW5SFEQdBmRstyBfcfAUnspg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVFbFsoX; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVFbFsoX"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ebe6495aedso59563471fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Jul 2024 07:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720015905; x=1720620705; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mumZLVo4m8NdPbnA7x1lFUdW1u6wizTrCPU22CYenRQ=;
        b=RVFbFsoXP0kz9SkDPKrGMhDCfkI2SFMyLBAzmW3mazPSmZJ4tAZFcZ9R6ktAPFJlqk
         BVvRBBBdQIZ05z/dvtZP3WnD2P3qMu0hQIo5ELahgOI/g7FkjqpIxzhreIhjz9Utq22e
         6x97h4xwrJW93MmzM9NBrfhAeUaOecCR4efdHBzOtL5rcnxBXK57bDd0o3B08Dxb3qIJ
         uwjkmYzXr50YjHSF0+tKwv65CcpRkEXQwH3jyGADTpVKNO1UEDK/PHF9HcqO80UODRUW
         GVYyknhfhyM0PAE/uQBxx20c+pwFjsRoun4SzhH/PGpzBE1+wQuLN8IKIalafEkLexmZ
         r5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720015905; x=1720620705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mumZLVo4m8NdPbnA7x1lFUdW1u6wizTrCPU22CYenRQ=;
        b=OBiDIMhrRe3UjpkfZLmaAkcRrl1IpihvuEbn5nkt8haBprE6cWpZx9cPMDwipl+SFI
         akszYySEc2L0htAU0QnO4xAYYwPTwhJRDK2W6IZhxcxrdmyaiSEZl21VCNvbaNrCYstb
         sXeDpk7HBj0MXz1leaTBVtRAp6PATuR+DUPaoby7VEDDQdW6BbwNVgvm0N2azVJtst0B
         zG8uCXjnz1Ouvnr7ZeMe2aQZnim9nSE94S765UrCl7l2OKnk1znh0rGJXiF2v/VOJhei
         f1yr0h7QZpygoZrJ1Z8mniPQh4+kri2PfV0+m8a9Ocq0QVQ29iytV+LxsSBeyZpegvPW
         Gbwg==
X-Gm-Message-State: AOJu0YyPfq7R16xsIz4ec8DAJPAwEX0A53QLBbaEB6ofYQQvv05v2Q8r
	ndCfk+YMmtojp0rGf03COXyyBEh17T7obG2yxkVM7EDzUAbshGshSN0wkmnvHZ/aPIWBFiETHE3
	mSsHM6N3I28g6GT++BbxXoySo73aU3bz/bBI=
X-Google-Smtp-Source: AGHT+IEBFA2NU7S4riB8L8VjsHTXR01CJioiuREwEXh6ASrk01LBzArhTfGxqSZyzL0MftTCwct4I8N/TvL2Aeu5vTw=
X-Received: by 2002:a2e:bcc5:0:b0:2ee:7b7d:66ed with SMTP id
 38308e7fff4ca-2ee7b7d68cdmr28926301fa.10.1720015904892; Wed, 03 Jul 2024
 07:11:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4cb7ecc4-2bf0-4403-a995-7ca3817be4cc@gmx.li>
In-Reply-To: <4cb7ecc4-2bf0-4403-a995-7ca3817be4cc@gmx.li>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 3 Jul 2024 10:11:32 -0400
Message-ID: <CABBYNZK2xgDZ-bkxE6L-5Yt9x3PDKT_swDpN1=HAD9PC_6QpVA@mail.gmail.com>
Subject: Re: [bug report] Reproducible pairing loss after reboot / Mediatek RZ616
To: =?UTF-8?B?Sm9uYXMgw5Z6YmF5?= <usul@gmx.li>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On Wed, Jul 3, 2024 at 5:01=E2=80=AFAM Jonas =C3=96zbay <usul@gmx.li> wrote=
:
>
> Hello Bluetooth List,
>
> this is a first post here as I found no other place to report bugs. Pleas=
e forgive if I do not report according to the expected format or missed any=
 additional information and point me to the respective guidelines - thank y=
ou!
>
> =3D=3DProblem summary:=3D=3D
> Bluetooth pairing with a mouse is lost after system reboot. The pairing h=
as to be removed and a new pairing initiated for being able to use the mous=
e again.
>
> =3D=3DSystem specifications:=3D=3D
> Framework Laptop 16 (Batch 7)
> CPU: Ryzen 7 7840HS
> GPU: AMD RX 7700S
> WiFi/BT controller: Mediatek RZ616
> Linux Kernel: 6.9.7-200.fc40.x86_64
> Distro: Fedora 40
> Bluez version: 5.76-1.fc40
> Peripheral device: Cherry Gentix BT
>
> =3D=3DReproduction steps:=3D=3D
> 1) Pair the Bluetooth mouse via GUI or bluetoothctl
> 2) The mouse will now work as expected
> 3) Reboot the system
> 4) The mouse does not work, the GUI might switch between "connected/disco=
nnected"
> 5) start btmon
> 6) clicking the left mouse button produced the attached btmon log

Weird, it is doing a pairing request right away:

< ACL Data TX: Handle 512 flags 0x00 dlen 11

#11 [hci0] 2.185573
      SMP: Pairing Request (0x01) len 6
        IO capability: NoInputNoOutput (0x03)
        OOB data: Authentication data not present (0x00)
        Authentication requirement: No bonding, No MITM, SC, No
Keypresses, CT2 (0x28)
        Max encryption key size: 16
        Initiator key distribution: <none> (0x08)
        Responder key distribution: IdKey LinkKey (0x0a)

But it is doing No bonding, so perhaps that is the real problem here
since that indicates to bluetoothd not to store the keys. The No
Bonding is controlled by HCI_BONDABLE flag which is set by
MGMT_OP_SET_BONDABLE which by default is false but is automatically
set to true once a pairing agent is registered, try reproducing this
with bluetoothctl and if you are not able to this must be gnome/fedora
not registering an agent.

> Sometimes btmon also displays the following errors after MGMT Event: Devi=
ce disconnected (sorry, console cut them, could not capture to file):
> bluetoothd[2974]: =3D profiles/input/hog-lib.c:proto_mode_read_cb() Proto=
col Mode characteristic read failed: Request attribute has encountered an..=
.   14.720255
> bluetoothd[2974]: =3D profiles/input/hog-lib.c:report_reference_cb() Read=
 Report Reference descriptor failed: Request attribute has encountered an..=
.   14.720368
> bluetoothd[2974]: =3D profiles/input/hog-lib.c:report_reference_cb() Read=
 Report Reference descriptor failed: Request attribute has encountered an..=
.   14.720401
> bluetoothd[2974]: =3D profiles/input/hog-lib.c:info_read_cb() HID Informa=
tion read failed: Request attribute has encountered an unlikely error      =
    14.720616
> bluetoothd[2974]: =3D profiles/deviceinfo/deviceinfo.c:read_pnpid_cb() Er=
ror reading PNP_ID value: Request attribute has encountered an unlikely er.=
.   14.720675
>
> =3D=3DAdditional Information:=3D=3D
> The mouse also sometimes stops working suddenly. In this case it might co=
me back after a few seconds, but sometimes I have to use "systemctl restart=
 bluetooth" which re-enables the mouse. This might be a different problem t=
hough. I have no way to reproduce this well so I also could not produce a l=
og file yet.
>
> Please tell me if I can provide any additional information. Thank you for=
 your work on this piece of software! :)
>
> Cheers,
>   Jonas



--=20
Luiz Augusto von Dentz
