Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793911859;
	b=31GiAi2MLGYfx1tmAF4vQ4fTcpU18+W/mIYHA/UooqbKwvj92rCJAdDYugg6sBfVjBYq
	 57YjkwwPGx9uD9Id15kHhmm7ejYoelzI8dxMRRE7G5L+c/fKhDbqjQDMH+/QhmJDxxodP
	 83cNiX4XanotDs9bQWHDqy2xwaO3uL2p/5vN/RDON8TbyeK47WbJ4EBVwk0nNBO2bNxxx
	 EYZ3hhFbT6QUAxo9OMZ2rhh/Cav5zdpTvm9YH3JKpuGPkd1Q1XSBuVkeurj8CVaZeGVu6
	 YkasAQkm6kfv+mY6A77sxoDkp15qBDh7M7k4MHb0yyAYH7iHqv0msjQU/XZs4Nt+B0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793911859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=zgQwN5IhdxKz6BJ7SXJ7A8UrNIHJHal094+qX4zCZQo=;
	b=1hsqYNvm3OSjNtgw57CFIr4qq/Chuy1zTq3RBknLr6LOt20kFmLfBJz5h8vN5slCiyV3
	 9LFzWvbEgHaaM/bojD1D0mEexiFgos0AIXa4VA6U5JCqqv3jy4w3kFX4glOKzvGh09tqm
	 hBcnTkkEe4oHelXoK8Z2eeHDtNJ9wO3TSOp1RQ6GUBhn56t7amMH8WSaZbnCk+AeBfYLF
	 2hsXO5tL815Xo5KZ9hVeas5WM65qH9CIoZyDzZ/iFcXs5DjXWBGHjEVMAmsK23Za6uIZf
	 2e+7J0GxCd5TU8tNmz3WAx+ZeU46v8645FNffxLhc/UoOofrM7d9DjAkmEl3CrSiC2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="t/kPQ78p";
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0669606A326
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 20:50:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0669606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t/kPQ78p
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-7d06763335aso692402137.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 12:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793911858; x=1794516658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zgQwN5IhdxKz6BJ7SXJ7A8UrNIHJHal094+qX4zCZQo=;
        b=t/kPQ78pUHQ/JcF3lTa8uwpTstIT6wTYRU2mYKU/Uhm/Vq3R85W9UGYyuJzUh1DEj6
         rVROQbYDKkKW8TEcsPh0WxRTmEVDxouJiGtHPv/nOv3FNPSQnxguloW+u8eDZbeAku6C
         YcjC8ciWEA6cPycnTxs8usfuV7G5HkOBVvu/3KB3JtmzKyiSZYCecxieCA2i44vZLAQo
         qWtKJQ1zYAt+gUSHzV2VZEY7y8ppn4wNVTf/5B9e7dT3p7dHkeYKtCcrbU9c4r8qm+rJ
         1sgJwScTsP/0ooTssaUYGdzQaeO6amaaeCivbM9KYD2Zl435NOutphsaHGSRD2b6FYdI
         +aRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793911858; x=1794516658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zgQwN5IhdxKz6BJ7SXJ7A8UrNIHJHal094+qX4zCZQo=;
        b=zi6lSHXfEIbpd+CTmPbD7PZx4oJ0t2ja16dbcgek8Byvkf+LFTMhOFEIHFZYaCGebI
         K43MtVnlQ4Z1B4SSOMweTYYAHyAIfDppR3jtQnDwqpZ6r+guK3cTwiG1Pc01ROWyWVQ8
         RLZpP417X0ZN7iiViLOtxO94RQDAXYW8gcZCo7UNNbudCktdfUzhBmCatvH3KM81oSzJ
         zWGj+2LLhRJNvcOQh7yNd505DA/BgJdFyBAsvZWEhkKlBBHTTg7Zgo8ndIM+T/w0M2vT
         HKYw3siZRv8BBcExG5owVq0O3q61WD/W/h8FC7BuHt2DwiR5lmrlT/0qPU/ewbqmcAJc
         fQUQ==
X-Gm-Message-State: APuU4Z9xO4a7KjBGZb/Y3sJJ01AMh3sT5DsPCrwNMJ3p6CWlVQ60G9WY
	1IBi4NF7ikfK87xADRL4RaDuUny9qAL+fNWYnoiHpvmK0Yx0wVF3/ttmS37DpA==
X-Gm-Gg: AYBFou2q3kG5ygnQgDZ849YY+BY5m5Ke3E+VCk/eu4r+7tlbIfrBmVDeJ/1LBjKJC5Y
	so9zDCFNpdjsZyb0FKMVLTPAWi0UqCbzCmEjDpC2XBogRpvU45pVNzurgFMog5EUQxo4mT9L02H
	rZcvio70RWTpxcevFWEMvMaR1UqQBEnwYW+3bz86BhGkUhYH4lCWtZNhTm4t8DV4VcAq9Liafls
	kZl03aLkVnTxk9RaQ0ZxzaZs1pQG8Bf+OQoSpmgcZ/2eEMSnkXeAchIBGH9cDzR7irfw8pKbEFK
	BXXFo2RktM/Le8VzjsPoUPPqsdDESeiwJyZijQSoVJ1PHvEw/amvTEIfF11w2DNpfAI5D6zYK+o
	3nOe0j6ivZhhYbpgY3mSV12utN4IEb+ca6/eviWHzoNR/crI2/WRt7CWHMpmCAloB6Mni+dF7DB
	8EHzFwLRoR1cz2gk4wgTVTuzqUm4dAgGJhv/ynVYmYmXe86Pd8G3XbaAo7Bghy1/xCOYFxZIrRx
	X3JKh7EFUSsxhKRrnBwdXKQWboobDz33p8/5NMSzbnVGTZFbKLv1Js0hmwQWXfZf8f2xlG8jgyS
	W/5WdPl8IJBYhdoJOEoRCjwbtR6K3fjHdZtZJOPuTIc/mLkTwtdSPYGrOjSzan9B8j5loyaA9Jh
	uRyPKYdeONa5m8JXku2T5vT2tiHr4ChKtuQAYtuxak5XUw+vSoItz2S09HO60SMPc8ugxaKzgHS
	D8z04=
X-Received: by 2002:a05:6102:390b:b0:7d2:8dd0:2e1 with SMTP id ada2fe7eead31-7d2a1522abcmr652592137.6.1793911857696;
        Thu, 05 Nov 2026 12:50:57 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d2770ffbb4sm4319582137.0.2026.11.05.12.50.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 12:50:57 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v6 0/6] Bluetooth: Add support for HDT and EKS
Date: Thu,  5 Nov 2026 15:50:50 -0500
Message-ID: <20261105205056.2218652-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for the LE High Data Throughput (HDT) PHY and the
Encryption Key Schedule (EKS) introduced in Bluetooth Core 7.0:

 - HDT PHY selection for ACL, CIS and BIS, the v2/v3 HCI commands and
   events that carry the HDT rates, and the LE Set HDT Default
   Parameters command.
 - ISO sockets take an extended, versioned QoS (struct bt_iso_qos_ext)
   through the existing BT_ISO_QOS option, carrying the HDT rates per
   direction; the legacy struct bt_iso_qos keeps working.
 - LE Enable Encryption v2 with the MIC length, Encryption Change v3
   and Key Refresh Complete v2.
 - L2CAP and BT_SECURITY gain a MIC length requirement; connections
   whose MIC is too short are refused with the MIC Length Too Short
   result.
 - EKS opportunistic encryption, enabled with a new MGMT system
   configuration parameter.

This series depends on:
 "Bluetooth: Fix not updating of hdev->commands[] after reset"

Changes in v6:
 - An encryption command that fails without a Command Status is
   handled where it is sent, aborting the link with
   hci_abort_conn_sync() without holding hdev->lock, rather than from
   its completion callback, which could deadlock, also when canceled,
   and drop the connection twice. LE Start Encryption's Command Status
   error now clears the pending encryption too.
 - Opportunistic encryption sends its command without that handling,
   so its failure can't disconnect a link SMP is encrypting.
 - SMP doesn't distribute keys on opportunistic encryption.
 - An Encryption Change failure on an opportunistically encrypted link
   is handled as for any encrypted link, clearing its encryption flags.

Changes in v5:
 - A CIS bound with BT_ISO_PHY_ANY keeps the GFSK PHYs of the ACL, as
   HDT isn't part of it, so a deferred CIS setup matches its binding.
 - LE Remote Features Complete clears HDT from the default PHYs, as
   HDT is a feature of page 1 which it doesn't report.
 - CIS Established v3 takes Max_SDU from its SDU fields rather than
   Max_PDU.
 - The default data length is only skipped if both its length and
   time are already at their maximum.
 - Encryption commands that fail without a Command Status clear the
   pending encryption and disconnect, as a Command Status error does,
   and are freed with kfree_sensitive() as they carry the key.
 - SMP starts encryption after DHKey Check before adding the LTK, so a
   failure doesn't remove a previously stored key.
 - Encryption Change v3 reporting opportunistic encryption for a link
   with a key from pairing disconnects it, as Key Refresh Complete
   does, and only a failure is taken as the one of an opportunistic
   encryption being started. A failed key refresh replacing the
   opportunistic key no longer reports the link as encrypted.

Changes in v4:
 - LE Set CIG Parameters v2 is limited to the CIS that fit in the 255
   octets of command parameters, and a CIS that would exceed that is
   refused when it is bound to the CIG.
 - setsockopt(BT_ISO_QOS) on a socket that already has a connection,
   such as with deferred setup or a PA sync, checks the QoS type there,
   since connect() or listen() won't.
 - SMP marks the encryption started after DHKey Check as pending, as it
   does after Random, so it isn't started a second time.
 - A Key Refresh Complete reporting opportunistic encryption, such as
   one changing the MIC length, keeps the link opportunistic, and
   disconnects a link with a key from pairing since that would be a
   downgrade. A key from pairing replacing the opportunistic one is
   handled as Encryption Change is for an unencrypted link.
 - Restore the lockdep_assert_held() before smp_pairing_in_progress(),
   which context analysis needs to know conn->hdev->lock is held.

Changes in v3:
 - Opportunistic encryption sets HCI_CONN_ENCRYPT and HCI_CONN_AES_CCM
   along with a new HCI_CONN_OPP_ENCRYPT flag, and the L2CAP key size
   check is skipped for it since it has no key from pairing. Pairing
   over such a link now completes: its Key Refresh Complete clears the
   flag. A failure, or a command that can't be sent, leaves the link
   unencrypted instead of disconnecting, and HCI_CONN_ENCRYPT_PEND is
   no longer used for it so it doesn't block SMP. The MIC length is
   taken right before the command is sent.
 - Changing TLV 0x0024 while the controller is up updates the
   Opportunistic Encryption host feature bit.
 - SMP checks the result of hci_le_enable_encrypt().
 - Set CIG Parameters v2 returns the failure of a response that doesn't
   match the command, and fails the unbound CIS of the CIG it was sent
   for.
 - CIS Established v3 and Create BIG Complete v2 are only unmasked with
   CIS and BIS support.
 - BT_PHY rejects HDT6 and HDT7.5 rates the controller doesn't support
   in that direction, and only reports supported ones.
 - struct bt_iso_qos_ext replaces its rfu bytes with a 16-bit version
   and a 16-bit type telling whether the unicast or broadcast member is
   in use, so each can later grow on its own; the union is the last
   member for that. BT_ISO_QOS_ANY, used for struct bt_iso_qos, leaves
   the type to connect() or listen(), which fail with -EINVAL on a
   mismatch. Connections set up by the controller get the version and
   type, and BT_ISO_HDT_RATE_* name the rates bits.
 - The extended ISO QoS is copied field by field, so padding is zeroed,
   and the v1 CIS Established event clears the HDT rates.

Changes in v2:
 - Remove the values from drafts of the specification and use the ones
   from Core 7.0: L2CAP MIC Length Too Short is 0x000C for LE Credit
   Based and 0x0010 for Enhanced Credit Based, and LE feature page 0
   bit 59 is no longer checked.
 - A 64-bit MIC is only used when both sides prefer it, so downgrading
   on re-encryption is no longer an error.
 - The key size of Encryption Change v3 is ignored for LE as the spec
   requires; hci_change_encrypt() no longer takes it.
 - Rename struct bt_iso_qos_v2 to struct bt_iso_qos_ext with a version
   field; the length passed to BT_ISO_QOS selects legacy or extended.
   Convert field by field, which fixes an out-of-bounds copy and an
   info leak through the legacy struct.
 - HDT rates are little endian and kept per direction.
 - HDT PHY selection is gated on hdt_capable(); mixed LE and HDT PHY
   masks are accepted; phy_opts is initialized.
 - Create BIG Complete v1/v2 share one bounds-checked handler; Set CIG
   Parameters v2 response is validated like v1; Create CIS waits for
   CIS Established v3.
 - Drop the unused LE Set Data Length v2 command and the unhandled
   Data Length Change v2 event mask bit.
 - EKS: copy the LTK under RCU and encrypt after unlocking, zero-pad
   the key for v1 and copy key_size bytes for v2, free the command
   when queueing fails, and handle the Command Status of LE Enable
   Encryption v2.
 - L2CAP: keep the requested MIC length separate from the negotiated
   one, take the negotiated one from Encryption Change v3 and Key
   Refresh Complete v2, propagate the channel MIC length on every LE
   security path and reject values above 0x02.
 - RFCOMM BT_SECURITY accepts the 2-byte struct and zeroes the struct
   returned by getsockopt.
 - One hci_le_set_hdt_params_sync() is shared by init and MGMT, and the
   defaults are resent when changed while the controller is up.
 - Opportunistic encryption requires eks_capable() and its TLV
   (0x0024) is validated as u8. Encryption Change v3 for it still only
   clears ENCRYPT_PEND: the key size is 0, so setting ENCRYPT would make
   the key size check refuse every L2CAP channel.

Luiz Augusto von Dentz (6):
  Bluetooth: Add initial support for HDT PHY
  Bluetooth: ISO: Add extended QoS with the HDT rates
  Bluetooth: Add initial support for EKS
  Bluetooth: L2CAP: Add MIC length validation for HDT PHY
  Bluetooth: Add HCI_OP_LE_SET_HDT_DEFAULT_PARAMS support
  Bluetooth: Add EKS Opportunistic Encryption support

 include/net/bluetooth/bluetooth.h | 102 +++++
 include/net/bluetooth/hci.h       | 216 +++++++++-
 include/net/bluetooth/hci_core.h  |  66 ++-
 include/net/bluetooth/hci_sync.h  |  12 +-
 include/net/bluetooth/l2cap.h     |   7 +
 include/net/bluetooth/mgmt.h      |   1 +
 net/bluetooth/hci_conn.c          | 279 +++++++-----
 net/bluetooth/hci_core.c          |   4 +
 net/bluetooth/hci_event.c         | 683 ++++++++++++++++++++++++++----
 net/bluetooth/hci_sync.c          | 683 +++++++++++++++++++++++++++++-
 net/bluetooth/iso.c               | 255 ++++++++++-
 net/bluetooth/l2cap_core.c        |  50 ++-
 net/bluetooth/l2cap_sock.c        |  23 +-
 net/bluetooth/mgmt.c              |   6 +
 net/bluetooth/mgmt_config.c       |  56 +++
 net/bluetooth/rfcomm/sock.c       |  13 +-
 net/bluetooth/smp.c               |  96 ++++-
 net/bluetooth/smp.h               |   2 +
 18 files changed, 2298 insertions(+), 256 deletions(-)

-- 
2.56.0

