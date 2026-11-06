Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981551;
	b=DEwPAOis6ycBZnpdkgM+FA9710YgEgKpn6FNOwmmWaX0X7a9hjzf9uNJd9Z/f/rTPpVe
	 14yV2DE8VctSmgvlxDQWWj2l4ItJzJSSFjgmvxH0+mC2Nm2CoA/SFngyDPuydx/0QBZb4
	 bV4DqO+DekYX8uv6Nc5z/uEdyiTaHFPqd5N+AdI+dwPPDbnfshBzvQBGHIp7defca2M9J
	 RzeALY3zBhE9NRiPPadnhU+xEorjWAXijW0NL5xY+/SDh++VAEs8vVW5FuuszTr+u1HOx
	 ONrUIb2oPGFHHaaUEUWeIjI2y7dd8VJNFclOaaCiNL2Cdibf/CqVkREsSq+U7z1gUKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981551;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=fvUcj37A/f4dsw4EoZ3XcykhfgitvsarE3eXHINrEHY=;
	b=Nh57vymlcO68+D2yfibTZgRR03l0ACnk+hJpX8PgbWhwVNmm5hMqP7bswqkn6sJQzAfi
	 Dgf4AKhN+B0wyc3SKwF/oW4gIUIcri06TvAqQWHUFwbs9J3t1LdtDhU/b7CiIvnFz0wOv
	 KgE59lcXchLkuI7ZpoWTnsP7A9ZVHSuAfcWDHjSht6Xbvjw8Woay4cgO72dv5IkHpMKBK
	 R6S0roDIkgJr6l8p8KUHjneCe9Pb63EPLp5o+cBh4nX/PRDrArwjrYAI7NaSYvyDsZs7d
	 6oKJrrFqQ2CyVwv7P/GUzFMy/UIUiYLiA2POW8vUSBSykOrfMACzn2V+RNnGBs9eA4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w4B4kK97;
	arc=none smtp.remote-ip=209.85.222.53
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D83C606A326
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 16:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D83C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w4B4kK97
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-98301b325c4so216592241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 08:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793981550; x=1794586350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fvUcj37A/f4dsw4EoZ3XcykhfgitvsarE3eXHINrEHY=;
        b=w4B4kK97IhN5/6nzgDVUa8PaEGDZYxpGamLdJNev54a6mPyafdZWUJuZ4YBYyge5ZS
         Juc+sxZbCMNrDylGiilKTdkr7/MwjaPU7zLZ3F8/H4fuTreGH3C9DN99f5aTdomYsm4p
         pywIdfUPJs4GqJowUX4UnGnF0EWuc/sUskFiLw6XjfUz3dKI1kTc+W+SQstAQqszKPZ2
         l56c0SbT03zIEyVs93TwbPlFDxpJWnLkZHEe1RPZ5SpT9422bs6tN+YIaXHCimb/u4Dc
         mZ2+PgDSYxd0TXfP6s3zFnbjdChEVKgrBDB3L6e/i6b9psCB+sLJZLfrk0/F8t5sjEbn
         HN3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793981550; x=1794586350;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fvUcj37A/f4dsw4EoZ3XcykhfgitvsarE3eXHINrEHY=;
        b=BI8+MrtJnt/1dqX0iJYNvuvLPbWr3BJl8cKfKWoI2bWP2KGI6lO8hq2H6B3w0pNsH2
         bBvnm7aCFH2+jdQOE8oWa6XkBXCYn5TL0vTA1TKOGP+Ux76/HFX0frNb7zka/M5XNEZs
         8L1stHtpA+V1rzNRbQ4J4GeUgvsLq7pyknDnvAH3LH7737ZBijxu9GkmrVWfIAlNrl4L
         36MFAjuJKG/0efQjJpDbJ5ZjIF4oZNu5yLKYNcSPzniVQA8ynzksCdc8qeMniIWi2QQo
         BG1QhyGiVvO8ObobVKmTfC5eym0EQZGffnFavOqyls65G7brZvl//yCvIfOa6mPTNQK9
         uhOQ==
X-Gm-Message-State: APuU4Z8pVDslbVUZ1K7IbhzdXrLWyDTUtlVsxSwz38Kbnbr0SU0mcduh
	xPrb+h26LybXD1t0JobogpEmVGVAl8cYogXFYCbVCTmdbWCWt6GMGVUndNIboQ==
X-Gm-Gg: AYBFou22PMOxUAfHbXNKEa+XkhQJKAKbuK1sW2IfEl/01P+WqsLO4u2Ck+qyFIPuvhg
	9RA42fQmfFhlHTcpVG1UpSMtgPvMH47qMS+4e3vfUDxkXZ9IXrWLxIoWaJvYLLhuxoOj1sVMjXs
	H0tMjeyuu0zan/ft+OURyfKKW69N98p8G0lhFXEW4mllm3Gl5vJz31IEjcodOQf4uGYxzWJRuz5
	Cgw6oEU6Rv1GzOnpEkATiiZ9TiVCfayyqfC/+PdpE4uM/Fu78m78ThMhPEetm9/DxcTSnoZouDP
	WOsBfu/Zk7/beLZwOSEPOH5yAh4nRZhvRlDJkjFzj7+RWCu87wbZDQDU3MLLOYBQEpU/EZ/KAB5
	8npAQ378fsG8BoHvkHBbyDP4PHfvj3I1rZQRl5d7vXMAbZQnzKdo16vgdQ70forOr9hoQbeV2ma
	Rp44O05zx5eY8yoayVlzPJ80bG/ohySMaV0iUG5q9I3kr6bTpZW2/26klXkuqTU/KcsQ3Dsjf01
	lBrHI/Gzb0DV+zpb/5b+9dp4/icuMJFeBme4JjRsIu+NINHlZ3q/SvKF2+O9GJzGB0Y7ygrsIks
	WVYzghgc7g2+c+KJE5fnji9bNjGr3tGn6RPQlKSlKIa6Z203h/XNp2cSSilG1G48a5BIEZBcVly
	66+8ydf0uq07nJARDh5VulNT4bddQDWot12RSs/3g7eIB49+lT5hebfy0aaK0jMHoVrnPAmc3dy
	350UTdQzBsjF6BXXVSI7CIHsvv
X-Received: by 2002:a05:6122:3c48:b0:5c0:fb8d:9993 with SMTP id 71dfb90a1353d-5ecc41abf99mr1499537e0c.0.1793981549955;
        Fri, 06 Nov 2026 08:12:29 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64ee921sm1689697e0c.12.2026.11.06.08.12.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 08:12:29 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v7 0/6] Bluetooth: Add support for HDT and EKS
Date: Fri,  6 Nov 2026 11:12:21 -0500
Message-ID: <20261106161227.2814291-1-luiz.dentz@gmail.com>
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

 include/net/bluetooth/bluetooth.h | 102 +++++
 include/net/bluetooth/hci.h       | 216 +++++++++-
 include/net/bluetooth/hci_core.h  |  66 ++-
 include/net/bluetooth/hci_sync.h  |  12 +-
 include/net/bluetooth/l2cap.h     |   7 +
 include/net/bluetooth/mgmt.h      |   1 +
 net/bluetooth/hci_conn.c          | 279 +++++++-----
 net/bluetooth/hci_core.c          |   4 +
 net/bluetooth/hci_event.c         | 680 +++++++++++++++++++++++++----
 net/bluetooth/hci_sync.c          | 691 +++++++++++++++++++++++++++++-
 net/bluetooth/iso.c               | 255 ++++++++++-
 net/bluetooth/l2cap_core.c        |  60 ++-
 net/bluetooth/l2cap_sock.c        |  23 +-
 net/bluetooth/mgmt.c              |   6 +
 net/bluetooth/mgmt_config.c       |  56 +++
 net/bluetooth/rfcomm/sock.c       |  13 +-
 net/bluetooth/smp.c               |  96 ++++-
 net/bluetooth/smp.h               |   2 +
 18 files changed, 2314 insertions(+), 255 deletions(-)

-- 
2.56.0

