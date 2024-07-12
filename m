Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCD6171E49
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jul 2024 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720795285; cv=none; b=aLHCn59ibtHeMWqHkRvq94T8xtwRg/8YyxbPvvH7DpBlfFTKSiNep9HhrKMkxhycG46zo4CIzhJb8KcNStQrpzizXEidP+NbJRDDT3pKjnZy0yfAbtI6B9ZuaEj2sp52GkiKTLisDDBKnZWpZ68NNk13AsYXT6MPwaITjNogQFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720795285; c=relaxed/simple;
	bh=uWo6mDQ3bRMfd5/MtPjF5l/5K/jQa5xllx+KC2kXqdY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ANkFKClhSpsxkB/ES7DKW9I2Q/xbYy32LvXW/zvi6ZJ0Pud1y3C9+gRCEIW9JJNxfavMl33eOgeFccicKs1w+geMCYUX2nbhvNKB+ZQ3iKLF7BcHNmauifh2Pr6dabc/8s2xs7lpT37qQ8NzDUdDpNcfpNZOZveLQj6bP8DFnu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.li; spf=pass smtp.mailfrom=gmx.li; dkim=pass (2048-bit key) header.d=gmx.li header.i=usul@gmx.li header.b=P4QlMEKi; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.li
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.li header.i=usul@gmx.li header.b="P4QlMEKi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.li;
	s=s31663417; t=1720795279; x=1721400079; i=usul@gmx.li;
	bh=nzJvEjd6POdWJoUl3tDoWuYautZEKHBLEITMxgPmPkU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=P4QlMEKi3iaGP6G4BAyEmLdVari4Z1Ay1GnOeQUGxcdcnHaIMYm0ihT53yryRZPN
	 +/yXC7OSEw1OZTcq/DdbJpI+6lpc1hohzm1vc7RVuZ2Gd9yknTWyWAuVvjfu7q6SY
	 FCTP3fKxaHzeY3bmK9VBBh0N3FaQh2VjtfFVdZZG7o9idN+TPYETb2dsQDe28tA4a
	 w2+k7ql65+vhj5aS1ujQtld0Ew0oMhQpAaByHfDdzvMLUFH0bdogGNATiqUgU061c
	 kkZ5WtioWZIejAs3BOT2p7jcuCOso9WEgZQkd4zPaVFS0JJv/wXxQ5qJg6W4LQmYx
	 wD2ozDHULugs+nt0ug==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [127.0.0.1] ([185.224.57.162]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MbRfl-1rv9d92TsH-00kkgc; Fri, 12
 Jul 2024 16:41:19 +0200
Message-ID: <87433dfd-9897-4de7-a3d9-6a2b9358fd74@gmx.li>
Date: Fri, 12 Jul 2024 16:40:09 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] Reproducible pairing loss after reboot / Mediatek
 RZ616 [partly resolved / probably not a Bluez bug]
To: Bastien Nocera <hadess@hadess.net>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <4cb7ecc4-2bf0-4403-a995-7ca3817be4cc@gmx.li>
 <CABBYNZK2xgDZ-bkxE6L-5Yt9x3PDKT_swDpN1=HAD9PC_6QpVA@mail.gmail.com>
 <c0b60ec6-08ef-4391-856d-14f60f33af9e@gmx.li>
 <CABBYNZLrATLZaE756Guu9K3nGxGc3aVzSuxOiLw9icsO5+QXww@mail.gmail.com>
 <d7c41cc6422da3e024280c055661833411c6e847.camel@hadess.net>
 <CABBYNZLkQh-Lb9P-ZwDgXkQJPpxVSRE0wTEFGEG6nUQ9HQkboA@mail.gmail.com>
 <8BF9EC88-361A-430B-857F-AD19F03134EA@gmx.li>
 <a152556f7fd550ef564cae217a01f59c2a366f88.camel@hadess.net>
Content-Language: de-DE
From: =?UTF-8?Q?Jonas_=C3=96zbay?= <usul@gmx.li>
Autocrypt: addr=usul@gmx.li; keydata=
 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
In-Reply-To: <a152556f7fd550ef564cae217a01f59c2a366f88.camel@hadess.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xFib2RnOPslTq9JvLA5zQ4giZaRR1YWUrZ5krEXhSnZskQDzhTH
 PWHqA3iqExlujMPjxdD20pUGb1sW0zJI/5ellXLjA0CSsp40Uli1dmZgYQn8Qa4gY4eYHiH
 GsAST1xGDSExggdXEgzi5x4zCNhrDk/02BV3EFXdFjmiB6qdhcmZDZg7HBMsG/Y1QM7neIl
 lyayWL3iZ8/bw9M4AAwAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vMlxWXZSD6A=;3DkMcsEudLaJcfGfljaw0aEe+Tz
 Xwd9ZN+ixs/DZdZd2U/wPOnp6jfQF5KmbohwOrCNn0UKjbGzdskM3Dtqh0TDNcfXZMZgf1mlc
 BSIXj4EQ1ANSSO3rQKYjbZGHWR9hTjoHYT0AivNQjsS8TEItE2WDepQUGZnh5F9297QwwRXR3
 RqB+Vqc2WgkY7Q7+p2f/JCRnBQ0h2p6dA9Q5PdrrCmVXBQscJWysURIm5c+jSwTj8VlTAHHF5
 NS78ySa4ztyNL4E4lgpS+fmi5yb+7dV00GtgC2eluo9yhkXgxkvGrRUPQlYwR9YNlHZ8Bf66C
 4INI7HoNklR0UkUSOSeLM+uwjj/FSvYw5f0IA0a4syLBcOrIRMAMghNyN6a0PZkYD84xPNEw8
 BZnNbfIHyrcq1f5Uk9b9TMz02h0aq8M0TXYfCnu9I6zpmMEZ51fOz7GzUqOsBFswSUcgcgE2y
 GabruW852JQ7Kwm0i0S0AEQlMthWxUMvcsMCy48Z9XefpyXNySPUjcbHd/QLnaV9ReKqQs8lR
 0llb/9vSx+39d+ePcs9xrgky3kTQVtb6bcgLva1Tk1+AaEQ+xubI4lA3wPi45Bq5cPobFidF0
 kExETpdtwtQZaC4hUpjfcnffKeKhWjKpRbfsH7JoahjX5ejj5hfP2XoFk2IhXGLvDdjN6LYMl
 dtJnqQmHXyUUM/t+XeCsAC9dbjwWSk3/GmK0kYDQLhsqQV/HV11TxpXg2TZ9nURuaPuUnWRCp
 s2XB7vi1glOrwfQBzkavwvF8mesw10uOdMlzHCRpTlgJ7cREer8/WIASQMUz00MidH4lOnpj8
 +Ofrf8ViPmq//hXdPe/2dkQeGp8XV7zm1wf+ujcTdQS8c=



Bastien Nocera:
> On Thu, 2024-07-04 at 16:30 +0200, usul@gmx.li wrote:
>>
>>
>> Am 4. Juli 2024 16:17:32 MESZ schrieb Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com>:
>>> Hi Bastien,
>>>
>>> On Thu, Jul 4, 2024 at 4:20=E2=80=AFAM Bastien Nocera <hadess@hadess.n=
et>
>>> wrote:
>>>>
>>>> On Wed, 2024-07-03 at 13:31 -0400, Luiz Augusto von Dentz wrote:
>>>>> <snip>
>>>>> @Bastien Nocera do you happen to know why gnome not register a
>>>>> pairing
>>>>> agent? Ive seem quite a few reports of things not working after
>>>>> rebooting lately which hints to No-bonding pairing happening or
>>>>> perhaps fedora uses main.conf:AlwaysPairable?
>>>>
>>>> There hasn't been a pairing agent in GNOME outside the Bluetooth
>>>> Settings panel for more than 10 years.
>>>>
>>>> I've never seen this being a problem before.
>>>>
>>>> Fedora uses the main.conf shipped by bluez with no changes
>>>> (except
>>>> AutoEnable to true, which does nothing as it's already the
>>>> default):
>>>> https://src.fedoraproject.org/rpms/bluez/blob/rawhide/f/bluez.spec#_1=
96
>>>
>>> Hmm, so if you got a incoming pairing request there is nothing to
>>> respond to authentication? Well even in that case it doesn't
>>> explain
>>> why there was no agent while setting up a new device, or perhaps
>>> that
>>> is not how setting up new devices works nowadays? Jonas, did you
>>> use
>>> the gnome setting panel to set it up or did you use something else?
>>>
>>
>>
>> When initial pairing was done with the gnome settings, I would not be
>> able to reconnect after reboot. Now that I did the pairing with
>> bluetoothctl, it survives a reboot.

Sorry to report back a week later, I just had time do run a few more tests=
.
First result: The pairing now works as expected both when done via the GNO=
ME UI and when done with bluetoothctl. I have no idea what happened, none =
of the kernel, bluez or gnome-bluetooth packages have been updated.


> I have no idea what the difference could be between pairing with GNOME,
> or pairing with bluetoothctl, there really shouldn't be any difference.
There is one difference though: in /var/lib/bluetooth/<controller>/<device=
>/info I find "Trusted=3Dtrue" when connecting with GNOME UI and "Trusted=
=3Dfalse" when connecting with bluetoothctl. Not sure if that means anythi=
ng and of course I could set it to trusted from bluetoothctl as well.

> Would be good to capture both cases to see whether there's any
> difference, checking the /var/lib/bluetooth files after pairing in each
> case might also show some differences.

The logs for this are huge (i.e. especially as I'm working in public space=
s and many devices are around. I have no idea what specifically to look fo=
r, and as both ways seem to work now, I think it does not matter anymore.

> The device looks like it supports pairing to multiple computers (look
> at the channel display at the bottom:
> https://www.cherry-world.com/gentix-bt
> Maybe that's part of the problem?
The device has a button to change between 3 different "channels". What it =
actually does is that each "channel" is assigned a different device ID. Wh=
en pushing the pairing button on a certain channel, a new - apparently ran=
dom - ID gets assigned to the selected "channel". Of course I took care no=
t to accidentally change the active "channel" during my earlier tests. Whe=
n it did not work earlier, I know it was available with the same device ID=
, but would not allow the encrypted connection to set up after a restart. =
Let's see if it happens again.

> Cheers
>
>> The connection still breaks once in a while (about 5x per day) and
>> then needs a few seconds to repair itself. But that might be a
>> different problem. I'll try to capture a log of this as well.
>> (Sorry, re-sending because my mobile phone didn't accept answer-to-
>> all)
This still happens once in a while. I'm not sure if some disconnects (like=
 once every 2 hours) are to be expected on a bluetooth connection? They ar=
e still very annoying, especially when I'm doing thing like moving items a=
round with the mouse (design/layout work) and then suddenly the connection=
 is lost.

Thanks again for your help. I will make a new report once I have captured =
a suitable log of the latter problem.

Cheers
  Jonas
