Received: from mailout04.t-online.de (mailout04.t-online.de [194.25.134.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C616A3839AA
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Jun 2026 12:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.25.134.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781873761; cv=none; b=Tk5+xeKRI61l6hgKss2CHoPeg8qYup6ojuXnpXhWI/x1/cYgZZ7EJP3rifFaSCjf+XpxZiBqskVQB9KDw1w0WKyVjKEEYKAvdZWr3vyd+XoleIA8E/VRKfOldRZs6NUvfecFTm4B7ofKdZ8PEIDzyqjv4/w/3jV3z8PZv88W2/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781873761; c=relaxed/simple;
	bh=75GBu/oNuF8D4riLpy3uqKTRdHT3K5vZ0zIqyzgtR7U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cdRfEPnzVoxozfsJQXlhCD9wVyWbL9ovJ/YjsXKupcYA1YPgCoV0IzqrcxUO/jN6P9dXwA7G+N+CjFMEQypcD33WueGmBtmsWgqc0654WJZjHi/kc5zC+fbTnd1g6kMWpxyifZJdCMG64AY9nGcvuPZrx0B3GDBvvjG3Nx3GYQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=t-online.de; spf=pass smtp.mailfrom=t-online.de; dkim=pass (2048-bit key) header.d=t-online.de header.i=f-tornack@t-online.de header.b=AFYqxf1B; arc=none smtp.client-ip=194.25.134.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=t-online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-online.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-online.de header.i=f-tornack@t-online.de header.b="AFYqxf1B"
Received: from fwd91.aul.t-online.de (fwd91.aul.t-online.de [10.223.144.117])
	by mailout04.t-online.de (Postfix) with SMTP id 86F2E506;
	Fri, 19 Jun 2026 14:49:28 +0200 (CEST)
Received: from [10.2.178.119] ([217.237.39.139]) by fwd91.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1waYem-1EqLMv0; Fri, 19 Jun 2026 14:49:12 +0200
Message-ID: <0f72c2912478145bc45ca72594fc8a2e4a8eda72.camel@t-online.de>
Subject: Re: [PATCH v2] Bluetooth: btusb: Add support for Quectel NCM865
From: Frank Tornack <f-tornack@t-online.de>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org
Date: Fri, 19 Jun 2026 14:49:11 +0200
In-Reply-To: <9b4395d8a6fd8abafaa74a4fd7542a0a1d2ae40f.camel@t-online.de>
References: <694a366a.e90a0220.1a6835.f67f@mx.google.com>
		 <20251223094535.91725-1-f-tornack@t-online.de>
		 <a0ee7d9d9451215a38cdf51c60691f3d4ab433ab.camel@iki.fi>
		 <31553bc66935b6287f0723984388a98b5f720e39.camel@t-online.de>
		 <2051d4d464090c4a84d508e7648e9580f50c14a0.camel@iki.fi>
		 <7B3FF8A1-0D76-40D0-8B65-85A949D5FF97@iki.fi>
	 <9b4395d8a6fd8abafaa74a4fd7542a0a1d2ae40f.camel@t-online.de>
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
 L2dpdGVhX3Byb29mFiEEirOWSf3d6fB6q3EmVa3qmdMF6s0FAml4juUFCQxAgakACgkQVa3qmdMF6
 s2qPQEA0krzDtCbl1cOGUlE6aBB4IKouFMrOtwIYMCY8uEJLsYBAJn9IXrpaO9MyQ/jFyn+7BeIOT
 M10vIiPMY4l4kXyiIHtFBGcmFua2Vuc3RlaW45MSAoRGllcyBpc3QgbWVpbmUgU3BhbSBFLU1haWw
 pIDxmcmFua2Vuc3RlaW45MS5pbmZvQGdvb2dsZW1haWwuY29tPojQBBMWCAB4AhsDBQsJCAcCBhUK
 CQgLAgQWAgMBAh4BAheAORSAAAAAABIAHnByb29mQG1ldGFjb2RlLmJpemh0dHBzOi8vbGljaGVzc
 y5vcmcvQC9NVExGcmFuaxYhBIqzlkn93enweqtxJlWt6pnTBerNBQJpeI7lBQkMQIGpAAoJEFWt6p
 nTBerN4rwA/jLnjzv5LwmAdlh8w1Ut3JkJSpEZC9ExSGDzoZpCxI0PAQD7Z/jjT2hRJKJUa1990my
 FvVm9rv0bDew8k2g3w25tB7RMRnJhbmtlbnN0ZWluOTEgPGZyYW5rZW5zdGVpbjkxLmluZm9AZ21h
 aWwuY29tPiAoc2hvcnQgdmVyc2lvbiBvZiBHb29nbGVtYWlsKYiWBBMWCAA+AhsDBQsJCAcCBhUKC
 QgLAgQWAgMBAh4BAheAFiEEirOWSf3d6fB6q3EmVa3qmdMF6s0FAml4juUFCQxAgakACgkQVa3qmd
 MF6s2pHAD9GIsVjgPXBa6hvgCNaFqFnVecUMCNuw0H6ki5xca50kEA/AipiYMnWYQYzBwWEwEnnLS
 gywV3XjvtZv8YuqNeD3sP
Organization: Privat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TOI-EXPURGATEID: 150726::1781873352-E4FF75DC-C85E7492/0/0 CLEAN NORMAL
X-TOI-MSGID: cbaf66ed-da03-4ddf-ac05-c9ca44f4183a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-online.de;
	s=20260216; t=1781873368; i=f-tornack@t-online.de;
	bh=75GBu/oNuF8D4riLpy3uqKTRdHT3K5vZ0zIqyzgtR7U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AFYqxf1Bv2jfZZSf5iLcPt1LZ9fjVHIA//4YcNkJTWDiZ/u0w2NeLJbvzB9zQPzvf
	 DFAOJa718qoZuyx0gW504IwatJz1q7jxdW0qcEsW6cb2OT5K4GB9IyQGYx2/s5eNYJ
	 hq2xE209LiCg8obccmikcKdsGzx2R/nZjrpAlZ+LXrwlEkVu7t7jbPQTOTHApoO1Do
	 rB5dVaIbhZOBALPgE3952G4bhGETPBx6+wrcAlwbJDvyr4d9aVrioSwYXWpyZqBLdo
	 ga+k29emGtGugFMWTQvtEf+jyTm69NMjcfEvZt5fDU+YO75aSnJPr0eJA8bsRruaa8
	 0tsqFWsubRegA==

Hi all

is there any update on this topic or open questions?

Thank you very much=20
--=20
Frank Tornack <f-tornack@t-online.de>
Privat

-------- Urspr=C3=BCngliche Nachricht --------
Von: Frank Tornack <f-tornack@t-online.de>
Antwort an: f-tornack@t-online.de
An: Pauli Virtanen <pav@iki.fi>
Kopie: linux-bluetooth@vger.kernel.org
Betreff: Re: [PATCH v2] Bluetooth: btusb: Add support for Quectel
NCM865
Datum: 25.12.2025 08:10:10

Hi Pauli

The reason for adding it to btusb_table is that without this entry, the
device (2c7c:0130) is being detected but defaults to a generic QCA
"Rome" configuration (0x190200), which lacks ISO/LE Audio support.

It is definitely loading the btusb driver, but without the explicit ID
match, the capabilities don't align with the actual WCN785x hardware.

Just a quick heads-up: I'm currently on vacation, so my response time
might be a bit slow. I'm mainly checking my mails and doing tests on
rainy days when I'm staying indoors.
