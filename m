Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE10C357D07
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Sep 2026 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789465582; cv=none; b=pciRx/wc9cSHiz3QZftY8atn2T+LQjTRzzV1YIa00W6Q6sT7RKVheRiIak8NROaShtvlErJU9cR9wgA9hOvMcvp9ukPDIgjITG699lvEmcGucAxhb/ma/8PiiN+0PoDhGjIvbn+JCFd/QLbnppLOVDbSkO3quiisMhy8l18uPl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789465582; c=relaxed/simple;
	bh=a2AoiY1PAOg4j7SNUX8UPo4K1WnAkOtVyQI5V3rYvrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CV5vIWPo3EIoBuUTybLUseAEy70ZKMOqAliJfl/7ghBEOOdCIf23McVhEztRYhIoptJ19XZfigB/2YoZ57fQz5tiZOxSw0Ifqc2RS6FkgeBvu2jdmgkkifnTSL8AYtOqUkcf3xMBYtsEYJNolu0logX3FlO54tfnz+Vt2YwPLC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=PBVRueHZ; arc=none smtp.client-ip=188.68.63.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="PBVRueHZ"
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4hkcZP2KSrz6G5n;
	Tue, 15 Sep 2026 11:45:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1789465517;
	bh=a2AoiY1PAOg4j7SNUX8UPo4K1WnAkOtVyQI5V3rYvrk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PBVRueHZBNAWf5ime1+ZsSNRgcGDcY9ZilqTK0/HV8oVyh1Oj0ZWeRfg4qfW90qPf
	 9NOFKIMpgAFsAg4dP8LvbD9rUP5hrlLS6rZ56dF++mUyDEJRMUD0djwVy7qUlpiQYx
	 L7dUAWgu+6eV2Cod+i4zwpMV0VqoBUXXvd8QV/tuFIS07hNfWhXey4O11mw2VOr91l
	 zmJbZLqreNACqmGuL58wOAc9EyCRtRPafCBqKRgLS+sNOtqHM/gzJPllc66a6ZIPaW
	 8O+Z/kRBpZP56YyKtHdlfspOlSu5eEwJDVjHpkPIW3b9qUzO0v7/8xyNsJrLBNn+cc
	 s2DR5DwF+kfGQ==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4hkcXs4FnJz501j;
	Tue, 15 Sep 2026 11:43:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.901
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4hkcXr5QPpz8tch;
	Tue, 15 Sep 2026 11:43:56 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id F2DD75F93E;
	Tue, 15 Sep 2026 11:43:47 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <67749e24-a652-4b6b-b4f4-a891e65e72da@leemhuis.info>
Date: Tue, 15 Sep 2026 11:43:47 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] 7.2: restore from hibernation hangs while btusb
 boots Intel AX210 (8087:0032); 7.1 and 6.18 fine
To: David Lomas <david.s.lomas@gmail.com>, linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, johan.hedberg@gmail.com,
 regressions@lists.linux.dev
References: 
 <CALjEBWRoqHa=833_dpDxaWpj-tAiAhLuLZBfRQkOkSGgGF5gQA@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CALjEBWRoqHa=833_dpDxaWpj-tAiAhLuLZBfRQkOkSGgGF5gQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <178946542834.1252613.7405697413254351868@mxe9fb.netcup.net>
X-Rspamd-Server: rspamd-worker-8404
X-Rspamd-Queue-Id: F2DD75F93E
X-NC-CID: ngNhoSTvAE9w+Eb3MFz2M2vQSXnrEBGDYdEZcgnK7K4d4hV1jK0=

Hi! Thx for the report.

On 9/10/26 21:37, David Lomas wrote:
> 
> My first message here, hope this meets expectations—I had a bit of
> help from you know who...

Well, no developer answered yet, which often means: they have no idea
what might cause this. You might want to wait another day or two for a
helpful reply, but if none is forthcoming, you most likely will have to
run a git bisection to identify which change causes this:
https://docs.kernel.org/admin-guide/verify-bugs-and-bisect-regressions.html
https://docs.kernel.org/admin-guide/bug-bisect.html

Ciao, Thorsten

> Since 7.2 my laptop hangs hard while resuming from hibernation, and
> the hang goes away if btusb is not bound to the Bluetooth controller.
> 
> #regzbot introduced: v7.1..v7.2
> #regzbot title: restore from hibernation hangs while btusb boots Intel
> AX210 (8087:0032)
> 
> Hardware
>   Dell XPS 13 9360 (BIOS 2.21.0, 2022-06-02), Kaby Lake, xHCI
> 8086:9d2f (Sunrise Point-LP).
>   Wi-Fi/BT card is an Intel AX210
>   Bluetooth controller is USB 8087:0032 on bus 1 port 3, driven by
> btusb + btintel, firmware intel/ibt-0041-0041.sfi ("Firmware Version:
> 202-5.26", linux-firmware 20260810).
> 
> System
>   systemd 261.2
>   No BlueZ is installed: the controller is only ever set up by the
> kernel's own HCI_AUTO_OFF path.
>   Root on LUKS + btrfs, swapfile with resume_offset,
> HibernateMode=platform, mkinitcpio busybox initramfs with the resume
> hook (systemd-hibernate-resume is present in the initramfs).
> 
> Kernels (Arch Linux packages, unpatched apart from Arch's config)
>   bad:  7.2.2.arch1-1, 7.2.4.arch1-2
>   good: 7.1.4 to 7.1.10 (weeks of daily use), linux-lts 6.18.49 (12/12
> cycles under the reproduction below)
> 
> Reproduction
>   systemctl suspend-then-hibernate with HibernateDelaySec=2min, lid
> open. After the timer wakes the machine from S3 it hibernates; power
> on, unlock LUKS, the boot kernel loads the image and hands over. On
> 7.2.x the restored kernel then stops within a couple of seconds,
> within the first three hibernate/restore cycles of a cold boot (it
> happened on the first cycle twice, the second four times, the third
> once, out of seven tests). Screen is black, backlight off, no
> response. Nothing is written to the journal. With efi_pstore +
> hung_task_panic=1 + softlockup_panic=1 + hardlockup_panic=1 armed and
> a three-minute wait, no detector fires and nothing ends up in pstore.
> 
>   With no_console_suspend, a good cycle shows these lines on the console:
> 
>     [ 2043.009649] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
>     [ 2044.588080] Bluetooth: hci0: No support for _PRR ACPI method
>     [ 2050.400042] Bluetooth: hci0: HCI reset during shutdown failed
> 
>   and eventually the desktop appears. On a bad cycle, I see these 2 lines:
> 
>     [ 2750.173700] atkbd serio0: Failed to deactivate keyboard on isa0060/serio0
>     [ 2750.959900] Bluetooth: hci0: No support for _PRR ACPI method
> 
>   and then a solid lockup.
> 
> Other info
>   - /sys/power/disk = test_resume (write the image, read it back and
> restore in-kernel, no power-off), each preceded by an S3 cycle: 8/8
> successful on 7.2.4.
>   - Fresh boot, `modprobe -r btusb` before the first cycle: 4/4 clean
> restore. `modprobe btusb` again in the same boot: hang on the 2nd
> cycle.
>   - A systemd unit that unbinds the two btusb interfaces before
> sleep.target and rebinds them after the thaw: 4/4 clean, Bluetooth
> otherwise usable. This is my workaround for now.
>   - Thermal-zone state (7.2 moved thermal zone resume earlier) was
> tested and does not appear to be involved.
>   - At every S3 wake on this machine btintel re-downloads the firmware
> (~1.4 s); in suspend-then-hibernate the hibernate starts while that
> download is still in progress.
>   - Plain `systemctl hibernate` (no S3 first) has not hung in the few
> tries I gave it.
> 
> Happy to provide full dmesg of a good cycle, try patches, or collect
> anything else that helps.
> 
> Thanks,
> 
> David Lomas

