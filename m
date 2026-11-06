Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989068;
	b=VHPR9xC/lurQaBXEak3mz26FIaqHRLkTg29ChEpEJegiVRMiupozt7r+eobJCP4Pj1ZP
	 ZKTBlEOcTzU3QDAx9JMoFfjX29dwC4DBYJyqIfiS8sX37ZFlzokc4EblyTyAxzukfEFB1
	 Zd8QAdvQGEq1mEzjUifE1k1WPBnvizuV+UGPu2WvQEJxvsce/jxm44oWPpaM/OjuF8VAD
	 i63/mYkVzwomCn+qjXsBV83LlFf2u7UCyLFx7gF3D1QM4/EB9RifQbulbKHNMoedmtjAi
	 uB9UdK5pXZgoaD8KjyUrAEhfhjDWrzMs25mAc9rOLu66HOB7IQilwouwXtTD+aoc8BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989068;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=f9ZrrXZo8JHZG5xFzIxwG6MJEzLQxSEuuKcyQtKkQL0=;
	b=CdQB/RawSo5DNIXd6gVlxTbacrkL4R/saJVE7zMGlaDV5Dj1/ZEm6HAvB8NyAFW+F2nj
	 Riqskl9jqwFKtRiF2UG0dj3lnyN4P0l2TjSvkUkD2qkE9bg8/SnnLcj2czUiqW9GciP1y
	 fetskwfooHN7ceD/6Fl2MmI4XJPEYkIlbef+Lc/mZv6NX7LSrwrOc8q5U8m/xXQoTaOyX
	 P/zDpecc09jznJdO+UQgb9m9IQDj8/PKJPoy4N7GHlFLrh/wsqX4iZhOgHJVQE89f+kY1
	 hT4choqm3KvszCtVCsVU4rMjy+uF/bMC/iUeWzsFcm+jGu+htb61GS9yZUaj5Kf/07w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tVBBzeZ6;
	arc=none smtp.remote-ip=209.85.221.176
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3FC606A326
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 18:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC3FC606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tVBBzeZ6
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5e948e56af3so403977e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 10:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793989067; x=1794593867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=f9ZrrXZo8JHZG5xFzIxwG6MJEzLQxSEuuKcyQtKkQL0=;
        b=tVBBzeZ6xoNZ2GDZxHi6cWWIOHdUk659bq7NOxLDb3SJPeKUfrk2UiKvkYPZizAKQz
         Mq2tl9IDurOb2sUQrC4qx9vviLgnxWDVxv7D8zzJm0YjMXRScfDI9c1ojODyKjs7lPqN
         uFZo+y6xRuVAkIBzD8rOS5Wc3ml3kBwKo9/NcMMBZBkg7SvuHhG00ysh6QJEt7EK3fS/
         YZguoGR44KBKOx/XpkvSbn8vdPOgmxbKN4duTE2BPRVIETBRvjwRXZHvSIU6+G4ZBI9N
         qz1X7GxY6O2Si0ZAllQRNnMTxdLo3KDxV7zEfZxa6vzR+oXwx8sDzbIJgbi2gejcA0sH
         1UyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793989067; x=1794593867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=f9ZrrXZo8JHZG5xFzIxwG6MJEzLQxSEuuKcyQtKkQL0=;
        b=sGZFGThqSvfSqQxDDAXdphiiVHgIJcGmhDz87KzCkJr86SiwpQTbdHw5Qo9+NtmgMD
         hUy5qJP/xg3k6Led31B6By9QcKq9BlFXsMwVIK3erJRA/PhxR3F2qCW/7AH+lgpbX9GG
         ZB2QAVUm3opbT6k+TqDCNkdFMR254S1SPtU2Y5KAdM++xHit4pF0/G4lqF9uU527GJC9
         a+cAQ5oEOT1/8qbhn9pSsG9JJ1Ezf6bktfITGxeBwKHP90he//cAO0HvfWqBbX0/a0Yy
         SbGuz7ndq08BKtFSAVbpZn0TAqk9cj5ZzvfMvcRyzv20goOyMXgzVWIf3uFfsokhiU7N
         /2rQ==
X-Gm-Message-State: APuU4Z85x66lo6ikaR2t1F6EeZhsIzE1KovDt4crUyYYHmXYQTeXgDfQ
	PBldwnuBYsVtUO2xPp6O8wOkKjiqXDuY6q/SV/B+cOQKjKM9KMd/+56Au/PXYA==
X-Gm-Gg: AYBFou0E2mEKf5enoxWiMNpksobufqAGwC9hrTtDG9gd5CiGX2zHT23Omc+FCkep4RH
	ORlF7hcr51/QRo0RxNN9MIULwaiBrZAGjw00APpz2P56LEs4fS7PCUIb3rb9e/KNWhzcbuqVGbO
	igS1lxLW2NbuT+biQbtRhke/shrAYiA8vcb7yRMdbkODji+CccTFS7/b3+4vSqddIvI41P2aIov
	cfHd41OdKMAbqXHMAha59hPqJKeOBXjb8/QdMp6ck4THPehP7C+29MLprhyMN41dB0MudBxRO6y
	qmbfKOOoUH94tg6dkLG2eLoY8yGZ3EQaVt8rkADXXYqQ9HNYnQNcaQLS78qw9FBp1/mz/Mm+ZxO
	m8ApCuOMU+kyveN7A54cmBT5/buR/zzq7Nzl0z5eqYI/35a0GqiktuvG/2OzWd/6QwHgvdP2sJr
	V2fcfkIE2O0K2LVe1VkKGMNTsWm15EM78sPpUht3eR1ztYYEdMj7p0X1D3dJMFWLVC79iy8tcvE
	aDZJ4mvTFKP/PugwpINayEsbC2eSIhN191TQs/Xrkl0Ukp26A1+Z3q5ZPMnHmIlLvodafbCteSM
	nUppoXEffbjhNDj/H3kWtbL57VS3GEL4Z0xVSL5LtbfywKohxrouNzi1ESLWl/zXmKe0cPhC4i4
	7DOHpOS7XyfvJQJUZjVqda/6apyDidaZnNsOfh9d/sbp2fWs8rW/Fncy3h3VkTkvy3jVe9Vk6GG
	s+edc=
X-Received: by 2002:a05:6122:8b8c:b0:5ea:c6c1:8dd4 with SMTP id 71dfb90a1353d-5ecc43bb9d5mr1640840e0c.5.1793989066595;
        Fri, 06 Nov 2026 10:17:46 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64ee921sm1951946e0c.12.2026.11.06.10.17.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:17:46 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 0/6] Bluetooth: Add support for HDT and EKS
Date: Fri,  6 Nov 2026 13:17:39 -0500
Message-ID: <20261106181745.3134593-1-luiz.dentz@gmail.com>
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
 net/bluetooth/iso.c               | 264 +++++++++++-
 net/bluetooth/l2cap_core.c        |  60 ++-
 net/bluetooth/l2cap_sock.c        |  23 +-
 net/bluetooth/mgmt.c              |   6 +
 net/bluetooth/mgmt_config.c       |  56 +++
 net/bluetooth/rfcomm/sock.c       |  13 +-
 net/bluetooth/smp.c               |  96 ++++-
 net/bluetooth/smp.h               |   2 +
 18 files changed, 2323 insertions(+), 255 deletions(-)

-- 
2.56.0

