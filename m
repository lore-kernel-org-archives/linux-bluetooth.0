Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553242FB0A3;
	Tue,  7 Apr 2026 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775554231; cv=none; b=Zz4ylcOtYyGdmzyITN4JBwyilZ19xZ3VOqTc3OlQtSMR2CVDkQQNe23M6Xzeggj91VGnDSudrhLj99KTvcfhDMbdzvUPiqA4PfTw9jPwIRQrmsjE1cITRi3uEQYCiZ+mxQMB6kVpFWiy3V4OVF663up8OKIKgywERPPuWminGD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775554231; c=relaxed/simple;
	bh=KNmYJVvuWQRSanL6eGyu95+6ELDLCJ32Q4PfWZ6Ttbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YIJszb5JnNahvG/QCHNvTELlhP6IZjvQ2l2596J/hIumoQM6E25VTpQwVkZvhm38UuOUOLae1LIlzDd6mlkPVi0apVVXFQAtDXvwCdAal8KWYEO5W4J4G9z7V5jNiIWNH4NopRTg6a1An7TZKyjn5x++y12tSldWEWYIBZqMtP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=GiW6jt/P; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="GiW6jt/P"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6379UGrS4800040, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1775554216; bh=P0icrpAvvbSKDJjrMzGueZRXZ3PKswx9ku8yEDwlMbI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=GiW6jt/PSNHwa5TBxSMH2X5wPsVzOcJbNj0rMtTaDZtDVCxhzbigIwRan2+gQ23Mu
	 ASquwCNKP9ufHepRlA/GJXX46DGd7uLl1ddtlLl2vHnMQ7AlIY11PnCsyOpDw1rsnb
	 F0dMJv0wpbc9IR+aYhF9esbs8YEs4S01mrxj9LYKQA69ZCPMUVPwVjwvzp3Rv92/RB
	 bCejWxP+jKpm88TEXHL7TOzimks6IIQknGT+H6hfH8rb6vByItfWk/UlGYu0mzssu2
	 QH6HeSxarNu5PJi1npRmNydjgzvY/X//0srv9EWTzVZjyfm06mKxEnPUamaFqvD99X
	 0q3bFO6azbpWQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.26/5.94) with ESMTPS id 6379UGrS4800040
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 17:30:16 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 7 Apr 2026 17:30:16 +0800
Received: from RTKEXHMBS05.realtek.com.tw ([fe80::5e14:1ddb:ee82:82d6]) by
 RTKEXHMBS05.realtek.com.tw ([fe80::5e14:1ddb:ee82:82d6%4]) with mapi id
 15.02.1748.010; Tue, 7 Apr 2026 17:30:16 +0800
From: Hilda Wu <hildawu@realtek.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-firmware@kernel.org" <linux-firmware@kernel.org>,
        Josh Boyer
	<jwboyer@kernel.org>,
        "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>,
        Max Chou <max.chou@realtek.com>
Subject: RE: [REGRESSION] rtl8822cu: BLE disconnects with firmware 0x0673_0EDC
Thread-Topic: [REGRESSION] rtl8822cu: BLE disconnects with firmware
 0x0673_0EDC
Thread-Index: AQHcwoqzFNYEvNmd/kC3msji9hdVI7XLuFJQ
Date: Tue, 7 Apr 2026 09:30:16 +0000
Message-ID: <e9cf7e6a4f1c4aa9b668f875fcb7084c@realtek.com>
References: <bug-221309-62941@https.bugzilla.kernel.org/>
 <42befa05-71bd-4a5e-9f8f-269ad532a234@molgen.mpg.de>
In-Reply-To: <42befa05-71bd-4a5e-9f8f-269ad532a234@molgen.mpg.de>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Paul,

Thank you for notifying us and providing the detailed information.
We have already reverted the commit. We will proceed with fixing this issue=
 and provide an updated firmware once the fix is complete.
Thank you again.

Regards,
Hilda

-----Original Message-----
From: Paul Menzel <pmenzel@molgen.mpg.de>=20
Sent: Thursday, April 2, 2026 6:22 PM
To: Hilda Wu <hildawu@realtek.com>
Cc: linux-bluetooth@vger.kernel.org; linux-firmware@kernel.org; Josh Boyer =
<jwboyer@kernel.org>; regressions@lists.linux.dev
Subject: Re: [REGRESSION] rtl8822cu: BLE disconnects with firmware 0x0673_0=
EDC


External mail : This email originated from outside the organization. Do not=
 reply, click links, or open attachments unless you recognize the sender an=
d know the content is safe.



[To/Cc: +Hilda, linux-firmware@, Josh]

Dear Hilda, dear Josh,


Hilda, unfortunately, you do not have a Linux Kernel Bugzilla account, so I=
 am replying here.

Am 02.04.26 um 01:57 schrieb bugzilla-daemon@kernel.org:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D221309
>
>              Bug ID: 221309
>             Summary: rtl8822cu: BLE disconnects with firmware 0x0673_0EDC
>                      regression
>             Product: Drivers
>             Version: 2.5
>            Hardware: AMD
>                  OS: Linux
>              Status: NEW
>            Severity: normal
>            Priority: P3
>           Component: Bluetooth
>            Assignee: linux-bluetooth@vger.kernel.org
>            Reporter: i+kernel.org@schimpf.link
>          Regression: No
>
> Created attachment 309794
>    -->=20
> https://bugzilla.kernel.org/attachment.cgi?id=3D309794&action=3Dedit
> stability log after downgrade
>
> Overview
>
> After updating linux-firmware-realtek to 20260221-1 (which includes=20
> commit fbf93476, "update rtl8822c bt usb and uart firmware to=20
> 0x0673"), the RTL8822CU USB Bluetooth adapter
> (0bda:b00c) begins dropping BLE connections every few minutes. Each=20
> disconnect lasts several seconds before the device reconnects. The=20
> adapter itself never resets and the USB device remains active throughout.=
 Only the BLE link is lost.

[... Linux 6.19.10-arch1-1 ...]

It looks like, the linux-firmware commit [1][2] caused a regression.
(Also linux-bluetooth@ wasn't in Cc?) Could you please look into it? I reco=
mmend to revert it for the time being and cut a new linux-firmware release.


Kind regards,

Paul


PS: Josh, do you have a pointer how to reach the commit from the merge requ=
est?

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/900
shows
https://gitlab.com/kernel-firmware/linux-firmware/-/commit/1f806c75e479fea9=
f222579deb6e69d285b614fc,
but I do not see a way to get to
https://gitlab.com/kernel-firmware/linux-firmware/-/commit/fbf93476.


[1]:
https://lore.kernel.org/all/20260202115751.1056277-1-hildawu@realtek.com/
[2]: https://gitlab.com/kernel-firmware/linux-firmware/-/commit/fbf93476
