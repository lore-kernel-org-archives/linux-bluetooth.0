Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CC71DA22
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jul 2024 14:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103436; cv=none; b=s0BOkYE/XeVQ6cC5hO8NCP9Q+cp0MkZf4xDTUc2hFTjdK1KQeAUC+dXnwzJbxtNE9/sZ95TytEGObjnXWNVD1FkGZQ1MmqKzIbjFjbg6BrVM6GVOpCpS+LQ4GMdjZGpFpjXifHW8IzpqI7PpXJxkJPHo7g+TTP+a96gK7pznm7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103436; c=relaxed/simple;
	bh=q69OfOnp4JzmSy9EVAv/QZMK0674X0AFgdb27AzBKPY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Q/R6Dd00JyL2BZ8Z44yeHl/PicL7/HreX/GRkZ4P8Xyt7ioMHFsg88UomNlh1pXnx64RuR7XnTxQ6QaK4Isis90wtid8ZOIcm4ZLN7ivXpARYDO7ktU1EUeLCkHQIInsVl+jMojF+QDfMhwNnhTub1EAesY8uV9DRX7gWQepW4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.li; spf=pass smtp.mailfrom=gmx.li; dkim=pass (2048-bit key) header.d=gmx.li header.i=usul@gmx.li header.b=WC4W8Rcy; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.li
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.li header.i=usul@gmx.li header.b="WC4W8Rcy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.li;
	s=s31663417; t=1720103431; x=1720708231; i=usul@gmx.li;
	bh=q69OfOnp4JzmSy9EVAv/QZMK0674X0AFgdb27AzBKPY=;
	h=X-UI-Sender-Class:Date:From:To:CC:Subject:In-Reply-To:References:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WC4W8RcyWfsUuYPR88kzL4rJRLViWoa3rQWZaxihVrQqIJWTLl2d05ncWuO62MhV
	 /8cov/j1qHyTIiqz1Ez7/9oKn7cey6pXZXcZQreB+TujfbIsAQpzh2AXWI/998Y6M
	 +7Efl132PEnE3KIOvvjmHzaV+u4Do1p/1vNTOyS10aaNS3eD390M4ww7L57YqpuB/
	 ewgM23G1eUGC6adsHE0Cf5XE8ewcTdZaxHsK1ZRuWCoVmkWTKS0xB8+u7Af95GOjS
	 JFV7WyZSPl6QNel+K/qKbANgLU/6xquqXI0FNkzvg5mdXusLfxQFeU/ADhZtvRxkG
	 YdT+REPop38AQ0HuUQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([185.104.138.48]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOiHl-1smGUL1Ibf-00Ofzm; Thu, 04
 Jul 2024 16:30:31 +0200
Date: Thu, 04 Jul 2024 16:30:24 +0200
From: usul@gmx.li
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Bastien Nocera <hadess@hadess.net>
CC: linux-bluetooth@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5Bbug_report=5D_Reproducible?=
 =?US-ASCII?Q?_pairing_loss_after_reboot_/_?=
 =?US-ASCII?Q?Mediatek_RZ616_=5Bpartly_resolv?=
 =?US-ASCII?Q?ed_/_probably_not_a_Bluez_bug=5D?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CABBYNZLkQh-Lb9P-ZwDgXkQJPpxVSRE0wTEFGEG6nUQ9HQkboA@mail.gmail.com>
References: <4cb7ecc4-2bf0-4403-a995-7ca3817be4cc@gmx.li> <CABBYNZK2xgDZ-bkxE6L-5Yt9x3PDKT_swDpN1=HAD9PC_6QpVA@mail.gmail.com> <c0b60ec6-08ef-4391-856d-14f60f33af9e@gmx.li> <CABBYNZLrATLZaE756Guu9K3nGxGc3aVzSuxOiLw9icsO5+QXww@mail.gmail.com> <d7c41cc6422da3e024280c055661833411c6e847.camel@hadess.net> <CABBYNZLkQh-Lb9P-ZwDgXkQJPpxVSRE0wTEFGEG6nUQ9HQkboA@mail.gmail.com>
Message-ID: <8BF9EC88-361A-430B-857F-AD19F03134EA@gmx.li>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=usul@gmx.li; keydata=
 mDMEYT0FchYJKwYBBAHaRw8BAQdArEjHsk6ctt1L9GHto/ToQwWNzLkcYNYic8sSFDh5Zfq0Gkpv
 bmFzIMOWemJheSA8dXN1bEBnbXgubGk+iJEEExYIADkWIQQSpKnfWmlka9xUP94Iq4jmQFt9rAUC
 YT0FcgUJBaOagAIbAwULCQgHAgYVCAkKCwIFFgIDAQAACgkQCKuI5kBbfawkIgD8C9W51CJ/LAlp
 mIzZWkNMvf31lm3cj18b6Y3aiQiBMPUA/3TusQ+yTjx6oW2TruaUWx17IM8mREN1RyQmLld6Qw4F
 uDgEYT0FchIKKwYBBAGXVQEFAQEHQJYg8RVKWRL9nRXGVzDL5qf3qVb/yPqFeDHWGgxHS4NPAwEI
 B4h+BBgWCAAmFiEEEqSp31ppZGvcVD/eCKuI5kBbfawFAmE9BXIFCQWjmoACGwwACgkQCKuI5kBb
 faxptQD+LuJTJO/AxlNps7gmplwUVRcPqJfKdlFpgjj5k2UysMkBAJ+dg+YGOfCDrUtSJHkJ077X
 3+FYcN0o8zxuE2qWey8O
X-Provags-ID: V03:K1:yVaV5l454P/PeKSw42OKKtmB2Ui2k2874nBBThuABTdwuGHXA/n
 WzMeSxSJeV4lx0/dI3fqQ+Qc2k/mI6/zQxlrY/z9G8JUvopWCsyHSwCnVmyVs37DKJe1lc4
 jLFAYIP4nvUH2Z8wbQYKi1cWJ7F05i3atXOs2RRKrPluQZf6lF+lmtZx+0MRUQJU9AHmJlA
 8NSSaZGKMZPoEHBTmzxZA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:40mPKqbvm3c=;pBgSCD+lmDd9AiqcY+E/9YSoKJ7
 3i90Sd/vbi2wtGCHhS4L7b/OmywRfOe+663L+t8O1uxhWXfjqw5P5ffUzxRAxlUXmEZ7IXmXa
 0YSEXNKD1jHRToxVEA72qdMKLnnih6HNws3hWgVOaYgD1XiYPByxMTpm5coQaE8nmaCG+fUR1
 nxkL+eOAlvpF4+LutuX3eFREp/VNNQ5L6aCpEEGYPljayQO6spVGFoII3YaB7GjcV9tvaoXLw
 2vcsQJeIj19hZlrIxPWyWNrmphO1iVDJ7O3GRpZKK4UmcL7tfRdzfLBzHwDFfovWyeAPdFj7z
 eraP3/t+vaXgY6bhqfTeQMFp6LgqNcvEroeAUe/Upx0UFWtN/0fuBOhYkG4HOedGM5SJ/TleK
 WcvgyQb8C5IPAl2+MqiQ8PYWUSDYp9d+OfE0Z+26Pun8fFePcq42cTNH1LK8xRO2rMD6nj42y
 MFZuDwXcs8kX3/7ZEbclBzlFIp9zqjwnMLylWgggkjoCcm/A4iLjhzFtyTjy+dWimb+KiBDkm
 asHSdfaxcP5wraymMdd/c9GLwtD4efx7KdnInhFkixAtRKuQCYSmG7DKyKOgiQ55gawTv2cNH
 OGIXwL6v3tpqveVTK+RsVpEh83wcx2iV8p8wlHKHJa6sxoUx4PfeFunKMrHOPMSgGh9B09W/1
 hkiRMOSSwGw4pRoSMhjqz3nmasUHS17oMV0r43cm05Q8Ou3tY/HyvpZ+tvafLw4r7xolzpDbC
 H0fOXcFdY3zyCkXV4Ve3Yh1KAm3NCQirtMyxBm+LVIEBIcNBPE5cfvoDzqUcPUN+Nr6oaeBf/
 QDCI5/wLePTcEdizGoPdnhUtVYATSXe6xpmLFLqiB+2Lk=



Am 4=2E Juli 2024 16:17:32 MESZ schrieb Luiz Augusto von Dentz <luiz=2Eden=
tz@gmail=2Ecom>:
>Hi Bastien,
>
>On Thu, Jul 4, 2024 at 4:20=E2=80=AFAM Bastien Nocera <hadess@hadess=2Ene=
t> wrote:
>>
>> On Wed, 2024-07-03 at 13:31 -0400, Luiz Augusto von Dentz wrote:
>> > <snip>
>> > @Bastien Nocera do you happen to know why gnome not register a
>> > pairing
>> > agent? Ive seem quite a few reports of things not working after
>> > rebooting lately which hints to No-bonding pairing happening or
>> > perhaps fedora uses main=2Econf:AlwaysPairable?
>>
>> There hasn't been a pairing agent in GNOME outside the Bluetooth
>> Settings panel for more than 10 years=2E
>>
>> I've never seen this being a problem before=2E
>>
>> Fedora uses the main=2Econf shipped by bluez with no changes (except
>> AutoEnable to true, which does nothing as it's already the default):
>> https://src=2Efedoraproject=2Eorg/rpms/bluez/blob/rawhide/f/bluez=2Espe=
c#_196
>
>Hmm, so if you got a incoming pairing request there is nothing to
>respond to authentication? Well even in that case it doesn't explain
>why there was no agent while setting up a new device, or perhaps that
>is not how setting up new devices works nowadays? Jonas, did you use
>the gnome setting panel to set it up or did you use something else?
>


When initial pairing was done with the gnome settings, I would not be able=
 to reconnect after reboot=2E Now that I did the pairing with bluetoothctl,=
 it survives a reboot=2E

The connection still breaks once in a while (about 5x per day) and then ne=
eds a few seconds to repair itself=2E But that might be a different problem=
=2E I'll try to capture a log of this as well=2E
(Sorry, re-sending because my mobile phone didn't accept answer-to-all)
