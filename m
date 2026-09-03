Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57250511209;
	Thu,  3 Sep 2026 19:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788465247; cv=none; b=DczM0etnP8XsPxXPRFfIXHL2rT+8RU8V9mQzKKvTiH5vHT7dOcuo5MTWtc6kL0CCnch16Kb5ukCtDqqKspnRl2aIUXlFfdjjfK7AJ8Dd2gTXj19KUOgZGK8SffNYYkVH6bV3OLAhZ707hTiNoS2acPABWhaaI3QNzxMTv9r43RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788465247; c=relaxed/simple;
	bh=fIMHLyyG4vTq+ZqLREyakOLkmH+dwv5+f8WX6EukCm0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbqDbNAWSOP1ic+/oQ1NlxN/MoLAMuGBoE9tH3b8IdGT/xKVCOKprrIuXFKReYShZHeQjpmPDWxYe5Mgezh88BRy5oLjk50qxuNIdBoi22+gkKRvKGlO8RHtcm0eEtZm+62h9mMJbcfnrmGQzsOTPc0y0lAFZs04txLPYRd4J3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=fX6ERHuA; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="fX6ERHuA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1788465232; x=1788724432;
	bh=1QgznbOgvUg459L5zM9/psIURXxCsT4oTnvwjIkAZso=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=fX6ERHuAvrxEDWxySTjwbOx9DympMRedmxaMyIsnYYaXWcgFVVBgkhsx4OUeVM8f0
	 LfC8S7RIAMwYUxyOL4RNYJAI+d8pKQ/LnGsNIrtIf5fD70bGVwk7v3xjt5/uU7z6WJ
	 pwwKKMqhwsfB9Jcp3Ny5IS6YfOoH8gpCsaL5PwFS1XWmg36jcY3qzYBzA6d29yJIKU
	 apO72ro72Ksfa82k82WlBE3fgJP2pHsz2VqmFUf+zFcdtXU7iVLUbp9r431n/58ITV
	 M2M0hhxdsdVDWyzPFa8MrchoKyUf8TNU6x4LNt4hQGL7LuyBYBxJjf5Ki6sfjg6kTZ
	 Sv1f+7owbi/7Q==
Date: Thu, 03 Sep 2026 19:53:48 +0000
To: "Vladimir V . Kondratyev" <vladimirkondratyev2@gmail.com>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Paul Menzel <pmenzel@molgen.mpg.de>, Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, Kiran K <kiran.k@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check
Message-ID: <20260903195342.78248-1-lsa.uz@pm.me>
In-Reply-To: <20260903192245.135310-2-vladimirkondratyev2@gmail.com>
References: <20260507203426.128975-1-vladimirkondratyev2@gmail.com> <20260903192245.135310-2-vladimirkondratyev2@gmail.com>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: d87253f2add65cfeb4bb2841280d3a074352681a
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Vladimir, Paul, Chandrashekar, Kiran,

Nothing here asks for a change to v4 =E2=80=94 it is right and my Tested-by=
 stands. This
is the measurement behind a question I put to the list on 2026-09-02 and co=
uld
not support with numbers at the time.

The question was whether BTINTEL_PCIE_CSR_BOOT_STAGE_REG should be polled f=
or the
target D-state, with the alive interrupt demoted to an early exit, rather t=
han the
other way round. So I timed both against the same zero =E2=80=94 the write =
in
btintel_pcie_wr_sleep_cntrl() =E2=80=94 on Surface Pro 11 (Lunar Lake), Int=
el BE201,
8086:a876 rev 10, kernel 7.0.0-30, s2idle. A measurement build polls the re=
gister
every 100 us and records when bit 24 reaches the target and when gp0_receiv=
ed
becomes true. Four suspend/resume cycles, eight transitions:

  dxstate  register (us)              interrupt (us)
  D3       1517  1027  1085  1111     1670  1171  1085  1112
  D0       1630  1521  1676  1701     1630  1646  1676  1701

The register reaches the target state in **1.0 to 1.7 ms** and is **never l=
ater
than the interrupt**. In four of the eight it is the same 100 us sample; in=
 two
it leads by 125 and 153 us. Against that, the current path budgets 200 ms p=
er
attempt and three attempts =E2=80=94 up to 600 ms per transition, twice per=
 suspend cycle.

That is the whole of my case, and its limits are worth stating plainly. One
machine, one controller, one firmware. The poll itself is PCIe traffic and =
could
be perturbing what it measures, though it would have to be perturbing it in=
 the
direction that flatters the register. And a settle time is not a guarantee:=
 an
interrupt exists partly so the driver need not assume a bound.

But if the bound holds on Intel's own hardware, polling would delete the
stale-cache class of bug rather than catch it, and POLL_INTERVAL_US is alre=
ady
declared in btintel_pcie.h and unused.

I have not written that patch, because it is your subsystem and my coverage=
 is
one machine. What I do have is the hardware, a fixture that drops the alive
interrupt on demand, and the per-hunk method already used in this thread. S=
o if
an RFC would be useful rather than noise, I will write one and report it th=
e same
way =E2=80=94 measured per hunk, with the failure injected and with it disa=
bled. If you
would rather it came from someone with the full range of controllers, that =
is a
perfectly good answer and I will leave it here.

Sergey

