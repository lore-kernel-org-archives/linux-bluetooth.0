Received: from mail-244121.protonmail.ch (mail-244121.protonmail.ch [109.224.244.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CF64AA575;
	Thu, 24 Sep 2026 19:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277200; cv=none; b=Y6baQu3SHt06oPEUwB7+Lr1BOPEWEc0bFnzzMXAGiWS+DscPfwgtPTG/+EHL4PpgBsBVqZ6DrI6h55kznKiGPCrOSwXf6AY24UGEqHEMXnA5TRlm/dVp6EC5JlEau7+x1NhhQhzX9ybgCzbxh3go9nD38Tq/fuaR/SQMlkbjDBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277200; c=relaxed/simple;
	bh=CR4cvcm/0EJ6cdaeNJWZJs4Im3hAFcYLSDi+58mfmc8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QAb0Ft+hduVnID0uxnlConA0fzu3OnVeMG/GcXYIL33x8aGCPRGuI5HqWtqEm52BwzRttDAXw5Q0xPD4vszymOXzKjxSuE9xjwMEgrJzJPQCg6+nAb2JSc4ld+bg4GG9itXqYyNAZFpMg2XQAXpMQ+r92huKqEIWYkixBRNFqQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=bxVDHrl3; arc=none smtp.client-ip=109.224.244.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="bxVDHrl3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1790277195; x=1790536395;
	bh=9mx3bB65vw0YIZGWaof9o2Stepo47dWeJbee1KZEqsY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=bxVDHrl3J1K0dU4kbhTOkI6QiUuTLzi3xAZ1imANxSRmdKs1J76H4bJ7Nm85XTAe/
	 zGDh2onx//O/eMT+4NsN7gCrEzMqrtYmrgJhtB6d9sqGOSUKd7/W4sOxIzIBor7TYf
	 QtnDd9M6dgnhfYr7YumaAZl6hIQ7SSTHinzg0YfkkxGxoEnDZFue1R9xEZxQvcV5HI
	 TyVnCIngEDrpboFmTKm45Ei3XpmY9CKGxQzF8+PwYh1ldYrn3aRgoC1fv9JwBsCCL9
	 Ik+i3LgCI0KRb/8qnLClNxVHP9G5r9OtiovcsKpFsrOfceX7FcrZgvaklWRkJzn4nH
	 PSg0vZ1sH522w==
Date: Thu, 24 Sep 2026 19:13:10 +0000
To: Ravindra <ravindra@intel.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: "Vladimir V . Kondratyev" <vladimirkondratyev2@gmail.com>, Ferenc Lengyel <dev@lengyelf.eu>, Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>, Kiran K <kiran.k@intel.com>, Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, Mahalingeshwara Chambarakatta <mahalingeshwara.chambarakatta@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and S4
Message-ID: <20260924191301.39161-1-lsa.uz@pm.me>
In-Reply-To: <IA1PR11MB7869C1A9A0630F8C8C856B73DA822@IA1PR11MB7869.namprd11.prod.outlook.com>
References: <20260909123416.71919-1-lsa.uz@pm.me> <20260909123416.71919-3-lsa.uz@pm.me> <CABBYNZJfH4F1-Hy1eiOrzuU1nzTbMbue3EqMT5gfHs60wFw9QA@mail.gmail.com> <20260909204654.91282-1-lsa.uz@pm.me> <IA1PR11MB786999FA8FCC7E7B8752F7A4DA852@IA1PR11MB7869.namprd11.prod.outlook.com> <20260920075720.7004-1-lsa.uz@pm.me> <IA1PR11MB7869C1A9A0630F8C8C856B73DA822@IA1PR11MB7869.namprd11.prod.outlook.com>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: 6fe3d7c1f0335b81ee93adeea660713494ce810c
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ravindra,

Thank you - that settles it. I am not sending a v3; your v4 is the right
vehicle, and I will not put a second copy of one fix in flight.

But do not take the third patch as posted. Re-reading it against your
answer turned up four things, three of them mine. Line numbers are from
bluetooth-next master at 671d566d3c3b.

1. The comment is wrong, and your answer is what makes it wrong.

You are right that error and lockdown are filtered at 1958 and 1965,
before the flag is set. My comment says the flag is raised for three
causes and the switch may match none of them. Carried as written, v4
would fix the old misguiding comment and import the same fault in a new
one.

The patch is still needed, for a reason the comment does not give:

  1971  data->gp0_received =3D true;
  2014  case BTINTEL_PCIE_D3:
  2015          if (btintel_pcie_in_d0(data)) {
   ..              ctxt =3D D0, submit_rx, signal_waitq
  2020          }
  2021          break;          <- matched, changed nothing

A matched case can complete having done nothing, with the flag already
true and signal_waitq clear. So it is not about which cause raised the
interrupt. That also means "the only scenario is a missed interrupt" is
too narrow: here the interrupt arrives and is handled, to no effect.

And it bites without any missed interrupt. Measured on the part rather
than argued, with a debug copy of the module: the handler's D3 case is
made to read in_d0() as false so it takes its own 2021 break, a 2 ms
sleep before the wait widens a window that is already there, and the
early return is a module parameter so stock and patched are one build.
The SP11 lines below are that instrumentation; everything else is the
driver's own.

  stock (early return kept):
    SP11: handler forced down the do-nothing break
    SP11: early return, dx=3D0 ctxt=3D6 after 204902 us
    Bluetooth: hci0: Received hw exception interrupt
    btintel_pcie 0000:00:14.7: resetting
    Bluetooth: hci0: command 0x0c01 tx timeout
    Bluetooth: hci0: Opcode 0x0c01 failed: -110
    Bluetooth: hci0: Opcode 0x0c1a failed: -110

  with the patch:
    SP11: handler forced down the do-nothing break
    SP11: verified path re-armed RX
    SP11: ok dx=3D0 ctxt=3D5 waits=3D1 nosleep=3D1 2133 us

ctxt 6 is D3 and 5 is D0, so 4213 returned success with the context still
saying D3 and the rings unarmed. Note the 204902 us: signal_waitq is clear
on that path, so nothing woke the queue - the wait ran its full 200 ms,
re-checked the condition at expiry, found the flag true and returned
non-zero. The success was believed on a flag set by a handler run that
had done nothing and had not even woken anyone.

One caveat on that pair, since it is a race and I would rather you heard
it from me. An earlier attempt suppressed the handler once instead, and
the stock side came back clean - a later handler run had repaired the
state before anything used it. So the window is real and reachable but
not hit every time. The older fixture, which injected a return between
1971 and the switch rather than taking the 2021 path, failed 3 of 3 and
was clean 3 of 3 with the fix; that is where the reproducibility comes
from, and this run is what ties it to the real path.

2. Keeping gp0_received inside the loop is not optional once this patch
is in, which is a second reason for the decision you already made.

With the flag hoisted out of the loop and "if (status) return 0" gone,
once any handler run has set it - the 2021 case is one - the later
retries find it still true, wait_event_timeout returns at once, and each
retry becomes a bare register read. Three 200 ms attempts collapse into
microseconds and the function returns -EBUSY without ever having waited.
A genuinely missed interrupt leaves the flag false and still waits, so
this only shows up in exactly the case the patch is for.

Measured the same way, on the suspend direction so a failure only aborts
the suspend, with the state check forced to fail all three times:

    hoisted:      waits=3D3  nosleep=3D2  total    1465 us   (and 1143 us)
    in the loop:  waits=3D3  nosleep=3D0  total  622445 us   (and 411499 us=
)

with the three "Timeout (200 ms)" lines present only in the second. The
first pair ran back to back, which left the second configuration facing a
controller the first had put in D3, so it was not a control; the figures
in brackets are a rerun in the opposite order with a clean, unforced
suspend/resume before each. The shape held both ways.

Your v4 resets it inside the loop, so this does not arise - but the two
changes are coupled and nothing says so.

3. The patch's D0 branch is an incomplete substitute for the handler.

The handler's submit_rx block does three things, not two: reset_ia,
start_rx, and the mbox<->alive handshake at 2038-2041. Mine does the
first two and claims in its comment to do what the branch would have.
If MBOX_PARSE_PENDING is set, the waiter at 1615 then sits out its
timeout for nothing.

4. start_rx() can fail and its return is discarded.

The handler is void and has no choice; set_dxstate() returns a status to
the resume path and does. Reporting 0 with the rings unarmed is the exact
condition this patch exists to prevent.

Rolled up, with the comment rewritten (it needs an int err; beside the
existing retry and status):

  =09=09if (dxstate =3D=3D BTINTEL_PCIE_STATE_D0) {
  =09=09=09if (btintel_pcie_in_d0(data)) {
 +=09=09=09=09/* Do what the handler's D3 -> D0 branch
 +=09=09=09=09 * would have done, unless it already has.
 +=09=09=09=09 */
  =09=09=09=09if (data->alive_intr_ctxt =3D=3D BTINTEL_PCIE_D0)
  =09=09=09=09=09return 0;
  =09=09=09=09data->alive_intr_ctxt =3D BTINTEL_PCIE_D0;
  =09=09=09=09btintel_pcie_reset_ia(data);
 -=09=09=09=09btintel_pcie_start_rx(data);
 +=09=09=09=09err =3D btintel_pcie_start_rx(data);
 +=09=09=09=09if (err)
 +=09=09=09=09=09return err;
 +
 +=09=09=09=09/* Complete the mbox<->alive handshake */
 +=09=09=09=09if (test_and_clear_bit(BTINTEL_PCIE_MBOX_PARSE_PENDING,
 +=09=09=09=09=09=09       &data->flags)) {
 +=09=09=09=09=09set_bit(BTINTEL_PCIE_MBOX_PARSE_READY,
 +=09=09=09=09=09=09&data->flags);
 +=09=09=09=09=09wake_up(&data->mbox_parse_wait_q);
 +=09=09=09=09}
  =09=09=09=09return 0;
  =09=09=09}

and the comment above the register read:

  /* gp0_received is set at the top of the handler, before the switch on
   * alive_intr_ctxt. Error and lockdown are filtered out above it, but a
   * matched case can still complete without doing anything - D3 breaks
   * unchanged while the controller has not reached D0 - and a hardware
   * bug may drop the interrupt outright. Either way the flag says a gp0
   * was handled, not that the transition completed, and only the register
   * knows. Refresh the cache here and retry only if the state check still
   * fails.
   */

The D3 branch needs no such guard: setting alive_intr_ctxt to D3 twice
has no second effect, where reset_ia and start_rx do.

On your 4/4, for what it is worth from here: clr_reg_bits() is a
read-modify-write, so on a W1C register it writes 0 to GP0 - not clearing
it - and 1 to every other cause that happened to be pending, acking
HWEXP, GP1 or FWTRIG before the ISR sees them. The ISR's own idiom is the
proof: 2712 reads the HW causes and 2716 clears them by writing the same
value back, under the comment that says so.

The one thing I need from you is question 1's other half.

Please keep Vladimir V. Kondratyev's From: and Signed-off-by on 1/2. His
one condition for letting me carry his patch was authorship credit, and I
relayed that to the list with the assurance that it was already the case.
As posted, 1/2 carries his From: at the top, his Signed-off-by first and
his two Link: tags, with my Tested-by and Signed-off-by beneath:

  https://lore.kernel.org/linux-bluetooth/20260909123416.71919-2-lsa.uz@pm.=
me/

Your answer explains the ambiguous diff as a local squash, which I read as
1/2 staying its own commit - but you did not say so, and it is his name on
it rather than mine, so I would rather ask than infer.

Same rule for the third patch, whichever form you prefer: Co-developed-by:
with the Signed-off-by, or From:. A bare sign-off records the chain but
not the author.

On question 2, your answer is enough whichever way that window falls. If a
handler is in flight while set_dxstate() reads the context, the guard
simply does not fire and we are back to the behaviour without it. It can
help and cannot hurt, so it never needed the window to be impossible.

The three patches apply to 671d566d3c3b with no fuzz. So does the rolled-up
version above, which is not just quoted at you: applied on top of them it
builds W=3D1 with sparse, zero warnings, and checkpatch --strict gives
0 errors, 0 warnings, 0 checks over 195 lines.

The bench for the measurements: kernel 7.2.0-rc6-btnext-norework built
from e40edfa04, where set_dxstate() and the gp0 handler are byte-identical
to 671d566d3c3b - only their line numbers moved, 4133 against 4200 - on a
BE201 8086:a876 rev 10.

Send v4 when it is ready and I will put it through the same bench.

Sergey

