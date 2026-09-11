Received: from mail-244122.protonmail.ch (mail-244122.protonmail.ch [109.224.244.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914E83BED44
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Sep 2026 09:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789119569; cv=none; b=p/58iOvrDsbPG4u8LInPSwPGTrTY5uxY5njrqTtuQGtkYyA46PRdhi5jEH2+futSeLBrSXGL7JtwwuuPfvWXjzFSPG9ZcjmAWZZEGKpCLdM3oWQn1zdSud0bP4FatmdRiU6ueppR781X7Jm0DEuZ18LKso749xSrASDt0Z9q/vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789119569; c=relaxed/simple;
	bh=wLKGCzBY4sX9VCaGpVxjuejmnyUu4j0g5ad0GPZGqW0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dhCxyH8rdoULE82h0A4RlGTLbti+517vThwqRqLyoRnAm1NHUGuVp3QrFmQ/bAepUjqmHe0n17eHXkdxkGGgMljjs+5ferruzw8+AFyTIZFo9mtxkvDvdIpStKFZ+m4gLYMXu0axouACZ0xJcisEfHCvYQd8JrNEMI3wLp3K1+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=MTnw08GI; arc=none smtp.client-ip=109.224.244.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="MTnw08GI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1789119559; x=1789378759;
	bh=y13xzxjeBXVdL02ezmce+5eyTzocO9iLF6PPN/+5D5E=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=MTnw08GIwQCydCToq6gmIAlHLGseivvb9uJfbiT5oZxO3l3oDgIU54fq1BESmZ9Az
	 Uj1V/lwTWBb2t9gZ/m4XesytDHVxRsf5K790rCX0azWXNqodMUiN9ZLxYxeOJFovgg
	 dbWY066rMfAnfb1mCnUNSYjKvQ9j+OPhzJqt3yrooVFkRrl2EvSRss5LYZfjd7mTw2
	 YLPszRjtfvQnKKhTHJ9BFboxIbp5T0UYDV5jXo477g0xFI3FDFKGOyVRVi1Z1xmFd6
	 TugpgBQ1NT35+eeGaPOY2GSAxSv8Q1R7dVkKcCnW3Im8ZD4O9LNV9uj7ciFn8mJ4Y6
	 qWaqNybkzbxzw==
Date: Fri, 11 Sep 2026 09:39:15 +0000
To: linux-bluetooth@vger.kernel.org
From: Sergey Lebedev <lsa.uz@pm.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Kiran K <kiran.k@intel.com>, Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>, Ravindra <ravindra@intel.com>, "Vladimir V . Kondratyev" <vladimirkondratyev2@gmail.com>, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: btintel_pcie: controller left dead after a boot-stage error, 1 in 12 warm reboots
Message-ID: <20260911093904.68667-1-lsa.uz@pm.me>
In-Reply-To: <20260831124952.87484-1-lsa.uz@pm.me>
References: <20260831124952.87484-1-lsa.uz@pm.me>
Feedback-ID: 113843758:user:proton
X-Pm-Message-ID: b7d9a7961c90f8ddf1cf1d98eb2189b824f357a5
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Following up my own report of 31 August with the measurement it was missing=
.
That one gave a rate from a mixed sample and could not say whether the fail=
ure
needs a previous boot to have happened. It does not, but it very nearly doe=
s.

Same machine, same kernel (7.0.0-30-generic), same firmware, one day:

  warm reboots, gap >=3D 200 s     4 of 10 failed
  cold boots, full power cycle   1 of 11 failed

Cold boots were ~270 s apart, so they are compared against warm reboots at =
a
similar cadence rather than against the whole warm sample. That matters: th=
e
raw figures are 16 of 30 warm against 1 of 11 cold, but most of those warm
reboots were 60 s apart and quick reboots fail more often on their own - 61=
 %
under 120 s against 40 % over 200 s. Against the matched 40 %, one failure =
in
eleven gives p =3D 0.03; against the unmatched 53 % it would look three tim=
es
stronger than it is.

The cold boots were automated: rtcwake arms an alarm, the machine powers do=
wn
fully, the firmware wakes it, a boot service records whether the driver pro=
bed.
Eleven cycles, no hands.

Where it stops, unchanged from the earlier report:

  Bluetooth: hci0: Firmware loaded in 75464 usecs
  Bluetooth: hci0: Device booted in 3338 usecs
  Bluetooth: hci0: Waiting for device transition to d0
      Timeout (3000 ms) on alive interrupt, alive context: intel_reset1
      Intel Soft Reset failed (-62)
      Controller in error state
  btintel_pcie 0000:00:14.7: probe with driver btintel_pcie failed with err=
or -62

btintel_boot_wait_d0() waits on INTEL_WAIT_FOR_D0 and, when the notificatio=
n
does not arrive, returns -ETIMEDOUT. There is no second question asked of t=
he
hardware. btintel_pcie_set_dxstate() waits for the same class of notificati=
on
and then reads the boot-stage register to see whether the controller got th=
ere
anyway; that fallback is why the suspend path survives a dropped interrupt =
and
this one does not.

What the cold figures add is which of those two stories is true. A full pow=
er
cycle clears everything the previous boot left behind, and the rate falls f=
rom
40 % to 9 % - but not to zero. So the dropped notification is not an artefa=
ct
of re-initialising a controller that was already up: it happens on a cold
controller too, just far less often. Leftover state makes it much more like=
ly;
it is not the cause.

Recovery is unchanged and total: modprobe -r btintel_pcie && modprobe
btintel_pcie brings the controller up every time, from the same state that
killed the probe. The hardware is fine; only this wait gives up on it.

So the question I am asking, and it is a question rather than a patch: shou=
ld
btintel_boot_wait_d0() get the same backstop - read the boot-stage register
before returning -ETIMEDOUT? I have not sent one because the D0 state is
reported through an hdev flag rather than the register that set_dxstate()
consults, and I do not know from outside whether the two are meant to be
equivalent on this generation. If they are, the fix is small and I am happy=
 to
write and test it here. If they are not, that is the answer and I will stop=
.

Hardware: Intel BE201, 8086:a876, on a Microsoft Surface Pro 11 for Busines=
s
(Lunar Lake). Firmware 2026.8 build 113003, SHA1 0x08f159a0 - unchanged
throughout, so nothing here is a firmware regression.

Sergey

