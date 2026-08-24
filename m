Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFAA49364D
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 19:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787599958; cv=pass; b=cKRWb7Zsqv3JBtuwy/j/Zwt3nEFOHhKZh7Tkoj64AYp4qSoa+BJgOU4rSqzAxIoR1wWCMLPQaaSRb8WuCl7784LpGWGWMMcEMQ1HcHA+DtagtCWWD2Evu71axphRpr6ng2caGYBU1n+K3fk6AT/v0+W3GIkqLGCvc/hLh+33rBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787599958; c=relaxed/simple;
	bh=K/wWT9dnOpjwQLTQSk864TBPLj6wA0F+DQzHzcR3gyE=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=iOr0OmpFTM0oKL0D+8VfsM8r516qgEQfYWyLNfHnoI8X+sIMK2+EQAra0qA7lGLbFw/SG7C1pLb1GvpmX3xSmYW538cFqvfceE22/lDDcqhyPTUD+YC7dce8U3BUMCOno1wP0TOSLAPRhQ4QT18gBb56nZM6NaJXU73ACgkrEOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niIWeUF/; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niIWeUF/"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b01146b205so2676126e87.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Aug 2026 12:32:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787599954; cv=none;
        d=google.com; s=arc-20260327;
        b=a/CayHU7JyvmkUiXc52zFDOx3enMaBw9qaZCO3gnA2EuT4cPxAj0stG8O1UToqIRT2
         jhjw2VDP+5thAuityaAt9TgjqO1rxcuUstSIsYf7bE5c0F24YuImojDq0LHFZ/IKuRpM
         pjiRsos1clHDBx0UKpcy1qZk0lUQd393tqA/EWTs108sbASpPlLIovxhbMLNeUo7esFd
         n4aAtkriOhwR/0hZ93Db2WCLOc3zaI+pHTzSU6jyCTcFm/ihsY6++IkUazCHUuppR1ji
         AQSgyWXpGtYvMa/pQVZhZJAClrsRQrMIx1sr/MGWtgogUcbUzVQtyrxOjkCGUMs3Ytdn
         gpsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+Cht892iobkPiug/YCXY4E6HTTNvKvvNPGIYk3ea120=;
        fh=nBN5WOfDgUgJyD8TqowHI51eNfbufHSWk5EqmtS/4TA=;
        b=GnCK+yLCt1bFzG0pLZbSiABxZKgsD5/stZG8fpuBrmQRsd1gfrCiv6DUSoeKcBnWnM
         cqOYQp58uqXXfe3dmwGJG1qV5e7NdqGR0R7KYkoSje8KgTPw/f6uxbrnWTfjQjHU7ylp
         UCBzLJMRF3+tMzrgKuOtW1ntCxs2lWSrCTPZ5IZsDkRq+Yb4ToPKaZ2TZ6YuswmUdS0O
         J2gsIAYXUfKw/EsowXiEO+R80jjHUX82nsJ1v9Y+rg+I5ZY158g5EmmEykFbBwU8tvDH
         5Aq+raZbYls1ELZqHaZwhuDxbwxExNg6DbplT2wJqB8vfFU7rQ+08hPe2BMVOGX/+X3I
         Tsbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787599954; x=1788204754; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Cht892iobkPiug/YCXY4E6HTTNvKvvNPGIYk3ea120=;
        b=niIWeUF/McaNx56abdEnk8puubELGTm/AaKVUF22RSwKCf7J6gW3oTq02caWhZbnqz
         cwMLHk/r1AFPc7oB1JTYZ8wV9jZ+Hgb6cLQJoBBp4C6nLuRRnLcf2Lw/DOHRigz1csmV
         b/l/sDj6RdoDQgyVuZBdHOsNIUP2VZg2dWkRx2r7sBx5tbUtaIlsX9B+mMAdUsWTKtoo
         e59NkOBQ7lDK83CMdAQ0oEoYpj4EF7jf2fmwkz2ftKz22zGp47nNOOfmUhyDE/ea/Qfg
         5HTf0dIdAH4szv2efS66F/DYq7EgPVV3aM3UlE2qkUrgkD19RNMk6vl/YLQoklqUmg9c
         aiNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787599954; x=1788204754;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+Cht892iobkPiug/YCXY4E6HTTNvKvvNPGIYk3ea120=;
        b=X5Yk/LVd+rUq7XeFVt/Kzsaw5NrVQVsRARJZRs8bdxfQ0Ce8esrmkDnPhY9g9a4Dit
         0EFKpqYJdhndzSOdCSWF8iw3uCf5V6BdJ3kFqP7yUI6RW/Oo1zhYbkr94NVcI94iTei4
         o09Zgf5sxoLwtC/8nAHYdgMHNrGvrMvS5zcBfiYwtUE3SIHwHbfgYpPRj3juCJbxq7oU
         SwAVSLlLLB6ISjGtldDMgcxhQNk0Q5JEIfLBxPANBrBtMES1Q7K4cb9yMKu8lVJKyS3a
         QLYUiEf9zVZX2b1F+PA8fr3i+XLgrFf32EMDbKtc7RFvxiPI7d1xKFxgD+L8QqDQ7Pix
         iQCQ==
X-Gm-Message-State: AFuF++kcj+lK/PjDG71c8+PRa1BvlH7kQluEQNFp+6IweeNbW/A3ImN+
	4zeGWXTeMfJ7I2vjnseFf4LxuQhY/kNltwfKT+3oDn3Oas0QIji1MH2sXaGuuY29E/2ma6yQFpA
	8EKecR3RUXqgMbJNijSA+qEP0td9oZcHuZN4T5oA=
X-Gm-Gg: AR+sD13zgRX6TMrihGB7ekhwycg6BLTl8U0tDb1L+qSfps4Q6/Wb+ZaSGkt5Zgwk/V6
	hi13VdM4RcDxgujgFvciNH9I/DeIyaK2+cSxdUJCQ9KhxqyFbzqnJwneYUypiyA+j+L/z6PFwfq
	dywnkPMLI+I+0K7Lomnclu4PTmAvPV2Df8Qn3kmyJC+wdbrJAVMe55c0zHorucVOhov1Z3TMVLM
	5bK4iWx10PmzSFVFqIzhFYUIVgOlktaAMyxniw8ELvaxPUMn2sFKUWJHTA0hZy8naHcGIy/6rvf
	dhRPiZZdBc5EJFq3G4MeK7SkwSwcy6I3EGKXZ70GMtLc2Q==
X-Received: by 2002:a05:6512:b2a:b0:5b2:a21a:10e7 with SMTP id
 2adb3069b0e04-5b48b8c31d4mr6282676e87.25.1787599953337; Mon, 24 Aug 2026
 12:32:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Daniel Minchev <uldixxion@gmail.com>
Date: Mon, 24 Aug 2026 22:32:21 +0300
X-Gm-Features: AcwNN1WG21gCE2CDHtfuzPsIAZqqYuErd-AM7l0t3ppOhkXKEzjgX5lD6wjaWc0
Message-ID: <CAPCBbk7t6OKtOGynNhf6oGnxGrSEqkh-SfweO_Yfms5NXDSCZQ@mail.gmail.com>
Subject: =?UTF-8?Q?MT7925_=280e8d=3A0717=29=3A_HFP_microphone_unusable_=E2=80=94_firm?=
	=?UTF-8?Q?ware_delivers_zero=2Dfilled_=28e=29SCO_frames_on_sentinel_handle_0?=
	=?UTF-8?Q?x0E00?=
To: linux-bluetooth@vger.kernel.org
Cc: "chris.lu@mediatek.com" <chris.lu@mediatek.com>
Content-Type: multipart/mixed; boundary="0000000000003868830659d00cab"

--0000000000003868830659d00cab
Content-Type: multipart/alternative; boundary="0000000000003868810659d00ca9"

--0000000000003868810659d00ca9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I am reporting a hands-free (HFP) microphone failure on the MediaTek MT7925
(RZ717) USB Bluetooth controller, with evidence that points at the
controller firmware's synchronous-audio receive path. I can reproduce this
at will and am happy to test patches or capture further traces.

Hardware / software
-------------------
- Controller: MediaTek MT7925 (RZ717), USB 0e8d:0717, on an ASRock X870
  Pro RS WiFi desktop board (module is the stock M.2 combo card)
- Kernel: 7.2.0-1-cachyos (happy to reproduce on mainline if needed)
- BT firmware: BT_RAM_CODE_MT7925_1_1_hdr.bin from linux-firmware
  20260810 (build 20260605...); 20260622 behaves identically
- BlueZ 5.87, PipeWire 1.6.8 / WirePlumber 0.5.15 (native HFP backend)
- Failing headset: Huawei FreeClip 2 (BT 6.0, LE-Audio-first design,
  classic HFP fallback)
- Control headset: Motorola moto buds+ =E2=80=94 mSBC HFP microphone works
  perfectly on the same adapter and stack
- The failing headset's microphone works fine on macOS (Broadcom
  controller) and on phones, so the headset side is functional

Symptom (stock kernel)
----------------------
A2DP works. On switching to the HFP profile, codec negotiation succeeds
(AT+BCS=3D2), Setup Synchronous Connection completes with Status: Success
(eSCO, Air mode Transparent, 60-byte packets), but no microphone audio
ever reaches userspace. dmesg fills with:

    Bluetooth: hci0: corrupted SCO packet
    Bluetooth: hci0: SCO packet for unknown connection handle 3584
    Bluetooth: hci0: ACL packet for unknown connection handle 3837

Note 3584 =3D 0x0E00 and 3837 =3D 0x0EFD. The 0x0EFD ACL traffic matches wh=
at
was identified in bugzilla #220564 as firmware-generated diag data on a
pseudo-handle; the SCO flavor appears to be unhandled.

Analysis (btmon capture attached)
---------------------------------
The attached btsnoop capture shows the defect at its origin: after Setup
Synchronous Connection on the BR-ACL link (handle 51), a retried setup is
rejected with Command Status 0x20 (Unsupported LMP Parameter Value), and
then the controller delivers:

    > HCI Event: Synchronous Connect Complete
        Status: Success (0x00)
        Handle: 3584            <-- 0x0E00, invalid/sentinel
        Link type: eSCO, Air mode: Transparent, RX/TX packet length: 60

i.e. the firmware reports a successful eSCO connection on the bogus
sentinel handle 0x0E00 in the completion event itself. The host cannot
associate that handle, and all subsequent incoming SCO data (tagged with
the same 0x0E00) is dropped. In earlier captures on the same setup I also
force-delivered those frames to userspace via the attached
handle-rewrite experiment: every frame is exactly 60 bytes of 0x00 =E2=80=
=94 not
valid mSBC (which always contains sync/header structure even for encoded
silence) =E2=80=94 so even when accepted, the stream carries no microphone =
data.

CVSD behaves slightly differently: the link sometimes carries real audio
briefly (a lucky first attempt after a fresh reconnect), then degrades to
the same zero/drop behavior. mSBC (Transparent air mode) has never
delivered a single non-zero frame across several dozen attempts. This
asymmetry suggests the Transparent-mode RX path in firmware is broken
outright while the firmware-decoded CVSD path is merely unreliable.

Ruled out / experiments performed
---------------------------------
- linux-firmware 20260622 vs 20260810: no difference
- bluetooth.disable_esco=3D1: no improvement
- multipoint/dual-device disabled; headset on latest firmware
- Delaying cleanup of outgoing SCO/eSCO conns pending in BT_CONNECT
  (hci_conn_drop currently schedules immediate cleanup for SCO/eSCO;
  since there is no HCI command to cancel a pending Setup Synchronous
  Connection, an early drop races the controller's completion and orphans
  the eSCO handle =E2=80=94 separate issue, but it reliably worsens this on=
e):
  with a 2s delay the transport becomes stable, but payloads remain zeros.
- Removing the blanket HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for the
  MTK block in btusb_probe() (cf. bugzilla #221722): Enhanced Setup
  Synchronous Connection is then used and completes successfully =E2=80=94 =
but
  incoming frames are still zero-filled on handle 0x0E00.
- Rewriting the bogus handle in btusb_recv_isoc() to the active eSCO
  conn's handle (analogous to "Bluetooth: btrtl: Fixup SCO header"):
  frames are then delivered to userspace, confirming the payloads are
  zeros end-to-end. Patch attached for reference.

Related reports (this looks like one firmware defect seen from
different angles):
- bugzilla #221722 =E2=80=94 MT7925 HFP mSBC produces all-zero samples
- bugzilla #220564 =E2=80=94 MTK firmware emits ACL on pseudo-handle 0x0EFD
  (confirmed by MediaTek as firmware diag traffic)
- bluez/bluez#2067 =E2=80=94 MT7925 LE Audio duplex collapses with "ISO pac=
ket
  for unknown connection handle 0" (same RX-direction pattern on ISO)
- The unmerged "Bluetooth: btusb: deal with MT7925 invalid ISO RX
  packets" thread describes the ISO twin of this behavior

Questions / requests
--------------------
1. To MediaTek: can the (e)SCO RX path (particularly Transparent air
   mode) be looked at in the MT7925 BT firmware? I can provide any
   captures or run any diagnostics needed.
2. Should btmtk grow a SCO-handle validation/fixup analogous to btrtl's,
   or should the 0x0Exx pseudo-handles be routed to hci_recv_diag() on
   the isoc path as is already done for some pseudo-handles on the ACL
   path?
3. Is the blanket BROKEN_ENHANCED_SETUP_SYNC_CONN quirk for all MediaTek
   devices still appropriate given #221722 and the behavior above?

Attachments: btmon btsnoop capture of a failing HFP session, dmesg
excerpt, version details, and the two experiment patches.

Thanks,
Daniel

--0000000000003868810659d00ca9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>I am reporting a hands-free (HFP) microphone fa=
ilure on the MediaTek MT7925<br>(RZ717) USB Bluetooth controller, with evid=
ence that points at the<br>controller firmware&#39;s synchronous-audio rece=
ive path. I can reproduce this<br>at will and am happy to test patches or c=
apture further traces.<br><br>Hardware / software<br>-------------------<br=
>- Controller: MediaTek MT7925 (RZ717), USB 0e8d:0717, on an ASRock X870<br=
>=C2=A0 Pro RS WiFi desktop board (module is the stock M.2 combo card)<br>-=
 Kernel: 7.2.0-1-cachyos (happy to reproduce on mainline if needed)<br>- BT=
 firmware: BT_RAM_CODE_MT7925_1_1_hdr.bin from linux-firmware<br>=C2=A0 202=
60810 (build 20260605...); 20260622 behaves identically<br>- BlueZ 5.87, Pi=
peWire 1.6.8 / WirePlumber 0.5.15 (native HFP backend)<br>- Failing headset=
: Huawei FreeClip 2 (BT 6.0, LE-Audio-first design,<br>=C2=A0 classic HFP f=
allback)<br>- Control headset: Motorola moto buds+ =E2=80=94 mSBC HFP micro=
phone works<br>=C2=A0 perfectly on the same adapter and stack<br>- The fail=
ing headset&#39;s microphone works fine on macOS (Broadcom<br>=C2=A0 contro=
ller) and on phones, so the headset side is functional<br><br>Symptom (stoc=
k kernel)<br>----------------------<br>A2DP works. On switching to the HFP =
profile, codec negotiation succeeds<br>(AT+BCS=3D2), Setup Synchronous Conn=
ection completes with Status: Success<br>(eSCO, Air mode Transparent, 60-by=
te packets), but no microphone audio<br>ever reaches userspace. dmesg fills=
 with:<br><br>=C2=A0 =C2=A0 Bluetooth: hci0: corrupted SCO packet<br>=C2=A0=
 =C2=A0 Bluetooth: hci0: SCO packet for unknown connection handle 3584<br>=
=C2=A0 =C2=A0 Bluetooth: hci0: ACL packet for unknown connection handle 383=
7<br><br>Note 3584 =3D 0x0E00 and 3837 =3D 0x0EFD. The 0x0EFD ACL traffic m=
atches what<br>was identified in bugzilla #220564 as firmware-generated dia=
g data on a<br>pseudo-handle; the SCO flavor appears to be unhandled.<br><b=
r>Analysis (btmon capture attached)<br>---------------------------------<br=
>The attached btsnoop capture shows the defect at its origin: after Setup<b=
r>Synchronous Connection on the BR-ACL link (handle 51), a retried setup is=
<br>rejected with Command Status 0x20 (Unsupported LMP Parameter Value), an=
d<br>then the controller delivers:<br><br>=C2=A0 =C2=A0 &gt; HCI Event: Syn=
chronous Connect Complete<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Status: Success (0=
x00)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Handle: 3584 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0&lt;-- 0x0E00, invalid/sentinel<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 Link type: eSCO, Air mode: Transparent, RX/TX packet length: 60<br><=
br>i.e. the firmware reports a successful eSCO connection on the bogus<br>s=
entinel handle 0x0E00 in the completion event itself. The host cannot<br>as=
sociate that handle, and all subsequent incoming SCO data (tagged with<br>t=
he same 0x0E00) is dropped. In earlier captures on the same setup I also<br=
>force-delivered those frames to userspace via the attached<br>handle-rewri=
te experiment: every frame is exactly 60 bytes of 0x00 =E2=80=94 not<br>val=
id mSBC (which always contains sync/header structure even for encoded<br>si=
lence) =E2=80=94 so even when accepted, the stream carries no microphone da=
ta.<br><br>CVSD behaves slightly differently: the link sometimes carries re=
al audio<br>briefly (a lucky first attempt after a fresh reconnect), then d=
egrades to<br>the same zero/drop behavior. mSBC (Transparent air mode) has =
never<br>delivered a single non-zero frame across several dozen attempts. T=
his<br>asymmetry suggests the Transparent-mode RX path in firmware is broke=
n<br>outright while the firmware-decoded CVSD path is merely unreliable.<br=
><br>Ruled out / experiments performed<br>---------------------------------=
<br>- linux-firmware 20260622 vs 20260810: no difference<br>- bluetooth.dis=
able_esco=3D1: no improvement<br>- multipoint/dual-device disabled; headset=
 on latest firmware<br>- Delaying cleanup of outgoing SCO/eSCO conns pendin=
g in BT_CONNECT<br>=C2=A0 (hci_conn_drop currently schedules immediate clea=
nup for SCO/eSCO;<br>=C2=A0 since there is no HCI command to cancel a pendi=
ng Setup Synchronous<br>=C2=A0 Connection, an early drop races the controll=
er&#39;s completion and orphans<br>=C2=A0 the eSCO handle =E2=80=94 separat=
e issue, but it reliably worsens this one):<br>=C2=A0 with a 2s delay the t=
ransport becomes stable, but payloads remain zeros.<br>- Removing the blank=
et HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN for the<br>=C2=A0 MTK block in=
 btusb_probe() (cf. bugzilla #221722): Enhanced Setup<br>=C2=A0 Synchronous=
 Connection is then used and completes successfully =E2=80=94 but<br>=C2=A0=
 incoming frames are still zero-filled on handle 0x0E00.<br>- Rewriting the=
 bogus handle in btusb_recv_isoc() to the active eSCO<br>=C2=A0 conn&#39;s =
handle (analogous to &quot;Bluetooth: btrtl: Fixup SCO header&quot;):<br>=
=C2=A0 frames are then delivered to userspace, confirming the payloads are<=
br>=C2=A0 zeros end-to-end. Patch attached for reference.<br><br>Related re=
ports (this looks like one firmware defect seen from<br>different angles):<=
br>- bugzilla #221722 =E2=80=94 MT7925 HFP mSBC produces all-zero samples<b=
r>- bugzilla #220564 =E2=80=94 MTK firmware emits ACL on pseudo-handle 0x0E=
FD<br>=C2=A0 (confirmed by MediaTek as firmware diag traffic)<br>- bluez/bl=
uez#2067 =E2=80=94 MT7925 LE Audio duplex collapses with &quot;ISO packet<b=
r>=C2=A0 for unknown connection handle 0&quot; (same RX-direction pattern o=
n ISO)<br>- The unmerged &quot;Bluetooth: btusb: deal with MT7925 invalid I=
SO RX<br>=C2=A0 packets&quot; thread describes the ISO twin of this behavio=
r<br><br>Questions / requests<br>--------------------<br>1. To MediaTek: ca=
n the (e)SCO RX path (particularly Transparent air<br>=C2=A0 =C2=A0mode) be=
 looked at in the MT7925 BT firmware? I can provide any<br>=C2=A0 =C2=A0cap=
tures or run any diagnostics needed.<br>2. Should btmtk grow a SCO-handle v=
alidation/fixup analogous to btrtl&#39;s,<br>=C2=A0 =C2=A0or should the 0x0=
Exx pseudo-handles be routed to hci_recv_diag() on<br>=C2=A0 =C2=A0the isoc=
 path as is already done for some pseudo-handles on the ACL<br>=C2=A0 =C2=
=A0path?<br>3. Is the blanket BROKEN_ENHANCED_SETUP_SYNC_CONN quirk for all=
 MediaTek<br>=C2=A0 =C2=A0devices still appropriate given #221722 and the b=
ehavior above?<br><br>Attachments: btmon btsnoop capture of a failing HFP s=
ession, dmesg<br>excerpt, version details, and the two experiment patches.<=
br><br>Thanks,<br>Daniel</div>

--0000000000003868810659d00ca9--
--0000000000003868830659d00cab
Content-Type: text/plain; charset="US-ASCII"; name="dmesg-excerpt.txt"
Content-Disposition: attachment; filename="dmesg-excerpt.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mt7mtbrc1>
X-Attachment-Id: f_mt7mtbrc1

WyA0MDQ5LjMxMjgxM10gQmx1ZXRvb3RoOiBoY2kwOiBBQ0wgcGFja2V0IGZvciB1bmtub3duIGNv
bm5lY3Rpb24gaGFuZGxlIDM4MzcKWyA0ODM3Ljg3NjA0OF0gQmx1ZXRvb3RoOiBoY2kwOiBIVy9T
VyBWZXJzaW9uOiAweDAwMDAwMDAwLCBCdWlsZCBUaW1lOiAyMDI2MDYwNTE4NDkzNQpbIDQ4Mzku
NzA1MzIwXSBCbHVldG9vdGg6IGhjaTA6IERldmljZSBzZXR1cCBpbiAxNzk4MjE3IHVzZWNzClsg
NDgzOS43MDUzMjRdIEJsdWV0b290aDogaGNpMDogSENJIEVuaGFuY2VkIFNldHVwIFN5bmNocm9u
b3VzIENvbm5lY3Rpb24gY29tbWFuZCBpcyBhZHZlcnRpc2VkLCBidXQgbm90IHN1cHBvcnRlZC4K
WyA0ODM5Ljg3Mzk0N10gQmx1ZXRvb3RoOiBoY2kwOiBBT1NQIGV4dGVuc2lvbnMgdmVyc2lvbiB2
MS4wMApbIDQ4MzkuODczOTUyXSBCbHVldG9vdGg6IGhjaTA6IEFPU1AgcXVhbGl0eSByZXBvcnQg
aXMgc3VwcG9ydGVkClsgNDgzOS44NzQwMzddIEJsdWV0b290aDogTUdNVCB2ZXIgMS4yMwpbIDUw
ODIuMTYxNzE2XSBCbHVldG9vdGg6IGhjaTA6IEFDTCBwYWNrZXQgZm9yIHVua25vd24gY29ubmVj
dGlvbiBoYW5kbGUgMzgzNwpbIDU2MDcuNTU3NTc2XSBCbHVldG9vdGg6IGhjaTA6IEFDTCBwYWNr
ZXQgZm9yIHVua25vd24gY29ubmVjdGlvbiBoYW5kbGUgMzgzNwpbIDU2NjcuNTU3MTEwXSBCbHVl
dG9vdGg6IGhjaTA6IEFDTCBwYWNrZXQgZm9yIHVua25vd24gY29ubmVjdGlvbiBoYW5kbGUgMzgz
NwpbIDc3MDkuODM0NDIxXSBCbHVldG9vdGg6IGhjaTA6IEFDTCBwYWNrZXQgZm9yIHVua25vd24g
Y29ubmVjdGlvbiBoYW5kbGUgMzgzNwpbIDc3MTIuOTg5MzU2XSBCbHVldG9vdGg6IGhjaTA6IEFD
TCBwYWNrZXQgZm9yIHVua25vd24gY29ubmVjdGlvbiBoYW5kbGUgMzgzNwpbIDc3MjMuMzYzMTg0
XSBCbHVldG9vdGg6IGhjaTA6IEFDTCBwYWNrZXQgZm9yIHVua25vd24gY29ubmVjdGlvbiBoYW5k
bGUgMzgzNwpbIDc3NTIuNTQxNzY4XSBCbHVldG9vdGg6IGhjaTA6IFNDTyBwYWNrZXQgZm9yIHVu
a25vd24gY29ubmVjdGlvbiBoYW5kbGUgMzU4NApbIDc3NTIuNTQxNzcxXSBCbHVldG9vdGg6IGhj
aTA6IFNDTyBwYWNrZXQgZm9yIHVua25vd24gY29ubmVjdGlvbiBoYW5kbGUgMzU4NApbIDc3NTIu
NTQxNzc0XSBCbHVldG9vdGg6IGhjaTA6IFNDTyBwYWNrZXQgZm9yIHVua25vd24gY29ubmVjdGlv
biBoYW5kbGUgMzU4NApbIDc3NTIuNTQxNzgwXSBCbHVldG9vdGg6IGhjaTA6IFNDTyBwYWNrZXQg
Zm9yIHVua25vd24gY29ubmVjdGlvbiBoYW5kbGUgMzU4NApbIDc3NTIuODU5NjU0XSBCbHVldG9v
dGg6IGhjaTA6IEFDTCBwYWNrZXQgZm9yIHVua25vd24gY29ubmVjdGlvbiBoYW5kbGUgMzgzNwpb
IDc4MDguNjgxNzE0XSBCbHVldG9vdGg6IGhjaTA6IEFDTCBwYWNrZXQgZm9yIHVua25vd24gY29u
bmVjdGlvbiBoYW5kbGUgMzgzNwpbIDc4OTcuNzY2NzQzXSBCbHVldG9vdGg6IGhjaTA6IEFDTCBw
YWNrZXQgZm9yIHVua25vd24gY29ubmVjdGlvbiBoYW5kbGUgMzgzNwpbIDc5OTMuMDMxMzQwXSBC
bHVldG9vdGg6IGhjaTA6IEFDTCBwYWNrZXQgZm9yIHVua25vd24gY29ubmVjdGlvbiBoYW5kbGUg
MzgzNwpbIDgwNTMuMDMwNDE1XSBCbHVldG9vdGg6IGhjaTA6IEFDTCBwYWNrZXQgZm9yIHVua25v
d24gY29ubmVjdGlvbiBoYW5kbGUgMzgzNwpbIDgxMTMuMDMwMzQ5XSBCbHVldG9vdGg6IGhjaTA6
IEFDTCBwYWNrZXQgZm9yIHVua25vd24gY29ubmVjdGlvbiBoYW5kbGUgMzgzNwpbIDgxNDguNTM1
MTk4XSBCbHVldG9vdGg6IGhjaTA6IEFDTCBwYWNrZXQgZm9yIHVua25vd24gY29ubmVjdGlvbiBo
YW5kbGUgMzgzNwpbMTE3MDIuNjc1OTk5XSBCbHVldG9vdGg6IGhjaTA6IEFDTCBwYWNrZXQgZm9y
IHVua25vd24gY29ubmVjdGlvbiBoYW5kbGUgMzgzNwpbMTE5NzguNTA2NDg2XSBCbHVldG9vdGg6
IGhjaTA6IEFDTCBwYWNrZXQgZm9yIHVua25vd24gY29ubmVjdGlvbiBoYW5kbGUgMzgzNwo=
--0000000000003868830659d00cab
Content-Type: application/octet-stream; 
	name="mt7925-freeclip2-hfp-fail.btsnoop"
Content-Disposition: attachment; 
	filename="mt7925-freeclip2-hfp-fail.btsnoop"
Content-Transfer-Encoding: base64
Content-ID: <f_mt7mt6md0>
X-Attachment-Id: f_mt7mt6md0

YnRzbm9vcAAAAAABAAAH0QAAACcAAAAn//8ADAAAAAAA4zeC/A0/QUxpbnV4IHZlcnNpb24gNy4y
LjAtMS1jYWNoeW9zICh4ODZfNjQpAAAAACEAAAAh//8ADAAAAAAA4zeC/A0/Q0JsdWV0b290aCBz
dWJzeXN0ZW0gdmVyc2lvbiAyLjIyAAAAABAAAAAQAAAAAAAAAAAA4zeC/A0/QwABnkKg8wo8aGNp
MAAAAAAAAAAAAAAAAAAAAAgAAAAAAOM3gvwNP0MAAAAIAAAACAAAAAoAAAAAAOM3gvwNP0SeQqDz
CjxGAAAAAB4AAAAe//8ADgAAAAAA4zeC/A0/RQEAAAACAAEXAAEAAAAQYmx1ZXRvb3RoZAAAAAAA
AAAAAAsAAAALAAAABAAAAAAA4zeC/BiriTMABwADAE0AIAcoAAAABwAAAAcAAAADAAAAAADjN4L8
GLxiEwUBMwABAAAAAAYAAAAGAAAAAwAAAAAA4zeC/BkxkwUEAAAOEwAAAAUAAAAFAAAAAwAAAAAA
4zeC/BlO3RsDMwAFAAAABwAAAAcAAAADAAAAAADjN4L8GVO/HQUAMwAYzAAAABAAAAAQAAAABAAA
AAAA4zeC/ByKQDMADAAIAAEABg4EAE8ARAAAAAAQAAAAEAAAAAUAAAAAAOM3gvwcpIUzIAwACAAB
AAcOBABPAEQAAAAAOAAAADgAAAANAAAAAADjN4L8HLE9BgtibHVldG9vdGhkAFBhdGggLyByZXNl
cnZlZCBmb3IgQWR2IE1vbml0b3IgYXBwIDoxLjIzMgAAAAAMAAAADAAAAAQAAAAAAOM3gvwctFIz
AAgABABMAOtTAdAAAAAHAAAABwAAAAMAAAAAAOM3gvwcvkoTBQEzAAEAAAAABwAAAAcAAAADAAAA
AADjN4L8HMeREwUBMwABAAAAAAwAAAAMAAAABQAAAAAA4zeC/BzXVjMgCAAEAEEA63MB+gAAAAwA
AAAMAAAABAAAAAAA4zeC/BzXZjMACAAEAEwAA1MB/QAAAAcAAAAHAAAAAwAAAAAA4zeC/Bzf+BMF
ATMAAQAAAAAMAAAADAAAAAUAAAAAAOM3gvwc8qQzIAgABABBAANzAdcAAAAQAAAAEAAAAAQAAAAA
AOM3gvwc8rAzAAwACAABAAYPBABMAEEAAAAAEAAAABAAAAAFAAAAAADjN4L8HPqAMyAMAAgAAQAG
BQQAQQBMAAAAABAAAAAQAAAABAAAAAAA4zeC/Bz6hzMADAAIAAEABwUEAEEATAAAAAAHAAAABwAA
AAMAAAAAAOM3gvwc/UgTBQEzAAEAAAAABwAAAAcAAAADAAAAAADjN4L8HQKkEwUBMwABAAAAABAA
AAAQAAAABQAAAAAA4zeC/B0VyzMgDAAIAAEABw8EAEwAQQAAAAAKAAAACgAAAAUAAAAAAOM3gvwh
uVEzIAYAAgBCACIHAAAACwAAAAsAAAAEAAAAAADjN4L8IbmXMwAHAAMATQAwCCgAAAB2AAAAdv//
AA0AAAAAAOM3gvwhukMDC2JsdWV0b290aGQAcHJvZmlsZXMvYXVkaW8vdHJhbnNwb3J0LmM6c2V0
X3ZvbHVtZSgpIFVuYWJsZSB0byBzZXQgdm9sdW1lOiBUcmFuc3BvcnQgZW5kcG9pbnQgaXMgbm90
IGNvbm5lY3RlZCAoLTEwNykAAAAAFwAAABcAAAADAAAAAADjN4L8IcL9DRUAMwAAAoifAAAAAAAA
qGEAAAAAAAAAAAAHAAAABwAAAAMAAAAAAOM3gvwhxuYTBQEzAAEAAAAAPgAAAD4AAAAEAAAAAADj
N4L8IcjJMyA6ADYATgCA4AAAAAAAAAAAAAFH/AAAsIyAAwAgIRFFABRQAUbwgQpaWlpaWlpaWlpa
WlpaWlpaWlpaWl4AAAAXAAAAFwAAAAMAAAAAAOM3gvwhyNgNFQAzAAACiJ8AAAAAAACoYQAAAAAA
AAAAAAcAAAAHAAAAAwAAAAAA4zeC/CHQLRMFATMAAQAAAAAKAAAACgAAAAUAAAAAAOM3gvwiRewz
IAYAAgBCADIIAAAAEAAAABAAAAAEAAAAAADjN4L8IkYHMwAMAAgAAQAGEAQATgBDAAAAAAcAAAAH
AAAAAwAAAAAA4zeC/CJPIRMFATMAAQAAAAAQAAAAEAAAAAUAAAAAAOM3gvwiYUUzIAwACAABAAcQ
BABOAEMAAAAAdgAAAHb//wANAAAAAADjN4L8JOVWAwtibHVldG9vdGhkAHByb2ZpbGVzL2F1ZGlv
L3RyYW5zcG9ydC5jOnNldF92b2x1bWUoKSBVbmFibGUgdG8gc2V0IHZvbHVtZTogVHJhbnNwb3J0
IGVuZHBvaW50IGlzIG5vdCBjb25uZWN0ZWQgKC0xMDcpAAAAABAAAAAQAAAABAAAAAAA4zeC/Cl3
FjMADAAIAAEABhEEAE0AQgAAAAAHAAAABwAAAAMAAAAAAOM3gvwpgAMTBQEzAAEAAAAAEAAAABAA
AAAFAAAAAADjN4L8KZE9MyAMAAgAAQAHEQQATQBCAAAAAA0AAAANAAAAEAAAAAAA4zeC/DppywEA
AAAUAKD+317awAAAAAAGAAAABgAAAAIAAAAAAOM3gvw6adsGBAMzABMAAAAGAAAABgAAAAMAAAAA
AOM3gvw6cgkPBAABBgQAAAAGAAAABgAAAAMAAAAAAOM3gvw7nlQFBAAzABYAAAAOAAAADgAAABEA
AAAAAOM3gvw7nlsBAAAADACg/t9e2sAAAgAAADwAAAA8AAAADQAAAAAA4zeC/Dui9QYLYmx1ZXRv
b3RoZABBZHYgTW9uaXRvciBhcHAgOjEuMjMyIGRpc2Nvbm5lY3RlZCBmcm9tIEQtQnVzAAAAABAA
AAAQAAAAEQAAAAAA4zeC/DvVVQEAAAABABQAAKD+317awAAAAAAvAAAALwAAAA0AAAAAAOM3gvw7
1ZYDC2JsdWV0b290aGQATm8gbWF0Y2hpbmcgY29ubmVjdGlvbiBmb3IgZGV2aWNlAAAAABAAAAAQ
AAAAAgAAAAAA4zeC/Gl2PwUEDaD+317awBjMAgAAAAEAAAA4AAAAOAAAAA0AAAAAAOM3gvxpdpIG
C2JsdWV0b290aGQAUGF0aCAvIHJlc2VydmVkIGZvciBBZHYgTW9uaXRvciBhcHAgOjEuMjMzAAAA
AAYAAAAGAAAAAwAAAAAA4zeC/Gl+Vg8EAAEFBAAAAA0AAAANAAAAAwAAAAAA4zeC/G1KDQMLADMA
oP7fXtrAAQAAAAAFAAAABQAAAAIAAAAAAOM3gvxtSlIbBAIzAAAAAB4AAAAe//8ADgAAAAAA4zeC
/G1KaQIAAAAAAAIWAAEAAAAQYnRtb24AAAAAAAAAAAAAAAAAAAQAAAAE//8ADwAAAAAA4zeC/G1K
awIAAAAAAAAGAAAABgAAAAMAAAAAAOM3gvxtT+UPBAABGwQAAAANAAAADQAAAAMAAAAAAOM3gvxt
UGMLCwAzAL/+T/7b/1uHAAAABgAAAAYAAAACAAAAAADjN4L8bVBpHAQDMwABAAAABgAAAAYAAAAD
AAAAAADjN4L8bVueDwQAARwEAAAADwAAAA8AAAADAAAAAADjN4L8bVyaIw0AMwABAgMAAAAAAAAA
AAAADQAAAA0AAAACAAAAAADjN4L8bVylGQQKoP7fXtrAAgAAAAAAAA4AAAAOAAAABAAAAAAA4zeC
/G1cqTMACgAGAAEACgECAAIAAAAABQAAAAUAAAADAAAAAADjN4L8bWJ0GwMzAAUAAAAGAAAABgAA
AAMAAAAAAOM3gvxtZ9MPBAABGQQAAAAHAAAABwAAAAMAAAAAAOM3gvxthKQdBQAzABjMAAAABwAA
AAcAAAADAAAAAADjN4L8bZNHHQUAMwAYzAAAAAcAAAAHAAAAAwAAAAAA4zeC/G2YKBMFATMAAQAA
AAEBAAABAQAAAAMAAAAAAOM3gvxttH0H/wCg/t9e2sBIVUFXRUkgRnJlZUNsaXAgMgAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACYA
AAAmAAAAEQAAAAAA4zeC/G20gwEAAAALAKD+317awAAIAAAAEwASCUhVQVdFSSBGcmVlQ2xpcCAy
AAAADgAAAA4AAAAFAAAAAADjN4L8bdmYMyAKAAYAAQAKQQIAAgAAAAAUAAAAFAAAAAUAAAAAAOM3
gvxt2ZgzIBAADAABAAsBCAACAAAAuAEAAAAAABQAAAAUAAAABAAAAAAA4zeC/G3ZoTMAEAAMAAEA
C0EIAAIAAAC4AgAAAAAADgAAAA4AAAAEAAAAAADjN4L8bdmlMwAKAAYAAQAKAgIAAwAAAAAHAAAA
BwAAAAMAAAAAAOM3gvxt4WsTBQEzAAEAAAAABwAAAAcAAAADAAAAAADjN4L8beZKEwUBMwABAAAA
AA4AAAAOAAAABQAAAAAA4zeC/G5aiTMgCgAGAAEACkICAAMAAAAAGAAAABgAAAAEAAAAAADjN4L8
blqPMwAUABAAAQALQgwAAwAAAIYAAAAAAAAAAAAAGAAAABgAAAAFAAAAAADjN4L8bmJLMyAUABAA
AQALAgwAAwAAAIIAAAAAAAAAAAAAEAAAABAAAAAEAAAAAADjN4L8bmJRMwAMAAgAAQACAwQAAQBA
AAAAAAcAAAAHAAAAAwAAAAAA4zeC/G5ppBMFATMAAQAAAAAHAAAABwAAAAMAAAAAAOM3gvxubwYT
BQEzAAEAAAAAFAAAABQAAAAFAAAAAADjN4L8busHMyAQAAwAAQADAwgABUBAAAAAAAAAAAAUAAAA
FAAAAAUAAAAAAOM3gvxu6wgzIBAADAABAARDCABAAAAAAQKnAgAAABsAAAAbAAAABAAAAAAA4zeC
/G7rEDMAFwATAAEABAQPAAVAAAAECQAAAAAAAAAAAAAAABYAAAAWAAAABAAAAAAA4zeC/G7rEjMA
EgAOAAEABUMKAAVAAAAAAAECpwIAAAAHAAAABwAAAAMAAAAAAOM3gvxu8l0TBQEzAAEAAAAABwAA
AAcAAAADAAAAAADjN4L8bvc+EwUBMwABAAAAAB0AAAAdAAAABQAAAAAA4zeC/G9kIDMgGQAVAAEA
BQQRAEAAAAAAAAQJAAAAAAAAAAAAAAAAHAAAABwAAAAEAAAAAADjN4L8b2Q7MwAYABQABUAGAAAA
DzUDGREe//81BQoAAP//AAAAAAcAAAAHAAAAAwAAAAAA4zeC/G9scBMFATMAAQAAAAB0AAAAdAAA
AAUAAAAAAOM3gvxvwdszIHAAbABAAAcAAABnAGQ1YjVgCQAACgABAAEJAAE1BhkRHhkSAwkABDUM
NQMZAQA1BRkAAwgdCQAFNQMZEAIJAAY1CQllbgkAagkBAAkACTUINQYZER4JAQcJAQAlDkhhbmRz
ZnJlZSBVbml0CQMRCQA7AAAAAAUAAAAFAAAAAgAAAAAA4zeC/G/CCBEEAjMAAAAABgAAAAYAAAAD
AAAAAADjN4L8b8k3DwQAAREEAAAACAAAAAgAAAADAAAAAADjN4L8b8m0Fwag/t9e2sAAAAAZAAAA
GQAAAAIAAAAAAOM3gvxvybgLBBag/t9e2sAeZcpIiw2ZZENcyO2PDf0CAAAADAAAAAwAAAADAAAA
AADjN4L8b9R1DgoBCwQAoP7fXtrAAAAABQAAAAUAAAADAAAAAADjN4L8cFJuBgMAMwAAAAAGAAAA
BgAAAAIAAAAAAOM3gvxwUnwTBAMzAAEAAAAGAAAABgAAAAMAAAAAAOM3gvxwWUQPBAABEwQAAAAG
AAAABgAAAAMAAAAAAOM3gvxxAjgIBAAzAAEAAAAFAAAABQAAAAIAAAAAAOM3gvxxAkEIFAIzAAAA
AAkAAAAJAAAAAwAAAAAA4zeC/HEJDQ4HAQgUADMAEAAAABAAAAAQAAAABAAAAAAA4zeC/HEJGjMA
DAAIAAEAAgUEAAMAQQAAAAAHAAAABwAAAAMAAAAAAOM3gvxxFUITBQEzAAEAAAAAjAAAAIwAAAAF
AAAAAADjN4L8cTzGMyCIAIQAAQAIwYAAPwQDAngAQVQrWFNIVUFXRUlGPTQsMDA0MDA2OTExN0hV
QVdFSSBGcmVlQ2xpcCAyMjA4MDAwMDAwMDAzMDQwMDAxNDA0MDI3ZDUwNDQxMTM2MDQwMTg4NzA0
WkFBUzgwNjAwMDE2NzkwODAwMjQwNDE4YTAyMDNiMDQ0MTEzmeoAAAAeAAAAHgAAAAUAAAAAAOM3
gvxxPMczIBoAFgABAAjCEgA/AQEBCgABAgMEBQcICf//Tx8AAAAQAAAAEAAAAAQAAAAAAOM3gvxx
PM4zAAwACAABAAHBBAABADAAAAAAHgAAAB4AAAAEAAAAAADjN4L8cTzRMwAaABYAAQAJwhIAPwEB
AQoAAQIDBAUHCAn//08fAAAABwAAAAcAAAADAAAAAADjN4L8cUYVEwUBMwABAAAAABcAAAAXAAAA
BQAAAAAA4zeC/HFIfDMgEwAPAAEACMMLAD8EAQEDAAIFAY6tAAAAFwAAABcAAAAEAAAAAADjN4L8
cUiBMwATAA8AAQAJwwsAPwQBAQMAAgUBjq0AAAAHAAAABwAAAAMAAAAAAOM3gvxxSvYTBQEzAAEA
AAAABwAAAAcAAAADAAAAAADjN4L8cU/ZEwUBMwABAAAAABQAAAAUAAAABQAAAAAA4zeC/HHFezMg
EAAMAAEAAwUIAFAAQQAAAAAAAAAAFAAAABQAAAAFAAAAAADjN4L8ccV8MyAQAAwAAQAEAQgAQQAA
AAECGgUAAAAfAAAAHwAAAAQAAAAAAOM3gvxxxYgzABsAFwABAAQGEwBQAAAAAQL9AwQJAAAAAAAA
AAAAAAAAFgAAABYAAAAEAAAAAADjN4L8ccWMMwASAA4AAQAFAQoAUAAAAAAAAQIaBQAAAAcAAAAH
AAAAAwAAAAAA4zeC/HHO0BMFATMAAQAAAAAHAAAABwAAAAMAAAAAAOM3gvxx07ETBQEzAAEAAAAA
IQAAACEAAAAFAAAAAADjN4L8ck4zMyAdABkAAQAFBhUAQQAAAAAAAQL9AwQJAAAAAAAAAAAAAAAA
DAAAAAwAAAAEAAAAAADjN4L8ck5CMwAIAAQAUAADPwEcAAAABwAAAAcAAAADAAAAAADjN4L8cleL
EwUBMwABAAAAAAwAAAAMAAAABQAAAAAA4zeC/HLDZDMgCAAEAEEAA3MB1wAAABYAAAAWAAAABAAA
AAAA4zeC/HLDczMAEgAOAFAAA+8VgxE68AcA+AMAB3AAAAAHAAAABwAAAAMAAAAAAOM3gvxyzLkT
BQEzAAEAAAAAFgAAABYAAAAFAAAAAADjN4L8cziXMyASAA4AQQAB7xWBETrgBwAAAQAHqgAAAAwA
AAAMAAAABAAAAAAA4zeC/HM4pDMACAAEAFAA6z8BMQAAAAcAAAAHAAAAAwAAAAAA4zeC/HNCGRMF
ATMAAQAAAAAMAAAADAAAAAUAAAAAAOM3gvxzuXszIAgABABBAOtzAfoAAAAQAAAAEAAAAAUAAAAA
AOM3gvxzuXwzIAwACABBAAHvCeMF642qAAAAEAAAABAAAAAEAAAAAADjN4L8c7mJMwAMAAgAUAAD
7wnjBeuNcAAAABAAAAAQAAAABAAAAAAA4zeC/HO5jDMADAAIAFAAA+8J4QXrjXAAAAAHAAAABwAA
AAMAAAAAAOM3gvxzz4gTBQEzAAEAAAAABwAAAAcAAAADAAAAAADjN4L8c9RmEwUBMwABAAAAABAA
AAAQAAAABQAAAAAA4zeC/HPkeDMgDAAIAEEAAe8J4QXrjaoAAAANAAAADQAAAAQAAAAAAOM3gvxz
5IczAAkABQBQAOv/ASFQAAAABwAAAAcAAAADAAAAAADjN4L8c+1QEwUBMwABAAAAABgAAAAYAAAA
BQAAAAAA4zeC/HP0FDMgFAAQAEEA6e8ZQVQrQlJTRj03NjMNlgAAABsAAAAbAAAABAAAAAAA4zeC
/HP1wTMAFwATAFAA6+8fDQorQlJTRjogMzU4NA0KTAAAABIAAAASAAAABAAAAAAA4zeC/HP1xDMA
DgAKAFAA6+8NDQpPSw0KTAAAABAAAAAQAAAABAAAAAAA4zeC/HP2CDMADAAIAAEAAgcEABkAQgAA
AAAHAAAABwAAAAMAAAAAAOM3gvx0AFcTBQEzAAEAAAAABwAAAAcAAAADAAAAAADjN4L8dAVnEwUB
MwABAAAAAAcAAAAHAAAAAwAAAAAA4zeC/HQKGxMFATMAAQAAAAAeAAAAHgAAAAUAAAAAAOM3gvx0
gL4zIBoAFgBBAOn/IwJBVCtCQUM9MSwyLDMyLDY0DYoAAAAUAAAAFAAAAAUAAAAAAOM3gvx0gL8z
IBAADAABAAMHCABRAEIAAQACAAAAABIAAAASAAAABAAAAAAA4zeC/HSA3jMADgAKAFAA6+8NDQpP
Sw0KTAAAAAcAAAAHAAAAAwAAAAAA4zeC/HSJFBMFATMAAQAAAAAUAAAAFAAAAAUAAAAAAOM3gvx0
kFMzIBAADAABAAMHCABRAEIAAAAAAAAAABsAAAAbAAAABAAAAAAA4zeC/HSQWTMAFwATAAEABAgP
AFEAAAAECQAAAAAAAAAAAAAAAAcAAAAHAAAAAwAAAAAA4zeC/HSXuRMFATMAAQAAAAAUAAAAFAAA
AAUAAAAAAOM3gvx0mCgzIBAADAABAAQCCABCAAAAAQJ/AwAAABYAAAAWAAAABAAAAAAA4zeC/HSY
MDMAEgAOAAEABQIKAFEAAAAAAAECfwMAAAAHAAAABwAAAAMAAAAAAOM3gvx0ofoTBQEzAAEAAAAA
FwAAABcAAAAFAAAAAADjN4L8dKfcMyATAA8AQQDp/xUBQVQrQ0lORD0/DYoAAACQAAAAkAAAAAQA
AAAAAOM3gvx0qAczAIwAiABQAOvvBgENCitDSU5EOigic2VydmljZSIsKDAtMSkpLCgiY2FsbCIs
KDAtMSkpLCgiY2FsbHNldHVwIiwoMC0zKSksKCJjYWxsaGVsZCIsKDAtMikpLCgic2lnbmFsIiwo
MC01KSksKCJyb2FtIiwoMC0xKSksKCJiYXR0Y2hnIiwoMC01KSkNCkwAAAASAAAAEgAAAAQAAAAA
AOM3gvx0qAozAA4ACgBQAOvvDQ0KT0sNCkwAAAAHAAAABwAAAAMAAAAAAOM3gvx0yQgTBQEzAAEA
AAAABwAAAAcAAAADAAAAAADjN4L8dM3qEwUBMwABAAAAAB0AAAAdAAAABQAAAAAA4zeC/HTO0zMg
GQAVAAEABQgRAEIAAAAAAAQJAAAAAAAAAAAAAAAAYQAAAGH//wANAAAAAADjN4L8dM8RBAtibHVl
dG9vdGhkAHByb2ZpbGVzL2F1ZGlvL2EyZHAuYzpsb2FkX3JlbW90ZV9zZXAoKSBVbmFibGUgdG8g
bG9hZCBMYXN0VXNlZDogcnNlaWQgMTAgbm90IGZvdW5kAAAAAAoAAAAKAAAABAAAAAAA4zeC/HTP
FzMABgACAFEAQAEAAAAHAAAABwAAAAMAAAAAAOM3gvx06zoTBQEzAAEAAAAAFgAAABYAAAAFAAAA
AADjN4L8dPXjMyASAA4AQQDp/xMCQVQrQ0lORD8NigAAACQAAAAkAAAABAAAAAAA4zeC/HT1/TMA
IAAcAFAA6+8xDQorQ0lORDogMCwwLDAsMCwwLDAsMA0KTAAAABIAAAASAAAABAAAAAAA4zeC/HT2
ATMADgAKAFAA6+8NDQpPSw0KTAAAAAcAAAAHAAAAAwAAAAAA4zeC/HT+PxMFATMAAQAAAAAHAAAA
BwAAAAMAAAAAAOM3gvx1G48TBQEzAAEAAAAADgAAAA4AAAAFAAAAAADjN4L8dSTEMyAKAAYAQgBC
AQgIKAgAAAALAAAACwAAAAQAAAAAAOM3gvx1JOkzAAcAAwBRAFAMCAAAAAcAAAAHAAAAAwAAAAAA
4zeC/HUvGRMFATMAAQAAAAAdAAAAHQAAAAUAAAAAAOM3gvx1RA8zIBkAFQBBAOn/IQJBVCtDTUVS
PTMsMCwwLDENigAAABIAAAASAAAABAAAAAAA4zeC/HVELDMADgAKAFAA6+8NDQpPSw0KTAAAABcA
AAAXAAAABAAAAAAA4zeC/HVEMDMAEwAPAFAA6+8XDQorQkNTOiAyDQpMAAAABwAAAAcAAAADAAAA
AADjN4L8dVsLEwUBMwABAAAAAAcAAAAHAAAAAwAAAAAA4zeC/HVgaBMFATMAAQAAAAAWAAAAFgAA
AAUAAAAAAOM3gvx1axMzIBIADgBCAFIMAQAHBgAAP/8CNQgAAAAACwAAAAsAAAAEAAAAAADjN4L8
dWsrMwAHAAMAUQBgDCgAAAAHAAAABwAAAAMAAAAAAOM3gvx1c/ITBQEzAAEAAAAAFgAAABYAAAAF
AAAAAADjN4L8dX6iMyASAA4AQQDp/xMBQVQrVkdNPTgNigAAABIAAAASAAAABAAAAAAA4zeC/HV+
xTMADgAKAFAA6+8NDQpPSw0KTAAAAAcAAAAHAAAAAwAAAAAA4zeC/HWaghMFATMAAQAAAAAYAAAA
GAAAAAUAAAAAAOM3gvx2B10zIBQAEABCAGIMAQAHCAACgAGMg4JwCAAAAAAaAAAAGgAAAAQAAAAA
AOM3gvx2Eh4zABYAEgBRAHADKBwBAAcIAAKAAISDgnAIAAAAAAcAAAAHAAAAAwAAAAAA4zeC/HYe
XBMFATMAAQAAAAAWAAAAFgAAAAUAAAAAAOM3gvx2Kn8zIBIADgBBAOn/EwJBVCtCQ1M9Mg2KAAAA
EgAAABIAAAAEAAAAAADjN4L8dixOMwAOAAoAUADr7w0NCk9LDQpMAAAABwAAAAcAAAADAAAAAADj
N4L8djbCEwUBMwABAAAAAAoAAAAKAAAABQAAAAAA4zeC/HafrTMgBgACAEIAcgMAAAANAAAADQAA
AAUAAAAAAOM3gvx2n64zIAkABQBCABANHAlgAAAACgAAAAoAAAAEAAAAAADjN4L8dp/9MwAGAAIA
UQASDQAAAAcAAAAHAAAAAwAAAAAA4zeC/HanExMFATMAAQAAAAALAAAACwAAAAQAAAAAAOM3gvx2
p2YzAAcAAwBRAIAGKAAAABcAAAAXAAAABQAAAAAA4zeC/HanjDMgEwAPAEEA6f8VAUFUK0NDV0E9
MQ2KAAAAKgAAACoAAAAFAAAAAADjN4L8dqeMMyAmACIAAQAIxB4APwgKAQQAEwAAAAIBAAEDAgAE
AQQGAEABQAFAAacYAAAAKgAAACoAAAAEAAAAAADjN4L8dqeSMwAmACIAAQAJxB4APwgKAQQAEwAA
AAIBAAEDAgAEAQQGAEABQAFAAacYAAAAEgAAABIAAAAEAAAAAADjN4L8dqe8MwAOAAoAUADr7w0N
Ck9LDQpMAAAABwAAAAcAAAADAAAAAADjN4L8dtfpEwUBMwABAAAAAAcAAAAHAAAAAwAAAAAA4zeC
/HbcyBMFATMAAQAAAAAHAAAABwAAAAMAAAAAAOM3gvx24a0TBQEzAAEAAAAACgAAAAoAAAAFAAAA
AADjN4L8dvG6MyAGAAIAQgCCBgAAABAAAAAQAAAABAAAAAAA4zeC/Hbx7TMADAAIAAEAAgkEABkA
QwAAAAAHAAAABwAAAAMAAAAAAOM3gvx3F2ITBQEzAAEAAAAAFwAAABcAAAAFAAAAAADjN4L8dyCg
MyATAA8AQQDp/xUBQVQrTlJFQz0wDYoAAAAVAAAAFQAAAAQAAAAAAOM3gvx3IQMzABEADQBQAOvv
Ew0KRVJST1INCkwAAAAHAAAABwAAAAMAAAAAAOM3gvx3Ku0TBQEzAAEAAAAAFAAAABQAAAAFAAAA
AADjN4L8dzR8MyAQAAwAAQADCQgAUgBDAAEAAgAAAAAUAAAAFAAAAAUAAAAAAOM3gvx3O+szIBAA
DAABAAMJCABSAEMAAAAAAAAAABQAAAAUAAAABQAAAAAA4zeC/Hc77DMgEAAMAAEABAMIAEMAAAAB
An8DAAAAHwAAAB8AAAAEAAAAAADjN4L8dzvyMwAbABcAAQAEChMAUgAAAAEC/QMECQAAAAAAAAAA
AAAAABYAAAAWAAAABAAAAAAA4zeC/Hc79TMAEgAOAAEABQMKAFIAAAAAAAECfwMAAAAHAAAABwAA
AAMAAAAAAOM3gvx3VuATBQEzAAEAAAAABwAAAAcAAAADAAAAAADjN4L8d1y4EwUBMwABAAAAACYA
AAAmAAAABQAAAAAA4zeC/Hdi/zMgIgAeAEEA6f8zAUFUK1hBUEw9MEEwQi1BMEIwLTAxMDAsMQ2K
AAAAEgAAABIAAAAEAAAAAADjN4L8d2MpMwAOAAoAUADr7w0NCk9LDQpMAAAABwAAAAcAAAADAAAA
AADjN4L8d2poEwUBMwABAAAAACEAAAAhAAAABQAAAAAA4zeC/HdqzDMgHQAZAAEABQoVAEMAAAAA
AAEC/QMECQAAAAAAAAAAAAAAABAAAAAQAAAABAAAAAAA4zeC/HdvrDMADAAIAAEAAgsEABcARAAA
AAAcAAAAHAAAAAQAAAAAAOM3gvx3b8EzABgAFAAFQAYAAQAPNQMZAQD//zUFCgAA//8AAAAAPAAA
ADwAAAANAAAAAADjN4L8d3P0BgtibHVldG9vdGhkAEFkdiBNb25pdG9yIGFwcCA6MS4yMzMgZGlz
Y29ubmVjdGVkIGZyb20gRC1CdXMAAAAABwAAAAcAAAADAAAAAADjN4L8d5bXEwUBMwABAAAAAAcA
AAAHAAAAAwAAAAAA4zeC/HebOhMFATMAAQAAAAAZAAAAGQAAAAUAAAAAAOM3gvx3qUwzIBUAEQAB
AAjFDQA/BAIBAQABAgEAASCJAAAAGQAAABkAAAAEAAAAAADjN4L8d6lSMwAVABEAAQAJxQ0APwQC
AQEAAQIBAAEgiQAAAAcAAAAHAAAAAwAAAAAA4zeC/HezoBMFATMAAQAAAAAiAAAAIgAAAAUAAAAA
AOM3gvx3tQczIB4AGgBBAOn/KwFBVCtJUEhPTkVBQ0NFVj0xLDEsOQ2KAAAAEgAAABIAAAAEAAAA
AADjN4L8d7UzMwAOAAoAUADr7w0NCk9LDQpMAAAABwAAAAcAAAADAAAAAADjN4L8d9YCEwUBMwAB
AAAAABQAAAAUAAAABQAAAAAA4zeC/HfcEzMgEAAMAAEAAwsIAFMARAABAAIAAAAAFAAAABQAAAAF
AAAAAADjN4L8d9wUMyAQAAwAAQADCwgAUwBEAAAAAAAAAAAbAAAAGwAAAAQAAAAAAOM3gvx33CAz
ABcAEwABAAQMDwBTAAAABAkAAAAAAAAAAAAAAAAHAAAABwAAAAMAAAAAAOM3gvx35HoTBQEzAAEA
AAAAFAAAABQAAAAFAAAAAADjN4L8eFkUMyAQAAwAAQAEBAgARAAAAAECoAIAAAAWAAAAFgAAAAQA
AAAAAOM3gvx4WRwzABIADgABAAUECgBTAAAAAAABAqACAAAABwAAAAcAAAADAAAAAADjN4L8eG2w
EwUBMwABAAAAAqgAAAKoAAAABQAAAAAA4zeC/Hh0bzMgpAKgAkAABwABApsCljYCxzUyCQAACgAA
AAAJAAE1AxkQAAkABDUKNQMZAQA1AxkAAQkCADUGCQEACQEBCQIBCgAAAAo1YwkAAAoAAQAACQAB
NQMZEQsJAAQ1EDUGGQEACQAZNQYZABkJAQMJAAU1AxkQAgkABjUJCWVuCQBqCQEACQAJNQg1BhkR
DQkBAwkBACUQQTJEUCBTTksgU2VydmljZQkDEQkAATVgCQAACgABAAEJAAE1BhkRHhkSAwkABDUM
NQMZAQA1BRkAAwgdCQAFNQMZEAIJAAY1CQllbgkAagkBAAkACTUINQYZER4JAQcJAQAlDkhhbmRz
ZnJlZSBVbml0CQMRCQA7NU0JAAAKAAEAAwkAATURHAAA/ZoAABAAgAAAgF+bNPsJAAQ1DDUDGQEA
NQUZAAMIAgkABjUJCWVuCQBqCQEACQEAJQtQcml2YXRlIENPTTVUCQAACgABAAQJAAE1AxkRAQkA
BDUMNQMZAQA1BRkAAwgBCQAFNQMZEAIJAAY1CQllbgkAagkBAAkACTUINQYZEQEJAQIJAQAlC1Nl
cmlhbCBQb3J0NU0JAAAKAAEABQkAATURHAAQECBMQgBlY25hRGV0eUIJAAQ1DDUDGQEANQUZAAMI
AwkABjUJCWVuCQBqCQEACQEAJQtQcml2YXRlIENPTTVoCQAACgABAAYJAAE1BhkRDhkRDwkABDUQ
NQYZAQAJABc1BhkAFwkBBAkABTUDGRACCQAGNQkJZW4JAGoJAQAJAAk1CDUGGREOCQEGCQEAJRJB
L1YgUmVtb3RlIENvbnRyb2wJAxEJAAM1bAkAAAoAAQAHCQABNQMZEQwJAAQ1EDUGGQEACQAXNQYZ
ABcJAQQJAAU1AxkQAgkABjUJCWVuCQBqAgKWAAAAFwAAABcAAAAFAAAAAADjN4L8eHRwMyATAA8A
QQDp/xUBQVQrVEJTRj0/DYoAAAAdAAAAHQAAAAUAAAAAAOM3gvx4dHAzIBkAFQABAAUMEQBEAAAA
AAAECQAAAAAAAAAAAAAAABUAAAAVAAAABAAAAAAA4zeC/Hh0jDMAEQANAFAA6+8TDQpFUlJPUg0K
TAAAAB4AAAAeAAAABAAAAAAA4zeC/Hh1QTMAGgAWAAVABgACABE1AxkBAP//NQUKAAD//wIClgAA
ABYAAAAWAAAABAAAAAAA4zeC/Hh1SjMAEgAOAFMAABEOAUgAABlYEAAAAQMAAAAHAAAABwAAAAMA
AAAAAOM3gvx4lL4TBQEzAAEAAAAABwAAAAcAAAADAAAAAADjN4L8eJlcEwUBMwABAAAAAAcAAAAH
AAAAAwAAAAAA4zeC/HieBxMFATMAAQAAAAAWAAAAFgAAAAUAAAAAAOM3gvx4n78zIBIADgBEABAR
DgFIAAAZWBAAAAEDAAAAHwAAAB8AAAAEAAAAAADjN4L8eJ/xMwAbABcAUwASEQ4MSAAAGVgQAAAK
AwgBAgMECAoLDQAAAAcAAAAHAAAAAwAAAAAA4zeC/HinyxMFATMAAQAAAAAgAAAAIAAAAAUAAAAA
AOM3gvx4rwQzIBwAGABBAOn/JwFBVCtIVUFXRUlCQVRURVJZPT8NigAAABUAAAAVAAAABAAAAAAA
4zeC/HivLTMAEQANAFAA6+8TDQpFUlJPUg0KTAAAAAcAAAAHAAAAAwAAAAAA4zeC/Hi2cRMFATMA
AQAAAABEAAAARAAAAAUAAAAAAOM3gvx48W0zIEAAPABAAAcAAgA3ADQJAQAJAAk1CDUGGREOCQEG
CQEAJRlBL1YgUmVtb3RlIENvbnRyb2wgVGFyZ2V0CQMRCQACAAAAABsAAAAbAAAABQAAAAAA4zeC
/HjxbjMgFwATAEQAAhEODEgAABlYEAAABgMEAQIFDQAAABwAAAAcAAAABAAAAAAA4zeC/Hj2WjMA
GAAUAAVABgADAA81AxkSAP//NQUKAAD//wAAAAAaAAAAGgAAAAQAAAAAAOM3gvx49mQzABYAEgBT
ABARDgNIAAAZWDEAAAUNAAAAAAAAAAcAAAAHAAAAAwAAAAAA4zeC/HkTtBMFATMAAQAAAAAcAAAA
HAAAAAUAAAAAAOM3gvx5GIczIBgAFABBAOn/HwFBVCtYSFVBV0VJU0Y9Pw2KAAAAGgAAABoAAAAF
AAAAAADjN4L8eRiIMyAWABIARADwEQ4DSAAAGVgxAAAFAQAAAAAAAAAHAAAABwAAAAMAAAAAAOM3
gvx5GJYTBQEzAAEAAAAAFQAAABUAAAAEAAAAAADjN4L8eRinMwARAA0AUADr7xMNCkVSUk9SDQpM
AAAAFwAAABcAAAAEAAAAAADjN4L8eRi4MwATAA8AUwDyEQ4PSAAAGVgxAAACAQAAAAAHAAAABwAA
AAMAAAAAAOM3gvx5IdoTBQEzAAEAAAAAGgAAABoAAAAFAAAAAADjN4L8eSQ8MyAWABIARAAQEQ4D
SAAAGVgxAAAFAgAAAAAAAAAeAAAAHgAAAAQAAAAAAOM3gvx5JFozABoAFgBTABIRDg9IAAAZWDEA
AAkC//////////8AAAAHAAAABwAAAAMAAAAAAOM3gvx5K6ITBQEzAAEAAAAABwAAAAcAAAADAAAA
AADjN4L8eTCBEwUBMwABAAAAAF0AAABdAAAABQAAAAAA4zeC/HlezTMgWQBVAEAABwADAFAATTVL
NUkJAAAKAAEACAkAATUDGRIACQAFNQMZEAIJAAY1CQllbgkAagkBAAkCAAkBAwkCAQkCfQkCAglB
EwkCAwkAAAkCBCgACQIFCQABAAAAABcAAAAXAAAABQAAAAAA4zeC/Hl+EjMgEwAPAEQAEhEOD0gA
ABlYMQAAAg05AAAACwAAAAsAAAAEAAAAAADjN4L8gsCeMwAHAAMAUQCQBygAAAAHAAAABwAAAAMA
AAAAAOM3gvyCyKYTBQEzAAEAAAAACgAAAAoAAAAFAAAAAADjN4L8hb7HMyAGAAIAQgCSBwAAAEsA
AABL//8ADQAAAAAA4zeC/IW/BAYLYmx1ZXRvb3RoZAAvb3JnL2JsdWV6L2hjaTAvZGV2X0MwX0RB
XzVFX0RGX0ZFX0EwL3NlcDEwL2ZkMDogZmQoNDQpIHJlYWR5AAAAABYAAAAWAAAABAAAAAAA4zeC
/IW/vjMAEgAOAFMAIBEOAEgAABlYUAAAATMAAAAHAAAABwAAAAMAAAAAAOM3gvyFx0UTBQEzAAEA
AAAAFwAAABcAAAADAAAAAADjN4L8hci6DRUAMwAAAoNiAQAAAAAA8isAAAAAAAAAAAA+AAAAPgAA
AAQAAAAAAOM3gvyGAcozIDoANgBSAIDgAAAAAAAAAAAAAUf8AACwjIADACAhEUUAFFABRvCBClpa
WlpaWlpaWlpaWlpaWlpaWlpaXgAAAAcAAAAHAAAAAwAAAAAA4zeC/IZB0xMFATMAAQAAAAAWAAAA
FgAAAAUAAAAAAOM3gvyGSZczIBIADgBEACIRDglIAAAZWFAAAAEzAAAAFgAAABYAAAAEAAAAAADj
N4L8hkqRMwASAA4AUwAwEQ4ASAAAGVhQAAABLAAAAAcAAAAHAAAAAwAAAAAA4zeC/IZU4BMFATMA
AQAAAAFsAAABbAAAAAQAAAAAAOM3gvyGqDczIGgBZAFSAIDgAAEAAAQAAAAAAUf8AACwjIADAP9O
IRtT1aKIhBQBBOBUDA3CZYstVUA0AnMTGtIa66DzygKJCxHEsRz9cuUvof7UyG7CyaQnJYQLB/0/
SukeKYMDKZKVNGJEF56Vu8vD2haecppdH3a33lw/KMk08+IQugChVent1adWfPNKOgpDTNRSFVqc
4FXz2rwCMiHuPqB2gwLoRFEKoMGLQIbgmS8cdN+Geo+RY8dQwwwbYYvf3Cdwi/TfcrIrMes/gdoi
RQHpBWaDEkDCYCwRwstivZZTAAWYqGtJa6/yOeUBBIRxIncmu+4seB/N828Nu8ECzLHWpn3bSOBk
pcDyARLU5AAJsCw+xx9i7N4UJ/scHHZvHZvEQAKQAU+78NOrPPhmAL/JtpBpGoAauOhCWCEtgyAR
BKC+RTG3Qkz27DcI5eOpOAmOY7CxiqCS6Enb1ZRO3lXquwrI/Aidh6Hz/5PUWFAcAAAABwAAAAcA
AAADAAAAAADjN4L8hsDHEwUBMwABAAAAABYAAAAWAAAABQAAAAAA4zeC/IbIZzMgEgAOAEQAMhEO
CUgAABlYUAAAASwAAAFBAAABQQAAAAQAAAAAAOM3gvyG+40zID0BOQFSAIDgAAIAAAgAAAAAAUf8
AACwjIADAP8jIStPB//w///cbULQOIgEIQIIWFAjCVgFAAUqkq+WtHW2yOeUBCEVtYri2jcW0a2i
KZpGhD7kk8pGTQsWHtsaR9GiAo979WrVWUGOWNXwnWGJKE/4KhXJi8OWoI+SImCIEU2IFYs5sTmj
nTRhZy1W+QWjtrl/7xNoM05o6Ul7f9kgYGoWTHVlX3tlXBsf661D+23/b9C/4oDsg7KqAIIwMIgE
IwIw6C4TmDgAoBRDWjrbZHPKAhCSETxF5iHVVM9NkY1UjOO7tC464XNQtBjCxkDAyZQwYQF4xJQU
iY8QsSgAqYymiurr0VrGGCtjdU1b1/x211W9oAFOjulmxjCTBbvI4p/EtDFRiqjCFzqkCBfKZZ2J
XbvD+J6v93W1axrGgcAAAAAHAAAABwAAAAMAAAAAAOM3gvyHGDETBQEzAAEAAAABxgAAAcYAAAAE
AAAAAADjN4L8h07iMyDCAb4BUgCA4AADAAAMAAAAAAFH/AAAsIyAAwD/qCFN2IAO7+B/H/uQfWlQ
M5RU3mwm3VZwXJRovwaKEPzy+L8hQRQyrgGORBblAHVB8THhdxkK5H7LPT3e0OEl+x1Q9r8P/+f0
T077APvH15fb6PnQ1Kbj+v0PtYkYog4g0Hc2cP2eSvGdDvRFGBnKhmMh9XPgD7ujsATs9AJ+K/Dx
Pi6CFwVFz5UZK4+TN39e0F8tqaTOhI9NsysMFcxxWAJeyN2ZWS/CuXz/GBKEch2rzsQav4/+xo/i
sj7V2Hgs5s07JSL0xNGWSXr3N3NhNqCUKqCYGhK0L2Wzrp2f6HhaoHEPrYVXKupoLm81gyQW7Wwi
CiWUURFDKuBUT0kQOl8fRM19eF70pEAGEahQJzXxvn3VXdOQL4XhF4rv5yBN8owled+oKGHXdH3f
o+29Rx1b7zu+Pqve/bxiHB1OCDlcHRBQ0QgCMTr4WsoGOb+lPLi5ceq6rfcpKe1jc0eWXsQKhBob
Jdzt9XwwE+v++yf2I+h5L3DnSORWSoGIvDQppaB0bpq9aqjWHe3ww0appIw0YTlNatdAmMOZBBAR
e2FCcX2fv/GBwAAAAAcAAAAHAAAAAwAAAAAA4zeC/IeDJBMFATMAAQAAAAGVAAABlQAAAAQAAAAA
AOM3gvyHojYzIJEBjQFSAIDgAAQAABAAAAAAAUf8AACwjIADAP93IXtN8AaX//+g7ghhIAhWgmEo
QCe/2D2e0876m5SCAAgBEdw4q7Iqs0+TbgSDyZ2ESEslCx1m2KlFj0XzJE5LtB3jiu3VSbtJbG2d
bUWkJfEcRnmeYq6YawwK2sWpqeosv5roU1hxL/lfrS3G/FTUQUFLvrn8f4xfwCIgIKI3LObjNYRT
Uhf9FZJ4zW6LWuzNq/cjVFdQIBRAF3Rx6rXoip5cX58kZPxB2PAEuaG99onK9Ihu0rCboJ4ScCMV
HYtxlE9kdpr8dY7exARFsUjCGiDYSiVX7B7ccWpfBRpAACI36AyLSPnPMWQgRKUkU1xl+6J1C1jg
rNFFnVo6msWi0WVh0LSlYWn6ZtnOYAxjFHwwwkEAB/AB5vfADIBITAYy64EkFAIEe1YQhz7USh+G
aM4y/CED60cG0UEE7klgAVO6gCoueynidrDACiUBEYoAPexMaxgEPu7sTkpuTxK5ZpEqlh7mq/qN
WW1J5Z1j58vuzQVAADgAAAAHAAAABwAAAAMAAAAAAOM3gvyH1iUTBQEzAAEAAAAAugAAALoAAAAE
AAAAAADjN4L8h/WKMyC2ALIAUgCA4AAFAAAUAAAAAAFH/AAAsIyAAwCcIRtUGIrKJAiKAKgwCP2A
9vuoJyDmFrskosIi43+swnLRKzKs3fUIQRAgABRELrgG+MhIiC4BgqntfJ0em4EF6OhUMR1GLRj9
4bwD4IR2QRg0QgMUAUQoMAj7Af5pyDu1DAYcSi1JYlem1zgCdP1aR3EEiMB/lUBfMATAnESFiK4C
9ixccFgArdKajOsvCdttyhkuk+AVbWeNeAfwAAAABwAAAAcAAAADAAAAAADjN4L8iAd1EwUBMwAB
AAAAANoAAADaAAAABAAAAAAA4zeC/IhI4zMg1gDSAFIAgOAABgAAGAAAAAABR/wAALCMgAMAvCEb
VBgKyiQHCsCIQQvAD/DlgNdypsDZlumeRz/ayWzNd4qhhk89z4j2qLRM02RIi0CkwJgACwTuAwGa
oSLoKgFSyIPTuuLp44rs6cf1qg2W2OmiHjHtXgwf1Fx72fXaUhEIQR2URg4SgIRgUQoMQj5HA/k3
WGXV4LEDzvDrGDeOdZRHgfUKn4fRZpwMQA2i9wAKpgLlLCyZPiARCEZpXtHjBCv9dCxQrz4P800E
XL9c4B+rfsX4b8DSkPYHAAAABwAAAAcAAAADAAAAAADjN4L8iFp3EwUBMwABAAAAASwAAAEsAAAA
BAAAAAAA4zeC/IicNjMgKAEkAVIAgOAABwAAHAAAAAABR/wAALCMgAMA/w4hG1PwisokAwhAYvAQ
iQTBURv9AOv34pTlRhaqsyBwQwC4SMeTj7Hy2CuVSfxcjWH1iIkUZrEwIkQAUABOIulAvEspC5IB
FIyiwRQC8lMhAvCBGRO1oTozHfhLg3J+MORK17mgwLiEhhKPGWisLDdr0lGdSxwvrlxhfa58r/W+
MgQTjsg9AQiYihB2D6DjQUY3SpSKRMoIpHwahgEX8iALckEOQeBCXi69M1MQWsAI5WUWJrASkF7C
YWisAFCQFUlgXWVWZ5/81GPMhs1pLcKUTQzwRR2xAQWrNXNen2lHSAGYFBZta5zmIVQrKwrfAwYy
nJfc8O6pX5I3cBGiqK4N7WV6e0QvtXN+t8ZA4AAAAAcAAAAHAAAAAwAAAAAA4zeC/Ii2wxMFATMA
AQAAAAE+AAABPgAAAAQAAAAAAOM3gvyI74szIDoBNgFSAIDgAAgAACAAAAAAAUf8AACwjIADAP8g
IRtT9ZxIBhEAxcAiExHCV/AH3/C3LGACSbAsBmQ/PElECPs61+jKIiMzPy/RkMRSLG1p2RcKayig
BMSVwziJAsEKO8sdFV46LHP8Lo38spGCK5lmhOtWQJ2mCBN6leoGUpe5s6kBvkUOt5Ix1WS67wrd
LaJcnGuuWXVNNwGjbl5YmKvwsYp6FGJLl1AIHyIG/o5HggIAR2QZAIUgIRMOAuEfxsP1B9DRSdgB
aVQdjdukX6KaTgEiZWxiw49MAAmAE5AIABDkEgJAmCaqEOmCpjdfvwiZcisryuitK9xNSHAFKhKS
PeeOv6+umCK6e+i4RQzZ7HBbCEp6JSZp5N1Rp1SU+fp6Kt1k5bnPpY+LAAEV+dWamKZXUQNXo5Hg
wBwAAAAHAAAABwAAAAMAAAAAAOM3gvyJAHwTBQEzAAEAAAABjgAAAY4AAAAEAAAAAADjN4L8iULh
MyCKAYYBUgCA4AAJAAAkAAAAAAFH/AAAsIyAAwD/cCEbU+EKzDciCRBQNQsAOtCoqrYKrZBQSJyD
UDbUraqQD4XJddnEpZoIQ7jvyXqWvZ+CnheZo4dnWfZtxYcDpw5U2ay170tKK1JbClWQw9JF0dic
wK0qitAmiukrsWWqutVETAaXsbqa8eFwHBSmxwWr1ooQ5ybQnTiykAXACj1VhC6vOJCvUFHi/q9O
luRfBZ1wTnNmbkucUZnBWIYIIUEVzIzWdS6YjozSn8EyYjZl5zd6h5mOx8MA+oAelHZUIMyGJEGw
zCPHYt+7LAVSmX3YotRFbCM8RyEJ8igquc7qhEtxwuseFUANOKao9fVCsXN3qhq56YUxbYa9MV0i
F1aky410xqgIp0+XL8uusEEnT1qxzRzn0ri42F5KY8LMUJikIa7a1PoMVKDnlEl7hZCxmAD2WO2l
c8Kumr02NvTehx6LpuLdoIFHBypbScs724dJ3KI8tNsbttp/t2UzuXCjXtsDbHqnkvQD9UPygwcA
AAAHAAAABwAAAAMAAAAAAOM3gvyJWGoTBQEzAAEAAAABngAAAZ4AAAAEAAAAAADjN4L8iZY1MyCa
AZYBUgCA4AAKAAAoAAAAAAFH/AAAsIyAAwD/gCEbU72g7kNAiRBQKgiE2+wPvwFQpRMbEGISr9AY
DxjFlokPDEsb5WmaDpKtoGCcwJaFVFCPjHiGKffpnjW+6mRjSM6W6PWk3DvtzaprRmCegXjeUU5Y
clpUhtcHHWCCawGVkZJR4hRTMUwj6PGH5SKFxlU/xRiTBKkktrW+qMeSfz1zjaIXFwtSvjh4qzlB
ClOAH0ZR2Qdj/h0HpweiSKXUJkjTTTOosjOZRcRDJRhGVVMBcoDjNQXgR9rpGS2OTl0T3vo+YA8i
OyDYjCNCQIwtvXL6D4MsGCsAAxaYOXZta0LUrIdfRJN2SI+CL9YzjdFWn/tRemPlt8BrwVz20p/a
6enCxA0iufAUZBATpmpKdFn5qgb8ykW/6qsdDZIlQ246GbIPc1yFcV5wlXynlIfvze6uqSVrNRWN
lOdbMYCeTMYJvkBq5yeVduYEJkmMHd1d+r1ec9drWp/f1T++AuWc9IapsHeO5HOpxlxhAv6upspR
kKMXGoPOXfxP04DgAAAABwAAAAcAAAADAAAAAADjN4L8ibmNEwUBMwABAAAAAdAAAAHQAAAABAAA
AAAA4zeC/InpjTMgzAHIAVIAgOAACwAALAAAAAABR/wAALCMgAMA/7IhG1OqDsg0IiFETDgahboA
0ChGVQJSMXSJyMavEKikEsp06xbPfRI+gJdB9ekNsrIAxqem0FMHjlvkh4+G/CPnXAq2R3ARM4s0
hwlOKglxpDsVFCoXXgoQHafQ+Dcyfz95U17DpYHobmDYyw0Hds9SrMyav8erxE1PgAadrxiN5tmE
PTq5pUXAWIAVwMTCUzGqI4QTCMLzrYyAYltY+lUqK+U2l2zKoatNoIKTwX4KTU/A+JCUnU3wzBQE
yaYpcIsnafqlm5ePcex6nMH1f8Pp+/gvs6QA6oOyGQZoYRIKCOFigGmIDbW1CUASpATRfhK4ikpv
TaKgy8AjB0pHi/t0jxG6RhEHddfZH/sRV2knd4qSqye+hyQIRfiG1QRypkJyFL6rtqFvdJkp7OqG
smh6jXPOVTncjefvPmQ0vF5rjqYTVukDGXZgORdNaWhviVwpOnPX48Mc8K/pPaqjGtXe7nWT9onH
x0GCnEv8+ttaAoiBGrGNC7LDHlyjGTKZkoIACwAQgrowzk4aRmqeAc+lJhSnz5TVPfyaOlsv8E2N
vpMj8Ap9fS/ffA4DfwvQRYDgAAAABwAAAAcAAAADAAAAAADjN4L8iipaEwUBMwABAAAAAgcAAAIH
AAAABAAAAAAA4zeC/Io84jMgAwL/AVIAgOAADAAAMAAAAAABR/wAALCMgAMA/+khG1OtnMgvQ7BQ
QiYlCcJnpqxoAwCKRUUTEtsAWB8Zqvokl92yGx3cSzEcjz6Zarx49a4rbscM7bLfKu6zV10E6rzK
GvgElWogzFU5apmmRmpWL9B4apYbUWNfUIMpMVcE8N+JS8apB/HCvL+N/DTH+f0eafeDainPKV2N
JhUusWEbRCwKPu0Y6kC5AFLIJahvu2voHA1Yt99/Oeg2QnVKoO2G6jrihJRM3UgYXWulkhWZpLNL
pnIhH7dvq8+/VobP117PfdrfSJARlqytgYjMbf1nhErGEqzt6w+Wxs7t2Xp5WDrew+v952vCPsfN
AgHUhWUSkgTkNiIRhwKguEAADYAJKUJQvsK0mSNg0MljOJkcqXlUiOqR451UlxZ9FhEvoPieGVch
/KfBkIQS++BtujoradiNICLNKuSUslppooHb9xQ3qtvqqugBQI6+bty0JOwLFNV9KSkNLRgnOyUa
cMSjfZS6zSxFNzz1yGBHW2QrNaK2WjdDXRkbrBWmyh6QJXI/O5NjeoKO43YVvjZShtM9hAI9KJbK
jKfc0Q1UyqYVTmq3SIFseb1Dd3X6zkv5cfIg3eqUI9PDay3eOFjRxTmRnTVkDv+qwjdgSk37Ep52
DKOH2bYrdI8R1+t8p5h1Gloq9LzADgAAAAcAAAAHAAAAAwAAAAAA4zeC/IpRaRMFATMAAQAAAAIn
AAACJwAAAAQAAAAAAOM3gvyKkDgzICMCHwJSAIDgAA0AADQAAAAAAUf8AACwjIADAP//CSEbU7GO
yGQmCVBMVBsOhuEo7HmzAAwRCpRKRKEa+lwEmIhGyXbvksp4UjhSdGnRPh8V+W3IfrjZZU8h7xj3
Hf6hgB5pXBRzqZGt2p9U4kieRLcRHe9s3Q+h7lFcbzwTISFHkp+rVRYVsU1ldCU2QqPxgodxavSd
t079EK6Sx6TzIp3kOwUzOSRDGZ0mcbzvkqJLJCMqoKqH40C62aD1MRFBTh3a01GLF4V2UmkpJaL6
bbHyzmOatpolqlxhp7JTn1zzcVmrikbtd/5gtPjH2FIIWZadA4Jh1bQqR7p61TVZDkQyqkrtNgEl
AI12hxr/fNHbC861JWFI7Qs83/d0f9nsKJEA6IOyKYlGRCsNBsOhWFwhzQ4AUBQCFKul1fIARvBp
sClkagMcYkQE8lgB7vCtbxcbJ4LX+5fVV5XnYawJCWMOYBSHIjRWQvrF50L/tZrFK8jsG5F18w+R
3TO1o7TGrqz3P0SURHjhL01L99/pi8LcWwniIdh8Q3CRcKGZK6TCTSs2srMYMWeAOGauJJ6LHqkN
RKBgpPm04UMgB/VMqoBJbHaoYgqNC89pNAq8HQsz0GNnR9i3vudarpm58e7sm8uWmjYoceC1SzzE
My/CVN61p4ea/Q5pmFlw9jep+6lUzZPCPKD9ZEyuOJzi/YsEku0QSBpHcN8RrC8wSJub+HH7DvAU
BwAAAAcAAAAHAAAAAwAAAAAA4zeC/IrBOxMFATMAAQAAAAI1AAACNQAAAAQAAAAAAOM3gvyK45Ez
IDECLQJSAIDgAA4AADgAAAAAAUf8AACwjIADAP//FyEbU6EOyFNCMVBsOhWGQhggFAAQpKCVZQJP
dNtaorE0g1CAjCw9mzt2fH6izgA4VHW62wzYR/BlCUGaDLSPxiaPwQzxVUetKkIKAIRkiV78E9y8
vAbKSz0loH9KGEYvb7PSAkYbvvMJbpGEpnf5sk6TGszbwpEZTsoQXIwvEBtGsqwFjDEKICD1TUtX
dspEJSNgaCY8qilIErXB4LnmbpXflUUy0qJ0o/+03a/lmcoVEmisTvzvsGbfol+64Y6fjfwf7/54
1YZ5v/SFbZD2ew8BB9J2ONeY5RVY2T8EvTDGyX6Zzx71gbBuv7kBhGURl9WEBl9ImjTu65jgemeL
bz7SsPNP6Rz//P0dhckA6IOyDRBMdBwKhWGQhjc0BQAKkKAQlC0vxW+Z1g2K+NctZCiUEh5j8mxh
7wwPVqp9/kXVRq66J+XLeCVI4bPqyR6zmKK6odPZ1u7YSpwQokoiG9/EMAncBBtcVAUPJJilKJDQ
q4JOArsmG4VLLHSVC6b6MryJivkklnamwYRQCprMarEN7hCe0HGDTUpsBwgjahWtSLQF5pjcUj1K
SV5wOu6TMjjyoH68Opky/nd+97mMgx8DTnwswM0wPNx6T7MTVTqMgNHQIzt4MQZaZt9doXVwFqk2
74B8hudtjFFVOfv5sYzrIqiXaYWGnlycGw1mt6VZuhy80W3SfaVP3N+1+I8R+u7cahAHAAAABwAA
AAcAAAADAAAAAADjN4L8ivfsEwUBMwABAAAAAiIAAAIiAAAABAAAAAAA4zeC/Is24TMgHgIaAlIA
gOAADwAAPAAAAAABR/wAALCMgAMA//8EIRtTiY6KhhYhGKhGHQpCGQKoUZbIKEFVCi1DevmWPA1k
gvlP+XhWoukD0mKN5YTtU2d513XyREvNutshWjjySVoKV+we3Z2xwtxIxdEssjgztxl+7Ww6bu1L
2zczMsAD0DsKwcabLb8Ok952tVIFAJOtRY0hLaINTOl0tM06360iSvNwvwzna5xssptOJ9UELLUt
CvVnJNUmHLCkmYUNE5JDIkZ1p+IrctPd96YByhCPtl5c2snWdspZ9tE4fS6yglieaaku/PGqnvsP
b8Kz6uibn7vCyC5veXlnhVsNHPEnTYJVDQ9R5fg+c2/LLBYj4LfnVS74/+h639H8DLd+WfRNEByQ
dlJwkQjBQTDQcEoMhLEzdBUBRgRKAKgA5wORftvpMw37P3YVVJl/KXs9n3GGmeQe0pfsDdxlOdRz
Yq6LFQoXbONIyj2F1ITRXXZxswzzZsToJS2QJjK5WBQh7oB+HNqVdshwpECaENeUbjtHIe9h0kQs
x+ShdU3BhPI0UchsEQgJjoSZLTeSxLmIlvO8AdplIHQoEFq2Xr6q+LhEbRnFCXuGZuX+rlv7sN84
zoJC3ErW08wplUExicsp9iIzvb4LeVLsQsRim3VwxszaTdzCSOCqt2dCsn6LaNGtv8CpNifl/J1b
ej+lWUGZsQgatX/gP8X888FDf8X/SOCBwAAAAAcAAAAHAAAAAwAAAAAA4zeC/ItPVhMFATMAAQAA
AAHnAAAB5wAAAAQAAAAAAOM3gvyLijYzIOMB3wFSAIDgABAAAEAAAAAAAUf8AACwjIADAP/JIRtT
sliOhiGw6IEqIAFA2AKJSVAzeyyXKoIlHZLc+AvnoW/dmo0A5PGVcsYwyO4VXZIV3AEbjq0sBmEs
CxjEKSeMcVqbXefvjpycuceSceX1+hkrKDPRk5GFUrACrtikfRtbdAjPZcJrtescOu8PHTFpTM8l
8d6oLpylKJpZ9qHrCUXTgrx3953rwXE6K1EpQtSJ3AwbrFhNnwtrKV0vp3wslnlsax0hNFf0NzZl
Iqaw6utQjd8dixzNkHJXyUZaO6qb6Kto2CM0kyKok6ExpnuTZYQR4bEdpoNCgHxBDgq9q8uKKKKJ
0SIoIaEYZDQLDoUhAGEAxAwVJSgVc2IjL3FlkfVs5u9e2hDHEzkdkRVS3WvbKtHCjGoDLcy0UvFp
nIxhx0pyGGxKpzKhN++9G/r3KW/nUOVxNy930pVrXCn5LW0b1cX7KSWmoW264klW0iM4ZphWchMy
MzoMomi072WURdNJ71c8BwBeaYUqDDnNuXWlqW8PMaYOQt90mFRPXM8pQMk9dFvPrMrdxrHKyXba
M73+Qn2J4fmah9SC0UOgkg4c+W/zSbPZyJNqos46N6Z2efhsq+l2ptxPxHleXw1+q+led2g4AAAA
BwAAAAcAAAADAAAAAADjN4L8i78mEwUBMwABAAAAAQUAAAEFAAAABAAAAAAA4zeC/IvdizMgAQH9
AFIAgOAAEQAARAAAAAABR/wAALCMgAMA5yEbU7igKiQDCGB2ILBQJjWlrbRH/BPKtJEF0oY2QSEo
MVLqFMM2qEtZgJQmj5OlF5bMAzCGRtiyWlqWyGigXNlcK2osRmWQPsmucVnJvTgrQTiTkRCwZRk+
jkWgM0sLCtxRu4INTyuY3YaMUPANnHywAAdSSFRIBUFA7CAAxKhdKQ0MiEP8pMJHbyT9h0pHESre
UMbf2yEqsZ5MsGC7nXc0VFLh4l8N/BDhdH/qnFK2VcTJ3OCGBNjuoyWp71sybKLSpRkKeKyyzgxl
pcLjXwWeKr9kmTWc581ViMdP4cQ/AO6k5YAAcAAAAAcAAAAHAAAAAwAAAAAA4zeC/IvwdRMFATMA
AQAAAAA+AAAAPgAAAAQAAAAAAOM3gvyMMOgzIDoANgBSAIDgABIAAEgAAAAAAUf8AACwjIADACAh
G1TAfc1o6d6fzyKvyYD7mtHTvT+eVd/7MIUtLS0tLwAAAAcAAAAHAAAAAwAAAAAA4zeC/IxDexMF
ATMAAQAAAAA+AAAAPgAAAAQAAAAAAOM3gvyMhDkzIDoANgBSAIDgABMAAEwAAAAAAUf8AACwjIAD
ACAhEUUAFFABRvCBClpaWlpaWlpaWlpaWlpaWlpaWlpaXgAAAAcAAAAHAAAAAwAAAAAA4zeC/IyW
fhMFATMAAQAAAAA+AAAAPgAAAAQAAAAAAOM3gvyM14ozIDoANgBSAIDgABQAAFAAAAAAAUf8AACw
jIADACAhEUUAFFABRvCBClpaWlpaWlpaWlpaWlpaWlpaWlpaXgAAAAcAAAAHAAAAAwAAAAAA4zeC
/IzpgBMFATMAAQAAAAA+AAAAPgAAAAQAAAAAAOM3gvyNKuEzIDoANgBSAIDgABUAAFQAAAAAAUf8
AACwjIADACAhEUUAFFABRvCBClpaWlpaWlpaWlpaWlpaWlpaWlpaXgAAAAcAAAAHAAAAAwAAAAAA
4zeC/I08gRMFATMAAQAAAAA+AAAAPgAAAAQAAAAAAOM3gvyNfjYzIDoANgBSAIDgABYAAFgAAAAA
AUf8AACwjIADACAhEUUAFFABRvCBClpaWlpaWlpaWlpaWlpaWlpaWlpaXgAAAAcAAAAHAAAAAwAA
AAAA4zeC/I2QAxMFATMAAQAAAAA+AAAAPgAAAAQAAAAAAOM3gvyN0Y4zIDoANgBSAIDgABcAAFwA
AAAAAUf8AACwjIADACAhEUUAFFABRvCBClpaWlpaWlpaWlpaWlpaWlpaWlpaXgAAAAcAAAAHAAAA
AwAAAAAA4zeC/I3jABMFATMAAQAAAAA+AAAAPgAAAAQAAAAAAOM3gvyOJOEzIDoANgBSAIDgABgA
AGAAAAAAAUf8AACwjIADACAhEUUAFFABRvCBClpaWlpaWlpaWlpaWlpaWlpaWlpaXgAAAAcAAAAH
AAAAAwAAAAAA4zeC/I41ihMFATMAAQAAAAA+AAAAPgAAAAQAAAAAAOM3gvyOeDYzIDoANgBSAIDg
ABkAAGQAAAAAAUf8AACwjIADACAhEUUAFFABRvCBClpaWlpaWlpaWlpaWlpaWlpaWlpaXgAAAAcA
AAAHAAAAAwAAAAAA4zeC/I6JCBMFATMAAQAAAAA+AAAAPgAAAAQAAAAAAOM3gvyOy4wzIDoANgBS
AIDgABoAAGgAAAAAAUf8AACwjIADACAhEUUAFFABRvCBClpaWlpaWlpaWlpaWlpaWlpaWlpaXgAA
AAcAAAAHAAAAAwAAAAAA4zeC/I7bkBMFATMAAQAAAAA+AAAAPgAAAAQAAAAAAOM3gvyPHuEzIDoA
NgBSAIDgABsAAGwAAAAAAUf8AACwjIADACAhEUUAFFABRvCBClpaWlpaWlpaWlpaWlpaWlpaWlpa
XgAAAAcAAAAHAAAAAwAAAAAA4zeC/I8ukBMFATMAAQAAAAA+AAAAPgAAAAQAAAAAAOM3gvyPckEz
IDoANgBSAIDgABwAAHAAAAAAAUf8AACwjIADACAhEUUAFFABRvCBClpaWlpaWlpaWlpaWlpaWlpa
WlpaXgAAAAcAAAAHAAAAAwAAAAAA4zeC/I+BkxMFATMAAQAAAAAWAAAAFgAAAAQAAAAAAOM3gvyP
q6gzABIADgBTAEARDgBIAAAZWFAAAAEmAAAABwAAAAcAAAADAAAAAADjN4L8j7fHEwUBMwABAAAA
AD4AAAA+AAAABAAAAAAA4zeC/I/FjTMgOgA2AFIAgOAAHQAAdAAAAAABR/wAALCMgAMAICERRQAU
UAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8j9UTEwUBMwAB
AAAAABYAAAAWAAAABQAAAAAA4zeC/I/YtjMgEgAOAEQAQhEOCUgAABlYUAAAASYAAAA+AAAAPgAA
AAQAAAAAAOM3gvyQGOEzIDoANgBSAIDgAB4AAHgAAAAAAUf8AACwjIADACAhEUUAFFABRvCBClpa
WlpaWlpaWlpaWlpaWlpaWlpaXgAAAAcAAAAHAAAAAwAAAAAA4zeC/JA7IxMFATMAAQAAAAA+AAAA
PgAAAAQAAAAAAOM3gvyQbDUzIDoANgBSAIDgAB8AAHwAAAAAAUf8AACwjIADACAhIUUAFFABRvCB
ClpaWlpaWlpaWlpaWlpaWlpaWlpaXgAAAAcAAAAHAAAAAwAAAAAA4zeC/JB7FxMFATMAAQAAAAHG
AAABxgAAAAQAAAAAAOM3gvyQv4szIMIBvgFSAIDgACAAAIAAAAAAAUf8AACwjIADAP+oIU3YgA7v
4H8f+5B9aVAzlFTebCbdVnBclGi/BooQ/PL4vyFBFDKuAY5EFuUAdUHxMeF3GQrkfss9Pd7Q4SX7
HVD2vw//5/RPTvsA+8fXl9vo+dDUpuP6/Q+1iRiiDiDQdzZw/Z5K8Z0O9EUYGcqGYyH1c+APu6Ow
BOz0An4r8PE+LoIXBUXPlRkrj5M3f17QXy2ppM6Ej02zKwwVzHFYAl7I3ZlZL8K5fP8YEoRyHavO
xBq/j/7Gj+KyPtXYeCzmzTslIvTE0ZZJevc3c2E2oJQqoJgaErQvZbOunZ/oeFqgcQ+thVcq6mgu
bzWDJBbtbCIKJZRREUMq4FRPSRA6Xx9EzX14XvSkQAYRqFAnNfG+fdVd05AvheEXiu/nIE3yjCV5
36goYdd0fd+j7b1HHVvvO74+q979vGIcHU4IOVwdEFDRCAIxOvhaygY5v6U8uLlx6rqt9ykp7WNz
R5ZexAqEGhsl3O31fDAT6/77J/Yj6HkvcOdI5FZKgYi8NCmloHRumr1qqNYd7fDDRqmkjDRhOU1q
10CYw5kEEBF7YUJxfZ+/8YHAAAAABwAAAAcAAAADAAAAAADjN4L8kNdjEwUBMwABAAAAAZUAAAGV
AAAABAAAAAAA4zeC/JES5DMgkQGNAVIAgOAAIQAAhAAAAAABR/wAALCMgAMA/3che03wBpf//6Du
CGEgCFaCYShAJ7/YPZ7TzvqblIIACAER3DirsiqzT5NuBIPJnYRISyULHWbYqUWPRfMkTku0HeOK
7dVJu0lsbZ1tRaQl8RxGeZ5irphrDAraxamp6iy/muhTWHEv+V+tLcb8VNRBQUu+ufx/jF/AIiAg
ojcs5uM1hFNSF/0VknjNbota7M2r9yNUV1AgFEAXdHHqteiKnlxfnyRk/EHY8AS5ob32icr0iG7S
sJugnhJwIxUdi3GUT2R2mvx1jt7EBEWxSMIaINhKJVfsHtxxal8FGkAAIjfoDItI+c8xZCBEpSRT
XGX7onULWOCs0UWdWjqaxaLRZWHQtKVhafpm2c5gDGMUfDDCQQAH8AHm98AMgEhMBjLrgSQUAgR7
VhCHPtRKH4ZozjL8IQPrRwbRQQTuSWABU7qAKi57KeJ2sMAKJQERigA97ExrGAQ+7uxOSm5PErlm
kSqWHuar+o1ZbUnlnWPny+7NBUAAOAAAAAcAAAAHAAAAAwAAAAAA4zeC/JEqZhMFATMAAQAAAAC6
AAAAugAAAAQAAAAAAOM3gvyRZjgzILYAsgBSAIDgACIAAIgAAAAAAUf8AACwjIADAJwhG1QYisok
CIoAqDAI/YD2+6gnIOYWuySiwiLjf6zCctErMqzd9QhBECAAFEQuuAb4yEiILgGCqe18nR6bgQXo
6FQxHUYtGP3hvAPghHZBGDRCAxQBRCgwCPsB/mnIO7UMBhxKLUliV6bXOAJ0/VpHcQSIwH+VQF8w
BMCcRIWIrgL2LFxwWACt0pqM6y8J223KGS6T4BVtZ414B/AAAAAHAAAABwAAAAMAAAAAAOM3gvyR
eQMTBQEzAAEAAAAA2gAAANoAAAAEAAAAAADjN4L8kbmMMyDWANIAUgCA4AAjAACMAAAAAAFH/AAA
sIyAAwC8IRtUGArKJAcKwIhBC8AP8OWA13KmwNmW6Z5HP9rJbM13iqGGTz3PiPaotEzTZEiLQKTA
mAALBO4DAZqhIugqAVLIg9O64unjiuzpx/WqDZbY6aIeMe1eDB/UXHvZ9dpSEQhBHZRGDhKAhGBR
CgxCPkcD+TdYZdXgsQPO8OsYN451lEeB9Qqfh9FmnAxADaL3AAqmAuUsLJk+IBEIRmle0eMEK/10
LFCvPg/zTQRcv1zgH6t+xfhvwNKQ9gcAAAAHAAAABwAAAAMAAAAAAOM3gvyRy4cTBQEzAAEAAAAB
LAAAASwAAAAEAAAAAADjN4L8kgziMyAoASQBUgCA4AAkAACQAAAAAAFH/AAAsIyAAwD/DiEbU/CK
yiQDCEBi8BCJBMFRG/0A6/filOVGFqqzIHBDALhIx5OPsfLYK5VJ/FyNYfWIiRRmsTAiRABQAE4i
6UC8SykLkgEUjKLBFALyUyEC8IEZE7WhOjMd+EuDcn4w5ErXuaDAuISGEo8ZaKwsN2vSUZ1LHC+u
XGF9rnyv9b4yBBOOyD0BCJiKEHYPoONBRjdKlIpEygikfBqGARfyIAtyQQ5B4EJeLr0zUxBawAjl
ZRYmsBKQXsJhaKwAUJAVSWBdZVZnn/zUY8yGzWktwpRNDPBFHbEBBas1c16faUdIAZgUFm1rnOYh
VCsrCt8DBjKcl9zw7qlfkjdwEaKorg3tZXp7RC+1c363xkDgAAAABwAAAAcAAAADAAAAAADjN4L8
khmoEwUBMwABAAAAAT4AAAE+AAAABAAAAAAA4zeC/JJgOTMgOgE2AVIAgOAAJQAAlAAAAAABR/wA
ALCMgAMA/yAhG1P1nEgGEQDFwCITEcJX8Aff8LcsYAJJsCwGZD88SUQI+zrX6MoiIzM/L9GQxFIs
bWnZFwprKKAExJXDOIkCwQo7yx0VXjosc/wujfyykYIrmWaE61ZAnaYIE3qV6gZSl7mzqQG+RQ63
kjHVZLrvCt0tolyca65ZdU03AaNuXliYq/CxinoUYkuXUAgfIgb+jkeCAgBHZBkAhSAhEw4C4R/G
w/UH0NFJ2AFpVB2N26RfoppOASJlbGLDj0wACYATkAgAEOQSAkCYJqoQ6YKmN1+/CJlyKyvK6K0r
3E1IcAUqEpI9546/r66YIrp76LhFDNnscFsISnolJmnk3VGnVJT5+noq3WTluc+lj4sAARX51ZqY
pldRA1ejkeDAHAAAAAcAAAAHAAAAAwAAAAAA4zeC/JJyChMFATMAAQAAAAGOAAABjgAAAAQAAAAA
AOM3gvySs40zIIoBhgFSAIDgACYAAJgAAAAAAUf8AACwjIADAP9wIRtT4QrMNyIJEFA1CwA60Kiq
tgqtkFBInINQNtStqpAPhcl12cSlmghDuO/Jepa9n4KeF5mjh2dZ9m3FhwOnDlTZrLXvS0orUlsK
VZDD0kXR2JzArSqK0CaK6SuxZaq61URMBpexuprx4XAcFKbHBavWihDnJtCdOLKQBcAKPVWELq84
kK9QUeL+r06W5F8FnXBOc2ZuS5xRmcFYhgghQRXMjNZ1LpiOjNKfwTJiNmXnN3qHmY7HwwD6gB6U
dlQgzIYkQbDMI8di37ssBVKZfdii1EVsIzxHIQnyKCq5zuqES3HC6x4VQA04pqj19UKxc3eqGrnp
hTFthr0xXSIXVqTLjXTGqAinT5cvy66wQSdPWrHNHOfSuLjYXkpjwsxQmKQhrtrU+gxUoOeUSXuF
kLGYAPZY7aVzwq6avTY29N6HHoum4t2ggUcHKltJyzvbh0ncojy02xu22n+3ZTO5cKNe2wNseqeS
9AP1Q/KDBwAAAAcAAAAHAAAAAwAAAAAA4zeC/JLJ7xMFATMAAQAAAAGeAAABngAAAAQAAAAAAOM3
gvyTBuEzIJoBlgFSAIDgACcAAJwAAAAAAUf8AACwjIADAP+AIRtTvaDuQ0CJEFAqCITb7A+/AVCl
ExsQYhKv0BgPGMWWiQ8MSxvlaZoOkq2gYJzAloVUUI+MeIYp9+meNb7qZGNIzpbo9aTcO+3NqmtG
YJ6BeN5RTlhyWlSG1wcdYIJrAZWRklHiFFMxTCPo8YflIoXGVT/FGJMEqSS2tb6ox5J/PXONohcX
C1K+OHirOUEKU4AfRlHZB2P+HQenB6JIpdQmSNNNM6iyM5lFxEMlGEZVUwFygOM1BeBH2ukZLY5O
XRPe+j5gDyI7INiMI0JAjC29cvoPgywYKwADFpg5dm1rQtSsh19Ek3ZIj4Iv1jON0Vaf+1F6Y+W3
wGvBXPbSn9rp6cLEDSK58BRkEBOmakp0WfmqBvzKRb/qqx0NkiVDbjoZsg9zXIVxXnCVfKeUh+/N
7q6pJWs1FY2U51sxgJ5Mxgm+QGrnJ5V25gQmSYwd3V36vV5z12tan9/VP74C5Zz0hqmwd47kc6nG
XGEC/q6mylGQoxcag85d/E/TgOAAAAAHAAAABwAAAAMAAAAAAOM3gvyTHHQTBQEzAAEAAAAB0AAA
AdAAAAAEAAAAAADjN4L8k1o2MyDMAcgBUgCA4AAoAACgAAAAAAFH/AAAsIyAAwD/siEbU6oOyDQi
IURMOBqFugDQKEZVAlIxdInIxq8QqKQSynTrFs99Ej6Al0H16Q2ysgDGp6bQUweOW+SHj4b8I+dc
CrZHcBEzizSHCU4qCXGkOxUUKhdeChAdp9D4NzJ/P3lTXsOlgehuYNjLDQd2z1KszJq/x6vETU+A
Bp2vGI3m2YQ9OrmlRcBYgBXAxMJTMaojhBMIwvOtjIBiW1j6VSor5TaXbMqhq02ggpPBfgpNT8D4
kJSdTfDMFATJpilwiydp+qWbl49x7HqcwfV/w+n7+C+zpADqg7IZBmhhEgoI4WKAaYgNtbUJQBKk
BNF+EriKSm9NoqDLwCMHSkeL+3SPEbpGEQd119kf+xFXaSd3ipKrJ76HJAhF+IbVBHKmQnIUvqu2
oW90mSns6oayaHqNc85VOdyN5+8+ZDS8XmuOphNW6QMZdmA5F01paG+JXCk6c9fjwxzwr+k9qqMa
1d7udZP2icfHQYKcS/z621oCiIEasY0LssMeXKMZMpmSggALABCCujDOThpGap4Bz6UmFKfPlNU9
/Jo6Wy/wTY2+kyPwCn19L998DgN/C9BFgOAAAAAHAAAABwAAAAMAAAAAAOM3gvyTfh8TBQEzAAEA
AAACBwAAAgcAAAAEAAAAAADjN4L8k62ZMyADAv8BUgCA4AApAACkAAAAAAFH/AAAsIyAAwD/6SEb
U62cyC9DsFBCJiUJwmemrGgDAIpFRRMS2wBYHxmq+iSX3bIbHdxLMRyPPplqvHj1rituxwztst8q
7rNXXQTqvMoa+ASVaiDMVTlqmaZGalYv0HhqlhtRY19QgykxVwTw34lLxqkH8cK8v438NMf5/R5p
94NqKc8pXY0mFS6xYRtELAo+7RjqQLkAUsglqG+7a+gcDVi333856DZCdUqg7YbqOuKElEzdSBhd
a6WSFZmks0umciEft2+rz79Whs/XXs992t9IkBGWrK2BiMxt/WeESsYSrO3rD5bGzu3ZenlYOt7D
6/3na8I+x80CAdSFZRKSBOQ2IhGHAqC4QAANgAkpQlC+wrSZI2DQyWM4mRypeVSI6pHjnVSXFn0W
ES+g+J4ZVyH8p8GQhBL74G26Oitp2I0gIs0q5JSyWmmigdv3FDeq2+qq6AFAjr5u3LQk7AsU1X0p
KQ0tGCc7JRpwxKN9lLrNLEU3PPXIYEdbZCs1orZaN0NdGRusFabKHpAlcj87k2N6go7jdhW+NlKG
0z2EAj0olsqMp9zRDVTKphVOardIgWx5vUN3dfrOS/lx8iDd6pQj08NrLd44WNHFOZGdNWQO/6rC
N2BKTfsSnnYMo4fZtit0jxHX63ynmHUaWir0vMAOAAAABwAAAAcAAAADAAAAAADjN4L8k+3xEwUB
MwABAAAAAicAAAInAAAABAAAAAAA4zeC/JQA4TMgIwIfAlIAgOAAKgAAqAAAAAABR/wAALCMgAMA
//8JIRtTsY7IZCYJUExUGw6G4SjsebMADBEKlEpEoRr6XASYiEbJdu+SynhSOFJ0adE+HxX5bch+
uNllTyHvGPcd/qGAHmlcFHOpka3an1TiSJ5EtxEd72zdD6HuUVxvPBMhIUeSn6tVFhWxTWV0JTZC
o/GCh3Fq9J23Tv0QrpLHpPMineQ7BTM5JEMZnSZxvO+SokskIyqgqofjQLrZoPUxEUFOHdrTUYsX
hXZSaSklovptsfLOY5q2miWqXGGnslOfXPNxWauKRu13/mC0+MfYUghZlp0DgmHVtCpHunrVNVkO
RDKqSu02ASUAjXaHGv980dsLzrUlYUjtCzzf93R/2ewokQDog7IpiUZEKw0Gw6FYXCHNDgBQFAIU
q6XV8gBG8GmwKWRqAxxiRATyWAHu8K1vFxsngtf7l9VXledhrAkJYw5gFIciNFZC+sXnQv+1msUr
yOwbkXXzD5HdM7WjtMaurPc/RJREeOEvTUv33+mLwtxbCeIh2HxDcJFwoZkrpMJNKzaysxgxZ4A4
Zq4knoseqQ1EoGCk+bThQyAH9UyqgElsdqhiCo0Lz2k0CrwdCzPQY2dH2Le+51qumbnx7uyby5aa
Nihx4LVLPMQzL8JU3rWnh5r9DmmYWXD2N6n7qVTNk8I8oP1kTK44nOL9iwSS7RBIGkdw3xGsLzBI
m5v4cfsO8BQHAAAABwAAAAcAAAADAAAAAADjN4L8lBV8EwUBMwABAAAAAjUAAAI1AAAABAAAAAAA
4zeC/JRUQDMgMQItAlIAgOAAKwAArAAAAAABR/wAALCMgAMA//8XIRtToQ7IU0IxUGw6FYZCGCAU
ABCkoJVlAk9021qisTSDUICMLD2bO3Z8fqLOADhUdbrbDNhH8GUJQZoMtI/GJo/BDPFVR60qQgoA
hGSJXvwT3Ly8BspLPSWgf0oYRi9vs9ICRhu+8wlukYSmd/myTpMazNvCkRlOyhBcjC8QG0ayrAWM
MQogIPVNS1d2ykQlI2BoJjyqKUgStcHgueZuld+VRTLSonSj/7Tdr+WZyhUSaKxO/O+wZt+iX7rh
jp+N/B/v/njVhnm/9IVtkPZ7DwEH0nY415jlFVjZPwS9MMbJfpnPHvWBsG6/uQGEZRGX1YQGX0ia
NO7rmOB6Z4tvPtKw80/pHP/8/R2FyQDog7INEEx0HAqFYZCGNzQFAAqQoBCULS/Fb5nWDYr41y1k
KJQSHmPybGHvDA9Wqn3+RdVGrron5ct4JUjhs+rJHrOYorqh09nW7thKnBCiSiIb38QwCdwEG1xU
BQ8kmKUokNCrgk4CuyYbhUssdJULpvoyvImK+SSWdqbBhFAKmsxqsQ3uEJ7QcYNNSmwHCCNqFa1I
tAXmmNxSPUpJXnA67pMyOPKgfrw6mTL+d373uYyDHwNOfCzAzTA83HpPsxNVOoyA0dAjO3gxBlpm
312hdXAWqTbvgHyG522MUVU5+/mxjOsiqJdphYaeXJwbDWa3pVm6HLzRbdJ9pU/c37X4jxH67txq
EAcAAAAHAAAABwAAAAMAAAAAAOM3gvyUaIATBQEzAAEAAAACIgAAAiIAAAAEAAAAAADjN4L8lKeW
MyAeAhoCUgCA4AAsAACwAAAAAAFH/AAAsIyAAwD//wQhG1OJjoqGFiEYqEYdCkIZAqhRlsgoQVUK
LUN6+ZY8DWSC+U/5eFai6QPSYo3lhO1TZ3nXdfJES8262yFaOPJJWgpX7B7dnbHC3EjF0SyyODO3
GX7tbDpu7UvbNzMywAPQOwrBxpstvw6T3na1UgUAk61FjSEtog1M6XS0zTrfrSJK83C/DOdrnGyy
m04n1QQstS0K9Wck1SYcsKSZhQ0TkkMiRnWn4ity0933pgHKEI+2XlzaydZ2yln20Th9LrKCWJ5p
qS788aqe+w9vwrPq6Jufu8LILm95eWeFWw0c8SdNglUND1Hl+D5zb8ssFiPgt+dVLvj/6Hrf0fwM
t35Z9E0QHJB2UnCRCMFBMNBwSgyEsTN0FQFGBEoAqADnA5F+2+kzDfs/dhVUmX8pez2fcYaZ5B7S
l+wN3GU51HNirosVChds40jKPYXUhNFddnGzDPNmxOglLZAmMrlYFCHugH4c2pV2yHCkQJoQ15Ru
O0ch72HSRCzH5KF1TcGE8jRRyGwRCAmOhJktN5LEuYiW87wB2mUgdCgQWrZevqr4uERtGcUJe4Zm
5f6uW/uw3zjOgkLcStbTzCmVQTGJyyn2IjO9vgt5UuxCxGKbdXDGzNpN3MJI4Kq3Z0Kyfoto0a2/
wKk2J+X8nVt6P6VZQZmxCBq1f+A/xfzzwUN/xf9I4IHAAAAB5wAAAecAAAAEAAAAAADjN4L8lPrs
MyDjAd8BUgCA4AAtAAC0AAAAAAFH/AAAsIyAAwD/ySEbU7JYjoYhsOiBKiABQNgCiUlQM3sslyqC
JR2S3PgL56Fv3ZqNAOTxlXLGMMjuFV2SFdwBG46tLAZhLAsYxCknjHFam13n746cnLnHknHl9foZ
Kygz0ZORhVKwAq7YpH0bW3QIz2XCa7XrHDrvDx0xaUzPJfHeqC6cpSiaWfah6wlF04K8d/ed68Fx
OitRKULUidwMG6xYTZ8LayldL6d8LJZ5bGsdITRX9Dc2ZSKmsOrrUI3fHYsczZByV8lGWjuqm+ir
aNgjNJMiqJOhMaZ7k2WEEeGxHaaDQoB8QQ4KvavLiiiiidEiKCGhGGQ0Cw6FIQBhAMQMFSUoFXNi
Iy9xZZH1bObvXtoQxxM5HZEVUt1r2yrRwoxqAy3MtFLxaZyMYcdKchhsSqcyoTfvvRv69ylv51Dl
cTcvd9KVa1wp+S1tG9XF+yklpqFtuuJJVtIjOGaYVnITMjM6DKJotO9llEXTSe9XPAcAXmmFKgw5
zbl1palvDzGmDkLfdJhUT1zPKUDJPXRbz6zK3caxysl22jO9/kJ9ieH5mofUgtFDoJIOHPlv80mz
2ciTaqLOOjemdnn4bKvpdqbcT8R5Xl8NfqvpXndoOAAAAAcAAAAHAAAAAwAAAAAA4zeC/JUEwBMF
ATMAAQAAAAAHAAAABwAAAAMAAAAAAOM3gvyVE2YTBQEzAAEAAAABBQAAAQUAAAAEAAAAAADjN4L8
lU5AMyABAf0AUgCA4AAuAAC4AAAAAAFH/AAAsIyAAwDnIRtTuKAqJAMIYHYgsFAmNaWttEf8E8q0
kQXShjZBISgxUuoUwzaoS1mAlCaPk6UXlswDMIZG2LJaWpbIaKBc2VwraixGZZA+ya5xWcm9OCtB
OJORELBlGT6ORaAzSwsK3FG7gg1PK5jdhoxQ8A2cfLAAB1JIVEgFQUDsIADEqF0pDQyIQ/ykwkdv
JP2HSkcRKt5Qxt/bISqxnkywYLuddzRUUuHiXw38EOF0f+qcUrZVxMnc4IYE2O6jJanvWzJsotKl
GQp4rLLODGWlwuNfBZ4qv2SZNZznzVWIx0/hxD8A7qTlgABwAAAABwAAAAcAAAADAAAAAADjN4L8
lVykEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/JWhljMgOgA2AFIAgOAALwAAvAAAAAABR/wA
ALCMgAMAICEbVMB9zWjp3p/PIq/JgPua0dO9P55V3/swhS0tLS0vAAAABwAAAAcAAAADAAAAAADj
N4L8leVfEwUBMwABAAAAABAAAAAQAAAABAAAAAAA4zeC/JXmRDMADAAIAAEABg0EAAVAQAAAAAAH
AAAABwAAAAMAAAAAAOM3gvyV7yETBQEzAAEAAAAAPgAAAD4AAAAEAAAAAADjN4L8lfTiMyA6ADYA
UgCA4AAwAADAAAAAAAFH/AAAsIyAAwAgIRFFABRQAUbwgQpaWlpaWlpaWlpaWlpaWlpaWlpaWl4A
AAAHAAAABwAAAAMAAAAAAOM3gvyWAqsTBQEzAAEAAAAAEAAAABAAAAAFAAAAAADjN4L8lgqkMyAM
AAgAAQAHDQQABUBAAAAAAD4AAAA+AAAABAAAAAAA4zeC/JZINzMgOgA2AFIAgOAAMQAAxAAAAAAB
R/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAA
AADjN4L8llqQEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/JabjzMgOgA2AFIAgOAAMgAAyAAA
AAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAAD
AAAAAADjN4L8lq2SEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/Jbu4TMgOgA2AFIAgOAAMwAA
zAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcA
AAADAAAAAADjN4L8lwCUEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/JdCOTMgOgA2AFIAgOAA
NAAA0AAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAA
AAcAAAADAAAAAADjN4L8l1zdEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/JeVnTMgOgA2AFIA
gOAANQAA1AAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAA
BwAAAAcAAAADAAAAAADjN4L8l6aYEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/Jfo6DMgOgA2
AFIAgOAANgAA2AAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpe
AAAABwAAAAcAAAADAAAAAADjN4L8l/mbEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/Jg8NjMg
OgA2AFIAgOAANwAA3AAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpa
WlpeAAAABwAAAAcAAAADAAAAAADjN4L8mEyhEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/JiP
jjMgOgA2AFIAgOAAOAAA4AAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpa
WlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8mKBmEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC
/Jji4jMgOgA2AFIAgOAAOQAA5AAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpa
WlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8mPvqEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA
4zeC/Jk2ODMgOgA2AFIAgOAAOgAA6AAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpa
WlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8mUWmEwUBMwABAAAAAD4AAAA+AAAABAAA
AAAA4zeC/JmJjDMgOgA2AFIAgOAAOwAA7AAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpa
WlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8mZipEwUBMwABAAAAAD4AAAA+AAAA
BAAAAAAA4zeC/Jnc4TMgOgA2AFIAgOAAPAAA8AAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpa
WlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8meurEwUBMwABAAAAAD4AAAA+
AAAABAAAAAAA4zeC/JowNzMgOgA2AFIAgOAAPQAA9AAAAAABR/wAALCMgAMAICERRQAUUAFG8IEK
WlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8mkh1EwUBMwABAAAAAD4A
AAA+AAAABAAAAAAA4zeC/JqDjTMgOgA2AFIAgOAAPgAA+AAAAAABR/wAALCMgAMAICERRQAUUAFG
8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8mpaSEwUBMwABAAAA
AD4AAAA+AAAABAAAAAAA4zeC/JrW4TMgOgA2AFIAgOAAPwAA/AAAAAABR/wAALCMgAMAICERRQAU
UAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8mumVEwUBMwAB
AAAAAD4AAAA+AAAABAAAAAAA4zeC/JsqNzMgOgA2AFIAgOAAQAABAAAAAAABR/wAALCMgAMAICER
RQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8mzyYEwUB
MwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/Jt9jzMgOgA2AFIAgOAAQQABBAAAAAABR/wAALCMgAMA
ICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8m5AZ
EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/JvQ4DMgOgA2AFIAgOAAQgABCAAAAAABR/wAALCM
gAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8
m+KdEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/JwkNjMgOgA2AFIAgOAAQwABDAAAAAABR/wA
ALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADj
N4L8nDWiEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/Jx3jjMgOgA2AFIAgOAARAABEAAAAAAB
R/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAA
AADjN4L8nIkhEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/JzK4jMgOgA2AFIAgOAARQABFAAA
AAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAAD
AAAAAADjN4L8nNulEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/J0eNzMgOgA2AFIAgOAARgAB
GAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcA
AAADAAAAAADjN4L8nS6pEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/J1xjTMgOgA2AFIAgOAA
RwABHAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAA
AAcAAAADAAAAAADjN4L8nYGrEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/J3E4zMgOgA2AFIA
gOAASAABIAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAA
BwAAAAcAAAADAAAAAADjN4L8ndUqEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/J4YOTMgOgA2
AFIAgOAASQABJAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpe
AAAABwAAAAcAAAADAAAAAADjN4L8nievEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/J5rjTMg
OgA2AFIAgOAASgABKAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpa
WlpeAAAABwAAAAcAAAADAAAAAADjN4L8nnq0EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/J6+
4DMgOgA2AFIAgOAASwABLAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpa
WlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8nusEEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC
/J8SNjMgOgA2AFIAgOAATAABMAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpa
WlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8nyE1EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA
4zeC/J9ljDMgOgA2AFIAgOAATQABNAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpa
WlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8n3O6EwUBMwABAAAAAD4AAAA+AAAABAAA
AAAA4zeC/J+44jMgOgA2AFIAgOAATgABOAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpa
WlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8n9TmEwUBMwABAAAAAD4AAAA+AAAA
BAAAAAAA4zeC/KAMNjMgOgA2AFIAgOAATwABPAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpa
WlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8oB6kEwUBMwABAAAAAD4AAAA+
AAAABAAAAAAA4zeC/KBfjDMgOgA2AFIAgOAAUAABQAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEK
WlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8oHGlEwUBMwABAAAAAD4A
AAA+AAAABAAAAAAA4zeC/KCy4DMgOgA2AFIAgOAAUQABRAAAAAABR/wAALCMgAMAICERRQAUUAFG
8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8oMSnEwUBMwABAAAA
AD4AAAA+AAAABAAAAAAA4zeC/KEGODMgOgA2AFIAgOAAUgABSAAAAAABR/wAALCMgAMAICERRQAU
UAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8oRepEwUBMwAB
AAAAAD4AAAA+AAAABAAAAAAA4zeC/KFZkTMgOgA2AFIAgOAAUwABTAAAAAABR/wAALCMgAMAICER
RQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8oWqsEwUB
MwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/KGs7DMgOgA2AFIAgOAAVAABUAAAAAABR/wAALCMgAMA
ICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8ob2u
EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/KIAODMgOgA2AFIAgOAAVQABVAAAAAABR/wAALCM
gAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8
ohEwEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/KJTijMgOgA2AFIAgOAAVgABWAAAAAABR/wA
ALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADj
N4L8omO0EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/KKm5DMgOgA2AFIAgOAAVwABXAAAAAAB
R/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAA
AADjN4L8ora5EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/KL6ODMgOgA2AFIAgOAAWAABYAAA
AAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAAD
AAAAAADjN4L8owm5EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/KNNmjMgOgA2AFIAgOAAWQAB
ZAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcA
AAADAAAAAADjN4L8o3BHEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/KOg7DMgOgA2AFIAgOAA
WgABaAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAA
AAcAAAADAAAAAADjN4L8o6+/EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/KP0QDMgOgA2AFIA
gOAAWwABbAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAA
BwAAAAcAAAADAAAAAADjN4L8pALDEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/KRHizMgOgA2
AFIAgOAAXAABcAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpe
AAAABwAAAAcAAAADAAAAAADjN4L8pF+IEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/KSa4TMg
OgA2AFIAgOAAXQABdAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpa
WlpeAAAABwAAAAcAAAADAAAAAADjN4L8pK2rEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/KTu
NTMgOgA2AFIAgOAAXgABeAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpa
WlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8pQCrEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC
/KVBjTMgOgA2AFIAgOAAXwABfAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpa
WlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8pVOuEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA
4zeC/KWU5DMgOgA2AFIAgOAAYAABgAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpa
WlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8paHQEwUBMwABAAAAAD4AAAA+AAAABAAA
AAAA4zeC/KXoQzMgOgA2AFIAgOAAYQABhAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpa
WlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8pfVOEwUBMwABAAAAAD4AAAA+AAAA
BAAAAAAA4zeC/KY7jDMgOgA2AFIAgOAAYgABiAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpa
WlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8pky2EwUBMwABAAAAAD4AAAA+
AAAABAAAAAAA4zeC/KaO4TMgOgA2AFIAgOAAYwABjAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEK
WlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8pp+5EwUBMwABAAAAAD4A
AAA+AAAABAAAAAAA4zeC/KbiNjMgOgA2AFIAgOAAZAABkAAAAAABR/wAALCMgAMAICERRQAUUAFG
8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8pvM5EwUBMwABAAAA
AD4AAAA+AAAABAAAAAAA4zeC/Kc1izMgOgA2AFIAgOAAZQABlAAAAAABR/wAALCMgAMAICERRQAU
UAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8p0W+EwUBMwAB
AAAAAD4AAAA+AAAABAAAAAAA4zeC/KeI4TMgOgA2AFIAgOAAZgABmAAAAAABR/wAALCMgAMAICER
RQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8p5jAEwUB
MwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/KfcQDMgOgA2AFIAgOAAZwABnAAAAAABR/wAALCMgAMA
ICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8p+vF
EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/KgvizMgOgA2AFIAgOAAaAABoAAAAAABR/wAALCM
gAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8
qD7FEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/KiC7jMgOgA2AFIAgOAAaQABpAAAAAABR/wA
ALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADj
N4L8qJHJEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/KjWPjMgOgA2AFIAgOAAagABqAAAAAAB
R/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAA
AADjN4L8qO4UEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/KkpjTMgOgA2AFIAgOAAawABrAAA
AAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAAD
AAAAAADjN4L8qTfNEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/Kl84DMgOgA2AFIAgOAAbAAB
sAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcA
AAADAAAAAADjN4L8qZAxEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/KnQODMgOgA2AFIAgOAA
bQABtAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAAPgAA
AD4AAAAEAAAAAADjN4L8qiONMyA6ADYAUgCA4ABuAAG4AAAAAAFH/AAAsIyAAwAgIRFFABRQAUbw
gQpaWlpaWlpaWlpaWlpaWlpaWlpaWl4AAAAHAAAABwAAAAMAAAAAAOM3gvyqRF4TBQEzAAEAAAAA
BwAAAAcAAAADAAAAAADjN4L8qk4kEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/Kp24DMgOgA2
AFIAgOAAbwABvAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpe
AAAABwAAAAcAAAADAAAAAADjN4L8qoi6EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/KrKQTMg
OgA2AFIAgOAAcAABwAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpa
WlpeAAAABwAAAAcAAAADAAAAAADjN4L8qtu8EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/Ksd
lDMgOgA2AFIAgOAAcQABxAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpa
WlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8qy7BEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC
/Ktw6TMgOgA2AFIAgOAAcgAByAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpa
WlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8q4HAEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA
4zeC/KvEQzMgOgA2AFIAgOAAcwABzAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpa
WlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8q9THEwUBMwABAAAAAD4AAAA+AAAABAAA
AAAA4zeC/KwXoDMgOgA2AFIAgOAAdAAB0AAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpa
WlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8rCfHEwUBMwABAAAAAD4AAAA+AAAA
BAAAAAAA4zeC/Kxq5DMgOgA2AFIAgOAAdQAB1AAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpa
WlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8rHrJEwUBMwABAAAAAD4AAAA+
AAAABAAAAAAA4zeC/Ky+NzMgOgA2AFIAgOAAdgAB2AAAAAABR/wAALCMgAMAICERRQAUUAFG8IEK
WlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8rM3OEwUBMwABAAAAAD4A
AAA+AAAABAAAAAAA4zeC/K0RjjMgOgA2AFIAgOAAdwAB3AAAAAABR/wAALCMgAMAICERRQAUUAFG
8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8rSDOEwUBMwABAAAA
AD4AAAA+AAAABAAAAAAA4zeC/K1k6DMgOgA2AFIAgOAAeAAB4AAAAAABR/wAALCMgAMAICERRQAU
UAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8rYdZEwUBMwAB
AAAAAD4AAAA+AAAABAAAAAAA4zeC/K24QTMgOgA2AFIAgOAAeQAB5AAAAAABR/wAALCMgAMAICER
RQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8rcbUEwUB
MwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/K4LjDMgOgA2AFIAgOAAegAB6AAAAAABR/wAALCMgAMA
ICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8rh68
EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/K5e4jMgOgA2AFIAgOAAewAB7AAAAAABR/wAALCM
gAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8
rnG9EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/K6yNjMgOgA2AFIAgOAAfAAB8AAAAAABR/wA
ALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADj
N4L8rsVFEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/K8FizMgOgA2AFIAgOAAfQAB9AAAAAAB
R/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAA
AADjN4L8rxfAEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/K9Y4jMgOgA2AFIAgOAAfgAB+AAA
AAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAAD
AAAAAADjN4L8r3QLEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/K+sNTMgOgA2AFIAgOAAfwAB
/AAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcA
AAADAAAAAADjN4L8r73IEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/K//izMgOgA2AFIAgOAA
gAACAAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAA
AAcAAAADAAAAAADjN4L8sBqNEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/LBS4zMgOgA2AFIA
gOAAgQACBAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAA
BwAAAAcAAAADAAAAAADjN4L8sGPLEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/LCmNjMgOgA2
AFIAgOAAggACCAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpe
AAAABwAAAAcAAAADAAAAAADjN4L8sLbPEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/LD5kTMg
OgA2AFIAgOAAgwACDAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpa
WlpeAAAABwAAAAcAAAADAAAAAADjN4L8sQnQEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/LFM
4DMgOgA2AFIAgOAAhAACEAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpa
WlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8sVzVEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC
/LGgNjMgOgA2AFIAgOAAhQACFAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpa
WlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8sa/WEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA
4zeC/LHzjDMgOgA2AFIAgOAAhgACGAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpa
WlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8sh+oEwUBMwABAAAAAD4AAAA+AAAABAAA
AAAA4zeC/LJG4TMgOgA2AFIAgOAAhwACHAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpa
WlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8slZaEwUBMwABAAAAAD4AAAA+AAAA
BAAAAAAA4zeC/LKaNjMgOgA2AFIAgOAAiAACIAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpa
WlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8sqlbEwUBMwABAAAAAD4AAAA+
AAAABAAAAAAA4zeC/LLtjDMgOgA2AFIAgOAAiQACJAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEK
WlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8sw7sEwUBMwABAAAAAD4A
AAA+AAAABAAAAAAA4zeC/LNA4TMgOgA2AFIAgOAAigACKAAAAAABR/wAALCMgAMAICERRQAUUAFG
8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8s1PFEwUBMwABAAAA
AD4AAAA+AAAABAAAAAAA4zeC/LOUQDMgOgA2AFIAgOAAiwACLAAAAAABR/wAALCMgAMAICERRQAU
UAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8s6bHEwUBMwAB
AAAAAD4AAAA+AAAABAAAAAAA4zeC/LPnmTMgOgA2AFIAgOAAjAACMAAAAAABR/wAALCMgAMAICER
RQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8s/nMEwUB
MwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/LQ65TMgOgA2AFIAgOAAjQACNAAAAAABR/wAALCMgAMA
ICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8tEzQ
EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/LSOOTMgOgA2AFIAgOAAjgACOAAAAAABR/wAALCM
gAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8
tJ/REwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/LThjTMgOgA2AFIAgOAAjwACPAAAAAABR/wA
ALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADj
N4L8tPLSEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/LU07DMgOgA2AFIAgOAAkAACQAAAAAAB
R/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAA
AADjN4L8tUZVEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/LWIPzMgOgA2AFIAgOAAkQACRAAA
AAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAAD
AAAAAADjN4L8tZjaEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/LXbnDMgOgA2AFIAgOAAkgAC
SAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcA
AAADAAAAAADjN4L8teveEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/LYu4jMgOgA2AFIAgOAA
kwACTAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAA
AAcAAAADAAAAAADjN4L8tj7cEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/LaCODMgOgA2AFIA
gOAAlAACUAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAA
BwAAAAcAAAADAAAAAADjN4L8tpHhEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/LbVizMgOgA2
AFIAgOAAlQACVAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpe
AAAABwAAAAcAAAADAAAAAADjN4L8tuThEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/Lco7zMg
OgA2AFIAgOAAlgACWAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpa
WlpeAAAABwAAAAcAAAADAAAAAADjN4L8tzfmEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/Ld8
QjMgOgA2AFIAgOAAlwACXAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpa
WlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8t5QuEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC
/LfPlzMgOgA2AFIAgOAAmAACYAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpa
WlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8t+LNEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA
4zeC/Lgi7DMgOgA2AFIAgOAAmQACZAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpa
WlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8uDZOEwUBMwABAAAAAD4AAAA+AAAABAAA
AAAA4zeC/Lh2QDMgOgA2AFIAgOAAmgACaAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpa
WlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8uJvcEwUBMwABAAAAAD4AAAA+AAAA
BAAAAAAA4zeC/LjJjDMgOgA2AFIAgOAAmwACbAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpa
WlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8uNvUEwUBMwABAAAAAD4AAAA+
AAAABAAAAAAA4zeC/Lkc4DMgOgA2AFIAgOAAnAACcAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEK
WlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8uS7WEwUBMwABAAAAAD4A
AAA+AAAABAAAAAAA4zeC/LlwNjMgOgA2AFIAgOAAnQACdAAAAAABR/wAALCMgAMAICERRQAUUAFG
8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8uXz2EwUBMwABAAAA
AD4AAAA+AAAABAAAAAAA4zeC/LnDljMgOgA2AFIAgOAAngACeAAAAAABR/wAALCMgAMAICERRQAU
UAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8udVZEwUBMwAB
AAAAAD4AAAA+AAAABAAAAAAA4zeC/LoW5DMgOgA2AFIAgOAAnwACfAAAAAABR/wAALCMgAMAICER
RQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8uidjEwUB
MwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/LpqQDMgOgA2AFIAgOAAoAACgAAAAAABR/wAALCMgAMA
ICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8unpm
EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/Lq9jDMgOgA2AFIAgOAAoQAChAAAAAABR/wAALCM
gAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8
us3jEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/LsQ6TMgOgA2AFIAgOAAogACiAAAAAABR/wA
ALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADj
N4L8uyBrEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/LtkNjMgOgA2AFIAgOAAowACjAAAAAAB
R/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAA
AADjN4L8u3NrEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/Lu3izMgOgA2AFIAgOAApAACkAAA
AAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAAD
AAAAAADjN4L8u8ZxEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/LwK4jMgOgA2AFIAgOAApQAC
lAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcA
AAADAAAAAADjN4L8vCz4EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/LxeNzMgOgA2AFIAgOAA
pgACmAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAA
AAcAAAADAAAAAADjN4L8vHY4EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/LyxjDMgOgA2AFIA
gOAApwACnAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAA
BwAAAAcAAAADAAAAAADjN4L8vNN7EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/L0E4TMgOgA2
AFIAgOAAqAACoAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpe
AAAABwAAAAcAAAADAAAAAADjN4L8vRddEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/L1YNjMg
OgA2AFIAgOAAqQACpAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpa
WlpeAAAABwAAAAcAAAADAAAAAADjN4L8vWrdEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/L2r
jDMgOgA2AFIAgOAAqgACqAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpa
WlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8vb1gEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC
/L3+6DMgOgA2AFIAgOAAqwACrAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpa
WlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8vi2vEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA
4zeC/L5SNjMgOgA2AFIAgOAArAACsAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpa
WlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8vmNlEwUBMwABAAAAAD4AAAA+AAAABAAA
AAAA4zeC/L6lizMgOgA2AFIAgOAArQACtAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpa
WlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8vrboEwUBMwABAAAAAD4AAAA+AAAA
BAAAAAAA4zeC/L744DMgOgA2AFIAgOAArgACuAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpa
WlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8vxzwEwUBMwABAAAAAD4AAAA+
AAAABAAAAAAA4zeC/L9MNTMgOgA2AFIAgOAArwACvAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEK
WlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8v1zyEwUBMwABAAAAAD4A
AAA+AAAABAAAAAAA4zeC/L+fizMgOgA2AFIAgOAAsAACwAAAAAABR/wAALCMgAMAICERRQAUUAFG
8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8v69wEwUBMwABAAAA
AD4AAAA+AAAABAAAAAAA4zeC/L/y4TMgOgA2AFIAgOAAsQACxAAAAAABR/wAALCMgAMAICERRQAU
UAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8wALvEwUBMwAB
AAAAAD4AAAA+AAAABAAAAAAA4zeC/MBGNzMgOgA2AFIAgOAAsgACyAAAAAABR/wAALCMgAMAICER
RQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8wFV0EwUB
MwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/MCZjDMgOgA2AFIAgOAAswACzAAAAAABR/wAALCMgAMA
ICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8wM+I
EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/MDs4DMgOgA2AFIAgOAAtAAC0AAAAAABR/wAALCM
gAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8
wPv3EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/MFANzMgOgA2AFIAgOAAtQAC1AAAAAABR/wA
ALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADj
N4L8wU5+EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/MGTjDMgOgA2AFIAgOAAtgAC2AAAAAAB
R/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAA
AADjN4L8wavAEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/MHm4jMgOgA2AFIAgOAAtwAC3AAA
AAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAAD
AAAAAADjN4L8wflkEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/MI6NzMgOgA2AFIAgOAAuAAC
4AAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcA
AAADAAAAAADjN4L8wkzkEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/MKNljMgOgA2AFIAgOAA
uQAC5AAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAA
AAcAAAADAAAAAADjN4L8wp9pEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/MLg4TMgOgA2AFIA
gOAAugAC6AAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAA
BwAAAAcAAAADAAAAAADjN4L8wvJsEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/MM0NTMgOgA2
AFIAgOAAuwAC7AAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpe
AAAABwAAAAcAAAADAAAAAADjN4L8w0VuEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/MOHjDMg
OgA2AFIAgOAAvAAC8AAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpa
WlpeAAAABwAAAAcAAAADAAAAAADjN4L8w5jvEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/MPa
4zMgOgA2AFIAgOAAvQAC9AAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpa
WlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8w+vzEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC
/MQuNTMgOgA2AFIAgOAAvgAC+AAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpa
WlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8xD55EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA
4zeC/MSBiTMgOgA2AFIAgOAAvwAC/AAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpa
WlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8xJF7EwUBMwABAAAAAD4AAAA+AAAABAAA
AAAA4zeC/MTU4jMgOgA2AFIAgOAAwAADAAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpa
WlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8xOR8EwUBMwABAAAAAD4AAAA+AAAA
BAAAAAAA4zeC/MUoODMgOgA2AFIAgOAAwQADBAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpa
WlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8xTf9EwUBMwABAAAAAD4AAAA+
AAAABAAAAAAA4zeC/MV7kzMgOgA2AFIAgOAAwgADCAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEK
WlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8xYqBEwUBMwABAAAAAD4A
AAA+AAAABAAAAAAA4zeC/MXO7DMgOgA2AFIAgOAAwwADDAAAAAABR/wAALCMgAMAICERRQAUUAFG
8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8xd2DEwUBMwABAAAA
AD4AAAA+AAAABAAAAAAA4zeC/MYiPjMgOgA2AFIAgOAAxAADEAAAAAABR/wAALCMgAMAICERRQAU
UAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8xkSNEwUBMwAB
AAAAAD4AAAA+AAAABAAAAAAA4zeC/MZ1jTMgOgA2AFIAgOAAxQADFAAAAAABR/wAALCMgAMAICER
RQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8xohsEwUB
MwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/MbI4TMgOgA2AFIAgOAAxgADGAAAAAABR/wAALCMgAMA
ICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8xttu
EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/MccNjMgOgA2AFIAgOAAxwADHAAAAAABR/wAALCM
gAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8
xy5wEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/MdvizMgOgA2AFIAgOAAyAADIAAAAAABR/wA
ALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADj
N4L8x4HyEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/MfC4DMgOgA2AFIAgOAAyQADJAAAAAAB
R/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAA
AADjN4L8x9R2EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/MgWODMgOgA2AFIAgOAAygADKAAA
AAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAAD
AAAAAADjN4L8yCd4EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/MhpjTMgOgA2AFIAgOAAywAD
LAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcA
AAADAAAAAADjN4L8yHp9EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/Mi86DMgOgA2AFIAgOAA
zAADMAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAA
AAcAAAADAAAAAADjN4L8yM1/EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/MkQNzMgOgA2AFIA
gOAAzQADNAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAA
BwAAAAcAAAADAAAAAADjN4L8ySCBEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/MljizMgOgA2
AFIAgOAAzgADOAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpe
AAAABwAAAAcAAAADAAAAAADjN4L8yXODEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/Mm24TMg
OgA2AFIAgOAAzwADPAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpa
WlpeAAAABwAAAAcAAAADAAAAAADjN4L8ycaGEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/MoK
OTMgOgA2AFIAgOAA0AADQAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpa
WlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8yhoHEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC
/MpdkDMgOgA2AFIAgOAA0QADRAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpa
WlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8ymyNEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA
4zeC/Mqw4jMgOgA2AFIAgOAA0gADSAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpa
WlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8ytxdEwUBMwABAAAAAD4AAAA+AAAABAAA
AAAA4zeC/MsEQzMgOgA2AFIAgOAA0wADTAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpa
WlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8yxMNEwUBMwABAAAAAD4AAAA+AAAA
BAAAAAAA4zeC/MtXjDMgOgA2AFIAgOAA1AADUAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpa
WlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8y2WVEwUBMwABAAAAAD4AAAA+
AAAABAAAAAAA4zeC/Muq7zMgOgA2AFIAgOAA1QADVAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEK
WlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8y713EwUBMwABAAAAAD4A
AAA+AAAABAAAAAAA4zeC/Mv+PDMgOgA2AFIAgOAA1gADWAAAAAABR/wAALCMgAMAICERRQAUUAFG
8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8zBD3EwUBMwABAAAA
AD4AAAA+AAAABAAAAAAA4zeC/MxRjzMgOgA2AFIAgOAA1wADXAAAAAABR/wAALCMgAMAICERRQAU
UAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8zGN8EwUBMwAB
AAAAAD4AAAA+AAAABAAAAAAA4zeC/Myk5jMgOgA2AFIAgOAA2AADYAAAAAABR/wAALCMgAMAICER
RQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8zL/IEwUB
MwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/Mz4NjMgOgA2AFIAgOAA2QADZAAAAAABR/wAALCMgAMA
ICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8zQmB
EwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/M1LjTMgOgA2AFIAgOAA2gADaAAAAAABR/wAALCM
gAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L8
zVeiEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/M2e7zMgOgA2AFIAgOAA2wADbAAAAAABR/wA
ALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADj
N4L8za+HEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/M3yOTMgOgA2AFIAgOAA3AADcAAAAAAB
R/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAA
AADjN4L8zgMGEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/M5FjTMgOgA2AFIAgOAA3QADdAAA
AAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAAD
AAAAAADjN4L8zlYMEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/M6Y4TMgOgA2AFIAgOAA3gAD
eAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcA
AAADAAAAAADjN4L8zqiPEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/M7sNjMgOgA2AFIAgOAA
3wADfAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAA
AAcAAAADAAAAAADjN4L8zvuSEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/M8/jjMgOgA2AFIA
gOAA4AADgAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAA
BwAAAAcAAAADAAAAAADjN4L8z2GgEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/M+S4DMgOgA2
AFIAgOAA4QADhAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpe
AAAABwAAAAcAAAADAAAAAADjN4L8z6GZEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/M/mNjMg
OgA2AFIAgOAA4gADiAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpa
WlpeAAAABwAAAAcAAAADAAAAAADjN4L8z/SWEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/NA5
izMgOgA2AFIAgOAA4wADjAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpa
WlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L80FFgEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA4zeC
/NCM4DMgOgA2AFIAgOAA5AADkAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpaWlpa
WlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L80J+BEwUBMwABAAAAAD4AAAA+AAAABAAAAAAA
4zeC/NDgODMgOgA2AFIAgOAA5QADlAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpaWlpa
WlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L80PKDEwUBMwABAAAAAD4AAAA+AAAABAAA
AAAA4zeC/NEzjTMgOgA2AFIAgOAA5gADmAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpaWlpa
WlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L80UWGEwUBMwABAAAAAD4AAAA+AAAA
BAAAAAAA4zeC/NGG4zMgOgA2AFIAgOAA5wADnAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEKWlpa
WlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L80ZiIEwUBMwABAAAAAD4AAAA+
AAAABAAAAAAA4zeC/NHaODMgOgA2AFIAgOAA6AADoAAAAAABR/wAALCMgAMAICERRQAUUAFG8IEK
WlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L80fTUEwUBMwABAAAAAD4A
AAA+AAAABAAAAAAA4zeC/NItjDMgOgA2AFIAgOAA6QADpAAAAAABR/wAALCMgAMAICERRQAUUAFG
8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L80j6OEwUBMwABAAAA
AD4AAAA+AAAABAAAAAAA4zeC/NKA5DMgOgA2AFIAgOAA6gADqAAAAAABR/wAALCMgAMAICERRQAU
UAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L80pGbEwUBMwAB
AAAAAD4AAAA+AAAABAAAAAAA4zeC/NLUNjMgOgA2AFIAgOAA6wADrAAAAAABR/wAALCMgAMAICER
RQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAABwAAAAcAAAADAAAAAADjN4L80uSTEwUB
MwABAAAAAD4AAAA+AAAABAAAAAAA4zeC/NMnjjMgOgA2AFIAgOAA7AADsAAAAAABR/wAALCMgAMA
ICERRQAUUAFG8IEKWlpaWlpaWlpaWlpaWlpaWlpaWlpeAAAACwAAAAsAAAAEAAAAAADjN4L80zhT
MwAHAAMAUQCgCSgAAAAHAAAABwAAAAMAAAAAAOM3gvzTci8TBQEzAAEAAAAABwAAAAcAAAADAAAA
AADjN4L803vzEwUBMwABAAAAABcAAAAXAAAAAwAAAAAA4zeC/NN95g0VADMAAAKInwAAAAAAAKhh
AAAAAAAAAAAACgAAAAoAAAAFAAAAAADjN4L805CvMyAGAAIAQgCiCQAAABgAAAAYAAAABAAAAAAA
4zeC/ONIAzMAFAAQAFAA6+8ZDQorVkdNOiAxMw0KTAAAAAcAAAAHAAAAAwAAAAAA4zeC/ONQzhMF
ATMAAQAAAAAUAAAAFAAAAAIAAAAAAOM3gv0CJIQoBBEzAEAfAABAHwAADQADAAKAAwAAABoAAAAa
AAAABAAAAAAA4zeC/QIkkjMAFgASAFAA6+8dDQorQ0lFVjogMiwxDQpMAAAABwAAAAcAAAADAAAA
AADjN4L9AjHUEwUBMwABAAAAAAYAAAAGAAAAAwAAAAAA4zeC/QKoeQ8EAAEoBAAAABQAAAAUAAAA
BQAAAAAA4zeC/QKvJzMgEAAMAEEA6f8PA0FUK0JDQw2KAAAAEgAAABIAAAAEAAAAAADjN4L9Aq9M
MwAOAAoAUADr7w0NCk9LDQpMAAAAFwAAABcAAAAEAAAAAADjN4L9Aq9WMwATAA8AUADr7xcNCitC
Q1M6IDINCkwAAAAHAAAABwAAAAMAAAAAAOM3gv0CtagTBQEzAAEAAAAABwAAAAcAAAADAAAAAADj
N4L9AtL1EwUBMwABAAAAABYAAAAWAAAABQAAAAAA4zeC/QNPTjMgEgAOAEEA6f8TAkFUK0JDUz0y
DYoAAAAJAAAACQAAAAIAAAAAAOM3gv0DT4gIBAag/t9e2sAAAAAMAAAADAAAAAMAAAAAAOM3gv0D
V0oOCgEIBAKg/t9e2sAAAAASAAAAEgAAAAQAAAAAAOM3gv0DW1AzAA4ACgBQAOvvDQ0KT0sNCkwA
AAAHAAAABwAAAAMAAAAAAOM3gv0DbzoTBQEzAAEAAAAAFAAAABQAAAACAAAAAADjN4L9A+PyKAQR
MwBAHwAAQB8AAA0AAwACgAMAAAAGAAAABgAAAAMAAAAAAOM3gv0D678PBCABKAQAAAATAAAAEwAA
AAMAAAAAAOM3gv0D+OwsEQAADqD+317awAIMBDwAPAADAAAABQAAAAUAAAADAAAAAADjN4L9BBDa
GwMzAAMAAAAeAAAAHv//AA4AAAAAAOM3gv0EWVoCAAAAAAACFgABAAAAEGJ0bW9uAAAAAAAAAAAA
AAAAAAAEAAAABP//AA8AAAAAAOM3gv0EWVwCAAAAAAAA8QAAAPEAAAAFAAAAAADjN4L9Ckxf/S7t
AOkABAIzAFaTXAEAAEMAAAAABAAAAEcFAAADAAAAbwAAAAAAAAABAQAASQcAAGsAAAAAAAAAAAAA
AAAAAABCk1wBQpNcAQe+AwwEJjcAAAABAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAMQAAAAAA
AAABAAAAMAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAABWk1wBMAAAAAAAAAAAAAAA////
////////fwEADAAGAAoAAAACAAEADAAGAAoAAAACAAEABQAGABEAAAAAAAEADAAGAAoAAAACAAEA
DAAGAAoAAAACAAAAABoAAAAaAAAABAAAAAAA4zeC/VBI5DMAFgASAFAA6+8dDQorQ0lFVjogMiww
DQpMAAAABwAAAAcAAAADAAAAAADjN4L9UFHzEwUBMwABAAAAABQAAAAUAAAAAgAAAAAA4zeC/Zo7
lCgEETMAQB8AAEAfAAANAAMAAoADAAAAGgAAABoAAAAEAAAAAADjN4L9mjulMwAWABIAUADr7x0N
CitDSUVWOiAyLDENCkwAAAAHAAAABwAAAAMAAAAAAOM3gv2aSZMTBQEzAAEAAAAABgAAAAYAAAAD
AAAAAADjN4L9mrzMDwQgASgEAAAAGgAAABoAAAAEAAAAAADjN4L+BnC3MwAWABIAUADr7x0NCitD
SUVWOiAyLDANCkwAAAAHAAAABwAAAAMAAAAAAOM3gv4GeLcTBQEzAAEAAAAAFAAAABQAAAACAAAA
AADjN4L+NQXGKAQRMwBAHwAAQB8AAA0AAwACgAMAAAAaAAAAGgAAAAQAAAAAAOM3gv41BdEzABYA
EgBQAOvvHQ0KK0NJRVY6IDIsMQ0KTAAAAAcAAAAHAAAAAwAAAAAA4zeC/jUM5hMFATMAAQAAAAAN
AAAADQAAAAUAAAAAAOM3gv41JEszIAkABQBBAOn/AQWKAAAABgAAAAYAAAADAAAAAADjN4L+NYUE
DwQgASgEAAAAGgAAABoAAAAEAAAAAADjN4L+gdttMwAWABIAUADr7x0NCitDSUVWOiAyLDANCkwA
AAAHAAAABwAAAAMAAAAAAOM3gv6B6r0TBQEzAAEA
--0000000000003868830659d00cab
Content-Type: text/plain; charset="UTF-8"; name="sysinfo.txt"
Content-Disposition: attachment; filename="sysinfo.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mt7mtg2k2>
X-Attachment-Id: f_mt7mtg2k2

KyB1bmFtZSAtYQpMaW51eCB1bGRpeHhpb24gNy4yLjAtMS1jYWNoeW9zICMxIFNNUCBQUkVFTVBU
X0RZTkFNSUMgVGh1LCAyMCBBdWcgMjAyNiAwNjowNjozMCArMDAwMCB4ODZfNjQgR05VL0xpbnV4
CisgZWNobwoKKyBwYWNtYW4gLVEgbGludXgtZmlybXdhcmUtbWVkaWF0ZWsgYmx1ZXogcGlwZXdp
cmUgd2lyZXBsdW1iZXIKbGludXgtZmlybXdhcmUtbWVkaWF0ZWsgMToyMDI2MDgxMC0yCmJsdWV6
IDUuODctMi4xCnBpcGV3aXJlIDE6MS42LjgtMS4yCndpcmVwbHVtYmVyIDAuNS4xNS0xLjEKKyBs
c3VzYgorIGdyZXAgLWkgbWVkaWF0ZWsKQnVzIDAwOCBEZXZpY2UgMDA2OiBJRCAwZThkOjA3MTcg
TWVkaWFUZWsgSW5jLiBXaXJlbGVzc19EZXZpY2UKKyBsc3BjaSAtbm4KKyBncmVwIC1pIG1lZGlh
dGVrCjA5OjAwLjAgTmV0d29yayBjb250cm9sbGVyIFswMjgwXTogTUVESUFURUsgQ29ycC4gTVQ3
OTI1IChSWjcxNykgV2ktRmkgNyAxNjBNSHogWzE0YzM6MDcxN10KKyBqb3VybmFsY3RsIC1rIC1i
IC0tbm8tcGFnZXIKKyBncmVwIC1pRSAnbXQ3OTI1LiooVmVyc2lvbnxCdWlsZCknCisgaGVhZCAt
NArQsNCy0LMgMjQgMTU6NDg6MzAgdWxkaXh4aW9uIGtlcm5lbDogbXQ3OTI1ZSAwMDAwOjA5OjAw
LjA6IEhXL1NXIFZlcnNpb246IDB4OGExMDhhMTAsIEJ1aWxkIFRpbWU6IDIwMjYwNjA1MTg0NjUx
YQrQsNCy0LMgMjQgMTU6NDg6MzAgdWxkaXh4aW9uIGtlcm5lbDogbXQ3OTI1ZSAwMDAwOjA5OjAw
LjA6IFdNIEZpcm13YXJlIFZlcnNpb246IF9fX18wMDAwMDAsIEJ1aWxkIFRpbWU6IDIwMjYwNjA1
MTg0ODA1Cg==
--0000000000003868830659d00cab
Content-Type: text/x-patch; charset="US-ASCII"; name="0002-btusb-mtk-sco-handle-fixup.patch"
Content-Disposition: attachment; 
	filename="0002-btusb-mtk-sco-handle-fixup.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mt7mtm9h3>
X-Attachment-Id: f_mt7mtm9h3

LS0tIGEvZHJpdmVycy9ibHVldG9vdGgvYnR1c2IuYworKysgYi9kcml2ZXJzL2JsdWV0b290aC9i
dHVzYi5jCkBAIC0xNDEyLDYgKzE0MTIsMzYgQEAKIAl9CiB9CgorLyogYmx1ZXRvb3RoLW1pYy1m
aXg6IE1lZGlhVGVrIE1UNzl4eCBmaXJtd2FyZSB0YWdzIGluY29taW5nIChlKVNDTyBmcmFtZXMK
KyAqIHdpdGggYSBib2d1cyBzZW50aW5lbCBoYW5kbGUgKGUuZy4gMHgwZTAwKSBpbnN0ZWFkIG9m
IHRoZSByZWFsIGNvbm5lY3Rpb24KKyAqIGhhbmRsZSwgc28gZXZlcnkgbWljcm9waG9uZSBmcmFt
ZSBpcyBkcm9wcGVkIGFzICJ1bmtub3duIGNvbm5lY3Rpb24iLgorICogQW5hbG9nb3VzIHRvIGJ0
cnRsJ3MgIkZpeHVwIFNDTyBoZWFkZXIiOiB3aGVuIHRoZXJlIGlzIGV4YWN0bHkgb25lCisgKiBj
b25uZWN0ZWQgU0NPL2VTQ08gbGluaywgcmV3cml0ZSB0aGUgaGFuZGxlIGluc3RlYWQgb2YgZHJv
cHBpbmcgdGhlIGZyYW1lLgorICovCitzdGF0aWMgYm9vbCBidHVzYl9tdGtfZml4dXBfc2NvX2hh
bmRsZShzdHJ1Y3QgaGNpX2RldiAqaGRldiwKKwkJCQkgICAgICAgc3RydWN0IGhjaV9zY29faGRy
ICpoZHIpCit7CisJc3RydWN0IGhjaV9jb25uX2hhc2ggKmggPSAmaGRldi0+Y29ubl9oYXNoOwor
CXN0cnVjdCBoY2lfY29ubiAqYywgKnNjbyA9IE5VTEw7CisKKwlyY3VfcmVhZF9sb2NrKCk7CisJ
bGlzdF9mb3JfZWFjaF9lbnRyeV9yY3UoYywgJmgtPmxpc3QsIGxpc3QpIHsKKwkJaWYgKChjLT50
eXBlID09IFNDT19MSU5LIHx8IGMtPnR5cGUgPT0gRVNDT19MSU5LKSAmJgorCQkgICAgYy0+c3Rh
dGUgPT0gQlRfQ09OTkVDVEVEKSB7CisJCQlpZiAoc2NvKSB7CisJCQkJc2NvID0gTlVMTDsJLyog
bW9yZSB0aGFuIG9uZTogYW1iaWd1b3VzICovCisJCQkJYnJlYWs7CisJCQl9CisJCQlzY28gPSBj
OworCQl9CisJfQorCWlmIChzY28pCisJCWhkci0+aGFuZGxlID0gX19jcHVfdG9fbGUxNihzY28t
PmhhbmRsZSk7CisJcmN1X3JlYWRfdW5sb2NrKCk7CisKKwlyZXR1cm4gc2NvOworfQorCiBzdGF0
aWMgaW50IGJ0dXNiX3JlY3ZfaXNvYyhzdHJ1Y3QgYnR1c2JfZGF0YSAqZGF0YSwgdm9pZCAqYnVm
ZmVyLCBpbnQgY291bnQpCiB7CiAJc3RydWN0IHNrX2J1ZmYgKnNrYjsKQEAgLTE0NDksNyArMTQ3
OSw5IEBACiAJCQloY2lfc2tiX2V4cGVjdChza2IpID0gaGRyLT5kbGVuOwoKIAkJCWlmIChza2Jf
dGFpbHJvb20oc2tiKSA8IGhjaV9za2JfZXhwZWN0KHNrYikgfHwKLQkJCSAgICAhYnR1c2JfdmFs
aWRhdGVfc2NvX2hhbmRsZShkYXRhLT5oZGV2LCBoZHIpKSB7CisJCQkgICAgKCFidHVzYl92YWxp
ZGF0ZV9zY29faGFuZGxlKGRhdGEtPmhkZXYsIGhkcikgJiYKKwkJCSAgICAgIShkYXRhLT5yZWN2
X2FjbCA9PSBidG10a191c2JfcmVjdl9hY2wgJiYKKwkJCSAgICAgICBidHVzYl9tdGtfZml4dXBf
c2NvX2hhbmRsZShkYXRhLT5oZGV2LCBoZHIpKSkpIHsKIAkJCQlrZnJlZV9za2Ioc2tiKTsKIAkJ
CQlza2IgPSBOVUxMOwoK
--0000000000003868830659d00cab--
