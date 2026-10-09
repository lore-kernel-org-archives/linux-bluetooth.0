Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DD34C9E1B
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 13:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791554264; cv=pass; b=lKMxJExgkvGKvZKdL4S1zufyL93ZaXXjUfYU+HGJfXDYwUpneVaEd+jmYo2W8A0Lfvz+cc9XH7gKkEm+57O1BzvTP/6FntIXyKhSNqcJb+eaIUce1kPI4FcvGd7H6zF+U+YTMwSThUbORCQ96Y2b6SGck62VJ58ZgEACfixkrf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791554264; c=relaxed/simple;
	bh=Pei62bNjdvw4HKZzmHQP+6GuJOUXx2pql0sJslh4TQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRt/12dWjBPliKBxPz3YGgfAJ6NmpDEVJjjg0Zj5f0B1PrbBKDks95o3Czmg0cu/gPA8ACMYWysA3Kk+o25d7nmJwptqbev6s0heQ/RaQO0TeuBiuizYQ2go+ji5TC3BKljksp9tg1BqSmLUdkZ0pNvAPEVMGLBT3tpxtB1Njus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Go8uduqB; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Go8uduqB"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b05bf699easo33850887b3.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Oct 2026 06:57:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791554261; cv=none;
        d=google.com; s=arc-20260327;
        b=UHo/WcgI8R5YDJffEucpITBOOONrW2HjyCfwvmFIFlobu1b/F/WD4FQ6/SWc501G2b
         sDHuV5fHilPr2hguCpHkSCYUv+oK/XqlN++F+rReBFZTP5NuHLWww+flkUR9cNO9aYOM
         LvzhwtzsONT4YQEMBRtg8L7w1PCPtZDTPbbOZfeu/aQ4Djy7dx/Oye+LZ0FF+uy8rkt3
         N0Ttgd2tHODZhM1xrciPgMRd+hIbGiae8VNV/j69WfRXz2o4tOfFIwyT19b61by/MQIy
         JU0C6ds7QEFsOSHR/vklrdh/vZJdOFw7HHNPUA6zqY0mH3rf5PzFIuTrAjcDnEL5/T7h
         TdcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bDCLz7WW3bEB9Nx65aqIBlmoYiNA1aEKD6eje2D3UuI=;
        fh=OTtSNNm3oCNIyAZRPy+ZWF1xTfl5Mt4Fu/bK64MKdNc=;
        b=MKIALV+tJSsYOo8rJdwCx/YtU80ThVxHJhlf3+JO0vgNfKRQsnYPpTrML143iY2sqd
         AQhb0cxwaGE4w609SnKr/7W79nGbgQLbZwlIjQxyGHSi+L9jTcIwcdh8LBdmNrpqQTmN
         w9LEpXwnYKcDy6FkPCqgMo3duz7i7qo08n/QM65LADgxzgCrsUiGbovtd2DWwydMsc70
         VFpbOb409+eRfnIWHsmUf6ePFLw/GGvYX6Eg7PgwdSWfACv/5GSpw+kZ8L7xkbQ8mowj
         ijv5lHvKCYessMYg2L/8pHC++RJhWjcJFsdRYDZEWeZJYM4dflkQiM3M6MzDkEiNpk3v
         jhUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791554261; x=1792159061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bDCLz7WW3bEB9Nx65aqIBlmoYiNA1aEKD6eje2D3UuI=;
        b=Go8uduqBQrGsW4Ez6C7qmkJ4VYhHqtNcZrhKZwB71+2Db9IrqNTzWLvtl/QlNM739I
         1HgODJAWQDBJNikd5HZWLfE/cOmrfCeKnpDNuQTI5rgUOq9SDCRAjkrdsPHZFewg6mLj
         rf8A259IJuFKZP7kfMyxr7j4UlOeNbETyeEIWpbkz/B/4qqpGLShHUsQyL0bjnbkwils
         ZKxm7E7ANpuiV8kHjsF8BY89SH2+32OqLcWAGkKfS1aJ2MWR9ounWI7Uh+mL+fthm+J7
         L7jYgrdhJrM/ApfZAEcPH2fsOsk1myNefxLFIFRgWnhpVxHTUFljMC0oQ5tEyQofybaL
         Ru/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791554261; x=1792159061;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bDCLz7WW3bEB9Nx65aqIBlmoYiNA1aEKD6eje2D3UuI=;
        b=u0ah+vIa+yRIBsYupKJjvJ2JWowGcfiBEmscgjGU2dta/Ds3QuNOpZ2t05Ck9bh5rc
         0XTKVlBzDcbyYQZ+98Qf5sq8hmMIjtNb1rg2uny6AXk5yYMREmOoM/bJ2Vm14d5NNi8E
         6ggGhnGj6X7IFl64V/coe4zAdvukKTiVtnlspsqxCjaVcStPVSRpmd3KexUTfRvTgDJE
         Suiao46YPM6LTiBHzu2Nvdmc79Wza/YDwWyqQ/s7VQzVx8vK8hRiigINkSpvm37fs+xF
         +h5b3B4R3DRvlUPkTy/3UabedqCYoTfY45wfYBu0iU3+V6AgOUsc+R6fgyinKLG3ZybF
         PdbA==
X-Gm-Message-State: AFq9FYKP1e9g/jbOvEiIm9lASW62gyxcxaTfYn/yCGZ3lw92dtb9+3U4
	FZ5ufYKVqZuonpJv7+kdimyQRKPNVZyUrgrrgN/kymciNqIH8ARWq9+OdLljBkR6CSjbzWCzBP5
	6uz/FxegJ8kNWuCZ01kZ5h+tlxaqi8wI=
X-Gm-Gg: AYBFou1bYZqjBxMxD2xZ2B5lC8lQ6IvfO8/ppme3XXbGUqH6gQJDhPsaewwEg3mR05B
	P68FQLdX33+BVKu8hhZJX/ZnRXmpCV9yVDlMv5j2KsQ5s9IL9ZAl2gQhUH1dwAjdj/5bH9p/otB
	E63FfXDLOBgq94Uv9CoK7lXTzt14pOjQEIA3DXiksYR1ce4MkSimywI6ZV90dW5eTaxVeG8btl1
	PmVksAZk2tHTcSLbj6mhnVcpyoRc0aTAkYm9LPA+Jz/ntYJr3ql4oHffHUo+UGhl1I8IECgQ2K7
	8KdT458fYi1x9DmAjTLVtaaUbZ8kYXwUlIXEc1FczZi0PG7FQ+MZPMSc0LdjYJe2pkJfE83SAtU
	3NtlOyXSeXEtHZAcZphWQhBc1AoQLr87LXwscHGU=
X-Received: by 2002:a05:690c:854:b0:8ab:44a4:6362 with SMTP id
 00721157ae682-8b07ebf6791mr4491947b3.4.1791554261155; Fri, 09 Oct 2026
 06:57:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008222616.2780570-1-enghitalo@gmail.com>
In-Reply-To: <20261008222616.2780570-1-enghitalo@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 9 Oct 2026 09:57:29 -0400
X-Gm-Features: AclHuK8l-gTzaBEBEX9qzqj4KNq6hOQ0ygnu7f7zfbESRsHZScu4nSFZaFyrz74
Message-ID: <CABBYNZJTK_baoJc35vf4gjcWaODF6AQ8M755oqJBCaeRgM9XZw@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Bluetooth: Fix SCO setup failures after an
 abandoned setup
To: Hitalo Souza <enghitalo@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hitalo,

On Thu, Oct 8, 2026 at 6:26=E2=80=AFPM Hitalo Souza <enghitalo@gmail.com> w=
rote:
>
> Since commit a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for
> aborting connections"), closing a SCO socket while its setup is pending
> deletes the hci_conn, after a Create Connection Cancel that cannot
> cancel a synchronous connection. When a new socket connects right away,
> e.g. PipeWire recreating the HFP transport after a codec negotiation as
> in bluez/bluez#2562, the abandoned setup can still complete, and:
>
>  1. It is matched to the new connection by address, the controller then
>     rejects the new connection's own setup, and the rejection handler
>     fails the first link on the ACL, which is now the connected one,
>     without disconnecting it (patch 1).
>
>  2. It is matched to the new connection before that connection's own
>     setup was sent: Enhanced Setup Synchronous Connection goes through
>     the cmd_sync queue, and any setup waits for the ACL to leave sniff
>     mode. The setup is then sent anyway and rejected. This is the order
>     of events in the report (patch 2).
>
>  3. Nothing takes it over, or it is a second link for a connection
>     that is already up: the link stays up in the controller with no
>     connection for it, and the controller rejects every further setup
>     for the device until the ACL drops (patch 4).
>
> Patches 3 and 5 make links that complete for an aborted connection be
> disconnected in general, as Luiz suggested, not only SCO ones. Patch 3:
> a link (ACL, SCO/eSCO or LE) that completes while its connection is
> being aborted, which then refuses the handle since 16e3b6429159
> ("Bluetooth: hci_conn: Fix modifying handle while aborting") and, for
> LE, 181a42edddf5 ("Bluetooth: Make handle of hci_conn be unique").
> Patch 5: an incoming ACL connection aborted after it was accepted,
> which is deleted before its link completes. Patch 6 stops notifying
> the driver of the air mode of a SCO link that did not come up: with
> btusb, that notification and the one for the connection's deletion
> right after could stop the audio of another SCO connection. btusb can
> still do that when a SCO link that was up goes down while another one
> stays up; that is not changed here.
>
> In 1 and 2 the new connection keeps the link of the abandoned setup,
> with the parameters of that setup: the completion event does not say
> which setup it belongs to. Its Air_Mode would show a change between
> CVSD and transparent data, but the series does not act on it. An
> abandoned setup that fails after a new connection was made, in Command
> Status or in its completion event, is likewise applied to that
> connection. Before a13f316e90fd both happened in another way, as the
> next socket reused the pending hci_conn.
>
> If a controller answers the setup of a SCO_LINK connection (only SCO
> packet types allowed, e.g. with the disable_esco parameter of sco.c)
> with an eSCO link, that link was ignored, so the connect timed out and
> the link stayed up. Patch 4 now lets the connection take it, as an
> eSCO connection already takes a SCO link.
>
> Changes in v3:
> - Patch 4: a SCO_LINK connection takes an eSCO link that answers its
>   setup, instead of the link being ignored and left up (Sashiko). T6
>   now checks that the connection gets the link.
> - Patch 1: the commit message notes that a Command Status does not
>   tell which setup failed, which the patch does not change (Sashiko).
> - Rebased on bluetooth-next 97a128698d9d, without conflicts.
> - Tests for BlueZ's sco-tester and l2cap-tester that abort a connection
>   while its connection complete event is pending, as Luiz asked:
>   https://lore.kernel.org/linux-bluetooth/20261008215756.2710812-1-enghit=
alo@gmail.com/
> - v2: https://lore.kernel.org/linux-bluetooth/20261008151238.2138665-1-en=
ghitalo@gmail.com/
>
> Changes in v2:
> - New patch 3, following Luiz's review: disconnect any link that
>   completes while its connection is being aborted, on Connection
>   Complete, Synchronous Connection Complete and LE Connection Complete.
>   It replaces the SCO-only handling of that case in v1's patch 3, and
>   covers the ACL and LE cases Sashiko pointed out.
> - Patch 4 (v1's patch 3) uses the helper of patch 3, and also
>   disconnects a second SCO link that completes with Connection Complete
>   for a connection that is already up (Sashiko).
> - New patch 5: disconnect an ACL link that completes after its
>   connection was aborted and deleted (an incoming connection).
> - New patch 6: notify the driver of the air mode only of a SCO link
>   that came up (Sashiko).
> - The disable_esco case is described as what it is: a controller
>   answering a SCO-only setup with an eSCO link.
> - New tests T5b, T7, T8 and T9.
> - v1: https://lore.kernel.org/linux-bluetooth/20261007154353.148223-1-eng=
hitalo@gmail.com/
>
> Patch 2 relies on hci_enhanced_setup_sync() taking hdev->lock, since
> 024e05f73a4c ("Bluetooth: hci_conn: Lock parent access during enhanced
> SCO setup"); a backport to a kernel without that commit needs the lock
> taken around the new checks.
>
> Testing:
>
> - QEMU/KVM, bluetooth-next at 97a128698d9d and with each patch applied
>   in turn, x86_64 defconfig + kvm_guest.config + BT=3Dy, BT_HCIVHCI=3Dy. =
A
>   userspace program emulates the controller and the headset over
>   hci_vhci; the controller allows one eSCO link per ACL and rejects
>   further setups with 0x0a (0x12 in T1, as in the report), except in
>   T5, where it allows a second one. Each case was run over Setup
>   Synchronous Connection (L), Enhanced Setup Synchronous Connection (E)
>   and Add SCO Connection (A, controller without eSCO):
>
>   T0  connect, receive SCO data, close
>   T1  close a socket with its setup pending, connect a new one; the
>       first setup completes, then the new one is rejected
>   T1b like T1, but the first setup completes before the new one is
>       sent, which waits for the ACL to leave sniff mode
>   T1c like T1b, but the new setup waits in the cmd_sync queue (E only)
>   T2  close a socket with its setup pending, the setup completes
>       afterwards, connect a new socket (cancel answered 0x0b and 0x02)
>   T2b like T2, but the setup completes while the abort still waits in
>       the cmd_sync queue
>   T3  a setup rejected with 0x0d in Command Status
>   T4  like T2, but the abandoned setup completes with 0x22
>   T5  like T1, but the new setup completes too, with a second link
>   T5b an incoming SCO connection is up, and a second SCO link to the
>       device completes with Connection Complete (A only)
>   T6  disable_esco set, and the emulated controller answers the
>       SCO-only setup with an eSCO link (L and E): the connection gets
>       the link, receives SCO data and disconnects it when closed
>   T7  an ACL connect to another device is aborted while paging, and
>       the page succeeds as Create Connection Cancel arrives (cancel
>       answered 0x0b)
>   T8  with an emulated LE-only controller: an L2CAP LE connect is
>       aborted while LE Create Connection is pending, and the connection
>       completes as LE Create Connection Cancel arrives (cancel answered
>       0x0c); also with the cancel succeeding in time, where nothing may
>       be disconnected
>   T9  an incoming ACL connection is aborted with MGMT_OP_DISCONNECT
>       after it was accepted; Create Connection Cancel fails with 0x02,
>       then the link completes
>
>   In T1c the cmd_sync queue waits for a Read RSSI (from mgmt Get
>   Connection Information) that the emulator leaves unanswered; in T2b
>   it waits for an ACL connection to another device, whose Connection
>   Complete the emulator holds as during a page.
>
>                   T1   T1b  T1c  T2   T2b  T5   T5b  T6   T7   T8   T9
>   bluetooth-next  FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL
>   + patch 1       pass FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL
>   + patches 1-2   pass (*)  pass FAIL FAIL FAIL FAIL FAIL FAIL FAIL FAIL
>   + patches 1-3   pass (*)  pass FAIL pass FAIL FAIL FAIL pass pass FAIL
>   + patches 1-4   pass pass pass pass pass pass pass pass pass pass FAIL
>   + patches 1-5   pass pass pass pass pass pass pass pass pass pass pass
>   + patches 1-6   pass pass pass pass pass pass pass pass pass pass pass
>
>   T0, T3, T4 and the LE connect cancelled in time pass on every row.
>
>   The results are the same on L, E and A, except (*): pass on L and E,
>   FAIL on A, where the abandoned link is not taken over by a connection
>   that has not started its setup, and stays up until patch 4.
>
>   Without the series, the new socket gets EINVAL in T1 (the emulator
>   rejects with 0x12) and EMLINK in T1b and T1c (its duplicate setup is
>   rejected with 0x0a), the next connect gets EMLINK in T2 and T2b, and
>   the second links in T5 and T5b and the ACL and LE links in T7, T8 and
>   T9 are not disconnected (they stay up until the ACL drops, or for
>   good); in T6 the connect times out and the link stays up. With it,
>   the new sockets and the connection in T6 receive SCO data and no
>   Create Connection Cancel is sent for SCO; the links that nothing
>   takes over (T1b on A, T2, T2b, T7, T8, T9) and the second links in T5
>   and T5b are disconnected as soon as they complete, and T4 and the LE
>   connect cancelled in time send no Disconnect. No kernel warnings.
>   Patch 6 is not covered here, as hci_vhci has no notify callback.
>
> - BlueZ testers (master 866b0b8 with the new tests) in the same VM, on
>   the debug kernel below plus CRYPTO_USER_API_{HASH,SKCIPHER}, run
>   twice: with the series sco-tester (31), l2cap-tester (113) and
>   iso-tester (141) pass, and without it only the three new tests fail.
>   mgmt-tester has 8 to 10 LL Privacy failures of 506 per run, with and
>   without the series.
>
> - Real hardware, with v2 (v3 only changes what happens when a SCO_LINK
>   connection gets an eSCO link, which does not occur there): a MediaTek
>   MT7921 (USB 04ca:3802, legacy Setup Synchronous Connection because of
>   HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN) with a Sony WF-1000XM6, on
>   v7.1.13 with the series built as the bluetooth module (patch 2 needs
>   one change there, as hci_enhanced_setup_sync() does not take
>   hdev->lock in that version; the other functions touched are the same
>   as in bluetooth-next). With PipeWire 1.6.8 the abandoned setups were
>   first seen there: Create Connection Cancel was answered with Unknown
>   Connection Identifier, and the setup still completed afterwards.
>
>   A SCO socket was closed 150 ms into its setup and a new one connected
>   0.3 s or 2.5 s later, five times; each abandoned setup completed about
>   0.2 s after it started, before the new connect. Without the series the
>   first abandoned link after each ACL connect (two in the run) was left
>   up, and from then on the controller rejected every setup, plain
>   connects included, with Unsupported LMP Parameter Value (0x20) until
>   the ACL was dropped. With the series no Create Connection Cancel was
>   sent, each abandoned link was disconnected as soon as it completed,
>   and every new socket and the plain connects after them received SCO
>   data. An abandoned setup that failed (the headset rejects CVSD with
>   0x20) caused no Disconnect. Between the groups PipeWire switched the
>   headset from A2DP to HFP (mSBC) for a recording while I counted
>   aloud: speech was recorded all three times, with and without the
>   series. The cases of patches 1 and 2 did not occur there.
>
> - W=3D1 builds of net/bluetooth/ and drivers/bluetooth/, no warnings:
>   GCC 16.2.1 x86_64 allmodconfig and i386 defconfig, LLVM 22.1.8 arm64
>   defconfig, arm multi_v7_defconfig, riscv defconfig and powerpc
>   ppc64_defconfig (big-endian), with BT, BT_HCIBTUSB{,_MTK,_QCOM} and
>   BT_VIRTIO.
>
> - sparse v0.6.5-rc1 on the same directories: the same 16 reports with
>   and without the series, none on the lines touched here.
>
> - With the series, the same tests on a kernel with PROVE_LOCKING,
>   PROVE_RCU, KASAN, DEBUG_ATOMIC_SLEEP, DEBUG_LIST and
>   DEBUG_OBJECTS{,_WORK,_TIMERS} enabled: all pass on the three paths
>   and with the LE-only controller, with no lockdep, KASAN or
>   debugobjects reports, also while the BlueZ testers ran.
>
> The patches, the commit messages, this letter and the test programs
> were prepared with an AI assistant (see the Assisted-by tags), which
> reproduced the report in the emulator and wrote and tested the fixes;
> the real-hardware runs were done on my laptop with my headset.
>
> Hitalo Souza (6):
>   Bluetooth: hci_event: Don't fail a connected SCO link on setup errors
>   Bluetooth: hci_conn: Don't set up a SCO link that is already up
>   Bluetooth: hci_event: Disconnect links that complete while being
>     aborted
>   Bluetooth: Don't leave abandoned SCO links up in the controller
>   Bluetooth: hci_event: Disconnect an ACL link that completes after its
>     abort
>   Bluetooth: hci_event: Notify the driver only of SCO links that came up
>
>  net/bluetooth/hci_conn.c  |  24 +++++++-
>  net/bluetooth/hci_event.c | 124 ++++++++++++++++++++++++++++++++------
>  net/bluetooth/hci_sync.c  |   8 +++
>  3 files changed, 135 insertions(+), 21 deletions(-)
>
>
> base-commit: 97a128698d9dcacb9a15cdc5080718a644b12637
> --
> 2.55.0

Sashiko is flagging a few more problems:

https://sashiko.dev/#/patchset/20261008222616.2780570-1-enghitalo%40gmail.c=
om

--=20
Luiz Augusto von Dentz
