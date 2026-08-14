Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442D830CD85
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 23:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786750567; cv=none; b=U0SyaARDmfhHvb6CYXkA97l1L6R8jWS1unQkrB3rhW/BRRVw0kpX1aLz0/md9md21fWW+WAjzP5LfzVmtecU1z4SSgRw6wCzwcRMHFnvG4aOaaMWfBdAiV8kozJ/QfkV17aL9fL9Gn5dcThaCpnmet0HZ7MBfOmrQMm3f7PxPz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786750567; c=relaxed/simple;
	bh=n406M06ATv79O0Vsh6vbHjik81TkGp55k4zgcPhBCsg=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=c+klmvDTzmEC0ekwaDInEaBXrYWsH7nzeu2NFxG+WJ9DY4owF7ypx5gN8ZAe+mMNiWcmgyUWIm/0/+wlNg3libEqLTuZXCkLs8p8PnB1kSl3Pq+i7Sf1d8CDqv1O5V94UsBnYje+IHjPOBjq/qAg7vSy8YZdKvANq62y+WLkF+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=W6nDezUT; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="W6nDezUT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1786750547; x=1787009747;
	bh=n406M06ATv79O0Vsh6vbHjik81TkGp55k4zgcPhBCsg=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=W6nDezUT98Q9uRLezIHFP07jUnd/0o4sq8Acz6HqD1gjyTyb9JVSPRS46CUXMiY1e
	 3AjxyZ69zNPANzbUNTEGXI03pDnTDELj062gAvUozNMV1jleoJueRbpI1sGAaNtTLI
	 IgTAbZvpDwhc+/wmxBySsnLYau+rZIBYTUBSV4477apmVY2aeIEASuYM8tNSwP0jxy
	 hm/GQ4+9/CcYL7bswJvnUsiGfUDTRPe07cJFLNAt9Kn2mL6QCMgYCXIZJjRW6AfOlf
	 xWYS1l6PqKiUt05TW+hPS9PU4qVUv/SGKJt3esYTOuvCFJX2mxdJZfuuF0yUmG7Twp
	 a6SpItmPYEpzg==
Date: Fri, 14 Aug 2026 23:35:42 +0000
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: nibbo <nibbo01@proton.me>
Subject: [BUG] Bluetooth: MT7922 active LE scan misses ADV_SCAN_IND seen during passive scan
Message-ID: <SJV4NCsCsuzgYtrsd-ssacoDxzwaT1MYgaSnswFnNLg84G1cUlFPrTttf7W_o9fcIQOtKCRlRl0myFNq9ubEsASY7-8_5WyHDMGxsblJE6U=@proton.me>
Feedback-ID: 166587309:user:proton
X-Pm-Message-ID: fe3d097abb04b9f91ab8602808632fb0aa2cf582
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello,
I am seeing a repeatable difference between active LE discovery and passive
Advertisement Monitor scanning on a MediaTek MT7922 controller. A changing
Apple manufacturer advertisement is absent from raw HCI reports during acti=
ve
scan, but appears immediately when the same controller returns to passive
monitoring.

Hardware and software
---------------------

- Bluetooth adapter: MediaTek MT7922 in a Mercusys MA80XE V2
- USB ID: 13d3:3625, bcdDevice 0100
- USB product: MediaTek Inc. Wireless_Device
- Driver: btusb 0.8 / btmtk 0.1
- Controller firmware log:
=C2=A0 `HW/SW Version: 0x008a008a, Build Time: 20260724143815`
- Kernel: 7.1.8-1-cachyos x86_64
- BlueZ: 5.87
- linux-firmware: 20260810
- Remote device: Apple AirPods Pro
- Controller Advertisement Monitor support:
=C2=A0 `controller-patterns`, monitor type `or_patterns`

The relevant legacy scannable advertisement is an ADV_SCAN_IND whose
manufacturer data begins with:

=C2=A0 =C2=A0 ff 4c 00 07 19 01

`4c 00` is the Apple company ID and `07 19 01` identifies the status payloa=
d
used in this reproducer. The raw btmon entry identifies it as follows:

=C2=A0 =C2=A0 Event type: 0x0012
=C2=A0 =C2=A0 =C2=A0 Props: 0x0012
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Scannable
=C2=A0 =C2=A0 =C2=A0 =C2=A0 Use legacy advertising PDUs
=C2=A0 =C2=A0 Legacy PDU Type: ADV_SCAN_IND (0x0012)

Results
-------

All counts below are from raw `> HCI Event: LE Meta Event` advertising repo=
rts,
not duplicated MGMT/control renderings. These were separate captures with
different durations and ambient traffic, so the total Apple counts are sani=
ty
checks rather than rates to compare across captures.

1. Clean BlueZ LE-only discovery, no Advertisement Monitor:

=C2=A0 =C2=A0- Extended active scan
=C2=A0 =C2=A0- LE 1M: interval/window 11.25/11.25 ms
=C2=A0 =C2=A0- LE Coded: interval/window 33.75/33.75 ms
=C2=A0 =C2=A0- Filter policy: accept all advertisements
=C2=A0 =C2=A0- Controller duplicate filtering: enabled
=C2=A0 =C2=A0- BR/EDR Inquiry: none
=C2=A0 =C2=A0- Apple advertisements: 64
=C2=A0 =C2=A0- Target `4c 00 07 19 01` advertisements: 0

2. Same normal active discovery with
=C2=A0 =C2=A0`HCI_QUIRK_STRICT_DUPLICATE_FILTER` temporarily enabled throug=
h debugfs:

=C2=A0 =C2=A0- The debugfs attribute was present at
=C2=A0 =C2=A0 =C2=A0`/sys/kernel/debug/bluetooth/hci1/quirk_strict_duplicat=
e_filter` and
=C2=A0 =C2=A0 =C2=A0initially read `N`.
=C2=A0 =C2=A0- The controller was powered down, `Y` was written to that exa=
ct attribute,
=C2=A0 =C2=A0 =C2=A0the `Y` readback was verified, and the controller was p=
owered up afterward.
=C2=A0 =C2=A0- No Advertisement Monitor was registered; btmon contained zer=
o monitor
=C2=A0 =C2=A0 =C2=A0add/program commands.
=C2=A0 =C2=A0- Scan parameters were the same as above.
=C2=A0 =C2=A0- HCI confirmed `Filter duplicates: Disabled (0x00)`.
=C2=A0 =C2=A0- BR/EDR Inquiry: none
=C2=A0 =C2=A0- Apple advertisements: 46
=C2=A0 =C2=A0- Target `4c 00 07 19 01` advertisements: 0

=C2=A0 =C2=A0The controller was powered down again, the attribute was resto=
red to `N`,
=C2=A0 =C2=A0the controller was powered up, and both final states were veri=
fied. This
=C2=A0 =C2=A0shows that disabling controller duplicate filtering is not suf=
ficient to
=C2=A0 =C2=A0make this target advertisement appear during active scanning o=
n this setup.

3. Controlled active-to-passive transition during one case-open event:

=C2=A0 =C2=A0- A controller-offloaded Advertisement Monitor pattern for
=C2=A0 =C2=A0 =C2=A0`ff:0:4c00071901` was registered.
=C2=A0 =C2=A0- Normal BlueZ LE discovery then ran in active mode for approx=
imately 15
=C2=A0 =C2=A0 =C2=A0seconds, with duplicate filtering disabled because moni=
toring was present.
=C2=A0 =C2=A0- During the active phase: 0 target advertisements.
=C2=A0 =C2=A0- Discovery was stopped, so the existing Advertisement Monitor=
 resumed its
=C2=A0 =C2=A0 =C2=A0passive scan.
=C2=A0 =C2=A0- Target ADV_SCAN_IND reports then appeared in the raw HCI str=
eam.
=C2=A0 =C2=A0- During that passive phase: 52 target advertisements.

4. Separate passive Advertisement Monitor capture:

=C2=A0 =C2=A0- HCI confirmed extended passive scan and duplicate filtering =
disabled.
=C2=A0 =C2=A0- Raw HCI Apple advertisements: 301
=C2=A0 =C2=A0- Raw HCI target advertisements: 206

In that capture the case remained open and untouched across the active-to-
passive transition. No target report appeared in the active portion, while =
52
appeared after passive monitoring resumed. Other Apple advertisements conti=
nued
to be reported during active scan.

Expected behavior
-----------------

Because passive scanning reports the complete ADV_SCAN_IND in the raw HCI
stream, while repeated active captures report other Apple advertisements bu=
t
none matching this target, I expected this PDU to reach the host during act=
ive
scanning as well. If this difference is intentional, clarification would be
appreciated.

Questions
---------

- Could the difference originate in the MT7922 active scanning path, for
=C2=A0 example in controller/firmware SCAN_REQ handling for this ADV_SCAN_I=
ND?
- Is there an existing btmtk/controller quirk suitable for forcing passive =
LE
=C2=A0 discovery on affected hardware, or should this be handled in firmwar=
e?
- Would maintainers prefer the complete btmon captures or a smaller btsnoop
=C2=A0 reproducer with device addresses redacted?

As an application-level workaround, registering a BlueZ
AdvertisementMonitor1 pattern and using its passive controller-offloaded sc=
an
reliably receives the packets. The report is about the underlying active-sc=
an
discrepancy rather than that workaround.

Thanks.
