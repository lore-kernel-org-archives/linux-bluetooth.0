Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06121583ADC
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788889409; cv=none; b=jphJKlWu4unbnTE0NMyyEXd5U7Kltmgror2Imebo+dvXEpwZBHaehLQ4fx/kSKC74qCipOhzR8XwNpHwI18lmuGYJ0Xlywcf6XTT0fcIsPdKBU6wSupSPwkwW+7z9pug21Ve75J6N79bQTJLC6Da07eOuf63wvrRjRFiJ2JnVSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788889409; c=relaxed/simple;
	bh=cXskDNcrfINTl+X9dXz2bbArFvkr004Nqks/7FyiEyA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=HO+UrncFvSL9US0remdUGhaEEH6Nc8BmkqyopGTeaKs4T112h3Ej5r7R+34m9nmZ6j+YHAO1bnohwYr0rVnRh9WBmUJJeReGPDopCv/hTHWPSdHSY9iZ4hQvcUr9O4ZT25JaSh7e8d28z+jSnnkIaWQXVO6rfX2sOgfTlkfaY8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=D8tn5anK; arc=none smtp.client-ip=185.70.43.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="D8tn5anK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1788889405; x=1789148605;
	bh=oQPm18zh06tZZe8iXMiiWqksfqWPMKfm3cO7Cyl2Zbw=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=D8tn5anKHPju8aE2YWTsyvja8BTTMUj692GHJhQK5mHyLG2o40c06ufV/HWz3YkHm
	 BMT7ya75lUp+IOU8KLXnpsWJUX5OnSIxOWH15+zMiFduH+jnx1DGx/vOFip0SQe28p
	 pOVfBevHm8DotW+wHKFEOzfr/QYYhoLqIKXxOpKJBM9FF8NJGqLM4xfOwJeyY0KgDg
	 DvKwzoYbyWVjrLHZ+GNBwhoSfwUTk07rozCWfeEdCqNg67ym+i9RA/5c2dXA/781jz
	 J+MOA4wyjxMLC2g9ZppuWkQcXkhbXLUQdFT2urEhGFq+XzI3Lsv2JtlhpENG6xFurV
	 rlJcR+Uu1sSBA==
Date: Tue, 08 Sep 2026 17:43:22 +0000
To: Ferenc Lengyel <dev@lengyelf.eu>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: "Vladimir V . Kondratyev" <vladimirkondratyev2@gmail.com>, Ravindra <ravindra@intel.com>, Kiran K <kiran.k@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>, linux-bluetooth@vger.kernel.org
Subject: Re: btintel_pcie: hibernation intermittently aborted by -EBUSY from D3 entry timeout
Message-ID: <20260908174316.11795-1-lsa.uz@pm.me>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: d2869251bf5248d72e348629794be88eab1ec1cb
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ferenc,

Two patches already on this list address exactly your signature, and they
fix different halves of it. Both are reviewed and neither has been applied
yet, so testing them is useful rather than redundant.

Your path is btintel_pcie_hibernate() -> btintel_pcie_suspend_late(
PMSG_HIBERNATE) -> btintel_pcie_set_dxstate(D3_COLD). After each 200 ms
timeout that function does not give up blindly: it falls back to asking
whether the controller reached the state anyway, because the alive
interrupt is known to go missing. The fallback is btintel_pcie_in_d3(),
which reads data->boot_stage_cache and not the register.

And boot_stage_cache is refreshed in exactly one place on this path: the
alive interrupt handler. So the fallback that exists to survive a missed
interrupt is disabled by the very miss it exists for - it re-reads a value
last written before the transition, three times, and returns -EBUSY after
the image is already on disk.

  Vladimir V. Kondratyev, v4 - re-read BOOT_STAGE_REG before the fallback
  check, so a genuinely missed interrupt becomes survivable:
  https://lore.kernel.org/linux-bluetooth/20260903192245.135310-2-vladimirk=
ondratyev2@gmail.com/

  Ravindra (Intel), v2 - move data->gp0_received =3D false out of the retry
  loop, so an interrupt that arrives late is not discarded by the next
  iteration:
  https://lore.kernel.org/linux-bluetooth/20260902042840.2432862-1-ravindra=
@intel.com/

I reproduced your exact three-retry signature deterministically on a
Surface Pro 11 (Lunar Lake, BE201 8086:a876) by dropping the alive
interrupt on demand, and measured the two patches per hunk: with only
Ravindra's, the missed-interrupt case still fails as unpatched; with only
Vladimir's, it passes. They do not interfere. I have also seen the failure
happen on its own, injection disabled, once in six s2idle cycles.

So my guess is Vladimir's patch alone will fix your hibernation, and it
would be worth knowing. If it does not, that is more interesting still:
it would mean your controller genuinely never reaches D3, which is a
different bug from this one and worth reporting as such.

If you do test it, a Tested-by would carry real weight. Everything above
is one machine, one controller, one firmware - which I have said in every
message I have sent on this - and yours is Panther Lake with 8086:e476, a
different generation. The two patches are being combined into a single
series, so there is a window in which a second machine can still be part
of it.

Your report: 22771256-6dcb-4ab9-ae77-3a88480e7d21@lengyelf.eu

Sergey

