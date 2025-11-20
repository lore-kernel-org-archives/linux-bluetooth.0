Received: from mail-43166.protonmail.ch (mail-43166.protonmail.ch [185.70.43.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68B1C2F12B1
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763633676; cv=none; b=VevUt0dkXeVW9cuUJjLGsT3W5dhqnIUQM+eg3qIiq1G0Dho2lmZge1Z7b7nTI7YlhIrGQRraGWzu2YmFB3PJCQAdyw2LGKB1FCojjMrobWJQgnwNxuID9stIdA8OYjVg4fd18VB0l3wh5HD1Me+AcNIYtFZfZAwmjB0yy989dhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763633676; c=relaxed/simple;
	bh=gp3bx3RXSvhm95WSv4/eCTqBpAOq/sdHyDOIcOCHK6w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XRQeRZ2xPCSFkqTCLFH0nuIQ0hnNLo8DOPmp70jocC/Wk3gXWApbIJD8nHqbztJdblmjZSXHtP2+rfEB29KguvWFgwoyqQKgNMnuZ3YIXRlg1Q90QUAkLOGtfMklA1RsaPIq/2KtnzpMAFRW6cYdyOw0ESeO6fEY8ucOZw06Svs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=GKEUfQWQ; arc=none smtp.client-ip=185.70.43.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="GKEUfQWQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1763633671; x=1763892871;
	bh=UMkBZFGSoChmNfuIPM3LT9SnOvM3CGZwkxtEENvp1DE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=GKEUfQWQFgAZ3qtMstgerw+O+5t3x6Wtk1YQvSfjYq29oBA3tLCaaH3jWAC0g4mg0
	 LT9hvGsBAUxLv4Hv0VAXyiFh15wrwHJeOLvv+R7Gzhqbj/QoXnxYFew62uCOamXWpA
	 Mdnz8r44C6NF1oiGPZzuWA7unDJNHzlpkCfk7wmpc1zIRcrJ0D/asGkUpdBgDhMSPm
	 WtHUsdA/77fhGM/660KuRcwLrHW2fSg9MYZY5YP80EX7rRGiSYJNbht9SvDVUS9RIU
	 mTEYihZHAZuSfQFUJGubR+trogsCfnq4n/Z1Rwi8C15jXVNOCmjMktuiLoN4Yn2uTB
	 vwZ+/wXAQxfzw==
Date: Thu, 20 Nov 2025 10:14:25 +0000
To: Doug Anderson <dianders@chromium.org>
From: incogcyberpunk@proton.me
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, "regressions@lists.linux.dev" <regressions@lists.linux.dev>, "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>, "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>, "sean.wang@mediatek.com" <sean.wang@mediatek.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION] Bluetooth adapter provided by `btusb` not recognized since v6.13.2
Message-ID: <YrzH4CVQLf1BjCQDuWEnQ5oxWGrsTge_CHmEViJEDklOFwbMEylpl2KnmeiG1EgCm62OKNFG1JRu_b2bOVUbZZOZQwcSNHbUO1gR1GiN1rI=@proton.me>
In-Reply-To: <CAD=FV=WRYYYB+G4-7y7uVR8QCEEMp2iRfmtsAa29UfyNCVD=4Q@mail.gmail.com>
References: <jOB6zqCC3xjlPPJXwPYPb4MxHJOhxVgp380ayP7lYq-aT2iA5D8YCdMeCvq5Cp_ICZmqjpfgX8o9siQdlPu9DY4qgnL_zCjgqP23fXc-P4U=@proton.me> <a380d061-479e-4713-bddd-1d6571ca7e86@leemhuis.info> <CAD=FV=Xt58+WGK_j_TvTxpUfXrm-=Cec1-oodkuf5xiDGrsKuA@mail.gmail.com> <T4YKnjuw-ZdA4uQjGVxQh-vqahAK_69kn20zfC_8R45iOxbdjo_tlIDwP5rTUyjn3NVUHYhG09VO2ryFtfLtgptBBhfXggFNAD2CVAwPcjU=@proton.me> <CAD=FV=WDx-WcosBWf2yd3sLx5pEyjOgbs_Y5RBF=+b=0q3dBww@mail.gmail.com> <5rFwJreAVujrYXDGZZxW32PHa6HZ29PEP4R5-dqS9dbU3FI__qe3zIUx31TIHO_LjuURCSwaGucSFBPeXAjf00XzAxTzXbmf1AaY6neyQ3Q=@proton.me> <CAD=FV=UCnt3nUktRyzUDp1agDFp3ZJo=t+xBbLCD6W7Jd0aF7Q@mail.gmail.com> <5vLxmZlxKXfznaWPi2ndxyj90dJN1FML_fINz027uaJP2rZK_nQu_41m7WA7Gnc1yy_XLw8KMWF18Y_keW-qKjHy0BBOQl0A92QiY7Kg004=@proton.me> <CAD=FV=WRYYYB+G4-7y7uVR8QCEEMp2iRfmtsAa29UfyNCVD=4Q@mail.gmail.com>
Feedback-ID: 139104781:user:proton
X-Pm-Message-ID: d238dfd89352f8fec50563173eb2b2e95bef4acc
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On Thursday, November 20th, 2025 at 12:16 PM <dianders@chromium.org> wrote:=
=20
> In 6.13.1, the following could happen:
>=20
> 1. We'd be running btusb_mtk_setup()
>=20
> 2. In btusb_mtk_setup(), we'd run:
>   btmtk_data->isopkt_intf =3D usb_ifnum_to_if(data->udev, MTK_ISO_IFNUM)
>=20
> 3. If usb_ifnum_to_if() returned NULL, "btmtk_data->isopkt_intf" would be=
 NULL.
>=20
> 4. Next, btusb_mtk_setup() would call btusb_mtk_claim_iso_intf().
>=20
> 5. btusb_mtk_claim_iso_intf() would pass "btmtk_data->isopkt_intf"
> (NULL) to usb_driver_claim_interface() as "iface".
>=20
> 6. usb_driver_claim_interface() would see that its parameter "iface"
> is NULL and would return an error.
>=20
> 7. btusb_mtk_claim_iso_intf() would notice the error, print "Failed to
> claim iso interface: %d", and return.
>=20
>=20
> In 6.13.2 after commit e9087e828827 ("Bluetooth: btusb: mediatek: Add
> locks for usb_driver_claim_interface()"), we'd add in this step after
> step 4:
>=20
> 4.5 btusb_mtk_claim_iso_intf() would call:
>   device_lock(&btmtk_data->isopkt_intf->dev);
>=20
> If "btmtk_data->isopkt_intf" is NULL, this is the same as
> "&(NULL->dev)", so we'd pass a number that's very close to NULL in as
> the dev pointer. Then device_lock() would try to dereference that and
> crash.


Sorry for the lack of knowledge on my part, but could you provide insights =
as how the bluetooth was functioning wihout errors in 6.13.1 :

1. Is it because there was no device_lock() checks in 6.13.1 and is because=
 of the newly added `device_lock()` added on 6.13.2 ?=20
2. Is it because there was `device_lock()` in 6.13.1 that despite being pro=
vided a NULL pointer,`device_lock()` could dereference and the bluetooth ad=
apter would turn on BUT in 6.13.2 , `device_lock()` would be provided a num=
ber close to NULL which could not be dereferenced and hence the bluetooth a=
dapter wouldn't turn on ?

Hope it's not much trouble for you.

Regards,
IncogCyberpunk
