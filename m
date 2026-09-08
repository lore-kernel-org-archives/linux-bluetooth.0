Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA42313E31
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 18:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890672; cv=none; b=Xi72byxseyaap1KQR6q/ojuzbdIUs6w0O9u2WfHakOQSznvadbjT1bHRpa0c4qSnIO9d//l/mQz7FUzInhP+fQRVX8f2PxlJqbYky/rG2H/C6MjfQzdPxNveg9clDYJkYRYlBfhGy2GXrkZ3c3kLPdb9gDYJbLvkIMkKuOtlmtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890672; c=relaxed/simple;
	bh=zMGZaqdJANDrh5Tl1OPidXpFwjIROfL+AT+lVazdOWc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=kMiMrR+R+bmur7Ik2l4NEZOiUpV762uL79m9F9Q8dK6ckR2OxmPNYzbwV/9eOAEYS/tBqK7RQCdNxIFAgYqDdoFHvds7QdA7lCXmYaZaS/PiE8P2irIvBEqkpGwhee22OFZ8pBdxVzitjoIiZe1Q0O9NJXSEDd3ftSs+eJhBh44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=U01VGX/S; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="U01VGX/S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1788890667; x=1789149867;
	bh=AKy78tl6tFVAGmyyExX3Fo/rPA9wuKEoQ3pqzIZU2SI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=U01VGX/S6MgtVy9dQKW1i7B72UMPZpf0ERrA8gjPG4fVNDgCO5zpF4tVsH0z/yUO4
	 ccPRf1M/2tKAExJjibCviFut/Z3rCKFCINDCOnNKdtEvvEfHmSxv74xEOPtly1ICvD
	 nrn7ZmJWOYJiDgVOYjnowACyfbaYJ/0AWT+VnkveiV+vRbknU+WJJ6uBK+IblF1O01
	 jZvo6IyEtepqLkr7kL2KUb9Wvvs7mF+NJ2gbeUMphGhZJ+8IAH1gSHqnTZ/I6HqaWF
	 GjLY4EDd7GLPEb/n4RjzExp6KiXDeraCLM23ZEDtQFW3xKFyBI9s6MXg14Xdq/x+cX
	 HIH4uRxGG3PjA==
Date: Tue, 08 Sep 2026 18:04:23 +0000
To: Mark Gerlach <fedora-bugs@mailbox.org>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: Kiran K <kiran.k@intel.com>, Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [BUG] btintel_pcie: Intel BE211 8086:a876 requests unavailable ibt-0190-01a1 firmware
Message-ID: <20260908180417.13209-1-lsa.uz@pm.me>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: 99b812ccf6d6901303a0639872c53701b5ffee5a
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mark,

The driver is asking for the right file. That file has never existed in
linux-firmware, so no update and no other distribution will produce it.

The name is built in btintel.c from two hardware fields, and the source
says which:

  /* ibt-<cnvi_top type+cnvi_top step>-<cnvr_top type+cnvr_top step-fw_id> =
*/
  format =3D "intel/ibt-%04x-%04x-iml.%s";
  snprintf(fw_name, len, format, cnvi, cnvr, suffix);

Both paths that can produce an "-iml" name build it the same way. First
field is cnvi_top, the connectivity part in the SoC; second is cnvr_top,
the radio. So yours is cnvi 0190 with cnvr 01a1, and the request matches
your silicon.

I have the same SoC side. Surface Pro 11 (Intel), Lunar Lake, and the
8086:a876 rev 10 you report - but subsystem 8086:000e where yours is
8086:0011. It works here, and loads:

  Found device firmware: intel/ibt-0190-0291-iml.sfi
  Found device firmware: intel/ibt-0190-0291-pci.sfi
  Found Intel DDC parameters: intel/ibt-0190-0291-pci.ddc

Same 0190, and 0291 against your 01a1. Two machines on the same
connectivity part carrying different radios.

I checked linux-firmware.git itself rather than any distribution package,
since package version strings do not compare across distributions - a
frozen LTS string can carry backported content and say nothing about it.
The tree listing and WHENCE agree on what is published:

  ibt-0190-*   with 0041 and 0291
  *-01a1-*     with 00a0 and 1190

And a path history query - run with two known-present files as controls,
because an empty result from a broken query looks identical to an empty
result from a true absence - returns 11 commits for ibt-0190-0291-pci.sfi,
6 for ibt-1190-01a1-pci.sfi, and none at all for ibt-0190-01a1-pci.sfi.
The file has never been in the tree, not merely dropped from it.

If it helps in asking Intel, their commits name each pair as a core:

  0190-0291   BlazarI          (this machine)
  0190-0041   BlazarIGfP
  1190-01a1   BlazarIW
  00a0-01a1   Scorpius

There is no commit for 0190-01a1 under any name.

One thing not to do: rename a neighbouring blob. ibt-1190-01a1 is your
radio against a different connectivity part and ibt-0190-0291 the reverse,
and the driver will not stop you - it validates the CSS header version and
the SBE type against hw_variant, but nothing checks that the image belongs
to your radio, so a renamed file is handed to the controller rather than
rejected.

So this is a firmware publication request and not a kernel bug, and it
needs Intel. I have put Kiran and Chandrashekar on Cc, who work on
btintel_pcie and are better placed than I am to say whether 0190-01a1 is
coming, or whether the module in your machine is not yet enabled on Linux.

Your report: 72098331-fa7c-443c-8b56-7671f9d711f2@mailbox.org

Sergey

