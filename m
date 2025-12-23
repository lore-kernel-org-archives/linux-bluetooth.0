Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5CD221546
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Dec 2025 21:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766526641; cv=pass; b=ftn5W9ndXDGdIdxotz6AaILoXiJkbf9mdkhY2ALzj2LFy7S5+gJ3uy+L4szGWhphmuFvzKsVhlq7XGunGGzyfZO5Kahe2Wjd2BpCxtVkyyBI/GYcPAmznvDhKKg8/iAmO9U+QQlQD9JN++HN5N4MEsnQwIGogtGHJty4S6/QJRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766526641; c=relaxed/simple;
	bh=WD9pcGR5DodpRsxx5Jn0h26hU0CJj6K6vAIdqe76t4k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=cZ18mkGSIF/rCR5Efzi2eiIdIMKU4TweHEI4NuF4XOXaJM4wwSOdeQNUaoNPLCUNSVR3XsIru9Ivn7mhTnLQUgEwM8nBu1rjVp5xu+vnLCCaPakj3fWnd81zJSGPbYfz0JzHvq+4yE5JefB9S0uXBmPhxJT56kjlQX7MydhQxrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=LnlvTT6A; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="LnlvTT6A"
Received: from ehlo.thunderbird.net (unknown [193.138.7.194])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dbTFy0p46zyR8;
	Tue, 23 Dec 2025 23:50:29 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1766526630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WD9pcGR5DodpRsxx5Jn0h26hU0CJj6K6vAIdqe76t4k=;
	b=LnlvTT6AxBryOrxj/3Ic3ViOaEeEjWvhD+h0tBD27GNAD3lwcUMbQZum13ddialPijFFVQ
	CewtRKJI7VY+sstuWLgC041GwCOKLCGxwkQyG7qWNiOyD+Mt8xlktyKKbcz+iXuLnX58e2
	v1Grr4KnlTbGHBhhvmmcCFzgO96JeLU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1766526630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WD9pcGR5DodpRsxx5Jn0h26hU0CJj6K6vAIdqe76t4k=;
	b=ATqxY6XsdtA8zfNndqWjplZ9SHQwVdmcmy5Ylu9r4crM5p3Z+SPqrMOk0COeHfxFpIFwlb
	mn5HW6+MvWR8Kx5I9knQ9l21QjGeXG7zjdYeevInEplwctCetUPzCusOEiJNvDsegk86I/
	y6q61nTKGHeD0Bjy7i9VMnlihSILbus=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1766526630;
	b=Hm0mQNuckMRJvagnsFyuOvUuLGXyUzIaD8p7YA+0hgT1Q8cDupxRtUCB2SgjF8PZRNfE8I
	MZMwBABlHtlhB1m2+m+YovFLNYQbhGsM2Tt2gS4sKGpxpAB4ykxcBuRoP9+4wjuKSDUVbf
	lW2rX5ZFKUIJNNNAKfg/UthLvljZL98=
Date: Tue, 23 Dec 2025 21:48:44 +0000
From: Pauli Virtanen <pav@iki.fi>
To: f-tornack@t-online.de
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: btusb: Add support for Quectel NCM865
In-Reply-To: <2051d4d464090c4a84d508e7648e9580f50c14a0.camel@iki.fi>
References: <694a366a.e90a0220.1a6835.f67f@mx.google.com> <20251223094535.91725-1-f-tornack@t-online.de> <a0ee7d9d9451215a38cdf51c60691f3d4ab433ab.camel@iki.fi> <31553bc66935b6287f0723984388a98b5f720e39.camel@t-online.de> <2051d4d464090c4a84d508e7648e9580f50c14a0.camel@iki.fi>
Message-ID: <7B3FF8A1-0D76-40D0-8B65-85A949D5FF97@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

23=2E joulukuuta 2025 13=2E27=2E49 UTC Pauli Virtanen <pav@iki=2Efi> kirjo=
itti:
>Hi,
>
>ti, 2025-12-23 kello 13:38 +0100, Frank Tornack kirjoitti:
>> Hi Pauli,
>>=20
>> Thank you very much for your quick and helpful feedback on my patch=2E
>>=20
>> Before sending a v3, I'd like to clarify a point=2E In the bluetooth-ne=
xt
>> tree I'm working with, an entry for the USB ID 2c7c:0130 already exists
>> in the quirks_table=2E
>>=20
>> However, this entry alone does not seem to be sufficient for the device
>> to be correctly initialized in my setup (tested with a DKMS module on
>> Arch Linux)=2E I found that adding an additional, identical entry to th=
e
>> btusb_table resolves the issue and allows the module to function as
>> expected=2E My v2 patch therefore adds this entry to the btusb_table=2E
>>=20
>> Given this, I'd like to ask for your guidance on how to proceed=2E Shou=
ld
>> I submit a v3 patch that keeps the entry in the btusb_table and
>> explains this necessity in the commit log? Or do you perhaps see a
>> better approach to address this specific behavior?
>
>That's surprising, usb_match_id() returns the first match so second
>identical entry should do nothing=2E

Looks like I missed v2 added the entry to btusb_table, not quirks_table=2E

So the change may be right, although I don't understand why quirks_table i=
s not consulted=2E There's maybe already id->driver_info present, but where=
 would it come from? Or is it loading a different USB driver than btusb? Wo=
uld be good to understand why=2E

>
>https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/=
tree/drivers/usb/core/driver=2Ec#n815
>
>I'd suggest to double check the patch actually does something, eg=2E
>change the added entry to `USB_DEVICE(0x1234, 0x5678)`=2E
>
>If it does something it's necessary to understand why=2E Easiest would be
>to add some printk(KERN_WARNING "some message") debug prints to
>suitable places in the code to trace what goes wrong, or use some other
>debugging mechanism=2E
>
