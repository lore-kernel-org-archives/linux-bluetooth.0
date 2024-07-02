Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79B22AF16
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Jul 2024 13:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926694; cv=none; b=AKzPOjJ9Iku5CEgM10o4BL3cd7ogXP8x4y78lP13Yvo4ZkBsNtKF8NvMeIgGJyiLaGmNUkhBGriS6p5161h/+DdSaPNAZWcTU9Zx87ydiTguNdzCqY12cF+gp9TXHfX7bAZIbAeaeo4/ca6Vz2s35MSgyhmg40tv6RCWkTQD6Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926694; c=relaxed/simple;
	bh=l3EmeKcAJLg+UonzWeL/Sbz6oogrRn6jxhVBZ9HEOrI=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=pbZlO7YK1rfjw7n1g158mm+ccO+fZ18KFLaGPaT6opx4zfcpqdJXKxK9I+RZuMKw8o+PQJ0fMzljgapT33Zizn7fzgvRYCF6mx+121Tp5y0+dX92+P0rjjQTxc4jHaxg+zG3vdb+v9B2xnY2GS8hbPmhm6qT8mmUZEutWFxCLeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=WM9AvcSE; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="WM9AvcSE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1719926691; x=1720185891;
	bh=ALQSQOoBk2bY6okwZ4XVDV2rQurkamxSUfUed9D8LvE=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=WM9AvcSE9EmxZo/A7JS2yS8ltBbMIFMZg3qNs/4dpKtiqEUV40ULnsAVfiKom53du
	 XPr/5qD0OodKX3/P1zssI6x9JDokUfU4yG8ZMLh+5bzNhubKxTkJGzQuLyKgHf6XpE
	 1ZoNYOHc9M7irS5OYoXN77v7IpR+/aevWsyhOPll3gkx25dD9X7nfn8vsvgBUuhzeF
	 +BC7FHnJdQtZ9NcUS1e/zHKehWOROKmi55jRwjWeBnO64bWXEd/tY4G3x2c231Xo+k
	 pPpiz8LDXFH2bLhQu3R6c1fznoJchBM0n/l0lP1w6VzN8QxLbQLQJhN6Ctq+qxDnWw
	 r5uJFmOcsiedQ==
Date: Tue, 02 Jul 2024 13:24:47 +0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: lexicdark@proton.me
Subject: Issue with Logitech MX5500 (recurring)
Message-ID: <Wz8HSZhvOzF1mcJnF44ilQFAE_utAwvRXYILQZzH_sGhEV4tGHH0duomsVNwj5aa-OzSJFCU1ZqbCZkbtqzGXJbUmVbwMgLjVqx9BmhJI3s=@proton.me>
Feedback-ID: 102303237:user:proton
X-Pm-Message-ID: 7a052a983e4b1a538442f4c6409a3b7d0fc5495f
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Solution requested:  Please remove the entries for the logitech MX5500 in=
=C2=A0/lib/udev/rules.d/97-hid2hci.rules again (and please don't put them b=
ack in later)
This issue now keeps coming back every time a bluez update is pushed. And i=
t has been going on since I have had it and reported to the Debian forums s=
everal times (but that has been useless, at best). It had been removed from=
 configs. about a decade ago then it regressed when someone put it back.
Any self respecting Logitech MX5500 user wouldn't install bluez unless they=
 had to (for other devices).
If I edit out the c71[bc] entries for the 046d device and the keyboard and =
mouse work again. These devices never have (and likely never will) work wit=
h this forced mode switch. The devices only appear to work in the raw mode.=
=C2=A0 hid2hci --method=3Dlogitech-hid only stops the device from working b=
ecause the hardware doesn't actually support it (supplementary: likely a to=
o early BT implementation, it has it's own bluetooth usb device which is to=
 talk with the mouse and keyboard but it seems you can't use it with other =
devices, and the mouse and keyboard don't work with other BT dongles, at le=
ast as far as I have tried).

lsusb=C2=A0
Bus 007 Device 004: ID 046d:c71c Logitech, Inc. Logitech BT Mini-Receiver
Bus 007 Device 003: ID 046d:c71b Logitech, Inc. Logitech BT Mini-Receiver
Bus 007 Device 005: ID 046d:c709 Logitech, Inc. BT Mini-Receiver (HCI mode)=
/lib/udev/rules.d/97-hid2hci.rules
first two are mouse and keyboard, c709 is the dongle.


Thanks,
Alex
