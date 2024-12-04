Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122F32391AA
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Dec 2024 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733341860; cv=none; b=GG6pa9arf0TvEZ55fgIKkR6ewSdy9UtTwhslGN0schGmmQoqv3E3feB9ZLHa+aFg4mKYKYtc9iNCQ7ojzwxxP0VhQQ7/QI+iPH4ZoJw8s8Tdous84GkLz2qQhCQqN4uEdo6i1XR3bF0gcahMJ2HYaL3JHbcDxiNZZhQMIfTYfWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733341860; c=relaxed/simple;
	bh=2rZUqDdpA3eWlaPqW0porMet1nXBIUB8tE6L9/gJvFs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=JEMCa65Ostvci5HgCh/SNSU7pzVpZbPQdjS0ZXe1WncGuzYcaWb5M91OWnbNOAAcNdrZLmQgaR2IRy0aej8+nzstNx4zJYLhHrBnum3pGc4VnyelcAycYvWTeGG4cWtaJtGaaC3ixOUKfAH26IGyJrVBbSU3YZkt2ZDva33PJOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=JUK5MJN4; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="JUK5MJN4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1733341855; x=1733946655; i=fiona.klute@gmx.de;
	bh=2rZUqDdpA3eWlaPqW0porMet1nXBIUB8tE6L9/gJvFs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=JUK5MJN4mmYc2zI3XHF2ITv2ARk8cQyeNs7sagpw6gNBfTEg0O1WSSBogRH0naf2
	 JkdoUKdyxkRikuCnyhMrfsoc5Ts76tL8m3/YsHemHUnfkPyzu/5JwLlej02jFRN79
	 F90+lmXrgZlk1KiRKLO74q8rAPcWsS0DMujIWUF2c0ob0InNVhnStEGp5PtOR8Jo4
	 vxqHl1sTd7Vn4EKDcvUe2OykCUidpzvp6Dc7vO+yC3RcjiSjR2TAr7XX9G7WrHB4q
	 CdrHVJQda2myBlLjCr5ylcYOEiITzDPB9QEekEU5oqJ0OWXKenkxCPud18O3ywAlk
	 GdWdOY3wsOjW8cxEvQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.7.2] ([85.22.124.249]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3KTo-1tjlef03Fq-00vJDc for
 <linux-bluetooth@vger.kernel.org>; Wed, 04 Dec 2024 20:50:55 +0100
Message-ID: <5bdab6f5-fe17-4060-8d43-f43754e452f7@gmx.de>
Date: Wed, 4 Dec 2024 20:50:54 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-bluetooth@vger.kernel.org
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Subject: Bluez: Read-only config dir install
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dnz6ZAsmADXuzIO5b5TZmsZIyA1ldJNtYIK1YGmLg6dUBgTwNaE
 Q19oSKxHW+xFoOPZ1u4U1nnIGUPfouoIrAgg8NnWXVXDmmVrsFheYuKjQPjHdv/xs6kiURN
 c0akJ9QtIKpnubFqRJ5pI9YDPL1CqQnyaVEF7gstv13m3Ma+xkjP6h5rBRjr+McsWihg6eT
 0YOLdpselQ0L2x/s+AfZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:slGoIndryAU=;D2g+ZIQKymKjwQZSquTff/7m8o+
 VNPjdgfXS2QxcNtQfQvkCK9jtGHon0b2O4+vkSHpeVlC7GBeSom1G4X7EqRbNlHQRa4U4k0H6
 js7j7pr1yU+yC/1mmDNKmV97bqx3zNj9n17DvENFxay1vDrVyryqPzqQIFVnClffX1iPNiJ+t
 pJkJ58OEj3gkT7OeNSiJ8aWjmK0ohMTn/nugWArqYlmEHbpA5dxlU/O4QCTf6BCHphK4GL25x
 RSTnIu+JlnWbc31NqauaC3qzbX+9UDdziW68lj5NmJF8AmbcxvU8ziHpfkqO0dLazZrwxT/T5
 uRT3uzZML2cdRLb2mSoxXG1rlQr8jbcgC/ZxbpIIB04+Z9VnWkGc9fM7GY4OJtS1L3GCjQMse
 7xZ0q9AUy9sFDwIkKiyK/UDJ9JwfawHb3AiH4ikhHYnSsyKW9bh0Ihvoak+sO45ZtDFDf+TQI
 Uwf9TQ6hk6Tz1fz+4BJ9QO3VmC6I56EUuMHLoDGDL538WfriK2zXqFyWKY0dUMgF1Aylr7Wiw
 weuItW3aH0fkvlsM1uBg59oGq6oR8SBaJ68drk89GvaM2ac3ETXHk6tvJ7r09hoLaPxfbYipM
 79khyuRpSo6FXI6KxFNBUEte6VKOzaKvc6SNopgfJ2ZewbCYcliHmDy2SXMZK6HLa221TehMt
 3YO9OGxkf+ZZ1bSjSWGMCbvClQq3Zxjz0Hf46bv9km89yZlkwEU2eNBWIedQTRzyCdUgHTa2f
 PgGs+9RkTYAweZW6XBNC1TW0lNdVIuCTKaKQTYEg9I1dLdXosqt/x6jssMSEqNydtc57dimaX
 /lH+h7DrKdo8BshJU42yWw4xuDHL0852gcn5k3k3aPT9w0qjOst7cUWPOdVfXPUYVoTfJByNI
 WBQpRk8FBfLZ+k2bAtQRIaFqLe+akmAWlCQktudKnoSdBupvug205mkun2cXmWLWHHYHmKetJ
 C+MARysRBA8hwhM4dBpoU7zZQjDKTF8TIuudbS9T0M55oDdeJFKPStFjuHgIy4LFlDMzkZd7f
 orL4VWwoFlgiTj/dAn0RcRlmMSviDsrJR2e1+zR/w9AIt4wxtA9a7RJu4qFy70RxkgF2IEMch
 XSK+B7CScgbJrxllyQBXU4E0VlcRaN

Hi,

since February Bluez installs a config directory with mode 0555 [1].
This broke the Buildroot build, because files in that directory cannot
be deleted any more. Buildroot disabled the datafiles installation as a
workaround [2], but at least in my setup this breaks *running*
bluetoothd because the D-bus policy is missing that way.

The commit message mentions needing specific permission, but does not
explain why /etc/bluetooth can't have mode 0755 (as it does on my Debian
system, with Bluetooth working just fine).

So my questions are: Can I just send a patch to change the permissions?
If not, why does it need to be read-only? I think I'll need to
understand that for a proper fix if changing permissions isn't right.

Kind regards,
Fiona


[1]
https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=3Dbe0e796299=
b0e7a73bf06c5655b56180588550b0
[2]
https://gitlab.com/buildroot.org/buildroot/-/commit/1a8676aa6e4b0e372a1a74=
4eac6e53c90c03bf0e
