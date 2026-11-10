Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317588;
	b=Zq6trdEvue7UNxzI6di0gR+wXb1TKi3ja3w/25mjIMQf7IcOUhpbPKcAnDqQymWyDiZa
	 5UeCddGaRIV5H9bW/+wNPxLaz9Cv5tlx7Vy21Ui2gjYDddzXrpIeGXpW+SwFVuDAOqG3O
	 Izhbm+p/DPDtdCBzAxC+otXRTvAPGtjlKGxBJoGqf/669ZMCcQDyYwSajoymHSr2YUhZk
	 kAzyvU+Tb8PQk0eBuGL5BjR3keCUsgonD7c0amvHbrhMDA1MlkWpffliSOBGIzvnZGoFk
	 2+DH8c8dDJeqEcutCUdaTmzI1b4qZ4k7/0/PvxVBuvxXnnCBeZr4ycv+BWVqfciq3Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317588;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ewK0soXt1rjG/TdFkyB4l7pXKruBKQUqeNsDG0csNS0=;
	b=b5HFeNgczY/eGlhTDsnw368U+xRAMbTtPGEnGoT2pj0IMWm3ildxMWr5VpM+0RnExb8i
	 Q0lO5JDGLmlv5xuEJ7VwF4bgTpdm2NUoH4Jjq0i5XB+LPfW7L8dNmJvRaDBftJsaL+1WA
	 rocUPI+7f3gpnHMWQSDcCHQywD0JwuhcP42YCjpAUw3+O11GjBFLo4fJ9Vrvafsb/h0Te
	 8TIMfQ+yZd+aMgoXVoR1eK2X7QAQXq/dMPFo/EYdW2jGxtvIpl1paeRbFywXKfFLMnkQ6
	 Kr4jzV9DJrSzaiADKYj5i0+0bABkLh2rf0EFiAFEb6sYLaFd5ElazpCk0pmoE7jWCkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=modelmiser.com;
	spf=pass smtp.mailfrom=modelmiser.com;
	dkim=pass header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=kaY8zVdd;
	arc=none smtp.remote-ip=185.70.43.98
Received: from mail-4398.protonmail.ch (mail-4398.protonmail.ch [185.70.43.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C61F606B2CE
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 13:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C61F606B2CE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=modelmiser.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=modelmiser.com header.i=@modelmiser.com header.a=rsa-sha256 header.s=protonmail header.b=kaY8zVdd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=modelmiser.com;
	s=protonmail; t=1794317584; x=1794576784;
	bh=ewK0soXt1rjG/TdFkyB4l7pXKruBKQUqeNsDG0csNS0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=kaY8zVddtXhEItDTfkFZyyi4nToIO/YgbbVR07yy0NsEH5jNMrs9rSea4vNz2U1Ge
	 3NlJSk/2R/78+uakHtT4kcdt2Qd2r69ZdvoSRyDT8/ddZ0O8siPSFBBWOptPg3jpAI
	 0As81k13kSKcc0DYeqCVFk77zlyRefWrma0ksN1Cma2uVjWiwCeGEdDJoGDzqx8ZmK
	 le4Tx4b10xBjRkNdJTYRGMRTGiimgYDFOaX+dzC9PuvC2jcRWNvgXVjxO9zuP1X2Sg
	 2oa6LmEgcm4e6KXatUIzwRIuwKhLLSv1YYPiiR7ppQQyo4sUuA/nDc7hBxmZ6R62bl
	 aNPz0s6xgrvaw==
Date: Tue, 10 Nov 2026 13:33:00 +0000
To: Cen Zhang <zzzccc427@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: Chad Aldreda <ca@modelmiser.com>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, jjzuming@gmail.com
Subject: Re: [PATCH] Bluetooth: vhci: Serialize packet reception with device creation
Message-ID: <20261110133255.1347825-2-ca@modelmiser.com>
In-Reply-To: <pm-bluetooth-objects-candidate-0253-v6-ffe55995e8c517fb1d86@gmail.com>
References: <pm-bluetooth-objects-candidate-0253-v6-ffe55995e8c517fb1d86@gmail.com>
Feedback-ID: 232753253:user:proton
X-Pm-Message-ID: 76af16c8e9d5b6c383691f8a23e20f25d7e44237
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat, 24 Oct 2026, Cen Zhang wrote:
> An incoming packet write can overlap the delayed default-create work
> scheduled by vhci_open(). If registration fails before acquiring the
> registration reference, the following order is possible:

The use-after-free reproduces on mainline without added delays, and
your patch removes it.

Tested on mainline v7.4-rc1-672-gd48723711bae, whose hci_vhci.c
matches bluetooth-next at 983f3fcb1282, on x86_64 in QEMU (4 vCPUs)
with KASAN, lockdep, DEBUG_LIST and kmemleak. A test program opens
/dev/vhci and creates the controller by writing the vendor packet
0xff 0x00, which runs __vhci_create_device() under open_mutex like the
default-create work (fail-nth is per task, so creation was driven from
the test thread rather than the delayed work). Fault injection
(failslab with ignore-gfp-wait=3DN, and fail-nth on the creating thread)
fails one allocation inside hci_register_dev(), so creation frees the
hci_dev it has already stored in data->hdev and returns -EBUSY.
Meanwhile a second thread keeps writing HCI event packets on the same
fd.

Without your patch, 300 cycles (295 with a failed registration) gave
42 KASAN reports: use-after-free reads at the same four sites in
hci_recv_frame() called from vhci_write(), 10 or 11 at each site. With
your patch, 300 cycles (296 failed registrations) gave none.

With two test-only delays, msleep(50) after "data->hdev =3D hdev;" and
msleep(100) at the start of hci_recv_frame(), every cycle with a
failed registration hits without the patch (39 cycles, 156 reports at
the same four sites; a verbose run shows each is an 8-byte read), at
both an early and a late allocation failure in hci_register_dev(). The
writer saw exactly 39 writes fail with an error other than -ENODEV, one
per failed registration (the errno itself was not recorded),
consistent with the HCI_UP/HCI_INIT test rejecting them. With the
patch and the same delays, 170 cycles (161 failed registrations) were
clean, and no write failed with anything but -ENODEV. These delayed
runs are the decisive comparison.

No lockdep, DEBUG_LIST, kmemleak or hung-task reports in any run with
the patch, so holding open_mutex across hci_recv_frame() caused no
lock-order report here; open_mutex has no other users in hci_vhci.c.

Not tested: the delayed default-create work itself (creation was
triggered by the vendor packet, which takes the same path under the
same mutex), registration failures other than injected allocation
failures, ACL, SCO or ISO packets (only event packets were written),
real controllers or btvirt, other architectures, and a build of
bluetooth-next itself (compared at source level only).

The test program and this report were produced with an AI assistant
(Claude Opus 5.5), which also did the runs above, including the
unpatched comparison. I ran the final version on the patched kernel
myself and got the same results. The test program is available on
request.

Tested-by: Chad Aldreda <ca@modelmiser.com>

