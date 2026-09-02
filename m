Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch [79.135.106.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFA73EC808
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788340247; cv=none; b=isdY+r3c2DAj+BSe1Wy7KfdIZij/2p51c9I5K1dpDlVZ4zIpGCWLiq4VPPPM8CIneGkcnYnEOTmGwUSH910t8GRfMCRUcvnbEh6ji2GizazmIth8EO9T1xnnUkP5mW/bLjn1ZZiC5RJ2xH2GrF1aBUeSMgCYJBnDZbw+ekaQBOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788340247; c=relaxed/simple;
	bh=LS7Fibgj6tHzCKLmNlN3CTMp/1S+Tjji9If21tIKkF8=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=pEv18MXwcJYMwnCFA1NXaYyaBsPeL0lDPplPzujPq6bf6QLy7cLWD2Ap5zEiVgpkboEAdJCLB099vjZ43vb5QCbbmEPMoM7pf8e2F7oDiETp1WbJ5XQnax3BiT35OVfPPLYfB2I93/SuVaqmH/Q/+m2iSlfs37Ywbi2celF1SVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=TQ27+2jK; arc=none smtp.client-ip=79.135.106.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="TQ27+2jK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1788340233; x=1788599433;
	bh=5iO1AtMI7nXpQM206CvTQOAiourbmDEKaegIHg4Pb9Q=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=TQ27+2jK+16IGN4ViULXC0SqeP39M3/Fi3invsgu7dgQdLxFwWHDLTt9vLLuxaag2
	 9AqRGTf+nQc8BYoEBjm5fYDiRa0ckYwcqYNpMjllOhi1D8R1E7HnTsZyAQX5HGb1DE
	 /uoM3f6NMQl32LP3zg3lMYUThNAMUZJ/boYwjJg6cY8vHGrmiYvJFAwoww18oXidB6
	 Jon0ObzHzqMKiGsEo6uRyuAJBFb2esFG3yymLn5UACED+blU418TklCUZhJyNSiZw6
	 SVFn5bEcMItH9ijdcFAyfjHTdHM/DMXZqTpyQzAMYM0kROySnK5rbb8doGn38rduRE
	 2mJkDSLZuI6Dg==
Date: Wed, 02 Sep 2026 09:10:29 +0000
To: Ravindra <ravindra@intel.com>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: "Vladimir V . Kondratyev" <vladimirkondratyev2@gmail.com>, Paul Menzel <pmenzel@molgen.mpg.de>, Kiran K <kiran.k@intel.com>, Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, Ravishankar Srivatsa <ravishankar.srivatsa@intel.com>, Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>, Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and S4
Message-ID: <20260902091021.20160-1-lsa.uz@pm.me>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: 1474c3297393a7f28e4cf14b8b1ad9c9268e1f9e
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ravindra,

Paul Menzel pointed me at this patch from the thread on Vladimir
Kondratyev's stale-cache fix, since both change
btintel_pcie_set_dxstate(). They overlap textually and, more usefully,
they fix different halves of the same failure. I have the hardware and a
fixture for one of those halves, so here is what I can add.

Your change moves the flag out of the retry loop:

  +    data->gp0_received =3D false;
  +
       do {
  -        data->gp0_received =3D false;

That recovers the case where the alive interrupt is merely *late* =E2=80=
=94 it
arrives while a later retry is waiting, and previously the per-iteration
reset threw it away. The comment you added states the invariant well.

What it does not cover is the interrupt being missed outright. When that
happens gp0_received never becomes true, the loop falls through to

      if (dxstate =3D=3D BTINTEL_PCIE_STATE_D0) {
          if (btintel_pcie_in_d0(data))

and those helpers read data->boot_stage_cache, which only the interrupt
handler ever writes. No interrupt, no refresh: the fallback is asked to
decide using the value from before the transition, so it reports the old
state, every retry is exhausted, and -EBUSY aborts the suspend. Vladimir's
patch re-reads BTINTEL_PCIE_CSR_BOOT_STAGE_REG immediately before that
check, which is what btintel_pcie_resume() already does.

So the two are complementary rather than competing: yours makes a late
interrupt count, his makes a missing one survivable.

I can be concrete about the second half because I reproduced it
deliberately. Surface Pro 11 (Intel, Lunar Lake), Intel BE201, 8086:a876
rev 10. The driver was built out of tree with one debug-only parameter
that returns from btintel_pcie_msix_gp0_handler() before the
boot_stage_cache refresh, and only while alive_intr_ctxt is
BTINTEL_PCIE_D0 =E2=80=94 the exact state a genuinely missed alive interrup=
t
leaves behind, with the controller still reaching D3.

Under that fixture, moving the flag out of the loop does not help: there
is no late interrupt to catch, and the cache stays stale. Three timeouts,
-EBUSY, suspend aborted. With the re-read, one timeout and the system
suspends. Method and logs are in
Message-ID <20260830151550.44687-1-lsa.uz@pm.me>.

The failure is not theoretical here. Before any workaround it aborted 2 of
the 3 suspends I attempted, and one device returning -EBUSY stops the
whole system from sleeping.

Whichever of the two lands first, the other will need a rebase =E2=80=94 th=
e
hunks touch adjacent lines. If it helps, I am happy to test them applied
together against my fixture and on ordinary suspend cycles, and to report
per-patch rather than as a combined result.

If you and Vladimir would prefer these as one series rather than two
independent patches, I am happy to do the assembly work =E2=80=94 rebased, =
with
both of you as the authors of your respective halves and the Fixes: tags
kept separate, since they are separate bugs with separate reverts. I did
not want to send that uninvited over two patches that are already on the
list; say the word and it is a short job.

One question on your patch, from someone who does not have S4 on this
machine to check: .thaw now takes the normal D0 path, while .restore
forces FLR. After PM_EVENT_FREEZE the controller was put into D3_COLD by
btintel_pcie_suspend_late(). Is D3_COLD guaranteed to preserve firmware
across a freeze/thaw on this part, or does thaw also need the FLR path?

Thanks,
Sergey

