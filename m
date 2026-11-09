Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239933;
	b=BQ5Cth/OqRyWyZhbwdYtBpbetynmO/EkFf1PlE0Gwpkqm83cyEqhFmjmHSrr0T4eQXGn
	 6mzvDQToxJNxOz66JcmRIMnfy53eRxOyYBZucvZGqRE3inAdkddanbDkAXx0wRRPSPNoK
	 5PXZFlevrV6zgR7b8qhW3YLS/9WfEVeai6l6wJowK/Rmo6vC4X6dNTpO64Uh0temcH8p2
	 dl4EIynFkPyxPY/8o9evMmzVLCOqVCks9LhxmXsnoYZYZ43/GRJQRkIapHWvfP5TZsRXr
	 w50UWg+4ShOYy21iDk2sdUMwETrPOiZqRoK2VULKMZD/D+A3Uc7c5trFC/uG0nzYBug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=hl2jpyRwsDjHkm7ihEEWn+169/oDHX4EqZLFkSJfZy0=;
	b=XJbAGZNrqS09v09XOopISg40KyV2AXTteCtCiLyVqFw/efQw5u86z1JdpsTpsmPf3oeL
	 VHXJPhdmgrhITP23HNE8vkoGRSJoeD8AkvitRl7vnv4GY5/B0cFsUCLEtjD0vdNyBntf7
	 tYvhHkno3yc6Nq8lDampUHhzAwbLV624FO4UYWUBL/3hU1AvAPJrL+FwrWtdluv1Aea0j
	 UTqzjgUBWNyYAg4sfwd5YjVBK4AapiZG/embFYzVxVI3ENFXNIzHoJ7vLWf88cGoqw7WB
	 xBitqEU9rpS05mK7ksLXalxUav5rHzdt8BwycZDpf56WVb9UR0OuVSAiK9y46Eu0auw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p65Aw1dA;
	arc=none smtp.remote-ip=209.85.222.45
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C5A606A31C
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Nov 2026 15:58:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75C5A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=p65Aw1dA
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-9906870a9baso456935241.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Nov 2026 07:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794239932; x=1794844732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hl2jpyRwsDjHkm7ihEEWn+169/oDHX4EqZLFkSJfZy0=;
        b=p65Aw1dAOW0o/sgnFkUv6q1P0Inlvh0wd1IMR2mCbWlz0v9wtxGBmHaA7K7Es/17Aj
         T4NgfpkeTpI2GlH4upvRTTyLm999Ws7hw1HBzrrNAFw7vphCJ7AO5e92arkeEfLF7+lD
         /D5rvne6pjT+Fv5YW9GJRrh54m162a4One2hj5h8RLaL6XNvhy9gZLL7q7g8KK35CvZf
         BtAmm0ibwmfY7IBSeDdnAgO/Toy2i8+xcSqKMuZR2leEPRxDQ+leUxSSnt4qbm4WPBXr
         NgtaY2a3IQQFYYxjXgfOCRxNDOC/AveFt6YDibHQUpMrikaKBLylx7DZLBGdS5ECVqWs
         XrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794239932; x=1794844732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hl2jpyRwsDjHkm7ihEEWn+169/oDHX4EqZLFkSJfZy0=;
        b=g+mWRxA3rdXFb8WsZybGqSuDh2cZ+HV3IMzNAvd3lydqQavo35btU/HYOEAvC+S10Q
         tdvxDRso5EVau28Pu33/RJ9Bzc2JtKTP64x6Qrb4iUha1gOovOYZipT4ma+8dGxCNRRy
         2g9+VEAQylJpQhsLDB9/Wv5JNrDwi/OL+pTz4qipdpfEQ/rduyyttPcW3Ei3p3V9Sf5B
         AsP8F3m+11FGafXdw1WIxyrA6jWiIOP4xoKXXyGcm994dUrsVPeLvMDTc9CYEZsMtZZI
         j8+e28Y9FwRUn2ItwhzQjZE5Dhw/0BEAFSkeEO56P2MZrP/XqcXle5LO+ThLKbrefR8d
         iCcQ==
X-Gm-Message-State: APuU4Z8PxZRZIhmINPunsatS8QGRoKxtq2IQYZ1J2zCKjbLHU100uNhF
	CKhxRnDk577RbZUig2PiarNGCksb/J8Lo0NXn+LnPB6MCeiGR22a2dHu8dXG2Q==
X-Gm-Gg: AYBFou3XbeaIDatb228oWw8K4eZgRtmMMyMniVkRHeD3ZLVsmZeFzrMUGvdl19hPhwK
	fNlXC/o3QLOL4tMs8SbwGhmZ6n/m/oFO0GpLS77lLoWRp62V6w2cwhNN6AU7tjG8GoHGoygxzUa
	wa2v8+QiuV5CCwZUKR2F2K0riSehYBLfLI/NXejFshw4lWM6avxSXDwWKLHQ3m/RHexYweNVMGc
	6aeam2/t6xOgjPKdtF9F30euXZlsM+gaopX1yPNXfpj+ySMsOIILm3DZhm54aJhL5eCsQCyDadD
	FS1ZVj+fttPkM8+OYzCA76Q/qBT8ZV1vJRk8Ioqb4Vp5JsV424VcmFGc9uH6qwYFTDkLC4dF8tY
	iW0KZW5j7kx4SYOwCli5Fa4o+IA9RTByfJj9zseLahhTyk6tHsfsgJEPV+qATqctVV7fZ6iSdPn
	DASdsOTl61gz1fcIoJW5U8DoyIkLUYari3mVeX5OfxYyxgFwetwkCjXRnaToqE0DsHA8d76h4pQ
	gHUfqKCikBnQhme8R3DeBhdFCmGG9P4LKDI0b7v2UCMWPT6Csrqzq93m6w8cKZLakBpnGySVsmx
	HCPajPAmn5AtW0BdNxttMsJh8cZntnVCjUOeWjysPqu5BTkbFYw8HJmt8nfbhEvOqCFiY2GtVAF
	RfWafUNvGNZXAIN5vZXR/nTA5kwR6ITkgm1xQ7eVNzU3g28L5lFuVKmOFtxSmNg2yNClIHYsT8D
	v9Kg8=
X-Received: by 2002:a05:6102:4412:b0:7d2:7e4b:e3ca with SMTP id ada2fe7eead31-7d2db1b5faemr1487088137.17.1794239932209;
        Mon, 09 Nov 2026 07:58:52 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d2db605322sm4145103137.7.2026.11.09.07.58.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 07:58:51 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v10 0/6] Bluetooth: Add support for HDT and EKS
Date: Mon,  9 Nov 2026 10:58:44 -0500
Message-ID: <20261109155850.1394252-1-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_sync.c          | 710 +++++++++++++++++++++++++-
 net/bluetooth/iso.c               | 264 +++++++++-
 net/bluetooth/l2cap_core.c        |  74 ++-
 net/bluetooth/l2cap_sock.c        |  27 +-
 net/bluetooth/mgmt.c              |   6 +
 net/bluetooth/mgmt_config.c       | 105 ++++
 net/bluetooth/rfcomm/sock.c       |  13 +-
 net/bluetooth/smp.c               |  96 +++-
 net/bluetooth/smp.h               |   2 +
 18 files changed, 2519 insertions(+), 280 deletions(-)

-- 
2.56.0

