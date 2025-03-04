Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BC727C878
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 18:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741112426; cv=pass; b=C3fU6jGlU93aAMxGa61g5nwEnw4r6v09Ioew6DmRAyCqN1c8dZEfMmqea0uuCOlDe6MjuqqbI+SGf4ZaihQ+Zu1m4PHrnX5ghrSZbXXtSz+tSEU5Oxfz2w6oymYZ5PCODPsuNkqLKvO2IZPncQu0Oia80XTTXKN3+I7xxczZ1+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741112426; c=relaxed/simple;
	bh=2ddPUGx8TvuhwMCUW042ZMEmKLuForXvZnGwbVoPygo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZbbPIqeaPj7+gPr3+Hpaf0J5FEu2Jvy9/LsiOt4dGV7V1POQhVSWQ9Gxxzg3gWEmAjI2j2cMcfr3nJGs4ya4T9neW4We+s/elhWS/BvVd3XPKAYnOdAYlHSWuwomYTjyBC6WrgHcImuqvqR+8Am+ApgTsrjWXIj/Jo28thGteCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=mV8RQmEO; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="mV8RQmEO"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Z6kW12My2z49Pwk;
	Tue,  4 Mar 2025 20:20:13 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1741112415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2geKMsC6pBhmIRaxSi9VB7GK8T7mVBstFE6FgqktCIo=;
	b=mV8RQmEO/VwSPWffzhXg/s1O/MAwtAZXKBOugRnLzua1E5oi4soF5S6NXP/V5xM9eaS+nv
	Fw7F97fpG9wA0FVpbDK9y51Jtw133Iux/7BsmTTJTjdUmVguGqP64vJqOFlzVFMd9zo4tX
	fH2ZDR8IY10k6XjTvecITVs80cNm9eZfdgCnN0B6M6G91OQluqXa2XwURBvusdR0JCn/Y8
	lUta5l6mzhjf6oituSxWwyoNaSQkdJyNfMKm9iwh+jNi9mD6CvAWuQvQwJRvz+x4mTyka/
	7AqnGD9WjNcQuAhUlKyiTCfP0Jenor9z2ZNapnQVgTdkUxztKEkPCbP1xl8zlQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1741112415; a=rsa-sha256;
	cv=none;
	b=SwWM8LEIB5grtJMKrzNhqoiKpePzscZaKzIDmuXmOsKuk2d1FWeOxrgR5fAh5mokiyQJnX
	qshulOyIRRScBoYLDlAzAjHUB0rqVo0LXxFq+u6bhxTurJW14jkRFtccqnf1tPTshus2Ri
	5SEM0Wmbt89kWXQYW5IRtNCByP00fyxYRXlBQI8fq+6TDKEsyXl9cgmMZL+ajutnz2YiF9
	qX9rbihgmiuxdt40r9wr/SlejXcQKVhkfI6RqtEGwmZH0eOskKMkuK4qaTgZqsui/NRqdj
	G/o2GCJUUSEYgLwD8rzspa5rYsFlzMLjVSLVmGn1xynxMQLIloY0nu3UXHb24Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1741112415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2geKMsC6pBhmIRaxSi9VB7GK8T7mVBstFE6FgqktCIo=;
	b=tE0/PyXPbTqMT1hle1O5DMGjxrUZHgHFi0Icaq/CL8dbwMdhXFjtioh6tM9vwCZ5w9ucyt
	bbn9ouvf6MOc+rfiTvdvb9uDQy6AY6fzeP11HNQVB1qrc2QEwuRpre5jMJeAunKmNLd0xU
	sDOQbSAq+ovecmGF0uWjNHn7wwX1ZIQywbk4BmE64aWViqSUcfc3Ke+GUMnIH2MPGqL+Bg
	YujeWG4HtDBMr6bvwyfG3ybW8d2J5U77hnnSejHRc6R6XIrbaDMxSCfwwyRVQPXQNICaPW
	Ktf5xoOR+38wK7N7SrizIx+OA888OX8WZrBGzATnkQURAZeaY02cKdv9rjDxoA==
Message-ID: <53bb8660d1ef946e568f538b988f58688e6b4c66.camel@iki.fi>
Subject: Re: [PATCH v4] Bluetooth: hci_core: Enable buffer flow control for
 SCO/eSCO
From: Pauli Virtanen <pav@iki.fi>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Cc: Kiran K <kiran.k@intel.com>
Date: Tue, 04 Mar 2025 20:20:11 +0200
In-Reply-To: <CABBYNZLLFG_2JZCYTpcspUp3fN-3=MFoUup-i4X9jBifddN=AA@mail.gmail.com>
References: <20250304162955.149884-1-luiz.dentz@gmail.com>
	 <CABBYNZLLFG_2JZCYTpcspUp3fN-3=MFoUup-i4X9jBifddN=AA@mail.gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Luiz,

ti, 2025-03-04 kello 11:38 -0500, Luiz Augusto von Dentz kirjoitti:

[clip]
>=20
> Looks like this is working when internally, so I wonder what is going
> on if you don't receive NOCP on Intel controllers, that said perhaps
> we need some way to detect if NOCP is not being generated, perhaps via
> timer, then disable HCI_SCO_FLOWCTL, the issue is this perhaps could
> cause hiccups at the start of the stream so perhaps we could do the
> opposite and always start without setting HCI_SCO_FLOWCTL and only if
> NOCP is generated then set HCI_SCO_FLOWCTL which can then be
> persisted, thoughts?

That's weird. The full btmon dumps are here:

https://gitlab.freedesktop.org/pvir/repros/-/raw/main/2025-03-sco-flowctl/s=
co-flowctl-intel-ax210.txt

https://gitlab.freedesktop.org/pvir/repros/-/raw/main/2025-03-sco-flowctl/s=
co-flowctl-rtl8761bu.txt

with Intel firmware

[    5.749140] Bluetooth: hci0: Firmware timestamp 2024.33 buildtype 1 buil=
d 81755
[    5.749146] Bluetooth: hci0: Firmware SHA1: 0xd028ffe4
[    5.792830] Bluetooth: hci0: Found device firmware: intel/ibt-0041-0041.=
sfi
[    5.792868] Bluetooth: hci0: Boot Address: 0x100800
[    5.792870] Bluetooth: hci0: Firmware Version: 91-33.24
[    5.792872] Bluetooth: hci0: Firmware already loaded
[    5.800638] Bluetooth: hci0: Fseq status: Success (0x00)
[    5.800644] Bluetooth: hci0: Fseq executed: 00.00.02.41
[    5.800647] Bluetooth: hci0: Fseq BT Top: 00.00.02.41

I checked now again with v4 of the patch, and result was the same: no
NOCP, so it writes SCO max packet packets and then stops. This was in
KVM virtual machine on Linux with USB redirection, but I don't think
that should matter as everything else works in this setup.=20

Enabling flow control only after observing NOCP for SCO handle sounds
safer. This probably needs timer, since if you write more than max SCO
buffers initially, I guess it's not guaranteed you get flow control
messages for each of them.

--=20
Pauli Virtanen
