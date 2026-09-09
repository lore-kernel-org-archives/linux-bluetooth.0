Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6A53D47DA
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Sep 2026 20:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986845; cv=none; b=nHGTfk1lzU//4WKN07CAikLJsb9fEx1y+4dl9vnlgaq0VFvQerBmyJIVJ/PxVbIIdLY1MLCRu7O3ZI+XKdSITVlDzNLhKiSlUcuVQfNvDKRLnKbnDa1CTJx3dRnMkVecyOlRQXMe9o31I4QlgZ9cKOlTcVfz/gMklv5Xw7hlLMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986845; c=relaxed/simple;
	bh=ZU8YTTlzkNKsk+YFMVAdXTY9Z7QXxSJjAl1Q33+ioAk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kfo86HmEQetNzLTIVf4JfxUO2RbDQGh/3G7aWoOWm051Z1MGFO2Q5hwD2ziwP+svkzEut6CTvwwG1NRyM+5hRfJFZOhclCsB+OI4bbRLm5qw6oWP4grhdEEi+gJswoink526rt9StvFN1IR09PL+jujhVg+aYHow+JtvOQg53NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=Q9/51Ve2; arc=none smtp.client-ip=79.135.106.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="Q9/51Ve2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1788986830; x=1789246030;
	bh=lABxs6VEi+8CS6nFugnKUAy5WADKPTGxiYP0lOC9JLI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Q9/51Ve27fIwlYItLOfztKFg1+MvKQN6KrdZovFBD5sp6ZVmmMFQDsFaYC7GBnuAP
	 h482L8BHuh/KxE+bN/1LbtiSLTIfDbwIEsDXZacI6tKH3NbLCU+vtK4KMr+8w/HuG3
	 3Tl7JHoAZIeFWCdcl9BygBt/cCfPNSX9M2kIpzfEH6Heftmt2nlkE+3IQfdvsDu2Jt
	 eKRfjdJR7NWNiskVdPtmt/z/XNS2JTrWJJGJxThag+vUEUVOdHHRE77PoNJSo06NGs
	 Qjxr5tfudJuZjAEM+dqH0sdgsCRHykOYidTgOYBUUITSi9DgDXKdWqhKTXHf0qazcu
	 GeF3h8Q8ub1nA==
Date: Wed, 09 Sep 2026 20:47:04 +0000
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Marcel Holtmann <marcel@holtmann.org>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: "Vladimir V . Kondratyev" <vladimirkondratyev2@gmail.com>, Ravindra <ravindra@intel.com>, Ferenc Lengyel <dev@lengyelf.eu>, Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>, Ravishankar Srivatsa <ravishankar.srivatsa@intel.com>, Paul Menzel <pmenzel@molgen.mpg.de>, Kiran K <kiran.k@intel.com>, Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, Mahalingeshwara Chambarakatta <mahalingeshwara.chambarakatta@intel.com>, Arnd Bergmann <arnd@arndb.de>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and S4
Message-ID: <20260909204654.91282-1-lsa.uz@pm.me>
In-Reply-To: <CABBYNZJfH4F1-Hy1eiOrzuU1nzTbMbue3EqMT5gfHs60wFw9QA@mail.gmail.com>
References: <20260909123416.71919-1-lsa.uz@pm.me> <20260909123416.71919-3-lsa.uz@pm.me> <CABBYNZJfH4F1-Hy1eiOrzuU1nzTbMbue3EqMT5gfHs60wFw9QA@mail.gmail.com>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: 7bba8913a876a238097641328487cca3ecdf0597
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thank you for the pointer. That review reached no list at all: not
linux-bluetooth, not devicetree, and not sashiko's own sashiko-reviews list=
,
which I checked over 31 August to 9 September. It exists only on the site, =
so
without you going to look we would not have known it was there.

One of its three findings is real, reproducible, and worse than it claims. =
I
have measured it rather than argued about it, and the fix is below. The oth=
er
two are at the end, more briefly.

A missed alive interrupt now costs the controller, not just the suspend
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

1/2 makes set_dxstate() return success when the register says the target st=
ate
was reached but the interrupt never arrived. That is correct about the
hardware and silent about data->alive_intr_ctxt, which only the interrupt
handler ever moves. So the tracker is left saying D0 after a suspend that
actually reached D3.

On resume the handler then runs with a stale D0 context while the hardware =
is
already heading to D0, takes neither branch, and sets neither signal_waitq =
nor
submit_rx. btintel_pcie_reset_ia() and btintel_pcie_start_rx() are the only
things that re-arm the RX rings, and nothing else on the resume path calls
them.

Measured with the same fixture as my 2 September matrix - one alive interru=
pt
dropped inside the handler, before it touches anything, which is the state =
a
genuinely missed one leaves:

  no injection      SP11RX: ctxt d3 -> d0, submit_rx=3D1     device unchang=
ed
  interrupt dropped SP11RX: ctxt d0 -> d0, submit_rx=3D0     ...then:

    Bluetooth: hci0: Received hw exception interrupt
    Bluetooth: hci0: command 0x0c01 tx timeout
    Bluetooth: hci0: Opcode 0x0c1a failed: -110
    btintel_pcie 0000:00:14.7: resetting

and the controller comes back as a new hci index. So it is not only that RX
stops: the firmware throws an exception, two HCI commands time out, the dri=
ver
FLRs it, and every paired device is gone until something re-pairs.

The fix
=3D=3D=3D=3D=3D=3D=3D

Do in the fallback what the handler's branch would have done. It mirrors th=
e
handler's own call site, which also ignores start_rx()'s return:

@@ -4204,11 +4204,25 @@ static int btintel_pcie_set_dxstate(struct btintel_=
pcie_data *data, u32 dxstate)
 =09=09if (dxstate =3D=3D BTINTEL_PCIE_STATE_D0) {
-=09=09=09if (btintel_pcie_in_d0(data))
+=09=09=09if (btintel_pcie_in_d0(data)) {
+=09=09=09=09data->alive_intr_ctxt =3D BTINTEL_PCIE_D0;
+=09=09=09=09btintel_pcie_reset_ia(data);
+=09=09=09=09btintel_pcie_start_rx(data);
 =09=09=09=09return 0;
+=09=09=09}
 =09=09} else {
-=09=09=09if (btintel_pcie_in_d3(data))
+=09=09=09if (btintel_pcie_in_d3(data)) {
+=09=09=09=09data->alive_intr_ctxt =3D BTINTEL_PCIE_D3;
 =09=09=09=09return 0;
+=09=09=09}
 =09=09}

Both halves are needed, and I only know that because setting the context al=
one
looked like a complete fix until I dropped the interrupt on the way up
instead:

  build                     drop on D3 entry        drop on D0 entry
  as posted                 wedged, FLR, new hci    -
  context only              clean                   wedged, FLR, new hci
  context + RX re-arm       clean, 3 of 3           clean, 3 of 3

Three cycles of each plus three controls: no "hw exception" and no "resetti=
ng"
in any of the nine, and the hci index never moved. One caveat about my own
instrument: I also counted HCI events during a scan after each resume, and =
one
*control* run returned zero with the device plainly healthy, so that counte=
r is
not trustworthy on its own. The exception and reset lines are what never
misfired.

What I propose to do
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Fold it into 1/2 and send the series as v2. My reasoning is that a fix for =
an
unmerged patch in the same series belongs inside it rather than on top, but=
 I
hold that loosely and a separate patch is just as easy if you prefer it for
review.

It changes Vladimir's logic rather than adding to it, so: Vladimir, say if =
you
would rather carry it yourself and I will hold. Otherwise I will send v2 in=
 a
day or two, unless Luiz would rather see it sooner.

The second finding, which I could not measure
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Moving data->gp0_received =3D false out of the retry loop means a late inte=
rrupt
from attempt N can satisfy wait_event_timeout() at the top of attempt N+1, =
and
"if (status) return 0;" has no hardware check behind it - the register re-r=
ead
1/2 adds sits on the timeout path only. So the function can report success
having just written wr_sleep_cntrl() and waited for nothing, right after th=
e
previous iteration read the hardware and found it *not* in the target state=
.

Real by reading, but unmeasured: my fixture drops interrupts and does not d=
elay
them, so I cannot produce a late one. Saying so rather than implying I test=
ed
it.

The third, which is pre-existing and not this series'
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

set_dxstate() clears the GP0 cause with btintel_pcie_clr_reg_bits(), which =
is
a read-modify-write. BTINTEL_PCIE_CSR_MSIX_HW_INT_CAUSES looks
write-1-to-clear: the interrupt handler acknowledges it by writing back exa=
ctly
what it read. If so the call does the opposite of both halves of its job - =
it
writes 0 to GP0, which clears nothing, and 1 to whatever else was pending i=
n
that register, retiring HWEXP, GP1 or FWTRIG unserviced.

Neither patch touches that line, so it is not this series' business, but
someone at Intel may want it.

Thanks,
Sergey

