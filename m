Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A4B214A73
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Dec 2024 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401236; cv=none; b=GDA2a4kZNeo8WJ7fno68XDPxF4ueMT+bjKAY+MQOjSYjhAP4+Fnpo1ALF9xaR5IhbjOJN7Epjd1/asULKrfomazzAYSVVHi3PkB8AXqbXGDaSyMz7T3wGGPIlYKEClrGlIzaFtbom0NIqLgfgmwH85u9ovFNWdOpqP/sULz3Bzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401236; c=relaxed/simple;
	bh=5laeiqoMu0IAjpRa1W/MUY56TvJ3oSTC2TyRktXm03Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNtKK40tvYIHpg5V1JyYrPIt6M4ms51Ee50Qja8m0ae2BGyGhP2ULGpbiBH70BsWWPvmxwn7fV5wO1Wtrp8ayAUOavgxjhdoNSDafbrZmSFCZetADXXDocJjCM051+RgXyFSuAv4AVVNeyjeu9SAsKqY6NsXl/iEZovd4o7jVMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=jPenCiQF; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="jPenCiQF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733401231; x=1734006031; i=fiona.klute@gmx.de;
	bh=EorMkKnUxjVB/fom4usL/n+J0HdzVvVYaUwhcM4VeG8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jPenCiQFQS7kZVec90dmuWaTeswpwtjJoQMbtILLhuar2C7VC+tEPRPl3hkR0P2/
	 CjxxvsUCPtL5wVd9vOKGsh+GIcIMLFpgUCFijNG4aecF7D4D9s3vyimrzP35O69yH
	 rxuYA34r69CzaH+9uFI0t2FAjxxdl9t1fMro61lohuhjghaCUkG8ny4LhRQrv2way
	 eJjdVVgS9dXaYrkJ/j2U2p4tnr9WKmjxag6O/Y5dZRBqrf0/OohJqQjz/6dlR5bTc
	 +trapCsHQIMijPv/O3qo6tTSnFyD1GsCw3Kr+gYHlp3dbpD167qFIuxxyXZaC0KdO
	 rUxQFrVsYCIJc0eMKA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.30.37]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7sHo-1tFIxp0UuA-008y7S; Thu, 05
 Dec 2024 13:20:31 +0100
Message-ID: <4d1206df-598b-4a68-8655-74981b62ecca@gmx.de>
Date: Thu, 5 Dec 2024 13:20:30 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bluez: Read-only config dir install
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <5bdab6f5-fe17-4060-8d43-f43754e452f7@gmx.de>
 <CABBYNZJ5pPNqH2ah9CcoP5Hr2OA0J+Jmo=ai35WDNMuzTNZ7Jg@mail.gmail.com>
 <CABBYNZJmyNojrLXsqz+VN3jV_NmBatYONK=MMMh75x2=rYM8ZA@mail.gmail.com>
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 xsFNBFrLsicBEADA7Px5KipL9zM7AVkZ6/U4QaWQyxhqim6MX88TxZ6KnqFiTSmevecEWbls
 ppqPES8FiSl+M00Xe5icsLsi4mkBujgbuSDiugjNyqeOH5iqtg69xTd/r5DRMqt0K93GzmIj
 7ipWA+fomAMyX9FK3cHLBgoSLeb+Qj28W1cH94NGmpKtBxCkKfT+mjWvYUEwVdviMymdCAJj
 Iabr/QJ3KVZ7UPWr29IJ9Dv+SwW7VRjhXVQ5IwSBMDaTnzDOUILTxnHptB9ojn7t6bFhub9w
 xWXJQCsNkp+nUDESRwBeNLm4G5D3NFYVTg4qOQYLI/k/H1N3NEgaDuZ81NfhQJTIFVx+h0eT
 pjuQ4vATShJWea6N7ilLlyw7K81uuQoFB6VcG5hlAQWMejuHI4UBb+35r7fIFsy95ZwjxKqE
 QVS8P7lBKoihXpjcxRZiynx/Gm2nXm9ZmY3fG0fuLp9PQK9SpM9gQr/nbqguBoRoiBzONM9H
 pnxibwqgskVKzunZOXZeqyPNTC63wYcQXhidWxB9s+pBHP9FR+qht//8ivI29aTukrj3WWSU
 Q2S9ejpSyELLhPT9/gbeDzP0dYdSBiQjfd5AYHcMYQ0fSG9Tb1GyMsvh4OhTY7QwDz+1zT3x
 EzB0I1wpKu6m20C7nriWnJTCwXE6XMX7xViv6h8ev+uUHLoMEwARAQABzSBGaW9uYSBLbHV0
 ZSA8ZmlvbmEua2x1dGVAZ214LmRlPsLBlAQTAQgAPgIbIwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBOTTE4/i2fL6gVL9ke6nJs4hI1pYBQJkNTaZBQkNK+tyAAoJEO6nJs4hI1pY3qwQ
 AKdoJJHZpRu+C0hd10k6bcn5dr8ibqgsMHBJtFJuGylEsgF9ipWz1rMDWDbGVrL1jXywfwpR
 WSeFzCleJq4D0hZ5n+u+zb3Gy8fj/o3K/bXriam9kR4GfMVUATG5m9lBudrrWAdI1qlWxnmP
 WUvRSlAlA++de7mw15guDiYlIl0QvWWFgY+vf0lR2bQirmra645CDlnkrEVJ3K/UZGB0Yx67
 DfIGQswEQhnKlyv0t2VAXj96MeYmz5a7WxHqw+/8+ppuT6hfNnO6p8dUCJGx7sGGN0hcO0jN
 kDmX7NvGTEpGAbSQuN2YxtjYppKQYF/macmcwm6q17QzXyoQahhevntklUsXH9VWX3Q7mIli
 jMivx6gEa5s9PsXSYkh9e6LhRIAUpnlqGtedpozaAdfzUWPz2qkMSdaRwvsQ27z5oFZ0dCOV
 Od39G1/bWlY+104Dt7zECn3NBewzJvhHAqmAoIRKbYqRGkwTTAVNzAgx+u72PoO5/SaOrTqd
 PIsW5+d/qlrQ49LwwxG8YYdynNZfqlgc90jls+n+l3tf35OQiehVYvXFqbY7RffUk39JtjwC
 MfKqZgBTjNAHYgb+dSa7oWI8q6l26hdjtqZG+OmOZEQIZp+qLNnb0j781S59NhEVBYwZAujL
 hLJgYGgcQ/06orkrVJl7DICPoCU/bLUO8dbfzsFNBGQ1Nr0BEADTlcWyLC5GoRfQoYsgyPgO
 Z4ANz31xoQf4IU4i24b9oC7BBFDE+WzfsK5hNUqLADeSJo5cdTCXw5Vw3eSSBSoDP0Q9OUdi
 PNEbbblZ/tSaLadCm4pyh1e+/lHI4j2TjKmIO4vw0K59Kmyv44mW38KJkLmGuZDg5fHQrA9G
 4oZLnBUBhBQkPQvcbwImzWWuyGA+jDEoE2ncmpWnMHoc4Lzpn1zxGNQlDVRUNnRCwkeclm55
 Dz4juffDWqWcC2NrY5KkjZ1+UtPjWMzRKlmItYlHF1vMqdWAskA6QOJNE//8TGsBGAPrwD7G
 cv4RIesk3Vl2IClyZWgJ67pOKbLhu/jz5x6wshFhB0yleOp94I/MY8OmbgdyVpnO7F5vqzb1
 LRmfSPHu0D8zwDQyg3WhUHVaKQ54TOmZ0Sjl0cTJRZMyOmwRZUEawel6ITgO+QQS147IE7uh
 Wa6IdWKNQ+LGLocAlTAi5VpMv+ne15JUsMQrHTd03OySOqtEstZz2FQV5jSS1JHivAmfH0xG
 fwxY6aWLK2PIFgyQkdwWJHIaacj0Vg6Kc1/IWIrM0m3yKQLJEaL5WsCv7BRfEtd5SEkl9wDI
 pExHHdTplCI9qoCmiQPYaZM5uPuirA5taUCJEmW9moVszl6nCdBesG2rgH5mvgPCMAwsPOz9
 7n+uBiMk0ZSyTQARAQABwsF8BBgBCAAmFiEE5NMTj+LZ8vqBUv2R7qcmziEjWlgFAmQ1Nr0C
 GwwFCQPCZwAACgkQ7qcmziEjWlgY/w//Y4TYQCWQ5eWuIbGCekeXFy8dSuP+lhhvDRpOCqKt
 Wd9ywr4j6rhxdS7FIcaSLZa6IKrpypcURLXRG++bfqm9K+0HDnDHEVpaVOn7SfLaPUZLD288
 y8rOce3+iW3x50qtC7KCS+7mFaWN+2hrAFkLSkHWIywiNfkys0QQ+4pZxKovIORun+HtsZFr
 pBfZzHtXx1K9KsPq9qVjRbKdCQliRvAukIeTXxajOKHloi8yJosVMBWoIloXALjwCJPR1pBK
 E9lDhI5F5y0YEd1E8Hamjsj35yS44zCd/NMnYUMUm+3IGvX1GT23si0H9wI/e4p3iNU7n0MM
 r9aISP5j5U+qUz+HRrLLJR7pGut/kprDe2r3b00/nttlWyuRSm+8+4+pErj8l7moAMNtKbIX
 RQTOT31dfRQRDQM2E35nXMh0Muw2uUJrldrBBPwjK2YQKklpTPTomxPAnYRY8LVVCwwPy8Xx
 MCTaUC2HWAAsiG90beT7JkkKKgMLS9DxmX9BN5Cm18Azckexy+vMg79LCcfw/gocQ4+lQn4/
 3BjqSuHfj+dXG+qcQ9pgB5+4/812hHog78dKT2r8l3ax3mHZCDTAC9Ks3LQU9/pMBm6K6nnL
 a4ASpGZSg2zLGIT0gnzi5h8EcIu9J1BFq6zRPZIjxBlhswF6J0BXjlDVe/3JzmeTTts=
In-Reply-To: <CABBYNZJmyNojrLXsqz+VN3jV_NmBatYONK=MMMh75x2=rYM8ZA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pykUkb2ZDs7hxr/zhBu2ho43Mkjx6YtR89KEcdAbUsbSZBADNsE
 VdoFW3t1DOzA9sVFJPChdey8a5HYEWtceIkGy50At4p/EfkR0oifDfaly+ixlOkWx2aYfIP
 MLgrNnY2aFZIElii32Qep0imeDX/8/X2MzZfv+pAihBikjOiZTcV69Od9AbSg+MTsZvAeTM
 oNnMz1rO/MHK6juYFSvSQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7hpGPEthbkA=;N/ybR0Tymq/faKvjpiw12s0oAZ9
 PAQROFsqFuRTyVRy/fbf4XS0Y2i4qn0szP8yfr62OJaKi4tOHHQGZLnF456HnjJqOyVXN9iPL
 P6YRwUCNY7TFQGcftPz1aN3lcAON7AWmKarkjcTiHBCzw8TxJNUpHb1JMbozTju4gcNQj1b/V
 iOfAJ6jsonb3KfkvlcfK3sw8iscGLkiKDbynX4tbx19lCy21Ck7IiMiA7IwLY8zPnyGF68V5n
 pA6z46R4iQdwctULu0Q4Hv5fKY53qnBImZXz13jOxtw0IC9WGdUOpAgSlADBiW3L2qBJT/rIg
 HY1fLEPzzkh6m4HL0rsB//f2koyGTgqV6FeXJbK/D5LDf9L9342GeGF2Om3hvbb34oykyxIRV
 Lnepvxae9rMnYaoIVo9s67ZlcwTmcJI2Byp4FxmK/LVYQHjMxwvznEhmW1sw4tIWMG/6LWVav
 h6c0KBRDMV7xJxiNcJ+e7bleTm/JuhD3LxF4YfRBMdpqmhwZc3HU47BlJw/sfaY9olCs47uYZ
 bEFs7zRJCQcfHurjHLoTK9GkQms9g9KhtqdV+XqVYXl8ovb8b+CA3gDzpBSRdKTGqxRqbCHfr
 l1VoZr212+6WtUgAcIsJRNSqQchyFUczeRfjF1rY4BH4HOzuPkof5SQ4QaRmsyYgXz15PO3Iq
 4TkxaQneuf88x4OBS6hm7UGk6JoJl8c/T7ft+eowhcvy2VBPoqIvKRhqQ8GzB3lFvYoL/IVbg
 cxu6ijN5n5tZWowcggBpoSTxKjS7glAcb9xeNerhQhjEBcp9AXowUgdQ6rioquuMSWN2yZybp
 PT+JB/WZj9OAb5PtMb70D22MfAsd5wogDs1hqIiA48biTWguROLYbJOxzZQkVQNf4aTkYDA6p
 d6O+8Fd6JXEhX4IFBo07aJr0p4eaNorZ7Cacaw+9D+pq3hJSmmu1E1JTov/BIL1HRK+QIpUpZ
 E1JhJ1EWdl/jloexkF6qRpuXGpSQRd4SVs1CxuRhwVGIkVS3MaK3OyKGXQllnIrvegezofLKY
 tHyzkA41atwy35Uopi0GQxUAw8Xgig/0xM6ilyLszpZFMZAY+OpLg49ctyjLtI3WD8TBTkQkW
 djzfaj8U6YroRMdy4J1ZBgMAsXMmn6

Hi Luiz,

thanks for your quick response!

Am 04.12.24 um 21:37 schrieb Luiz Augusto von Dentz:
> Hi Fiona,
>
> On Wed, Dec 4, 2024 at 3:31=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>>
>> Hi Fiona,
>>
>> On Wed, Dec 4, 2024 at 2:51=E2=80=AFPM Fiona Klute <fiona.klute@gmx.de>=
 wrote:
>>>
>>> Hi,
>>>
>>> since February Bluez installs a config directory with mode 0555 [1].
>>> This broke the Buildroot build, because files in that directory cannot
>>> be deleted any more. Buildroot disabled the datafiles installation as =
a
>>> workaround [2], but at least in my setup this breaks *running*
>>> bluetoothd because the D-bus policy is missing that way.
>>>
>>> The commit message mentions needing specific permission, but does not
>>> explain why /etc/bluetooth can't have mode 0755 (as it does on my Debi=
an
>>> system, with Bluetooth working just fine).
>>>
>>> So my questions are: Can I just send a patch to change the permissions=
?
>>> If not, why does it need to be read-only? I think I'll need to
>>> understand that for a proper fix if changing permissions isn't right.
>>>
>>> Kind regards,
>>> Fiona
>>>
>>>
>>> [1]
>>> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3Dbe0e79=
6299b0e7a73bf06c5655b56180588550b0
>>> [2]
>>> https://gitlab.com/buildroot.org/buildroot/-/commit/1a8676aa6e4b0e372a=
1a744eac6e53c90c03bf0e
>>
>> Here is the discussion why end up setting it as 0555:
>>
>> https://github.com/bluez/bluez/issues/329#issuecomment-1102459104
>>
>> Now the question is why would buildroot delete files under
>> ConfigurationDirectory? Or is the problem that the directory is
>> created empty and then you add custom files later?

Buildroot builds a rootfs image. Files created by package builds are
written to a staging directory on install, moved around when building
the rootfs (as regular user), and during development I use "clean"
pretty often, which naturally needs to delete build results.

> Ok, sounds like this really is _not_ how the distros are setting it up:
>
> -rw-r--r--. 1 root root  1028 Nov  1 15:25 input.conf
> -rw-r--r--. 1 root root 12929 Nov  1 15:25 main.conf
> -rw-r--r--. 1 root root   120 Dec 24  2012 network.conf
>
> So I think it should really have been 0755, so the likes of root can
> write/delete it.
Thanks for the confirmation, I'll look at sending a patch then.

The arguments presented in the discussion on Github don't make sense to
me, ProtectSystem=3Dstrict should already prevent writes to /etc from the
service. ConfigurationDirectoryMode=3D0555 isn't going to *check* for
those permissions, it's going to set them (except it looks like
ProtectSystem=3Dstrict actually prevents that). The system I'm building
with Buildroot doesn't use systemd though, if I wanted to achieve the
same thing I'd need to add bubblewrap or something to the init script.

Best regards,
Fiona

