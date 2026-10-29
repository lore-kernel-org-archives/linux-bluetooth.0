Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299211;
	b=luIvWSEAlzRm45qDP0JG9O422U9j/7zMaYoDNJAilObqHwhfNlRlFCxoHf47w9sGY3nr
	 pT88Np7sUWYDbXmI2HX8TTflGX/CUH+hz9K2ACIHatbIHixybRsDhTLQojQG+n/y0HDBO
	 dnrjkoQ/0O3cocmP8Lu2J7yX4N/iZwFBeZzHTSDdnhOrK1kNyF6aUVZHOisUWgf2u2ygb
	 CnN77GtpWdLy7YkcpwRPBjg5hWXuqo972f0WHYI8MmARWnm2rT1Gg3+i0ym0zx1n+XpkV
	 fR6aXlvHi3AQ0snbpqTHyij48XXSheapzaVMY0m06NAmC8EJrJILfa3KT3tZaLRagSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299211;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=6Qr2slpLJMIdJHB7HQ2pE2xrzIamHxwbjpzeT9Jb19g=;
	b=h0m87ycSpw0a6xjZbUuGqwr+yMQ+oPuPdl5M0Z4AEW2iDACmF+zqneGsQitko5n7MnHV
	 Tkk7J15Tt8YHWEGzYsaaBV06fwpQAvuRKO7FQatExB1fexaDqwwpFxUS1FcbpPN0umzwy
	 GJ8ZOYMAkVcvlum1J348B3dHSYKYA6tqusY5oe/3cm0tEFKgxVAj3bacHUILGEPF7728F
	 cBwoQnlNkx34BPMEvamNyzvMynlwEmvR+drLme/cgMR9+4lmBF5v99DHeCb915IQ4zwLz
	 ENV0qxiY7iCpy7M4UFX5bTsS4l2D4x7gga11FSq2+KUDtUh9V7/apps5T/3dqZzmwLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lxrZdXq0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF4E606A31A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lxrZdXq0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 899351F01826;
	Thu, 29 Oct 2026 18:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299210;
	bh=6Qr2slpLJMIdJHB7HQ2pE2xrzIamHxwbjpzeT9Jb19g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lxrZdXq0WgC04f5FWZWm4SjsN6KSZwop5PuQlG4s8u0OpqBe3ND63p7kXryjJmegw
	 gc6tmOMWjKEL2yVTRGlNvb/SMeuPpIDw+zpBCeen2GlCXKgMJog5MykfYNAxwPsp0h
	 xPdC6Dss5lD5Gzy5eNZYK+KDZEWKZCcqhlFL/a5gepXXvWjHOKwS4btejM6+GcHy7G
	 tNQrISKFXO36ItETv+2ZZ9tlGLZaQnJ6kIqPNpzsxoNwKqm//IYdwUC5PQu6jesp2u
	 Dn8Xu6EeVhEdu2Kvz2KHtWABaYncbXvuFMRUFfy7z3lbifskol+Ap3KNIUini3MSCq
	 ARLIFG0apr1gg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D2623808228;
	Thu, 29 Oct 2026 18:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 00/27] Run the testers under User Mode Linux with
 time travel
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179329920930.627977.12056796897465326563.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 18:40:09 +0000
References: <20261022154701.3959500-1-luiz.dentz@gmail.com>
In-Reply-To: <20261022154701.3959500-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 22 Oct 2026 11:46:33 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes test-runner run the kernel testers in a User Mode Linux guest
> as well as with QEMU/KVM, and with -T on a simulated clock: btvirt is the
> guest's time travel calendar, so timers and timeouts take no real time
> and timing is the same on every run. btvirt can also serve controllers to
> UML guests as vhost-user virtio devices sharing the calendar, e.g. for
> firmware simulators.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,01/27] tools/test-runner: Do not report filesystems already mounted
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=01a2794c5b5e
  - [BlueZ,v1,02/27] shared/tester: Time out teardown
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d32cf1e77713
  - [BlueZ,v1,03/27] mgmt-tester: Wait for LL Privacy setup to complete
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a2b5b7c7b756
  - [BlueZ,v1,04/27] iso-tester: Fix leaking socket watches
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9cd93aa69d97
  - [BlueZ,v1,05/27] l2cap-tester: Fix race in LE Client - Close socket 2
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a10a29556ce8
  - [BlueZ,v1,06/27] iso-tester: Fix busy waiting in PAST tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9b3856a85336
  - [BlueZ,v1,07/27] doc: Enable IPv6 in tester.config
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2362c4224ba9
  - [BlueZ,v1,08/27] 6lowpan-tester: Find the interface of the controller
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6cc3ff01132d
  - [BlueZ,v1,09/27] emulator: Remove -T option from btvirt
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ba940f323890
  - [BlueZ,v1,10/27] doc: Add btvirt documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=703331bde0eb
  - [BlueZ,v1,11/27] emulator: Add vhost-user backend
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1ce41b67dd13
  - [BlueZ,v1,12/27] emulator: Add vhost-user virtio server to btvirt
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=11199825bfdc
  - [BlueZ,v1,13/27] emulator: Add time travel calendar to btvirt
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d7ef45305b15
  - [BlueZ,v1,14/27] emulator: Add virtio console and time travel client to btvirt
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=faca01db81d6
  - [BlueZ,v1,15/27] tools/test-runner: Add User Mode Linux support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a7e9a42a791a
  - [BlueZ,v1,16/27] doc: Add virtio documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fe2d32320fba
  - [BlueZ,v1,17/27] shared/mainloop: Add idle callbacks
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=43593026bf84
  - [BlueZ,v1,18/27] shared/timeout: Run timeouts of 0 once idle
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3bce4ad01a01
  - [BlueZ,v1,19/27] shared/tester: Remove GLib dependency
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=941e0a26f1f9
  - [BlueZ,v1,20/27] emulator/hciemu: Remove GLib dependency
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=60eda0019a8b
  - [BlueZ,v1,21/27] tools: Build testers that do not need GLib with the mainloop
    (no matching commit)
  - [BlueZ,v1,22/27] shared/mainloop: Add deferred callbacks
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a2b4b1308069
  - [BlueZ,v1,23/27] tools: Add socket watches for testers without GLib
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b0c80a96d0a2
  - [BlueZ,v1,24/27] tools: Run sco-tester, rfcomm-tester and 6lowpan-tester on the mainloop
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e37f17751c75
  - [BlueZ,v1,25/27] tools: Run l2cap-tester and iso-tester on the mainloop
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=477642f6b5fa
  - [BlueZ,v1,26/27] doc/virtio: Update measurements of the testers
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=14bd6ab65f4a
  - [BlueZ,v1,27/27] doc: Split tester.config for QEMU and User Mode Linux
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


