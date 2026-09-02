Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D4F49C4CD
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 13:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356338; cv=none; b=M1X4XBMHq+FbbF8dJ/P7mKREMGyHUNsgvI3ohQ5mJ5k0LagFxcH6PcstGNF29JSX59ufe+zYYOsV2h/c5cui8tYNyu3fakXcG++tsOlhQ/LMz5S8DgGye4cEtsngb/nZ0ZZQ06eaKTxjyhC1AIMYo7TLx9VKCXArARN8ZChg2CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356338; c=relaxed/simple;
	bh=dhJYsV56OQwZfw3BZcNGvNPDNMOK3kQrXY4cdD0UJQ4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rrZBTjFch29ZKTVuiCQr3/HFtXj/eB2Mre2RUEJaVqatJ1F4HHpg1Uw0Fm3dSVk+VvQpBVR5H1njfqbMKy/XQs3VUFZrEdhwqNYV1dsr1dOsL/6+ef96zx58VdYI7SqBAMQ2IZSAmYD7dkr1cM7uZjJS7V7wSeJqvCEpisZLKKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=sD5HyrBp; arc=none smtp.client-ip=185.70.43.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="sD5HyrBp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1788356326; x=1788615526;
	bh=1XskHtwEG52c1RKgX5wX4eFj06maOHss6VTmOYDRXoM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=sD5HyrBpXSQRrCtUhJ78Wkb3vCAYVUfMMhauXgaepEIWBAxsN9WeEGAT+EkiXSZE+
	 H9CKWECvWgKZaOHYdGb6GjMrxRa+ydcEdG9+0hAZILXT7ulvbbuVMIDNN6mwXPxV0r
	 4WYfhMSJn82hZyMUCdK14TS+j/2tJNkO5tZnIQJiscDT0hJE5P8zfg3NUZ5kRHSpYj
	 CTu01o6YZ7KIIw1WPGqmZZW1UgQEfIvl/4faYFBtQ9lZnppjMeypFvNj0MAjEx1t9F
	 XMRlZwV1S4n4JWxG6hYI50yfNHWH5hIxWdt7xU58rZ+Vcep/ZHpoW9/DHtkav9jJu/
	 PKJiNtvt/jhCA==
Date: Wed, 02 Sep 2026 13:38:42 +0000
To: Ravindra <ravindra@intel.com>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: "Vladimir V . Kondratyev" <vladimirkondratyev2@gmail.com>, Paul Menzel <pmenzel@molgen.mpg.de>, Kiran K <kiran.k@intel.com>, Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and S4
Message-ID: <20260902133836.11786-1-lsa.uz@pm.me>
In-Reply-To: <20260902091021.20160-1-lsa.uz@pm.me>
References: <20260902091021.20160-1-lsa.uz@pm.me>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: fca3389088a6770b8525cdb2fe7661afcfd1fc3b
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I said in my earlier mail that these two patches fix different halves of
one failure, and offered to test them. Here is the measurement rather
than the argument.

Hardware: Surface Pro 11 (Intel, Lunar Lake), Intel BE201, 8086:a876
rev 10, kernel 7.0.0-30, s2idle. Four builds of btintel_pcie from the
same source, differing only in which hunk is present, each carrying one
debug-only module parameter that returns from
btintel_pcie_msix_gp0_handler() before the boot_stage_cache refresh and
only while alive_intr_ctxt is BTINTEL_PCIE_D0. That is a missed alive
interrupt: gp0_received never set, cache never refreshed, controller
still reaching D3. Suspend triggered with rtcwake -m freeze -s 45.

  build                          result
  ---------------------------------------------------------------
  neither hunk                   3 timeouts, -EBUSY, suspend aborted
  Ravindra's hunk only           3 timeouts, -EBUSY, suspend aborted
  Vladimir's hunk only           1 timeout, suspended and resumed
  both hunks                     1 timeout, suspended and resumed

Unpatched and with your hunk alone, identical:

  PM: suspend entry (s2idle)
  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry =
count 0
  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry =
count 1
  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry =
count 2
  btintel_pcie 0000:00:14.7: PM: failed to suspend async: error -16
  PM: Some devices failed to suspend, or early wake event detected
  PM: suspend exit          <- 1.7 s after entry; it never slept

With the re-read present, alone or alongside your hunk:

  PM: suspend entry (s2idle)
  Bluetooth: hci0: Timeout (200 ms) on alive interrupt for D2 entry, retry =
count 0
  PM: suspend exit          <- 48.8 s after entry; it slept the full period

This is not a criticism of your patch: the fixture removes the interrupt
entirely, so there is no late interrupt for your hunk to rescue, and it
cannot help by construction. It measures the half it does not cover, and
confirms the two do not interfere when applied together.

The single-run table above had one oddity - the both-hunks run slept 8.6 s
instead of the full 45 - so I repeated it rather than leave a guess in the
archive. Eight further cycles, no failures anywhere:

  both hunks        48.0  48.6  50.8  48.6  50.7 s
  re-read only      48.6  46.6  50.8 s

The 8.6 s did not recur. It was a stray wake, not a property of the
combination.

Those runs turned up something better than the caveat they removed. The
retry count varies between 1 and 3 from run to run, and the outcome does
not: even when all three retries time out, the re-read then observes D3
and set_dxstate() returns 0. One of the re-read-only runs did exactly
that - three timeouts, no -EBUSY, slept 46.6 s - which is the fallback
doing the whole job with the retry loop having contributed nothing.

One incidental confirmation, since Paul asked in the other thread whether
a register called *boot stage* really changes after boot. Tracing the
fallback path prints what it actually reads at D3 entry:

  SP11TRACE: retry=3D0 dxstate=3D2 gp0_received=3D0 boot_stage=3D0x61710007

Bit 24 - BTINTEL_PCIE_CSR_BOOT_STAGE_D3_STATE_READY - is set, on hardware,
long after boot, which is why the re-read is able to answer the question
the cached value cannot.

One caveat I cannot remove. I have no fixture for the late-interrupt case
your hunk addresses, so I have measured only that it does no harm here,
not that it works. That needs a different fixture - delaying the interrupt
rather than dropping it - and I have not built one.

Raw log and the four builds are available if anyone wants them.

While instrumenting this I caught the failure happening on its own, with th=
e
injection disabled, which I had not managed before. One run in six:

  PM: suspend entry (s2idle)
  Timeout (200 ms) on alive interrupt for D2 entry, retry count 0
  SP11TRACE: retry=3D0 dxstate=3D2 gp0_received=3D0 boot_stage=3D0x61511007
  Timeout (200 ms) on alive interrupt for D0 entry, retry count 0
  SP11TRACE: retry=3D0 dxstate=3D0 gp0_received=3D0 boot_stage=3D0xa0db1007
  Timeout (3000 ms) on alive interrupt, alive context: intel_reset1

The interrupt went missing in both directions in the same cycle, and the
re-read rescued both: bit 24 set at D3 entry, clear at D0 entry, each time
matching the state the controller had actually reached. No -EBUSY. So this
is not only a fixture artefact - the hardware does drop it, and the registe=
r
is right when the interrupt is not.

That leads to a question rather than a patch, for whoever owns this code.

Both patches keep the interrupt as the primary signal and the register as a
fallback. Given that the driver's own comment calls the missed interrupt a
hardware bug, and given the register answers correctly in both directions,
would it not be sounder to invert that - poll BOOT_STAGE_REG for the target
bit, and treat the interrupt as an early-exit optimisation rather than the
thing being waited on?

The file already does exactly this shape for the reset path:

  do {
      reg =3D btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
      if (reg & BTINTEL_PCIE_CSR_FUNC_CTRL_BUS_MASTER_STS)
          break;
      usleep_range(10000, 12000);
  } while (--retry > 0);

and btintel_pcie.c declares POLL_INTERVAL_US, which nothing uses - so the
intent seems to have existed at some point.

The practical difference is not only correctness. Today a missed interrupt
costs up to 600 ms of waiting per transition before the fallback is even
consulted; a poll would return as soon as the bit flips. And the stale-cach=
e
class of bug disappears rather than being caught.

I am not proposing this as a patch over yours - you two own this code and I
have one machine. But if either of you thinks the shape is right, I have th=
e
hardware, the fixture and now a spontaneous reproduction to test it against=
.

Vladimir has said he is content either way on the series question, so it
rests with you and the maintainers. My offer to do the assembly stands.

Thanks,
Sergey

