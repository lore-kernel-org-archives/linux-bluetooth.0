Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794244053;
	b=eh8qqWzIgfdxXzrjV/yUsG66Wk4Exrn7RlUvrMYUt8ZzLVFkpcJaWpcL7dJB58pmXuSs
	 92ZBNa5VyCSF5dOCwsCvUOQHOv4j7YPaUyPNLfWpJoM26kl80NclnKl9TXNkoGTvDmAtL
	 nt/Ij9Aj+hmMecsm8A5RtcFBWDqa7Hu66aOWKJr6P4kfBngXPMZWd01ILUu9UvKoac7rT
	 voAOvXF+xHSgHZNVabmLfDUodkloLep4S3kLO4xHaQ0loUCZC6IaVEwl/WbEMNgT1jTp2
	 /4eKjeBO1pyV/GkHmpiKk4lN2EGSCMsEYizAhbFWYVE9Ioi1pwUe8g25NK0fQCeHceg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794244053;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8F0eszf/IkI61axTkbrA7E6sbto26+Q1QYwNRzlLyls=;
	b=5oRZmAde7CikjrVLLH+Ew2hazjFBAb+giyCKWYKDfRCb3sWr4SKK7Ivj9jikPUMV2CdA
	 xXSla/wMa+KgDKwslTxl3PFNMHRfe9qeowKW0CTds664DFvLTMEQu4QMIXEPdVwZTtRDA
	 c6DzlnmcKyTgnGJwK7j/sDZvrnx9+GSB+8KYxQYf6VlGZSviOIGaYyhwpIkRN/XK5VXw/
	 jjg8IiFuLRR68h7Y2lLxj22CGYn9QydhIJEEHaWY7nIP+I5paMGClFwap7qt4Aon3RD9z
	 5Yj/b+OqpoqH6mKna9Cex35NZf3E99Vl93/sc/zSgV4GXKzvyefxuFJiVHCe8KMygEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vyja7jQx;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C7C606A32A
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 17:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1C7C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vyja7jQx
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5ecda93627eso345628e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 09:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794244051; x=1794848851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8F0eszf/IkI61axTkbrA7E6sbto26+Q1QYwNRzlLyls=;
        b=vyja7jQxIjzAtjp9iJc+1P1VxoOqBOGh9ipzvGxbRph0CTBWl97RbYfCg4JbTurSg8
         0u9+DGls1yXEaMSLCOt9el9Zk0b4+G7lfloFxvDkMf3wZm71ozRBftGB8l6u6fn2iWYd
         G2tM1Ns+u1V/jzPhafYPdfWpYN+mnTRT83iChrg6ygIkFZtUr55OkoA+B/aRygzgEzb2
         LCGE3HKTWsFvLpVvK4PK70AH1lwdO0yifMUN9u9k0g7rZVFH5QNqBxowzopbrjzAI5Ik
         mw5ZiOrmwvXY3X/Ww1UAakUbGWte6RJ7ZeI4xuCOiR4NfKr9OL8MSZYDe+9VBN3oZlTc
         pTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794244051; x=1794848851;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8F0eszf/IkI61axTkbrA7E6sbto26+Q1QYwNRzlLyls=;
        b=ruAO9SqJgPOGRVLm8juh71rVNGdLAHR/hnUnQcoNetX5EGkKYL39a/VFTeEYwCx6dW
         GyZ6ftfbAVjMDjU1HhPSs4OnRbRxQ4y0H/MkfbcWqTb058kYuIdv4relziVkbCImgQvt
         +Xrm5wyvlikymF4NntbpebiQXJxLDRwE86hwktYdC/dziZgNnDB2BxAY1bkJGL2HMvxW
         IDoi52tXLQQIwWhweDY5e768WAsCLAe4Q+8oklqgkseN44fERqJZvNEQAtlU9x6lJncL
         ZyM+XMEPvEbAdMS+KzXspjQQELVHwt+Af0ng9fZjgzTL3OkSEavanEVrzlybNNPHoGJ9
         ZHLA==
X-Gm-Message-State: APuU4Z/IHumg1wAwz+Vom7sgE9zG8T+m6QCh/nvK3ROgIN+7Rr4FmIkY
	Rc2yWODne3u81l/twsVhCJ9MetJ/IWA7epnni2XNf6Iqs1wC/bpmpLvWA/4UeA==
X-Gm-Gg: AYBFou21u5lFm9GsbmtqzRT/hfkL/zAZJSwv6b+wHnSIsdqMxWHb5aRfIhx7M3WqKH6
	rlphGs700jQbBRo9P+CqRLcyxC1l8kqJ160ZgkE1KbjJbtpQZJF7IPqyhguegXCv1bu3PN7qG9X
	we0wSUrnDfTil3DnWNq3I/wyAJi4G+5sUTcTz0rJGq2YIEpW9x11T2nwt/CAo1UiKcBaOk087Ee
	CKyWgn8me9LJ1ld89oDpMpDTUR0f45mu/D2dwS3BFawQa3FryPmGJG0fGriuL/xoxZqQDPoKYKd
	eZlq3DHjoQ4sHBZENVsRRYnaoGhs1CJojOURm7QmTeo1INPuVRnXeyIyZnS/uAjMyXfU9HMV3RI
	19CNsPEkWHeC95yoG9N7SQNZvuys5fahmpQYeVhNVm4Z2Em/P7C3xnD/ZFNw1/Lx3s4Yy/Ydg1P
	UOs+Krk+1xyMOu/4zfe8GgtXi75tHgSrHd40EaqVBubcrkRyi7MT7L13PVAMa9oVKcSI9vLL8mv
	tyjT81cqusX4xHB/cMYaUvlB2YlW5MtNUumG22ajTzhapCMYgncA/Adg77OyYw/2m0kD6DL6cSL
	1ZEhbAPfEVP6BQYxcSJiHvAdh8wme36Hw6qNVhSn/KEN0F5qY3mu8eujqWj+sjNKvUFwUhlLEzo
	CXOvf49gs/FehGtnbREcAdlFyY8be7T3vVBJyc+/CNnDiRDyOR16QpHDlVtbsWGXQHtWGnA0qzG
	OT9r4=
X-Received: by 2002:a05:6122:6081:b0:5ea:c727:11fa with SMTP id 71dfb90a1353d-5ece700dbfcmr1607536e0c.0.1794244051143;
        Mon, 09 Nov 2026 09:07:31 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ece63fd624sm4750876e0c.11.2026.11.09.09.07.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:07:30 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v11 0/6] Bluetooth: Add support for HDT and EKS
Date: Mon,  9 Nov 2026 12:07:23 -0500
Message-ID: <20261109170729.1584072-1-luiz.dentz@gmail.com>
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

Changes in v11:
 - Fix the event codes and names in the comments of the Encryption
   Change v3 and Encryption Key Refresh Complete v2 entries of the HCI
   event table, which are 0x5a and 0x5b, and list them in code order.
 - LE Set HDT Default Parameters is not sent with a packet format or
   rates the controller would reject: Packet Format 1 is replaced by any
   supported one if the controller doesn't support it, and if the rates
   end up empty, being none preferred or only unsupported ones, all the
   supported rates are preferred.

Changes in v10:
 - The MIC length, packet format and rates system configuration TLVs
   (0x0021 to 0x0023) are rejected with Invalid Parameters if they have
   a value LE Set HDT Default Parameters reserves: a MIC length other
   than 64 or 128 bits, 32 bits being the one of the GFSK PHYs, a packet
   format above 1 or a rate above HDT7.5. The controller would reject
   them, failing the initialization.

Changes in v9:
 - The encryption key size Encryption Change v3 reports for BR/EDR is
   used instead of reading it with HCI_Read_Encryption_Key_Size,
   saving a round trip, and is validated the same way, in a helper
   shared with the read's completion. As the spec says, it is ignored
   for LE and when encryption is off, and a value outside the 0x07 to
   0x10 range it allows is read instead.
 - Quote the Core 7.0 specification where the code relies on it: the
   event versions used, the data length limits, the mandatory HDT
   rates, the MIC length values and where they apply, the MIC Length
   Too Short results, LE Enable Encryption being only for the Central
   and opportunistic encryption only for unencrypted links, what the
   EKS mode reports, the security of an opportunistically encrypted
   link and when LE Set Host Feature is disallowed.

Changes in v8:
 - The ISO QoS rates are validated: reserved bits, or rates without
   BT_ISO_PHY_HDT, are rejected rather than passed to the controller.

Changes in v7:
 - The MIC length of LE Enable Encryption v2 is taken when the command
   is sent, so channels raising it after it was queued are taken into
   account, and incoming LE and Enhanced Credit Based connection
   requests record the MIC length of the listening channel before
   checking the security.
 - A failed Key Refresh Complete reporting opportunistic encryption is
   handled as any other failed refresh, disconnecting the link.

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

 include/net/bluetooth/bluetooth.h | 102 ++++
 include/net/bluetooth/hci.h       | 216 +++++++-
 include/net/bluetooth/hci_core.h  |  71 ++-
 include/net/bluetooth/hci_sync.h  |  12 +-
 include/net/bluetooth/l2cap.h     |   9 +
 include/net/bluetooth/mgmt.h      |   1 +
 net/bluetooth/hci_conn.c          | 281 ++++++-----
 net/bluetooth/hci_core.c          |   4 +
 net/bluetooth/hci_event.c         | 806 ++++++++++++++++++++++++++----
 net/bluetooth/hci_sync.c          | 732 ++++++++++++++++++++++++++-
 net/bluetooth/iso.c               | 264 +++++++++-
 net/bluetooth/l2cap_core.c        |  74 ++-
 net/bluetooth/l2cap_sock.c        |  27 +-
 net/bluetooth/mgmt.c              |   6 +
 net/bluetooth/mgmt_config.c       | 105 ++++
 net/bluetooth/rfcomm/sock.c       |  13 +-
 net/bluetooth/smp.c               |  96 +++-
 net/bluetooth/smp.h               |   2 +
 18 files changed, 2541 insertions(+), 280 deletions(-)

-- 
2.56.0

