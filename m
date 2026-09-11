Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA293F4DE2
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 21:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789160812; cv=none; b=RFW4n9itl157N9FzkGQwebPOAnfLmcxQ1Jw4aQiiswioUrw6jPYILfL3gtR+4RNJaU3Pwfayy4cbKq5k8hbGhESUHQpnF62cOH4YcuweUlfn+VRzL5eV7pqbu/AdCM6H31olBnkj27pCddE2UcqBCp85KA2yUIQ27OjhTuYBe70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789160812; c=relaxed/simple;
	bh=MA2qtN7mULxtG7cEKLaJbCdj53/0F6z9SEiUgnQyyHk=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=H1I38vpnKPvDFjjN9FJlEEJeTlos+LVqOj4PRqgqKowHGz6hUG7dBBNRyFweACb91D3LUSNsR3k9eSVW6dTGQBC6InN9gXsugXq1YQI4fUVog/hr7SFPIbHLsLGoWhm42Q9CP6pUIDUuYNCmFmtnlstQ5gCe18hjOx04vlizQR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=W/jz62AV; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="W/jz62AV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1789160805; x=1789420005;
	bh=tOXOILZg2pKDTX/TniDztESlMwc8JCcimzbiTJIZHFE=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=W/jz62AVr4umDJDS2xY2jpayMN9dUAA07H14wLY4cNAzXjJNUywZwBJM+QN/xoZlh
	 c3y3CEoSKmSUB3AQKQc/3J0NcF0m+uXYwlqEjkJmHjM3Uqrq3ZAQyZd6BvDrAcaWf0
	 yHMo7s/SWcNxOwwBUGE8Ugm5R/HE2NjG/khvPUARo6S56NIub770UYNDmnjoqZrefQ
	 GgqVmJeZQMtBeDin6RvaYSVScbw4QenutRSRKE8YkSUL5xJW002ObLpqBDzbEsI8LW
	 fBDsy2gTAAMRLpQmT5sDN057I25pEFn708NYrjCypwIxFcXutT90p0QHT4sqebkwoc
	 sLiAH+RYFwGPQ==
Date: Fri, 11 Sep 2026 21:06:41 +0000
To: linux-bluetooth@vger.kernel.org, Kiran K <kiran.k@intel.com>
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Ravindra <ravindra@intel.com>
Subject: btintel_pcie: a gp1 mailbox interrupt during firmware download left the controller dead on 7.0; gone on bluetooth-next
Message-ID: <20260911210634.87502-1-lsa.uz@pm.me>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: 38d2bd7912d41fbd218896ea32f8ea37106fd056
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

A race on a shipping distro kernel that I cannot reproduce upstream, and a
control that rules out the obvious explanation. I am reporting it because t=
he
kernel it bites is one people are running today, and because the thing that
looked like the fix demonstrably is not.

What happens on 7.0.0-30-generic
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

Surface Pro 11 for Business, Lunar Lake, Intel BE201 (8086:a876). Roughly o=
ne
warm reboot in twelve leaves the controller dead:

  Bluetooth: hci0: Unsupported cnvi 0x00000000
  Bluetooth: hci0: Controller in error state

adapter DOWN, BD address 00:00:00:00:00:00. Reloading btintel_pcie recovers=
 it
every time, from that same state.

The cnvi line is several steps downstream. What differs is the ordering of =
one
interrupt during the second-stage firmware load. Twelve consecutive warm
reboots, one kernel, one firmware, nothing else changed, one failure:

  failing boot                        every healthy boot
  ---------------------------------   ---------------------------------
  Found device firmware: ...sfi       Found device firmware: ...sfi
  Boot Address: 0x10000800            Boot Address: 0x10000800
  Firmware Version: 107-8.26          Firmware Version: 107-8.26
  Received gp1 mailbox interrupt <--
  Waiting for firmware download ...   Waiting for firmware download ...
  Firmware loaded in 685555 usecs     Firmware loaded in 645371 usecs
  Received gp1 mailbox interrupt      Received gp1 mailbox interrupt
  Controller in error state           Waiting for device to boot

One extra gp1, before the wait rather than after it. Every healthy boot has
exactly 1 gp1 and 0 "Controller in error state"; the failing boot has 6 and=
 3,
the extras being the driver's own retries. Then alive-interrupt timeout, In=
tel
Soft Reset failed (-62), three download retries, dead adapter.

Rates on 7.0.0-30-generic: 1 failure in 12 controlled warm reboots, and 16 =
in
50 retained boots. Controller firmware is 2026.8 build 113003 throughout an=
d
never changed, so this is not a firmware regression; a platform firmware up=
date
did not fix it either.

What happens on bluetooth-next
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D

Built pristine bluetooth-next at e40edfa049 (2026-09-10), same machine, sam=
e
firmware, same day, rebooted under an automated harness. Then built it a se=
cond
time with one patch reverted, and did it again:

  kernel                                       boots   failures
  7.0.0-30-generic (Ubuntu, 6613-mod config)      12          1
  7.0.0-30-generic, retained journal               50         16
  7.2.0-rc6 bluetooth-next                         41          0
  7.2.0-rc6 bluetooth-next, one patch reverted     41          0

The second bluetooth-next row is the point of this message, so it is worth
saying what it was: I reverted

  Bluetooth: btintel_pcie: sync mbox tlv parsing with GP0 alive
  https://lore.kernel.org/linux-bluetooth/20260819143219.22728-2-kiran.k@in=
tel.com/

because it is what replaced the code the failing boots ran - 7.0 logs "Rece=
ived
gp1 mailbox interrupt" unconditionally, bluetooth-next does not and carries=
 an
mbox<->alive handshake instead. It reverts cleanly on its own (1/3 and 3/3 =
do
not, so they stayed in), which made it a single-variable control: same tree=
,
same .config, same signing key, same harness, same day.

**Reverting it does not bring the failure back.** Kiran, your series is not=
 what
closed this, and I would rather say so than let you spend time on a fix tha=
t
is not one.

What the numbers support
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

  P(0 in 41) if the rate were still 1/12                     0.028
  P(both arms clean) if the rate were still 1/12             0.0008
  pooled 0 of 82 on bluetooth-next, 95% upper bound on rate    3.6%

So the difference between these kernels is real, and the race is not proven
gone: 1 in 30 would sit inside this data comfortably. "Not observed in 82
boots, and not the mailbox handshake" is the whole of what I can say.

What is left as a candidate, and I have not separated these: the 7.0 to 7.2
version gap and whatever else changed in btintel over it; Ubuntu's own delt=
a;
and the config, which is the one I would suspect first - the test kernels a=
re
localmodconfig with 273 modules against Ubuntu's 6613, and a leaner boot me=
ans
less contending with the firmware download. A race is exactly what a timing
change hides without fixing.

I stopped there rather than guess further, and I have not bisected the vers=
ion
gap: at 1 in 12 each step needs forty boots to mean anything, an hour a ste=
p,
and one of you may recognise this on sight.

Why it matters beyond this machine: 7.0.0-30-generic is a current Ubuntu
kernel, the failure costs the user Bluetooth outright until a module reload=
,
and nothing in the logs points at a cause. If the change that closed it can=
 be
identified, it looks like a stable candidate.

The hardware is here and the harness is automated - unattended reboots, one
row per boot. Building 7.2 with Ubuntu's full config would separate the tim=
ing
explanation from the code one; that or more boots on any tree you name is a=
bout
an hour, and I am happy to run it.

Sergey

