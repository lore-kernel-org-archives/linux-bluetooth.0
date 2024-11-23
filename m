Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3BB4A0A
	for <linux-bluetooth@vger.kernel.org>; Sat, 23 Nov 2024 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732377775; cv=none; b=fZe6yEHPMAVkAqWVgvznwt/zwpsGIjyrryCTCkiPyIHTxuugynFSETLzn9taAIxLrqyfw7HVE1Jt3eKWk88MlMUroF+sLSQ750c0nsAEUB7KvzVDZqrSFVcDoSGvzlTZSTSXxte7EWx8COGTCM2GJOR2GrXoxts/4bdr6FCxvnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732377775; c=relaxed/simple;
	bh=fodFt+De76eV+nY+zYmhvQ8isUCW3AifA6RI74tCSCs=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=FjJubknp/lsYJVm/aCG1JUrRtDnKj1NPBH0Zxw185wpyD69A/5K4OVLgQ7PT3zhtrojJojvpInZay+iQLFQKBhV94l11cUTQ+CHIjnpboFOmEJwTBIJ5FOIZEJYEBPt21f7du/xLs50T4PcIjDEVUiPkpPppTxJwLwwiHd9PeLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=f0+jOHnr; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="f0+jOHnr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732377771; x=1732636971;
	bh=fodFt+De76eV+nY+zYmhvQ8isUCW3AifA6RI74tCSCs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=f0+jOHnrVEHbg8noqaNtoEcBm5WHaVkm9lelpBOaIwEJ+trxMBu689WsZz0l8ql2i
	 8SRIhkEf0RWwmdz0dnwrmcFLuUkMuEHwLMfPPZuyD7kamg6Cvaz586jsW8WSe/1K1e
	 sHi0+B512fZ/DEOX3Gsju5oLazfnqNL4f36mV9yUdgD4MdvvD1h6n8XL8CDYIid8YM
	 yczoo4JDJNyVSEYgKV7oFYv8XAFTCfV/blu+qbJhHhXnd1YDDuSIAn15V0cSU2JUoN
	 XkDizJoeu0dev/LKz0Cjb9eTCDpHyQEnRtQaxNuPsn3n4Y0uIvs922VJco9/Z4PZUM
	 SZnaMMsNBx3dw==
Date: Sat, 23 Nov 2024 16:02:47 +0000
To: pmenzel@molgen.mpg.de
From: Alan Jones <j.alan.jones@pm.me>
Cc: j.alan.jones@pm.me, linux-bluetooth@vger.kernel.org
Subject: Answers and Details
Message-ID: <009c6435-bd28-420e-ba34-7df025c6cfd7@pm.me>
Feedback-ID: 106914784:user:proton
X-Pm-Message-ID: 59900e4e87fd713b8b582c53215c1f99f9559bb5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Here's what happens when the module is plugged in and I press a button=20
on a previously paired remote.

 =C2=A0=C2=A0=C2=A0 [483044.866453] usb 3-4: new full-speed USB device numb=
er 47 using=20
xhci_hcd
 =C2=A0=C2=A0=C2=A0 [483045.477740] usb 3-4: New USB device found, idVendor=
=3D057e,=20
idProduct=3D0305, bcdDevice=3D 1.00
 =C2=A0=C2=A0=C2=A0 [483045.477749] usb 3-4: New USB device strings: Mfr=3D=
1, Product=3D2,=20
SerialNumber=3D0
 =C2=A0=C2=A0=C2=A0 [483045.477754] usb 3-4: Product: BCM2045A
 =C2=A0=C2=A0=C2=A0 [483045.477757] usb 3-4: Manufacturer: Broadcom Corp
 =C2=A0=C2=A0=C2=A0 [483047.572500] Bluetooth: hci0: Opcode 0x0c14 failed: =
-110

Beyond this is gets weird. The version of weird depends on the next steps.
The Nintendo stack is almost, but not quite, entirely unlike Bluetooth.


The unique vendor and product IDs are a result of the firmware payload.
In the manufacturing manual for the component there's a note regarding=20
this (after firmware install):
 =C2=A0=C2=A0=C2=A0 "USD Vender ID and product ID of nintendo module is not=
 same as it=20
of Pre-write module."

Link:
https://fccid.io/MCLJ27H002/User-Manual/Users-Manual-721663.pdf


So in theory: yes, this would apply to all BCM2045 devices re-flashed=20
with Nintendo's firmware.
I don't know how feasible this actually is: to my knowledge it isn't=20
widely done.
In practice, hobbyists extract the Foxconn WML-C43 or Foxconn/Panasonic=20
J27H002 module from a Wii console and add the wiring to interface to a PC.

Example using a daughtercard adapter here:
https://www.abbiedoobie.com/product/bluetooth-passthrough-adapter/


Ack on requested changes; I'll send a follow-up

Alan

