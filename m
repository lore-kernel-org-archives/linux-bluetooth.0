Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF413655D8;
	Tue, 28 Jul 2026 14:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785247583; cv=pass; b=sZr9+CkYVslfYc0t9BsSyVas3wBPonVRQUbGTRLra8W0/g3F9/c0xo4xr/3UyAjvyXMAgZfhXOSVH2q5bC1pcO/+80HtnH3S51NdhgCgo9pvuDo+TRRGN7bDfzg/J5ipds1fn4aHs++E9Hwmn7/kI99xrWF6jVzkmSeTvgRbJWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785247583; c=relaxed/simple;
	bh=mPYxJ94xOzpiUOmZAE1UCxSfS+VruoJQxabHq2Di7ms=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=YpT00Vb6NiXgZ9fC0ejBixtayB6+JxN7sRqLXs8dKEh6asKLMG5DBuJGCvsUXIBdCqlgsSc70aQbQHBFOpxbqma1V6G8YrzSJF4mvGtk10uGw9GK8K3fCDi9m4uKLSujcEtvAFUrGWOUwf2C88ngsOHgHA41VlzxDb4Edq7ipwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=EVa2oQl8; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="EVa2oQl8"
ARC-Seal: i=1; a=rsa-sha256; t=1785247558; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dfZh9uh3PCaWM3hn6M8DhfkjkO7SCcBlPMELKyMXzyFEafD/3tCT3V2HOBT8dUFAVdtJxWUOYQv4VppSjfuBA6bcOLjzuFzDoEz8EIK5Y2+dnICrF7VG62img1bf7Dtyoj5EnRYWydL9hRHnlQmfOnqVpVq+VkD/tbiYcUxLTlI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1785247558; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=CYcm+1VQADQZhDXtTAnvGLMsxjZQq4SUgqmssOerQ3o=; 
	b=YEvKGJrYDx9/hvYPsVrozecQ6UOghDtNyQBZAfjkTqPuf63mBjkcPH+xXj/SDMOktCjPmbICK7llznKYy0Qwp2revjxNeOlvqTtnYy6Zn/rBE1n1jAekdSPAXOciflETpcySnBrc8YNTGq8jL9AookgN8NRGkg8btNlzqFKVBOk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785247558;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=CYcm+1VQADQZhDXtTAnvGLMsxjZQq4SUgqmssOerQ3o=;
	b=EVa2oQl8qfYys8CT9skQgryD0rLF6+1ArtJUiuFnGg7Dmy/4pQ3DXw3VnE9QAcIX
	O7Gai3+oOsDLi+fVcs3ecTsWVUDjQ8ifiP1XFeojLkuMEwfmY2aE4BR8VqzcylI/z8y
	Y2xfE9zT0Qz7mFBhMxRRGlgrkSxMXiGoqpoKXmaW0A8U7xHgD+w5ynMkiPAFK8vCyT/
	8X1OOCs+QUr2AbF8VUCUEBAPaXXp1JPHApIyFWh14+L6wFF27hAqbQCosBWboOBz1jo
	bN0Fi55I3JejmKq5L7FpP4uNDFoKa4J2Notw1LrSLvVFcKlbuUJD9oKTaWyuz9lKpIX
	Y9hJroEPIw==
Received: by mx.zohomail.com with SMTPS id 1785247556029509.12114283912604;
	Tue, 28 Jul 2026 07:05:56 -0700 (PDT)
Message-ID: <133c4858657c55b31affd4bff1cbd68f812de5e1.camel@rong.moe>
Subject: Re: [PATCH v2] Bluetooth: Properly disable remote wakeup for
 MT7922/MT7925 on Ryzen platform
From: Rong Zhang <i@rong.moe>
To: Rafael Passos <rafael@rcpassos.me>, Marcel Holtmann
 <marcel@holtmann.org>,  Luiz Augusto von Dentz	 <luiz.dentz@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,  AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, Chris Lu
 =?Big5?Q?=28=B3=B0=B8X=AAl=29?=
	 <Chris.Lu@mediatek.com>, Will-CY Lee =?Big5?Q?=28=A7=F5=ACF=BFo=29?=
	 <Will-CY.Lee@mediatek.com>, SS Wu =?Big5?Q?=28=A7=C5=BE=CB=AAY=29?=
	 <ss.wu@mediatek.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org
In-Reply-To: <DKA8F33O8HID.2UV2DWTLE6S48@rcpassos.me>
References: <20260701-btmtk-ryzen-remote-wakeup-v2-1-767ac7907472@rong.moe>
	 <DJRKO72HWZOI.QJYJUAC45QOJ@rcpassos.me>
	 <79D5F3E6-8F40-4422-BB2D-16691E377394@rong.moe>
	 <DJRP3YO7Y0WK.20KNRZIMX1CYK@rcpassos.me>
	 <F16A2A9A-A43F-45FE-8CC0-44A129360D47@rong.moe>
	 <DKA8F33O8HID.2UV2DWTLE6S48@rcpassos.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 22:00:48 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-10 
X-ZohoMailClient: External

Hi Rafael,

On Tue, 2026-07-28 at 10:17 -0300, Rafael Passos wrote:
> Hi again,
>=20
> On Mon Jul 6, 2026 at 4:39 PM -03, Rong Zhang wrote:
> > Hi Rafael,
> >=20
> > Hmm, interesting. My speculation is that it doesn't matter which option=
s are changed, but some changed options cause the BIOS to reinitialize some=
thing. Does resetting the BIOS settings to default help?
>=20
> I was unable to trigger the same issue again. It has been working fine
> (even when running without your patch). I believe the reset with bios
> config changes fixed it for good.

Oh, that's really good news. Cheers!

>=20
>=20
> > Could you provide more details about your device's USB and PCI topology=
? Does the NIC's USB connect to one of the USB root hubs of the SoC (i.e., =
CPU) or the chipset?
>=20
> I believe its a hub connected to the chipset.
>=20
> /:  Bus 001.Port 001: Dev 001, Class=3Droot_hub, Driver=3Dxhci_hcd/12p, 4=
80M
>     | ...
>     |__ Port 008: Dev 004, If 0, Class=3DWireless, Driver=3Dbtusb, 480M
>=20
> In the block diagram on the manual [1], Key "E" Wifi is tied
> to the AMD PROM21 CHipset.

Yes, and no.

The block diagram indicates that the NIC card's PCIe interface (note the
"x1") is connected to the chipset, without any mention of its USB
interface.

Based on the bus number (001), it's more likely a root hub of the SoC
instead of the chipset.

You can check the root hub's PCI path with

   realpath /sys/bus/usb/devices/usb1

Then you can cross-check with the PCI topology, i.e., `lspci -tnnnvvv'.

>=20
>=20
> > And I guess your device runs into the issue without any precursor? Once=
 boot, try running the script below to capture more clues into dmesg, and w=
ait for the issue to appear.
> >=20
> >     #!/bin/sh
> >=20
> >     ddcmd()
> >     {
> >         echo "$*" | sudo tee /proc/dynamic_debug/control;
> >     }
> >=20
> >     ddcmd file drivers/usb/core/hub.c +p
> >     ddcmd file drivers/usb/core/driver.c +p
> >     ddcmd func handle_tx_event +p
>=20
> Thanks for the script! I'm learning a bit with it!
>=20
> > I would do the below experiments if I had a buggy device like that. Som=
e extra hardware is required though.
> >=20
> > Connect another NIC (w/ Bluetooth interface) to the same M.2 port after=
 triggering the enumeration failure, and see if the enumeration failure per=
sists.
>=20
> It is integrated (soldered) to my motherboard.

Huh? How can an M.2 "Key E WiFi" expansion card being soldered to a
"vertical M.2 socket"?

AFAIK, once the metal shield(s) are unscrewed, it should be replaceable,
see
https://www.techpowerup.com/review/asrock-b850-steel-legend-wi-fi/4.html

But it doesn't matter anyway since the issue has gone ;-)

Thanks,
Rong

>=20
> [1] page 10 https://download.asrock.com/Manual/B850M%20Steel%20Legend%20W=
iFi.pdf
>=20
> Thanks,
> Rafael Passos
