Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0973492522
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 12:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788957274; cv=none; b=m2VN++w6A7IiRXcbZaj4FI16Qt450cqrIz1+FTwIccFH/+xn3qtiPODUUJNNoJhsc69zSzzskuUg22D3Llibd6qbIoT0nvIF9B8yOIkx+KyyemDXgY0r+lsds0C/e0CR/MNAJkKJWeAi7HmkND0jUczoPrRaXajX0FfmqT34DK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788957274; c=relaxed/simple;
	bh=Z7+vjnGGeVwv0RSVOFrLDFGxzP6Nx6JPFZsXRRpQTck=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=O4pjL2euVNoEOfUyF8spv7gDc/J1kgy4l0tShk2zlsf+7AUEkUsZPiMQnQj/jxvKAd0Z7y4T2WHJyezvLIR01/OHdtQ3jl1XMnCCccxgsfBsvL1SqKm8kITJjK4lwm0ppEmmPzi4ZcXHvb0t54ADJCt6tOdSscRzx0aVY4C3tFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=kJcIGIRC; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="kJcIGIRC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1788957270; x=1789216470;
	bh=6mEqcbB1stbfq33PpXl/N5pk5+NTONG711JCj8/6s6E=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=kJcIGIRC7QNodCGFjA4CAA/d+aSAPXlfpSSH0xjMYUngC+GXOy5HCexMKpmDqipt5
	 FN7ReNaqYLpgrvcSAYQ663JrZzdvqus5JYmKYkcfrCPaRWsCgw7IQlJLcV+NavtcUN
	 gVa5XQONpINo2AZnmZYJBuEAIEIgz+37mhgh6r+BwolGcS90smMQa643Tq45GwemIt
	 8GlRo+k0pJE3CVabFbOZN98tSGpxVGH3dLcH7cL8Cb2gxTwVk58K4urXO+QADd3AJI
	 lvWwV18GnBpxTyAJZ64PSlPoYcu+qn4+31ueejZqs3n8vnpmbi4j862lHBDKpWmymv
	 j45WAFdRONkXQ==
Date: Wed, 09 Sep 2026 12:34:25 +0000
To: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, "Vladimir V . Kondratyev" <vladimirkondratyev2@gmail.com>, Ravindra <ravindra@intel.com>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: Ferenc Lengyel <dev@lengyelf.eu>, Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>, Ravishankar Srivatsa <ravishankar.srivatsa@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>, Kiran K <kiran.k@intel.com>, Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, Mahalingeshwara Chambarakatta <mahalingeshwara.chambarakatta@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: btintel_pcie: two PM fixes, assembled as one series
Message-ID: <20260909123416.71919-1-lsa.uz@pm.me>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: f01ad771e84e472a10af2134e05262c398876408
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Two patches already on this list fix different halves of the same fault, an=
d
each leaves a real failure behind when applied alone. This assembles them i=
nto
one series. I am the submitter only - authorship, Fixes: tags and existing
trailers are unchanged.

  1/2  Vladimir V. Kondratyev  - re-read BOOT_STAGE_REG before the fallback
                                 check, so a missed alive interrupt is
                                 survivable
  2/2  Ravindra (Intel)        - fix the PM flow for S0ix, S3 and S4, which
                                 among other things stops .thaw running an =
FLR

Both carry Fixes: e57362f4911b.

How this came about, so nobody has to take my word for it. Ravindra agreed =
to
the assembly on 2026-09-08, on the condition that authorship and the Fixes:
tags be preserved and that his patch be rebased on top of Vladimir's; both =
are
done:

  https://lore.kernel.org/linux-bluetooth/IA1PR11MB786922E0DBE2CDC8FB00C5B6=
DAB12@IA1PR11MB7869.namprd11.prod.outlook.com/

Vladimir has not replied to the message that said this would go out unless =
he
objected, and I am not treating that silence as agreement. Vladimir - it is
your patch. If you would rather post the series yourself, or not at all, sa=
y
so and I will drop this:

  https://lore.kernel.org/linux-bluetooth/20260908102758.72135-1-lsa.uz@pm.=
me/

Why one series
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

They were posted separately and read as alternatives. They are not. The
evidence now comes from two machines, two controller generations, and two
distinct faults:

Surface Pro 11, Lunar Lake, BE201 8086:a876, s2idle. With a fixture that
drops the alive interrupt on demand, Ravindra's change alone leaves the
missed-interrupt case failing exactly as unpatched; Vladimir's re-read fixe=
s
it; together they do not interfere. The same failure was also caught
spontaneously with injection disabled, one run in six.

  https://lore.kernel.org/linux-bluetooth/20260902133836.11786-1-lsa.uz@pm.=
me/

ThinkPad X9-15p, Panther Lake 8086:e476, hibernation. Ferenc Lengyel report=
ed
hibernation aborting with -EBUSY after the image was already written, and
tested both patches:

  stock                    3 aborts in 10 cycles
  1/2 alone                2 aborts in 5
  1/2 + 2/2                0 aborts in 10

He then instrumented 1/2's re-read and found why 1/2 alone is not enough on
his machine: the register honestly reports the controller is not in D3,
because .thaw has just run an FLR that dropped it to ROM, and firmware has
not reloaded by the time .poweroff asks for D3 some nine seconds later. 2/2
removes that FLR from .thaw and keeps it on .restore. His own caveat, which
he states himself: ten clean cycles against a roughly one-in-three prior
failure rate is Fisher p ~ 0.06 - consistent and matching the mechanism,
not a large sample.

  https://lore.kernel.org/linux-bluetooth/df180a89-b214-41b4-b8ce-c6ed6b123=
72f@lengyelf.eu/

What the rebase changed
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Nothing but context. 2/2 needed one hand adjustment: its header hunk remove=
s
u8 pm_sx_event from struct btintel_pcie_data, and bluetooth-next has since
gained struct btintel_pcie_mdbgc mdbgc between dbgc and dmp_hdr, so the
three-line context no longer matched. The resulting diffstat is identical t=
o
Ravindra's posting - 64 lines in the .c, 2 in the .h, 44 insertions and 22
deletions - and no reference to pm_sx_event is left anywhere in
drivers/bluetooth.

Built against bluetooth-next at 701ca7188 with W=3D1: no warnings from eith=
er
file. The code is otherwise byte-for-byte what was tested on both machines.

One thing for Paul: you gave a Reviewed-by on v3 of 1/2 at 14:36 UTC on
2026-09-03 and v4 went out at 19:22 without carrying it. I have not added i=
t
back, since it is not mine to move, but you may want to re-give it here.

Originals:
  1/2  https://lore.kernel.org/linux-bluetooth/20260903192245.135310-2-vlad=
imirkondratyev2@gmail.com/
  2/2  https://lore.kernel.org/linux-bluetooth/20260902042840.2432862-1-rav=
indra@intel.com/

Ravindra (1):
  Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and S4

Vladimir V. Kondratyev (1):
  Bluetooth: btintel_pcie: fix stale cache in set_dxstate fallback check

 drivers/bluetooth/btintel_pcie.c | 72 ++++++++++++++++++++++----------
 drivers/bluetooth/btintel_pcie.h |  3 +-
 2 files changed, 50 insertions(+), 25 deletions(-)

--=20
2.50.1 (Apple Git-155)


