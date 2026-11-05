Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904292;
	b=BzcJJuPOHLCNDZPBteUdmv1y+kGy1rTjhRebw7qwfsPBTvY0G2hPG5yrqeDK3Eb4BB/C
	 j/1XiGYxrqm4fT3Ry5BW+wTBWjttPTe9gbDIYwwqt6rgiAqV9obq9KaRSXtvJREtQP077
	 lXlGGkptBz6dGrG9lfB3fubkrWr4+r2hqikCWi40WgV6RkynWpw9VC37gUmArc6JMtqKl
	 5BqfgCvSinKLH2uhBWhMDb4GKRYxnvRYvZ+O6P5Ocd/FrH9ZmCfcaXZxz7pFeq4M/l+K0
	 qxptXcOWy7zONU64ID/HraVxgCm48DuHaXeVp5UCnboAzdJI8mqewMqOVBOuX0Oi/7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=SUGGgOuwXbJPgz86+8UuEKM1AixgGD1Ul0YmqM9ExoE=;
	b=Ky8N15QVKiNXDqPv+OYS2X8ZxNr+F0Sq7PtCN5KKpV3LwGmMQQLGkEDvCaV1EF1feDh2
	 y4K0+FOtRSoNADEzyFke6UlnfSF5jc5BKHgH3reiUKMC/gsTM8ynEc69QuYyHHTicLE9J
	 oHGtIKr92qJx/g3ExrqbdGqbUiPdKBdpSacCBU/nvKQ1PVas2FPhszNuLNnKOWat8n5jJ
	 gAwH/P0GyAJkzI5vgNG75EORFgt0dujIcqYhybXxeaF64V+vPjJz7V+4cvOY11q9emyLp
	 U/omFKIP1RxrFxIiKEaAkjNdlonQ/eRIWsXie0gUFhIMvokwi2ettqF5ObJgIFJdLGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wt17irmB;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9043606A326
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 18:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9043606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wt17irmB
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5e948e56af3so827488e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 10:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793904291; x=1794509091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SUGGgOuwXbJPgz86+8UuEKM1AixgGD1Ul0YmqM9ExoE=;
        b=wt17irmBBsSBE9Zgbh5pDC0Z5NL3vy8F21ZgxCVCsHEt3MQi57OhKsiPc+ZmMlwg26
         gDhLrW+t2h1pWK8JOj7zYIsQOZGbVUOZbf5PsfIizeaYKnjIRbyUM8HqO/p+DI2XPkbg
         zakQKVWTkHqClT2GM++UanmIU8YPidYuXbh1Ov+sQc9TYrMi20QF7d/LooqhrX3Cvfbg
         eRIVtn9SM7x3qGem4y/MT/ozovy52+zkbiS0f17jLy71mSHb0KxXZTXJVEI6M8EMKugM
         PldQ89yj+l9PTquHf13w2H0r6b2sA602oKyEuEZqklmQl3ce0urYt7b8Dj15Zl7OOuoZ
         pWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793904291; x=1794509091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=SUGGgOuwXbJPgz86+8UuEKM1AixgGD1Ul0YmqM9ExoE=;
        b=bv9a7E2KJ6WbPjcMghNkrTQI2IsBPql10tUn406q22+e9dCOAY6kSrhsRR0FPw90AH
         UvL3kEtevVMHFD/lQFg4lW0N/5FOEAOb7OzS4P7VohqC86uyV0yJo/6yXvYEWg8zD6hH
         wSiY35gdv0D9vRrLmD12bsqymrKx59BN8ggKEPgN0DlgSlFUU+DMA/yh9VTX0nbllyce
         yYm7tnKU42vaQz9vLKnmW/skHpXVVbB99gKJu8diYTtb10pvZ5cB4YojLsrT+Hmw/zpv
         yB+4+lWnY0ewBMstHow+VH9ViG1TkMSdF6FnqERFfnr4k7FpbvwIk4NYmotvu2DZ6GiN
         vMSg==
X-Gm-Message-State: APuU4Z+HIhvryWjXM9QGU0MHNVnMAR+JwopIcdq1xHpBPB6958GUszDI
	7V+BvQdt6uc4wRqirDTfNPPsSq8jngdHfGKuIWSWJDIWbIKM9QJsyUsGC3iHFQ==
X-Gm-Gg: AYBFou0sJXAUaI10PDqAPBILH2Nt6n1dbh94m3uXcbTG9nmcYHB+Ct1fLnZLpcNjbsE
	83akk6so1BwooPzjQXiekse8sm/sG21hii3J0mrKBIWDtlUFpToJ2E2arRTC+brlhlrjMHcBMSg
	trLrIn9QCNk3MkaioSEMqskjKx5BxKJHzcciGewQGsXM/4xzC//M93UtS49GWmp8mEYDZ906NLB
	nvzBEU2viXQR00edr6Rx4a0+0Y1XsaQ1xvLnH0S77C7kuOgSlOHcMEu9IDmBJgDw2aPD2PfKwWQ
	pZLHm1HBMe3zXaqTNSmEjeOZy9BWYR9Hp2kv5NjC8sdgp7IDPLOMiIJ7Zlr/mwZAs9VvIyC0y6P
	2sJGFAPDFF54/4Z+Qx5YHyCMWNfl+aOqECP+eo4K00xDopxCIlG6R5whiB66Z3NHKAiYobcXl/p
	XKIv6IRPX0S/PaNcC2GVZFMZiP1pyQ3qTSd4/GQd1uxDH1NNyZ8KuouPFL6O5ewB4Dw3lMt9NRv
	M7XwZpMh9ePJ2tRCqAitzluEcPnKDhtPnmEuU2twYAb5E9yka2+fgkrD7IABjEWP0GwDBBZy5sp
	octnYKl/ZDzDaZACrQySyq7cFudkb+TVGLNPUS3o8jm59S6nFlq9c8naUVTJfFNhW4zzxZ8CmgS
	tZYkQhX531bBmC4+49syEFfbhJ0qensa2O7Et6usliZXe+mog1p5QP150w7CX58K7rYNsIANIAi
	Pd3cs=
X-Received: by 2002:a05:6102:2910:b0:7cc:23e7:e743 with SMTP id ada2fe7eead31-7d2a155fed1mr444372137.15.1793904290643;
        Thu, 05 Nov 2026 10:44:50 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99baea8aeb0sm12182241.9.2026.11.05.10.44.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 10:44:50 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 0/6] Bluetooth: Add support for HDT and EKS
Date: Thu,  5 Nov 2026 13:44:43 -0500
Message-ID: <20261105184449.2149626-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_event.c         | 680 ++++++++++++++++++++++++++----
 net/bluetooth/hci_sync.c          | 663 ++++++++++++++++++++++++++++-
 net/bluetooth/iso.c               | 255 ++++++++++-
 net/bluetooth/l2cap_core.c        |  50 ++-
 net/bluetooth/l2cap_sock.c        |  23 +-
 net/bluetooth/mgmt.c              |   6 +
 net/bluetooth/mgmt_config.c       |  56 +++
 net/bluetooth/rfcomm/sock.c       |  13 +-
 net/bluetooth/smp.c               |  90 +++-
 net/bluetooth/smp.h               |   2 +
 18 files changed, 2270 insertions(+), 255 deletions(-)

-- 
2.56.0

