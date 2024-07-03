Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43C417995
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720024732; cv=none; b=gwaFi0hqswxfZwtb/Vd/pEv5rC7B7wtk7fHKXTKe0hLCNwqrA0YzMPFUfsX7fpWeLp8HICu3+wgxDRQd9HKpMuZ7czd1xq1cu2hANtaZouwlaXPcCvNb+ND2DdTI9QUKq5G/Ga2j6oreABZZkyI+XnWteBEkgXTef4aaDHi+JGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720024732; c=relaxed/simple;
	bh=CuNZ0J/2SBOyapzgdg3QGnBnSa05WmAQ66ITyqONEtQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=n41XHBpe68qFldb5w0/nakxxu1R4XjuMvIPMwgLtTyWl3Y9j6yGHWw67hqJdJfRUMFJytnDGclhCWjS5sDX3PYa5YCdpz7CZDXg52l58ROMcsCUV1RIKZA4wVgStPW1sJJspnoO4jyEgLcX9nciy4xHWoY7hh3pTaqFkPPca6yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.li; spf=pass smtp.mailfrom=gmx.li; dkim=pass (2048-bit key) header.d=gmx.li header.i=usul@gmx.li header.b=t8Zhv05o; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.li
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.li header.i=usul@gmx.li header.b="t8Zhv05o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.li;
	s=s31663417; t=1720024727; x=1720629527; i=usul@gmx.li;
	bh=6D6OBLYE5zKT6FKQNSi1Yx9FHtRzI+AYA++euGcigHM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=t8Zhv05opoaLRb+rMVd7had4F/oKL4DTUydMVsuzxwJ7aXTTydLGnmqNGBHzJqZ2
	 AsXuh3nwH8cVgiEESudy6TaXaCR2Sdm/tyHimdp4r6xwvrZqdyRwoHlhBLteNA/J+
	 WZ53abIA762LZSAQTLIaGToYwTsNHc7emvYiI7mwYB/Vq/VkXjduqE1tbJB+3+/7H
	 PyYgT+bgl/A5vPbjzxCcrPhVN+/rNHluzaOBGMUF0HK404yNlLCjaoWC5n5+el6CW
	 e4jUGJ53hMffLrCrQSGrNzmzMBvvIWw8o8HfPDuaAyPqXAGY+dVhQwHcS03PC/bST
	 hNllVKG1gdjNVXj3tA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([37.4.249.3]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N8obG-1sK6m90uXO-017eGK; Wed, 03
 Jul 2024 18:38:47 +0200
Message-ID: <c0b60ec6-08ef-4391-856d-14f60f33af9e@gmx.li>
Date: Wed, 3 Jul 2024 18:38:46 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Jonas_=C3=96zbay?= <usul@gmx.li>
Subject: Re: [bug report] Reproducible pairing loss after reboot / Mediatek
 RZ616 [partly resolved / probably not a Bluez bug]
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <4cb7ecc4-2bf0-4403-a995-7ca3817be4cc@gmx.li>
 <CABBYNZK2xgDZ-bkxE6L-5Yt9x3PDKT_swDpN1=HAD9PC_6QpVA@mail.gmail.com>
Content-Language: de-DE
Autocrypt: addr=usul@gmx.li; keydata=
 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
In-Reply-To: <CABBYNZK2xgDZ-bkxE6L-5Yt9x3PDKT_swDpN1=HAD9PC_6QpVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0nS5QB0WqskQ/heuOdbousVCXFeZeOTV0tsr/hai3fY7dk4LsHc
 V4r1rtOm+SRXF7/YJleXmNjl4KrtwxWRrlCUrJCgPb6DfZPsUaio0SCmMzWZy+O70v1bLB9
 58eUGkyZc6+VTZes+y9VzqpYx1ksiI7/usWUpnu2X7vG+dbb/n+BonMyIXNz027dOjIIziZ
 I8GKpF6b3kQ7Uwg05u4Tw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:I1XvLxUeXvM=;ADsrwoOH5oCeqgddwa/Rt0Ru58I
 wgOTaCj/xBT1aOHT6mR9HftyrBibp1x1chlKzKTx5DPBHXSz8JhdldVTT3lSpBS7Xdia5LgEy
 pH0u/Kyvbqqq01ooRIu4JaEszaNV8Hy3H4QhwKsKuyXa6pdh+fX8uKp5VZ9LXYjtbgx+pi6iD
 SzdFhKfG7UbAOFfmAQDsuym82gJ2WyMri9hGpZiadPTyYGgZHyhv+mBIDj++p+ka+OO0HlXot
 o+DtpLVzP44AiOHgr6KRDXVkeilk21FMbdfQQ4isRl5XffJj9RPHR6HCeAzV9meZOZV6ZtgFd
 x1mY1wVRqh0SV7tC3/UKqOZoj2tzMFQwMPNXTv5IxvNY9vKJEJE222sS7iwQ23qwInCuZzOLx
 VrR8z4y98bITq8wKW1jKZNiFJI1DypMinjXAN+DF7YU6HSU2o4jbwbc8PiNCPG9RKdT3WsSs0
 IVddUSimgVvw7NbhrILBNh6jOkGXJD7MLFPwfv0Qae8t6bXHSzFHFerDFo6Xe9uDS9RlWzph4
 K3mkhKZrqrGBYEzYMyx2AaUEtiDeAMJwLRehBFZIf1wgDeJX+be0a6EjRkCb7I5qE1VWmpQF1
 4ZqMtEgYawrfUqpoQkabR65uZKQNyk+g0LEH0hF7ssnZOTwirSttNVpeP3MappOXk78FUNUjq
 86y6bQkV1G4NZIhkVaql9Z7LjY7ZNYfp530P48OSSweopxfKPuePAhl/DlqogAOiR62Bmjpsv
 foYwWt3lfgIa4TgbVuLS3E6g/uxPYIJ1YcIEPuU5PnbsuFSTCLLxbjgTY547fKqgTGs6Q5Xxx
 Ng6NHmLUy0L0tj1Rslb9N+XjCDwldJh7QwkMLUEg6FXUY=

Hi Luiz,

Luiz Augusto von Dentz:
> Hi Jonas,
>
> On Wed, Jul 3, 2024 at 5:01=E2=80=AFAM Jonas =C3=96zbay <usul@gmx.li> wr=
ote:
>>
>> Hello Bluetooth List,
>>
>> this is a first post here as I found no other place to report bugs. Ple=
ase forgive if I do not report according to the expected format or missed =
any additional information and point me to the respective guidelines - tha=
nk you!
>>
>> =3D=3DProblem summary:=3D=3D
>> Bluetooth pairing with a mouse is lost after system reboot. The pairing=
 has to be removed and a new pairing initiated for being able to use the m=
ouse again.
>>
>> =3D=3DSystem specifications:=3D=3D
>> Framework Laptop 16 (Batch 7)
>> CPU: Ryzen 7 7840HS
>> GPU: AMD RX 7700S
>> WiFi/BT controller: Mediatek RZ616
>> Linux Kernel: 6.9.7-200.fc40.x86_64
>> Distro: Fedora 40
>> Bluez version: 5.76-1.fc40
>> Peripheral device: Cherry Gentix BT
>>
>> =3D=3DReproduction steps:=3D=3D
>> 1) Pair the Bluetooth mouse via GUI or bluetoothctl
>> 2) The mouse will now work as expected
>> 3) Reboot the system
>> 4) The mouse does not work, the GUI might switch between "connected/dis=
connected"
>> 5) start btmon
>> 6) clicking the left mouse button produced the attached btmon log
>
> Weird, it is doing a pairing request right away:
>
> < ACL Data TX: Handle 512 flags 0x00 dlen 11
>
> #11 [hci0] 2.185573
>        SMP: Pairing Request (0x01) len 6
>          IO capability: NoInputNoOutput (0x03)
>          OOB data: Authentication data not present (0x00)
>          Authentication requirement: No bonding, No MITM, SC, No
> Keypresses, CT2 (0x28)
>          Max encryption key size: 16
>          Initiator key distribution: <none> (0x08)
>          Responder key distribution: IdKey LinkKey (0x0a)
>
> But it is doing No bonding, so perhaps that is the real problem here
> since that indicates to bluetoothd not to store the keys. The No
> Bonding is controlled by HCI_BONDABLE flag which is set by
> MGMT_OP_SET_BONDABLE which by default is false but is automatically
> set to true once a pairing agent is registered, try reproducing this
> with bluetoothctl and if you are not able to this must be gnome/fedora
> not registering an agent.
>
>> Sometimes btmon also displays the following errors after MGMT Event: De=
vice disconnected (sorry, console cut them, could not capture to file):
>> bluetoothd[2974]: =3D profiles/input/hog-lib.c:proto_mode_read_cb() Pro=
tocol Mode characteristic read failed: Request attribute has encountered a=
n...   14.720255
>> bluetoothd[2974]: =3D profiles/input/hog-lib.c:report_reference_cb() Re=
ad Report Reference descriptor failed: Request attribute has encountered a=
n...   14.720368
>> bluetoothd[2974]: =3D profiles/input/hog-lib.c:report_reference_cb() Re=
ad Report Reference descriptor failed: Request attribute has encountered a=
n...   14.720401
>> bluetoothd[2974]: =3D profiles/input/hog-lib.c:info_read_cb() HID Infor=
mation read failed: Request attribute has encountered an unlikely error   =
       14.720616
>> bluetoothd[2974]: =3D profiles/deviceinfo/deviceinfo.c:read_pnpid_cb() =
Error reading PNP_ID value: Request attribute has encountered an unlikely =
er..   14.720675
>>
>> =3D=3DAdditional Information:=3D=3D
>> The mouse also sometimes stops working suddenly. In this case it might =
come back after a few seconds, but sometimes I have to use "systemctl rest=
art bluetooth" which re-enables the mouse. This might be a different probl=
em though. I have no way to reproduce this well so I also could not produc=
e a log file yet.
>>
>> Please tell me if I can provide any additional information. Thank you f=
or your work on this piece of software! :)
>>
>> Cheers,
>>    Jonas

Thank you very much for the extremely quick reply!
After pairing the device with bluetoothctl it finally reconnects after reb=
oot.
I have some basic knowledge of C/C++ - where would I start looking for in =
the GNOME sources? Any specific function calls I could search for to have =
a starting point? I have no idea about how the UI would call things from t=
he bluetooth system ...
