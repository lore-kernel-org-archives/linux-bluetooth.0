Received: from mail-43103.protonmail.ch (mail-43103.protonmail.ch [185.70.43.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39022F7EE4
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 07:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789891073; cv=none; b=FWnalSKIjnvQ8++CiMFwdDmZLyr2HepUTHNZWMruxGdExj+V2itiordLo29O2cQSgDJTQeGCuZjfZPCiG0rGMmvSNomCX2QQQV0b1NrCnqoh0NRFNcSN3ELTBvW2kF2neFws9wlG2tX4mueIsgBL03C5AV2gvY1Ai0+l26H5OMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789891073; c=relaxed/simple;
	bh=uHAOQLm1Kg1IHj2EEI5dk1gSmNIcJFd4GqRVN00dsW4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i/AWP36/ayQK3+mnDOLA9CBRWiMz8qPK9oufZA2rVg6vIBfOrCMM7RdfMxMQMIgio6QEJ4u5cpLe4KkehsKypceEuWVM5XQ4DYS0om8hjFAjVHlAk0gzjuJzsfn+qoLDLzz8d+1GlaAciisdzV7TbiYddMpAndju1laTcesKyMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=RbXmjHs8; arc=none smtp.client-ip=185.70.43.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="RbXmjHs8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1789891062; x=1790150262;
	bh=J+/vFVdHnJkGa/5kQWsiXyK5CSZFgvCBW3lvo/IlH2M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RbXmjHs8c7B31QnmY2mwZLHFZqpMJQUoUX17ydNVfS4inbQVAwx6AWtkazcEeNaun
	 nrn1xzJnVfpHad0GFEKQjef+Tw0NM4fuF5IvFEmT0I81yU2LZ4toNYk2lmn5sjmh/l
	 za4xGVHmodal6lXqHnF9liZwU4QG3N5FRtqy+5lR+08UFITmmtNb/c9+zbMQniIDgl
	 Uu3LIZu4+U3/vLzrfN3AK5wfwN6KVrQ8yfHbNA2lXB5DPrSOrJQ1afy3ltH8wmWCUA
	 FUmhgNk5JiDlbKxSohlOcqTJtlhZLYc9kJctKj8ltO3Ccu9FprViUo89EhFvOzVZyx
	 WHgSkxq01Yy3w==
Date: Sun, 20 Sep 2026 07:57:35 +0000
To: Ravindra <ravindra@intel.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: "Vladimir V . Kondratyev" <vladimirkondratyev2@gmail.com>, Ferenc Lengyel <dev@lengyelf.eu>, Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>, Ravishankar Srivatsa <ravishankar.srivatsa@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>, Kiran K <kiran.k@intel.com>, Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, Mahalingeshwara Chambarakatta <mahalingeshwara.chambarakatta@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and S4
Message-ID: <20260920075720.7004-1-lsa.uz@pm.me>
In-Reply-To: <IA1PR11MB786999FA8FCC7E7B8752F7A4DA852@IA1PR11MB7869.namprd11.prod.outlook.com>
References: <20260909123416.71919-1-lsa.uz@pm.me> <20260909123416.71919-3-lsa.uz@pm.me> <CABBYNZJfH4F1-Hy1eiOrzuU1nzTbMbue3EqMT5gfHs60wFw9QA@mail.gmail.com> <20260909204654.91282-1-lsa.uz@pm.me> <IA1PR11MB786999FA8FCC7E7B8752F7A4DA852@IA1PR11MB7869.namprd11.prod.outlook.com>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: 46d2228082e433d536a953fab13d1981df6963d2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thank you - and for taking the third finding, which I had written off as
not this series' business.

Where this stands, and what I need from you
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

A v3 is assembled and ready: 1/2 and 2/2 unchanged, plus a third patch for
the one path the fold does not close. It applies to today's bluetooth-next
with no adjustment, checkpatch --strict gives 0 errors and 0 checks, and th=
e
third patch is measured rather than argued - 3 of 3 injected cycles failed
without it, 3 of 3 were clean with it, plus four uninjected controls.

I am not sending it. Four things are not mine to settle, and I would rather
ask than guess:

  1. Is 1/2 still a separate commit in your tree? The diff you sent reads
     either way, and the answer decides whether v3 is three patches or two.

  2. Can btintel_pcie_set_dxstate() race the gp0 handler? The new patch
     guards on alive_intr_ctxt so that RX is not armed twice, and that guar=
d
     is only sound if it cannot. You know that path; I have only read it.

  3. Which tree is your hunk against? It sits at 5193, while bluetooth-next
     has set_dxstate() at 4169 and nothing inside it has moved since the
     series went out.

  4. Where do you want the W1C clear? It is your fix and pre-existing, and
     neither patch touched that line, so it reads better as its own commit
     with its own Fixes: than inside a PM patch. Say the word and v3 carrie=
s
     it as a fourth patch with your Signed-off-by; say nothing and I leave
     it out for you to send.

An answer to any of them - or "hold, I will carry it myself" - and I will
act on it the same day. Everything below is the evidence behind them.

Whose commit 1/2 is
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The diff applies to a tree without 1/2: its minus side carries the old
comment, its plus side carries Vladimir's re-read word for word. So either
the two commits are now one, or it was taken against the pre-series base.
I cannot tell from here.

If they are one, please keep his From: and Signed-off-by, or add
Co-developed-by: and Signed-off-by: if it has to stay a single commit. His
one condition for letting me carry his patch was authorship, and I answered
him on-list that it was already safe - so this part is mine to ask about
rather than his. His two Link: tags are worth keeping either way.

Ferenc Lengyel's Tested-by is a different matter: it was given for the patc=
h
as posted, so dropping it from a modified one is fair. He is on Cc, so I am
saying it here rather than letting it go quietly.

The flag means less than it says
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

I argued the opposite to you on 9 September - that moving gp0_received out
of the retry loop rescues a late interrupt, and that your comment stated th=
e
invariant well. That was wrong, and I would rather say so than switch sides
quietly.

data->gp0_received =3D true is set at 1968 unconditionally, before a switch
that may match no case at all. The comment at 1940 says the same thing from
the other side: gp0 is raised for three causes and it is not easy to know
which one fired. So the flag means a gp0 arrived, not that the controller
moved.

"if (status) return 0;" at 4182 has no register read behind it. Together
those two let set_dxstate() report success while alive_intr_ctxt is stale
and the RX rings were never re-armed.

That needs no late interrupt and no second attempt: it happens inside one
pass, and it is in bluetooth-next today. Moving the flag out of the loop
widens it to a later attempt as well. The fold closes neither, because it
sits on the timeout path and this returns above it.

Measured
=3D=3D=3D=3D=3D=3D=3D=3D

Fixture: the gp0 handler returns after data->gp0_received =3D true and befo=
re
the switch, once, while alive_intr_ctxt is D3. That is not a delayed
interrupt - it is what a gp0 that matches no case does on its own. s2idle,
rtcwake -m freeze -s 45, SP11, BE201 8086:a876 rev 10, kernel 7.0.0-30.

  build                                     injected    result
  ---------------------------------------------------------------
  set_dxstate() byte-identical to bt-next    3 of 3     failed
  1/2 + 2/2 + your fold                      3 of 3     failed
  the same plus the diff below               3 of 3     clean
  the same, no injection                     4 of 4     clean

Failure is the same every time:

    Bluetooth: hci0: Received hw exception interrupt
    Bluetooth: hci0: Controller in error state
    Bluetooth: hci0: command 0x0c01 tx timeout
    Bluetooth: hci0: Opcode 0x0c1a failed: -110
    btintel_pcie 0000:00:14.7: resetting

and the controller returns under a new hci index, so every paired device is
gone. In one of the six the FLR did not recover it either: it came back at
00:00:00:00:00:00 and needed btintel_pcie and btintel both unloaded.

The part I did not expect is how quiet it is. "Timeout (200 ms) on alive
interrupt" appears in none of the six, because the function returns above
it. Nothing in the log says the resume went wrong - the first sign is the
firmware exception a second later.

The diff
=3D=3D=3D=3D=3D=3D=3D=3D

This is v3's third patch, shown against your folded version so the change i=
s
visible rather than the whole function. It moves the verification above the
success return rather than adding anything, and does the handler's work onl=
y
when the handler has not.

  @@ -1,31 +1,36 @@
   =09=09status =3D wait_event_timeout(data->gp0_wait_q, data->gp0_received=
,
   =09=09=09msecs_to_jiffies(dx_intr_timeout_ms));

  -=09=09if (status)
  -=09=09=09return 0;
  +=09=09if (!status) {
  +=09=09=09bt_dev_warn(data->hdev,
  +=09=09=09=09   "Timeout (%u ms) on alive interrupt for D%d entry, retry =
count %d",
  +=09=09=09=09   dx_intr_timeout_ms, dxstate, retry);

  -=09=09bt_dev_warn(data->hdev,
  -=09=09=09   "Timeout (%u ms) on alive interrupt for D%d entry, retry cou=
nt %d",
  -=09=09=09   dx_intr_timeout_ms, dxstate, retry);
  +=09=09=09/* clear gp0 cause; MSIX_HW_INT_CAUSES is W1C, so write only
  +=09=09=09 * this bit to avoid acking other pending causes
  +=09=09=09 */
  +=09=09=09btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES=
,
  +=09=09=09=09=09      BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0);
  +=09=09}

  -=09=09/* clear gp0 cause; MSIX_HW_INT_CAUSES is W1C, so write only
  -=09=09 * this bit to avoid acking other pending causes
  +=09=09/* gp0_received only says a gp0 arrived. It is raised for three
  +=09=09 * causes and the handler sets the flag before a switch that may
  +=09=09 * match none of them, so it does not mean the target state was
  +=09=09 * reached; a hardware bug may also drop the interrupt outright.
  +=09=09 * Either way only the register knows, and only the handler
  +=09=09 * refreshes the cache. Refresh it here and retry only if the
  +=09=09 * state check still fails.
   =09=09 */
  -=09=09btintel_pcie_wr_reg32(data, BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES,
  -=09=09=09=09      BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0);
  -
  -=09=09/* A hardware bug may cause the alive interrupt to be missed. Refr=
esh
  -=09=09 * boot_stage_cache from hardware, since only the interrupt handle=
r
  -=09=09 * updates it. Finally retry only if the state check still fails.
  -=09=09 */
   =09=09data->boot_stage_cache =3D btintel_pcie_rd_reg32(data,
   =09=09=09=09BTINTEL_PCIE_CSR_BOOT_STAGE_REG);

   =09=09if (dxstate =3D=3D BTINTEL_PCIE_STATE_D0) {
   =09=09=09if (btintel_pcie_in_d0(data)) {
  -=09=09=09=09/* GP0 handler never ran to do this: keep the
  -=09=09=09=09 * state tracker in sync and resubmit RX.
  +=09=09=09=09/* Do what the handler's D3 -> D0 branch would
  +=09=09=09=09 * have done, unless it already did it.
   =09=09=09=09 */
  +=09=09=09=09if (data->alive_intr_ctxt =3D=3D BTINTEL_PCIE_D0)
  +=09=09=09=09=09return 0;
   =09=09=09=09data->alive_intr_ctxt =3D BTINTEL_PCIE_D0;
   =09=09=09=09btintel_pcie_reset_ia(data);
   =09=09=09=09btintel_pcie_start_rx(data);

That guard - "if alive_intr_ctxt is already D0, the handler did it" - is
question 2 above. The handler is threaded (2779) and the gp0 dispatch at
2736 runs after irq_lock is dropped at 2697, so it can set gp0_received on
one CPU and reach submit_rx at 2030 while set_dxstate() is reading the
context on another. If that window is real the guard is wrong, and the rest
of the patch stands without it. It bears on your fold the same way.

Fifty clean S4 cycles cannot reach any of this - the path runs only when th=
e
alive interrupt is missing or unactionable, so a healthy controller never
enters it. That makes your run a no-regression result on the normal path,
which is worth having. Send me whatever you settle on and I will put it
through the same fixture.

Whichever way this goes, please post it to the list rather than pushing it
straight - then Vladimir, Ferenc and Luiz all see the trailers before it
lands.

Thanks,
Sergey

