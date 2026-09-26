Received: from mail-106120.protonmail.ch (mail-106120.protonmail.ch [79.135.106.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AF92F0C48
	for <linux-bluetooth@vger.kernel.org>; Sat, 26 Sep 2026 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790433915; cv=none; b=jUy/OF2/L0ObFbIVlgwdo65aIA68yjmzNkMUPT8VykboJxxZO5qZRrS3ECknVb90A36UhWcCkL6BBgjqaNCRoEYqCVTYv+ynHqfpab7dPc5FvmBIgyfIYVcMgRn0mmUbcOdnerDysFWGh0c7Uf9z4Zmtc6/Aiy+/BkjAd3ERpRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790433915; c=relaxed/simple;
	bh=pICmn9fJ9p2A/LWOiFZzr9TtpvYjbTGzG/FF/ZXO5Jo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nttRNNzSezjHTYNmCJBuKsxy/FE16+uDTwz2oCvZZjAy2NiO9KYa8JNwc8EQv0uLKjyu/KrivA31F3kN0Z4IQjrny41kvpkqqEeSz/vnAzzDDMoVwQzSY1LpBvRM25VyjX2RUwTJiS26B8C9qhxqqgi7gTn5YeH0gAkS2/XdEBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=hKckLObb; arc=none smtp.client-ip=79.135.106.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="hKckLObb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1790433905; x=1790693105;
	bh=lLvXWwTV8psrHGzjhZPgRvvsjTmO4/8mZi24bj1pjps=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=hKckLObbYDw9/sRnZlus4wSvwyKH6IKktRk+8l0Xo3nuaO18rZ4MTp3jfC/eNWwym
	 0og3DvrJlSKc36wCGMK++6uSzprf7VrqxSOKjxsn9evnmedOZnR8EzyvN8E0dINOdj
	 lc/gCMTTiNG76xYM3VS0DcPFDSY7wd65BeCEj5WBbGjnNwYUljYgrjzfU+HBAg0g94
	 xr9iTFc0gEUDKixt26CxMco64Xcp8VPXFl8bDQdjyc+gFVMUbzVOTETD23eXwHQWb0
	 k1LBt08K87jjA6F8nD7HcGvLjymxboBdoPGqHFvCBbEK3BaYL7aRFgsv52nHcr7zWk
	 iEQBGO0jIc4Lg==
Date: Sat, 26 Sep 2026 14:44:59 +0000
To: Ravindra <ravindra@intel.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: "Vladimir V . Kondratyev" <vladimirkondratyev2@gmail.com>, Ferenc Lengyel <dev@lengyelf.eu>, Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>, Kiran K <kiran.k@intel.com>, Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, Mahalingeshwara Chambarakatta <mahalingeshwara.chambarakatta@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and S4
Message-ID: <20260926144451.17188-1-lsa.uz@pm.me>
In-Reply-To: <IA1PR11MB786927FFF15A4863BB96AB4FDA8F2@IA1PR11MB7869.namprd11.prod.outlook.com>
References: <20260909123416.71919-1-lsa.uz@pm.me> <20260909123416.71919-3-lsa.uz@pm.me> <CABBYNZJfH4F1-Hy1eiOrzuU1nzTbMbue3EqMT5gfHs60wFw9QA@mail.gmail.com> <20260909204654.91282-1-lsa.uz@pm.me> <IA1PR11MB786999FA8FCC7E7B8752F7A4DA852@IA1PR11MB7869.namprd11.prod.outlook.com> <20260920075720.7004-1-lsa.uz@pm.me> <IA1PR11MB7869C1A9A0630F8C8C856B73DA822@IA1PR11MB7869.namprd11.prod.outlook.com> <20260924191301.39161-1-lsa.uz@pm.me> <IA1PR11MB786927FFF15A4863BB96AB4FDA8F2@IA1PR11MB7869.namprd11.prod.outlook.com>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: d8139bee98e996a06b92e1913f0906198e8f885d
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ravindra,

Thank you - all four are in. I checked them in the code, with v4 applied
from lore onto 671d566d3c3b and onto e40edfa04, where it lands identically.

Your D3 branch also closes a hole in what I proposed: if the handler's D0
case runs before the controller reaches D3, it breaks without recording
D3, the context stays D0, and the guard in the D0 branch then skips the
re-arm on resume. The bench shows it with and without your branch.

Bench: Surface Pro 11, BE201 8086:a876, the driver at bluetooth-next
e40edfa04 against the same plus v4, one instrumented build each. "HCI ok"
is Read Local Version returning status 0 after the cycle.

  first gp0 on D3 entry dropped, as a missed interrupt (1/4's case)
    stock  timeouts at retries 0, 1 and 2, -EBUSY, suspend aborted,
           HCI fails
    v4     one timeout, D3 recorded from the register, HCI ok (2 of 2)

  handler's D0 case forced to break on suspend
    v4 without the D3 branch   resume skips the re-arm, HCI fails
    v4                         D3 recorded, handler re-arms on resume,
                               HCI ok (2 of 2)

  handler's D3 case forced to break on resume
    stock  success reported with ctxt 6 (D3), then hw exception, FLR,
           0x0c01 tx timeout
    v4     re-armed to ctxt 5 (D0) either way the race falls: handler
           before the wait, 2.2 ms; during it, 208 ms; HCI ok (2 of 2)

  state check forced to fail three times on suspend
    v4     waits=3D3, none skipped, 413 ms, -EBUSY as forced

  plain s2idle
    v4     D3 in 1.5-1.6 ms, D0 in 1.5-1.7 ms, HCI ok (3 of 3)

  S4, in the kernel's suspend and test_resume hibernation modes
    stock  .thaw goes through FLR
    v4     .freeze: D3_COLD in 1.5-1.8 ms
           .thaw: D0 in 1.6 ms, HCI ok after (2 of 2)
           .restore: FLR, firmware reloaded, HCI ok (2 of 2)

S4 ran on the bench kernel, since the distribution kernel refuses it
under Secure Boot lockdown, and without cutting power, so .poweroff is
not covered. The firmware offers no S3.

After the FLR in .restore the log says "BT reprobe failed", on stock
too; the device probes again about a second later and works.

Tested-by for 4/4 follows in its own thread.

Sergey

