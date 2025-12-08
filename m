Received: from jkusti.notcom.org (jkusti.notcom.org [118.27.113.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D3F1A9FA8
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Dec 2025 20:01:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.27.113.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765224117; cv=none; b=d5NMvqxCMAPXKwuyPQddVK+Nix4xGO3fVaJ2e3vdOxoVyhPJQdMkXHZ7Q9PoNxTnQ/cMrsvLT7+X+V1bF+s1Bftdige+SMc0OitPtkzShXxrmlb+5A+SKa9x8v7TeWdbwe61hs++qyftjAx2gtCUappAfuCovfSm18KxR6qw1Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765224117; c=relaxed/simple;
	bh=1g/pE/s9/V8i3QdvEQ6s/QDieRHk8KE7M2HWKYXQJPs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oBoqdWPpbt4oxRLp0onoDWnc7mJfRZ8r3e5BPfXOO0Iamgnj/QYnLgViIBz9mvV0cSgjX45yjntuvo9t04tsIJOoYCriFDCyu0hFvJl8RdLBoPGj10oJ9FfiKKi82BHDWYLlZNIt1MxBaqPbKXTRTGb47J6C5Ls/8OvvAmwQ5nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=notcom.org; spf=pass smtp.mailfrom=notcom.org; dkim=pass (2048-bit key) header.d=notcom.org header.i=b49a205f73f09af5fde31f6781a721d6b26ace42@notcom.org header.b=N/ciU4GU; arc=none smtp.client-ip=118.27.113.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=notcom.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=notcom.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=notcom.org header.i=b49a205f73f09af5fde31f6781a721d6b26ace42@notcom.org header.b="N/ciU4GU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=notcom.org;
	s=jk; h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Reply-To:Cc
	:Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=0jhVdhG89KyOMZpT5OZ4EL1zqDQq/R29tG9PKSgPUPU=;
	i=b49a205f73f09af5fde31f6781a721d6b26ace42@notcom.org; t=1765224113;
	x=1765872113; b=N/ciU4GUIDFlX5G38VFXQxrGAfS4+XmLibQNUdYX5+W3IwBkpzd/2F9rNxSnq
	6Am5tOa7MuZWkXjfbPL3JUe3aEtQspF/IJlZ605+cy0m06x5vIsWVu1xcriznqari0lpeNdZe8sUx
	RKSp3fK8BUpPN0KxVcTPoWlxBz+uVmchgvwAWVtxpBylMKJEiz+y3tlaO4ImJkHKUWdKtAO+0wwU4
	8JJvMx3WYa8PdJQWvFZ5N9u0SfcSTs5iHveXGjDHcOmDBWRwW21aUBHeCPe3Ytyk96i0nQUAfO+U2
	aecWVT4rcqojWhhctGH8EYLUCHrDDUCl95aOTs+bVJeI7AGIAQ==;
Received: from submission.internal ([2400:8500:1302:775:a118:27:113:1533])
	by jkusti.notcom.org (Exim) with esmtpsa (TLS1.3)
	(envelope-from <vuori@notcom.org>)
	id 1vSh7R-003r8r-1c for <linux-bluetooth@vger.kernel.org>;
	Mon, 08 Dec 2025 19:42:01 +0000
Received: from a10d750d756b015054aa81d63d047a232e64e839 by sendhost.internal with local (Exim 4.x)
	(envelope-from <vuori@notcom.org>)
	id 1vSh7J-00000000dol-2IIP
	for linux-bluetooth@vger.kernel.org;
	Mon, 08 Dec 2025 21:41:53 +0200
Date: Mon, 8 Dec 2025 21:41:53 +0200
From: Valtteri Vuorikoski <vuori@notcom.org>
To: linux-bluetooth@vger.kernel.org
Subject: btrtl/rtl8761bu: latest firmware causes frequent disconnects
Message-ID: <ovf5xu5xw3rdoolcw4b2gz5qyithh5flgfketkrm6ai7572e52@lfxbtzodribq>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20241002-60-525451

Hi, after upgrading to Debian 13 which pulled in rtl8761bu firmware version
0xDFC6D922 (matches current latest in the linux-firmware git repo), my Logitech
MX Anywhere 2 BTLE mouse started disconnecting about every 2-3 minutes. I'm
running homebuilt mainline 6.12.59 + Debian-packaged Bluez 5.82 with a
Ugreen-branded BT USB dongle (VID/PID 2b89:8761).

There are no entries in dmesg regarding the disconnect. With bluetoothctl
running, it only says that device disconnected with "reason 0". Disabling
USB autosuspend makes no difference.

The symptoms largely match those reported last year with Xbox controllers when
using the same firmware version:

https://bugzilla.kernel.org/show_bug.cgi?id=219234
https://github.com/atar-axis/xpadneo/blob/a16acb03e7be191d47ebfbc8ca1d5223422dac3e/docs/BT_DONGLES.md?plain=1#L107

Downgrading the firmware to the prior version in linux-firmware (0x09A98A6B)
fixes the issue.

While downgrading does the job for now, are there any more recent firmwares
available for this controller? With Debian now shipping 0xDFC6D922 in stable it
seems likely more people may be affected by this, since the rtl8761bu appears to
be very widespread in USB dongles.

I can test other firmware versions if needed. Please cc me on any replies.

 -Valtteri
 
