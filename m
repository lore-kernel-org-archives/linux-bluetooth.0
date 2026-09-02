Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17D62C11E4;
	Wed,  2 Sep 2026 07:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788333881; cv=none; b=SSCVMdDCGMZrhJvOxGDgYLHyE0Cf6O7r1qoZlekJg841dd+PkLcCyPbygetrltwCFm15pJKh9McpV1kkNaJwCTRIc3w2TYV6mW2A/wB/y8KIU588n6PvRzJPKqAPBOMUFadKcrw+xBR4/BkJQPina9SCRkBSCP04/1E3zqNNVV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788333881; c=relaxed/simple;
	bh=y/VGxOjXx9WKrpCAGSYzwGElUc5SHrT6RR6puJTyVvI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YYTXiMBdJn9lXs81zZPfIPwg1vplchuN4kE+N8bcIxTvQlMF160Jt8rkr5eqVN9E3LGwW7WTxiSYyiBv2hHIoAo5YeXekIrOqrbjAmez3pGPKCateLpkuRi+Kt+SbF5vj5ioiP+fQDjN2pShfGyTIX+3/m0+gn1UWtoTeq1bOw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Ngse44MK; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Ngse44MK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1788333875; x=1788593075;
	bh=y+NztLsaxHfn7/cfzYIZfyev6yyfJyuSOiYsy0vD+tQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Ngse44MKbZvbwKw/9L3WXgA7D0eM/WQJCfgaDYmb1PzbBNZh+PCt8UiAoR4L4NJN2
	 aOWkNNHzlmLgScxxK3FXulkSQj4mWfDYe6rXNsyjDTL6pUJCOJqIA3MYHgFPmTuhKK
	 ROtAMEeRV5caKK+nbXkbNPdAZaZzOb57TCONbn6Q08Ir/0wBWRZHXot+ubwtcBv3hR
	 gN9yL+0Jr94Le2fEWHOUIoF3ycnLKF8MmUGyKCMvclKv6X4IEsmK/yPNCPiu4OeZoj
	 pPprDITtos6ZIZh8+4O6mDsZofEpqO/rEfajOGJiAOx+VGoEWMCTROn2I3ow81gBr6
	 4hBJ9vciyiMKw==
Date: Wed, 02 Sep 2026 07:24:30 +0000
To: Paul Menzel <pmenzel@molgen.mpg.de>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: "Vladimir V . Kondratyev" <vladimirkondratyev2@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, Kiran K <kiran.k@intel.com>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
Message-ID: <20260902072417.30260-1-lsa.uz@pm.me>
In-Reply-To: <d633b7ee-0afa-4fa1-8340-3d7616f429d2@molgen.mpg.de>
References: <20260507203426.128975-1-vladimirkondratyev2@gmail.com> <20260901203818.112189-2-vladimirkondratyev2@gmail.com> <d633b7ee-0afa-4fa1-8340-3d7616f429d2@molgen.mpg.de>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: 12c2388c7be689cd056d9858deaafb28d4c0f3f9
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Paul,

Two of your three points I can answer from the hardware, since the
Tested-by on this patch is mine.

> Can you reproduce this on real hardware?

Yes. Surface Pro 11 (Intel, Lunar Lake), Intel BE201, 8086:a876 rev 10.
It first appeared in ordinary use, not in a test:

  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry =
count 0
  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry =
count 1
  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry =
count 2
  btintel_pcie 0000:00:14.7: PM: pci_pm_suspend(): btintel_pcie_suspend ret=
urns -16
  PM: Some devices failed to suspend, or early wake event detected

One device returning -EBUSY aborts the whole system suspend, so the
machine does not sleep at all.

I have to be honest about the rate rather than useful: it failed on 2 of
the 3 suspends I attempted before installing a workaround, and later, on
a newer kernel with the workaround removed, it succeeded 7 times out of 7
with no btintel_pcie change in between. So the spontaneous failure is not
something I can produce on demand.

What I could do was exercise the exact path deterministically. I built
the driver out of tree with one debug-only parameter that returns from
btintel_pcie_msix_gp0_handler() before the boot_stage_cache refresh, and
only while alive_intr_ctxt is BTINTEL_PCIE_D0. That leaves the cache
stale and gp0_received false =E2=80=94 precisely the state a genuinely miss=
ed
alive interrupt leaves behind =E2=80=94 while the controller still reaches =
D3.

Without the patch, that reproduces the production failure exactly: three
timeouts, -EBUSY, suspend aborted. With the patch and nothing else
changed: one timeout, the re-read observes D3, set_dxstate() returns 0,
and the system suspends and resumes normally.

Full method and logs are in my earlier message on this thread,
Message-ID <20260830151550.44687-1-lsa.uz@pm.me>.

> To me it sounds strange, that a register name *boot stage* should
> change after the boot. ;-)

It is a fair reaction to the name, but the register genuinely carries
live power state. From the driver's own header:

  #define BTINTEL_PCIE_CSR_BOOT_STAGE_D3_STATE_READY  (BIT(24))

and both helpers test that one bit and nothing else:

  static bool btintel_pcie_in_d3(struct btintel_pcie_data *data)
  {
      return data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_D3_STATE_=
READY;
  }

  static bool btintel_pcie_in_d0(struct btintel_pcie_data *data)
  {
      return !(data->boot_stage_cache & BTINTEL_PCIE_CSR_BOOT_STAGE_D3_STAT=
E_READY);
  }

So bit 24 is updated by the controller on every D-state transition, long
after boot. The name describes the register's original purpose rather
than everything Intel later put in it. btintel_pcie_resume() already
re-reads it for exactly this reason, which is what makes the patch's
change consistent rather than novel.

The re-flow is Vladimir's call and I have no opinion on it. If a v3 comes
out of this, I still have the hardware and the test fixture and will
re-run both halves against it.

Thanks,
Sergey

