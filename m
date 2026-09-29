Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9AD4FDA71
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790686664; cv=none; b=j96PE7kUmFf3EuWiCckveSpJ1AzuSADdL1zREiGc1I/7+KZpgKwSGXphT12BcufwcrdwqCecE8Lk9UiNW431UPQXv/JdviKyF5Poo/xLPx6ThIl6cuaVODlWCfrtcRJj4/fVIB+2P5nfhHU95nNYs2XrMOXUR6NoYs2FhUxY5E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790686664; c=relaxed/simple;
	bh=mvI99qjRlMfZTZ/WHaalnFFP3OsC8BTwgoHYYTXjjTc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fi8s+3qKYHwrwEZCkMlfTAJpHOu1eKMn+ujagMmtDK5T68e/VgefyILpr+hPGvXu6n5L2Jb7yMesS1q+WXPomcNZ+UsWZu5rzXTN/U4+IK3bITDouF1wn5rKXdXW+vucKC7iVgfg2PT9cyR5fBt9zBVMt89ksgDJKTwKEG5KO5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=hIjOOeqO; arc=none smtp.client-ip=185.70.43.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="hIjOOeqO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1790686652; x=1790945852;
	bh=aW40yFsQQVBEhux8EBCqWRxfD9Vurz0F67UWu0vlI2A=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hIjOOeqOa1kz+VzY7JBho1n6TRCkAemcgSTiHx66yM/KMQ52jqobiBw/vevA93QeI
	 y3UFrudGr2tdb1ZT3NS7y1vVgSBC9ZPbQdZYGlmLD2ebZykt/KbCr+yDInkzW4m/Z4
	 lotGDzG6Glwvk6kGclrPNnkBdccISlJhv6adV5j+YuTSOpnbN/H/UkFB092qZVC+d1
	 2ECXMmvA3RPhZlq60QqmVZHjmXhaWyFHFpmYM0+qR22q7f9+oWP/SrZgEHGRCA4pBD
	 3RdPj1iDGDuHFZIm/ydb/9jPiIPHQcWCsgiXWCzv4IUcX6dh08bYtzQKWTbqNIVJZU
	 5UEb8zaJF16BQ==
Date: Tue, 29 Sep 2026 12:57:27 +0000
To: linux-bluetooth@vger.kernel.org
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Kiran K <kiran.k@intel.com>, Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, Ravindra <ravindra@intel.com>, "Vladimir V. Kondratyev" <vladimirkondratyev2@gmail.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: btintel_pcie: controller left dead after a boot-stage error, 1 in 12 warm reboots
Message-ID: <20260929125718.79878-1-lsa.uz@pm.me>
In-Reply-To: <20260911093904.68667-1-lsa.uz@pm.me>
References: <20260831124952.87484-1-lsa.uz@pm.me> <20260911093904.68667-1-lsa.uz@pm.me>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: 37b5b9530ed77e19f4b606fdd979f0b3139276b0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

A correction to my message of 11 September, written as a summary so that
this thread can be read from here.

That message said two things. One was wrong and I withdraw it; the other
stands.

Withdrawn: the failed probe and btintel_boot_wait_d0()
------------------------------------------------------

The failed probes were my own doing. A recovery service I run reloaded
btintel_pcie as soon as it saw a zero BD address, which is also what the
adapter shows while the firmware setup is still running. The unload takes
the interrupts away from that setup, and the probe of the reload then waits
3 s for the alive interrupt and fails with -62. The same sequence does this
to a healthy controller here.

btintel_boot_wait_d0() never gave up. The log I quoted has no "Device d0
move timeout", none of the 59 boots I still have logs one, and every boot
where the race struck logged "Device moved to D0". Please disregard the
question.

Stands: the race, and how often it hits
---------------------------------------

What fails is the race this thread began with. A gp1 mailbox interrupt
arrives during the second-stage firmware download before the driver is
waiting for it. The controller goes into error state, the Intel Reset after
the download times out (alive context intel_reset1), the driver's one retry
fails the same way, and the adapter is left DOWN at 00:00:00:00:00:00 with
"Unsupported cnvi 0x00000000".

The cold and warm figures stand, as figures for that race. They counted
failed probes, and in every boot I still have, the service caused a failed
probe exactly when the race had struck and never otherwise:

  warm reboots, >=3D 200 s apart    4 of 10
  cold boots, full power cycle    1 of 11    p =3D 0.03 against the warm ra=
te

So a full power cycle makes it much rarer but not impossible: left-over
state makes it more likely, and a real race sits under it.

Since then
----------

- Ubuntu's current 7.0.0-34 still has it: 9 of 28 boots here, same
  signature.
- Left alone, the adapter stays at the zero address, and a reload after
  the firmware setup has given up brings it back.
- bluetooth-next and 7.3 kernels built here: the race did not appear in
  109 boots (82 in my other report, 27 since). Those builds carry about
  270 modules against Ubuntu's 6709, so this does not yet tell a difference
  in code from a difference in timing. A current kernel built with
  Ubuntu's config would, and I can run that here. Details in the other
  report:
  https://lore.kernel.org/linux-bluetooth/20260911210634.87502-1-lsa.uz@pm.=
me/

Sorry for the noise.

Sergey

