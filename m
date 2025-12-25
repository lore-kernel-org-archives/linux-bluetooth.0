Received: from mailout12.t-online.de (mailout12.t-online.de [194.25.134.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7F02D5C68
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Dec 2025 07:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.25.134.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766647222; cv=none; b=koaCn4fau3UkiMP6Uu+J1H6orjO6cp2p3/SKIsPUa/ht2GmKDVRsbXTXnc/2tE0pzmgny1m+kUMU5ZJ+bJZ7P+JXqDW3WH3GDVID/iNVQwAvnJpmdRkhSEIaBUmesoWwFc4+q6fjLsJH4P1b7wj7HQEC8Jd7F9y0gnygSZYkAAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766647222; c=relaxed/simple;
	bh=oP7/k0DMkmfFUL3YGMQ7LPE8wLCAaJpvXLqSKQW5wMs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XduaUuxhBA/rdamydYcS8z48LRxpGaUf/J0PxkD+EbZY92MMuZfnp5lr4qzrU6Gqr0dla/boDq+NYxZ0CJQthynhi6JVfq0qDNa/lCyZdMkQ49rLa4mZ40L43FGMUzq7SHfe/OIHV8OLXBw5cfYINPJvHNDzVoZhDyb+teQD17E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=t-online.de; spf=pass smtp.mailfrom=t-online.de; arc=none smtp.client-ip=194.25.134.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=t-online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-online.de
Received: from fwd88.aul.t-online.de (fwd88.aul.t-online.de [10.223.144.114])
	by mailout12.t-online.de (Postfix) with SMTP id A53EFDF76;
	Thu, 25 Dec 2025 08:10:21 +0100 (CET)
Received: from [192.168.32.221] ([133.159.148.251]) by fwd88.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1vYfUF-1hv80P0; Thu, 25 Dec 2025 08:10:17 +0100
Message-ID: <9b4395d8a6fd8abafaa74a4fd7542a0a1d2ae40f.camel@t-online.de>
Subject: Re: [PATCH v2] Bluetooth: btusb: Add support for Quectel NCM865
From: Frank Tornack <f-tornack@t-online.de>
Reply-To: f-tornack@t-online.de
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 25 Dec 2025 08:10:10 +0100
In-Reply-To: <7B3FF8A1-0D76-40D0-8B65-85A949D5FF97@iki.fi>
References: <694a366a.e90a0220.1a6835.f67f@mx.google.com>
	 <20251223094535.91725-1-f-tornack@t-online.de>
	 <a0ee7d9d9451215a38cdf51c60691f3d4ab433ab.camel@iki.fi>
	 <31553bc66935b6287f0723984388a98b5f720e39.camel@t-online.de>
	 <2051d4d464090c4a84d508e7648e9580f50c14a0.camel@iki.fi>
	 <7B3FF8A1-0D76-40D0-8B65-85A949D5FF97@iki.fi>
Autocrypt: addr=f-tornack@t-online.de; prefer-encrypt=mutual;
 keydata=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
 KwYBBAHaRw8BAQdA9MoQWxT+PljXoionhEHpIAuLlhUME07Jht42EmJS9/K0f0ZyYW5rIEVja2hhc
 mQgVG9ybmFjayAodGhpcyBrZXkgaXMgdXNlZCBhZnRlciAyMy4wNy4yMDIxLiBBbiBhdHRlbXB0IH
 dhcyBtYWRlIHRvIGludmFsaWRhdGUgb3RoZXIga2V5cykgPGYtdG9ybmFja0B0LW9ubGluZS5kZT6
 JAoYEExYIAi4CGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4ACGQFEFIAAAAAAEAArcHJvb2ZAYXJp
 YWRuZS5pZGh0dHBzOi8vdHViZS50Y2huY3MuZGUvYS9ib2xsZXJ3YWdlbnBpY2FyZC9iFIAAAAAAE
 gBHcHJvb2ZAbWV0YWNvZGUuYml6aHR0cHM6Ly9naXN0LmdpdGh1Yi5jb20vZnJhbmtlbnN0ZWluOT
 EvOGE2ZmEwNmMxM2ZiY2VlZjhhMjRmZDFiNmRlNzIyYmFFFIAAAAAAEgAqcHJvb2ZAbWV0YWNvZGU
 uYml6aHR0cHM6Ly9tYXN0b2RvbnRlY2guZGUvQEJvbGxlcndhZ2VuUGljYXJkqhSAAAAAABIAj3By
 b29mQG1ldGFjb2RlLmJpem1hdHJpeDp1L0Bib2xsZXJ3YWdlbnBpY2FyZDp0Y2huY3MuZGU/b3JnL
 mtleW94aWRlLnI9IWRCZlFaeENvR1ZtU1R1amZpdjptYXRyaXgub3JnJm9yZy5rZXlveGlkZS5lPS
 RjWGVqcnQ3dWJ1RUF5aTNsaFVDeWFEUUlBa0lnRktHMnF3TF8yTXl6MDY0UxSAAAAAABIAOHByb29
 mQG1ldGFjb2RlLmJpemh0dHBzOi8vZ2l0LmdnYy1wcm9qZWN0LmRlL0JvbGxlcndhZ2VuUGljYXJk
 L2dpdGVhX3Byb29mFiEEirOWSf3d6fB6q3EmVa3qmdMF6s0FAmiMmowFCQhajfQACgkQVa3qmdMF6
 s2uHgD/dxJ2cY3dVn5DJCkCNdr0wxz0rL5MZtqXfRxGOlH6GZQBALoRq4LFNYIeiuJjVi6iNBjKQg
 0AbjOnM/UCVTAGjAYEtFBGcmFua2Vuc3RlaW45MSAoRGllcyBpc3QgbWVpbmUgU3BhbSBFLU1haWw
 pIDxmcmFua2Vuc3RlaW45MS5pbmZvQGdvb2dsZW1haWwuY29tPojQBBMWCAB4AhsDBQsJCAcCBhUK
 CQgLAgQWAgMBAh4BAheAORSAAAAAABIAHnByb29mQG1ldGFjb2RlLmJpemh0dHBzOi8vbGljaGVzc
 y5vcmcvQC9NVExGcmFuaxYhBIqzlkn93enweqtxJlWt6pnTBerNBQJojJqSBQkIWo30AAoJEFWt6p
 nTBerNeMsBAILdFx36go3uOgLVukgeD+bWu2q38wY29u4icMiCfadsAP9nngHM3BIiY4r0RWWrY8E
 KFcNM+DfPF2j+BCmkpu/LD7RMRnJhbmtlbnN0ZWluOTEgPGZyYW5rZW5zdGVpbjkxLmluZm9AZ21h
 aWwuY29tPiAoc2hvcnQgdmVyc2lvbiBvZiBHb29nbGVtYWlsKYiWBBMWCAA+AhsDBQsJCAcCBhUKC
 QgLAgQWAgMBAh4BAheAFiEEirOWSf3d6fB6q3EmVa3qmdMF6s0FAmiMmpIFCQhajfQACgkQVa3qmd
 MF6s3pOgD/ZEnhUZ7GUWlcuWReqZNI5YX6ZvfiBf/c/Z8Tb+M3kZQA/29ktoeEe78tMiFtBp9nhbK
 sopm1fvM5aaGDn4nXSnMJ
Organization: Privat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TOI-EXPURGATEID: 150726::1766646617-BAFD1FBE-0DCF40E7/0/0 CLEAN NORMAL
X-TOI-MSGID: 34e3cdf4-c4fa-4634-98a1-105497b2827d

Hi Pauli

The reason for adding it to btusb_table is that without this entry, the
device (2c7c:0130) is being detected but defaults to a generic QCA
"Rome" configuration (0x190200), which lacks ISO/LE Audio support.

It is definitely loading the btusb driver, but without the explicit ID
match, the capabilities don't align with the actual WCN785x hardware.

Just a quick heads-up: I'm currently on vacation, so my response time
might be a bit slow. I'm mainly checking my mails and doing tests on
rainy days when I'm staying indoors.

--=20
Frank Tornack <f-tornack@t-online.de>
Privat

-------- Urspr=C3=BCngliche Nachricht --------
Von: Pauli Virtanen <pav@iki.fi>
An: f-tornack@t-online.de
Kopie: linux-bluetooth@vger.kernel.org
Betreff: Re: [PATCH v2] Bluetooth: btusb: Add support for Quectel
NCM865
Datum: 23.12.2025 22:48:44

Hi,

23. joulukuuta 2025 13.27.49 UTC Pauli Virtanen <pav@iki.fi> kirjoitti:
> Hi,
>=20
> ti, 2025-12-23 kello 13:38 +0100, Frank Tornack kirjoitti:
> > Hi Pauli,
> >=20
> > Thank you very much for your quick and helpful feedback on my
> > patch.
> >=20
> > Before sending a v3, I'd like to clarify a point. In the bluetooth-
> > next
> > tree I'm working with, an entry for the USB ID 2c7c:0130 already
> > exists
> > in the quirks_table.
> >=20
> > However, this entry alone does not seem to be sufficient for the
> > device
> > to be correctly initialized in my setup (tested with a DKMS module
> > on
> > Arch Linux). I found that adding an additional, identical entry to
> > the
> > btusb_table resolves the issue and allows the module to function as
> > expected. My v2 patch therefore adds this entry to the btusb_table.
> >=20
> > Given this, I'd like to ask for your guidance on how to proceed.
> > Should
> > I submit a v3 patch that keeps the entry in the btusb_table and
> > explains this necessity in the commit log? Or do you perhaps see a
> > better approach to address this specific behavior?
>=20
> That's surprising, usb_match_id() returns the first match so second
> identical entry should do nothing.

Looks like I missed v2 added the entry to btusb_table, not
quirks_table.

So the change may be right, although I don't understand why
quirks_table is not consulted. There's maybe already id->driver_info
present, but where would it come from? Or is it loading a different USB
driver than btusb? Would be good to understand why.

>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/d=
rivers/usb/core/driver.c#n815
>=20
> I'd suggest to double check the patch actually does something, eg.
> change the added entry to `USB_DEVICE(0x1234, 0x5678)`.
>=20
> If it does something it's necessary to understand why. Easiest would
> be
> to add some printk(KERN_WARNING "some message") debug prints to
> suitable places in the code to trace what goes wrong, or use some
> other
> debugging mechanism.
