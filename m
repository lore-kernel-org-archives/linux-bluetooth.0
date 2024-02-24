Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861141E49D
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Feb 2024 15:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708789919; cv=none; b=oBgpGAMV0r9rfTWfnUVMJgIM7tUuuu1QioqjtYs6TtFaiubjzJSzzwCieRGR0G2BDVB9idfqQ383f75ei6n30h9Ufc2U5niXvD5IGNuiyBLjvLhqSLUej2mOD1kL9KKNqMZgZRn2XAwA2naXeOn+Vsz3v5fv9UBBd61qEkiSvQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708789919; c=relaxed/simple;
	bh=M3cCfC0/+Cj86bM690KxxavdtU2kstF4d/fvh9I4Ev8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RdO3XQX/JLNw47NjrObePM6QRFuAgjE6gyl427M0y/MjvW0iJipru3uyO7uXIbP1Xg1S3me54qS9X/KCsFXp7tfB9448a7E495As7DQpZVvXoMN5UPve+6SjaFLFJthE3hDpgHUt2v9zJOg2pzGv/19VjhsfM8JQ6e23tfvWF5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozOnV8Qg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozOnV8Qg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0EDD6C43390
	for <linux-bluetooth@vger.kernel.org>; Sat, 24 Feb 2024 15:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708789919;
	bh=M3cCfC0/+Cj86bM690KxxavdtU2kstF4d/fvh9I4Ev8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=ozOnV8QgY1N7KGMf2uzEt5DX9vx9SweTM7gRUqA4KvrqTi/9ZtqONELXiNqiNMSmr
	 BujREyceJm6HMfvaNvXQAJlIXNW/BBVruuf3X1hi4CbqNLtCRpPOPfY3bDWMSFVVn9
	 U6TN3oSJlRceKdjsuA4/NQ02tCNMG82DeQcirnkTqzwPrr5BAu62e7HpTnOsrUEd4W
	 YODRmDTRRnDiKfOnNB+5a4nBlbxO9LUPYyH8Pb0gKjrAX64f/nBW2UnCQUeJRG0Owx
	 WdU0t6jx0/Id63zvnsK9dyP1EDEqE6S96sslYeGITBKcB0L3pBeJuGhFXwnMTnMPrS
	 On5TGxPgtMHzA==
Received: by aws-us-west-2-korg-bugzilla-1.web.codeaurora.org (Postfix, from userid 48)
	id E0E5CC4332E; Sat, 24 Feb 2024 15:51:58 +0000 (UTC)
From: bugzilla-daemon@kernel.org
To: linux-bluetooth@vger.kernel.org
Subject: [Bug 218472] mt7921e bluetooth not working
Date: Sat, 24 Feb 2024 15:51:58 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: Drivers
X-Bugzilla-Component: Bluetooth
X-Bugzilla-Version: 2.5
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bugzilla@mail.cam-it.nl
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P3
X-Bugzilla-Assigned-To: linux-bluetooth@vger.kernel.org
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-218472-62941-Rag6B9u3L8@https.bugzilla.kernel.org/>
In-Reply-To: <bug-218472-62941@https.bugzilla.kernel.org/>
References: <bug-218472-62941@https.bugzilla.kernel.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.kernel.org/
Auto-Submitted: auto-generated
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

https://bugzilla.kernel.org/show_bug.cgi?id=3D218472

--- Comment #7 from Chris (bugzilla@mail.cam-it.nl) ---
(In reply to jeremy from comment #6)
> You should post results from terminal for
> sudo cat /sys/kernel/debug/usb/devices| awk '/3585/' RS=3D
>=20
> The bluetooth devs usually want that info.  I am guessing that you will n=
eed
> a kernel patch similar to
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.=
git/
> commit/drivers/bluetooth/btusb.c?id=3Df0ad26ee822b197f2421462df9c358a5687=
fddfd
> but it would be at about line 610 of btusb.c and be
>=20
>       { USB_DEVICE(0x13d3, 0x3585), .driver_info =3D BTUSB_MEDIATEK |
>                                                    BTUSB_WIDEBAND_SPEECH |
>                                                    BTUSB_VALID_LE_STATES =
},

Thanks Jeremy. I compiled btusb.c with that change and it works.
For completeness, here's the requested output of=20
sudo cat /sys/kernel/debug/usb/devices| awk '/3585/' RS=3D

T:  Bus=3D03 Lev=3D01 Prnt=3D01 Port=3D06 Cnt=3D04 Dev#=3D  5 Spd=3D480  Mx=
Ch=3D 0
D:  Ver=3D 2.10 Cls=3Def(misc ) Sub=3D02 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
P:  Vendor=3D13d3 ProdID=3D3585 Rev=3D 1.00
S:  Manufacturer=3DMediaTek Inc.
S:  Product=3DWireless_Device
S:  SerialNumber=3D000000000
C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3De0 MxPwr=3D100mA
A:  FirstIf#=3D 0 IfCount=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01
I:* If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D125us
E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D 512 Ivl=3D0ms
I:* If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
I:  If#=3D 1 Alt=3D 6 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3Dbtusb
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  63 Ivl=3D1ms
I:* If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3D(none)
E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D  64 Ivl=3D125us
I:  If#=3D 2 Alt=3D 1 #EPs=3D 2 Cls=3De0(wlcon) Sub=3D01 Prot=3D01 Driver=
=3D(none)
E:  Ad=3D8a(I) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us
E:  Ad=3D0a(O) Atr=3D03(Int.) MxPS=3D 512 Ivl=3D125us

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.=
