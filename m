Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE05F3B71DD
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788102970; cv=none; b=DScUnyZniHYAYOC3Sbb8fGjAXm5Z2WfMc0pii4odztu02PzIEXWHaBROjoOMXVUIUXoBLeASn7tPJr/WTFZ7QW7jdBLvecHDfk9GZoZ2n620/GLOkeAxclzzBhZutA3bbFkNA3zNrJtguPPbuRx87hD/iozccjk/RGzeiKsFV80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788102970; c=relaxed/simple;
	bh=pZV5hrfKKHFiDRWMOh/2zNybjRfx4NEcdVEufL221fw=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=qEo88hxDDTF3PAlJVFdniPVesrPnmJh7WTP0pQIzm8Y2Q9u4aHyl22ffzTYjla+S8IEQXjOWHB3t3Nuw34s9hyE6Oo1b5jwbpKJH8pu3v2vndrfETn5EtZfpt0bjNR4bBa9B9Drc2+nNt//D/0wjyAAtPtEzABq7Dxi6dXoOC7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=eDdd862M; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="eDdd862M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1788102965; x=1788362165;
	bh=Eg4sUp4vaOvNKyvP2sLV47ehNVyZFA3gOLqPonrsOh4=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=eDdd862MM8ApCOvY0RqeCNLYEhgVyu2rTzyvL4TirZMba1SdbTTbypuE0+afWp2AC
	 DwqCYlYoWr7t/hhxjUmhBxSXTAI1lFaLYChOWf5wIdN/c3HUAsXEUbzGAFwWUrRimR
	 bfBBLJpaOf2lZXZ/zP/2AK0R04v048D3NPGYsHptwGnfiZN21S9ecvXcR6RxSSPa1j
	 psDs55PJsLOOnY8o0/AmWuLA+/5T0CDhtSDP5jsUr5Yr7u4PNxiifKPrb9S0ZsXwbH
	 cDXnLYb5kjJlOHIaStx0XKH8FfzDnAQIth5/7UzL/hQN4siNBIWxM+TImXwoLVvHgc
	 RKRHswvoTvlAA==
Date: Sun, 30 Aug 2026 15:15:58 +0000
To: "Vladimir V. Kondratyev" <vladimirkondratyev2@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, Kiran K <kiran.k@intel.com>, Tedd Ho-Jeong An <tedd.an@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>, Arnd Bergmann <arnd@arndb.de>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
Message-ID: <20260830151550.44687-1-lsa.uz@pm.me>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: 8ffdbec19789efc7f8e6da190c92adcd4fbdc707
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Vladimir, Marcel, Luiz,

This patch is four months old and has had no reply other than the CI
bot. It fixes a real failure. Here is a report from the field and a
test of the patch itself.

Hardware: Microsoft Surface Pro 11 (Intel, Lunar Lake), Intel BE201,
8086:a876 rev 10, firmware timestamp 2026.8 buildtype 1 build 113003,
SHA1 0x08f159a0.

The failure, as it happened here on Ubuntu 7.0.0-28 before any
workaround existed:

  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry =
count 0
  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry =
count 1
  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry =
count 2
  btintel_pcie 0000:00:14.7: PM: pci_pm_suspend(): btintel_pcie_suspend [bt=
intel_pcie] returns -16
  btintel_pcie 0000:00:14.7: PM: dpm_run_callback(): pci_pm_suspend returns=
 -16
  btintel_pcie 0000:00:14.7: PM: failed to suspend async: error -16
  PM: Some devices failed to suspend, or early wake event detected

One device returning -EBUSY aborts the whole system suspend, so the
machine simply does not sleep. The workaround in use here since then
unloads btintel_pcie from a systemd sleep hook.

On the frequency I have to be honest rather than useful: it failed on
2 of the 3 suspends attempted before the workaround was installed, and
this week, on 7.0.0-30 with the workaround disabled, it succeeded 7
times out of 7 (3 of those with an LE scan running). Same firmware,
and no btintel_pcie change between the two kernels. So I cannot give
you a reproduction rate, and I am not going to invent one.

What I could do instead is exercise the exact path your patch touches,
deterministically. Method, so it can be judged:

  - built v7.0 drivers/bluetooth/btintel_pcie.c out of tree against the
    running kernel's headers, unmodified apart from the debug knob
    below, and confirmed it loads and works;

  - added a debug-only module parameter that returns from
    btintel_pcie_msix_gp0_handler() before the boot_stage_cache
    refresh, and only while alive_intr_ctxt is BTINTEL_PCIE_D0. That
    leaves boot_stage_cache stale and gp0_received false, which is
    precisely the state a genuinely missed alive interrupt leaves
    behind, while the controller itself still reaches D3.

Without your patch, the emulated missed interrupt reproduces the
production failure exactly:

  Timeout (200 ms) on alive interrupt for D2 entry, retry count 0
  Timeout (200 ms) on alive interrupt for D2 entry, retry count 1
  Timeout (200 ms) on alive interrupt for D2 entry, retry count 2
  btintel_pcie 0000:00:14.7: PM: failed to suspend async: error -16
  PM: Some devices failed to suspend, or early wake event detected

With your patch applied to that same build, and nothing else changed:

  PM: suspend entry (s2idle)
  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry =
count 0
  PM: suspend exit

One timeout, then the re-read observes D3, set_dxstate() returns 0, and
the system suspends and resumes normally. That is the difference the
two added lines make.

The debug knob is a test fixture, not a proposal; I am happy to send it
to anyone who wants to reproduce this.

Worth noting that btintel_pcie_set_dxstate() is byte-identical in v7.0
and v7.1-rc7, so this is current, not historical.

Tested-by: Sergey Lebedev <lsa.uz@pm.me>

I have the hardware and can re-test any revision of this patch.

Thanks,
Sergey

