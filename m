Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817390;
	b=Y4gfxDmMID7eacVVMq4DpVRZrXkEKseRk2EoeD1QUrnq+u4TnJdLaTtNylVmuCwDqibo
	 yWBa4pgVzrOgUjULyMXoVKDm5dzwpgOdIAvzNuiZaLoxDp2l5DrWFgn23yXYQ/IQCRHQb
	 FOJ+Zzpfcy4N/nKS5JC7kDCzy8L91AQ1jHMYmW6L4dfytE8xLVkJR0l/1rUOiYYSzdplE
	 wKHq4j4iy27leKFbkIG/5U6HQjtHbEt3rV+jSFGEm7hAdXIyZPvNZAXmIXW2/m7tNYm+D
	 8PMy8BY/gvK9GhUMBlZ+RUg72o7dslwSUUKV72kg99uvl2+oEzX3IsAJJqyKUd76GuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817390;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=LpKRkKwQx+08ZKK0n88HqebA3HQE05QwUnG7DaxX2gM=;
	b=MPEpi7MCaacUaG+gjPFVU+CqVJlwmTfkSjXTI+l6mB9k66qqh8L78AJaXxH2QO0QR4Te
	 mvJ+7tsUMtte+JjGoeYti1XqlMa1tuc1uoKMufTnRZ8r4t1DeAqpVhaqGxL03bGWA/32v
	 eXj4nT7aejDTjvwrJQhsK1OBBn9g/ZtCcCJL5aacNH7LqsEHIGkTBNDsa2WLRJxS3IG5n
	 7EVWrY5HCAB/XAq9Mbdt7mm8w8fq9yDDvT9EhgpsAjdWqTIV08Gt6JqVunPkIseEF6G/J
	 TM84X1/q1Pd+ODR5qfA6YYYa84fLK4VmNasg0mTHoaWlno9zEL6Sls5GU45Do7/dGYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HfO0UJr7;
	arc=none smtp.remote-ip=209.85.222.52
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C04606A31B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 18:36:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7C04606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HfO0UJr7
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-99061e2171cso352869241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 10:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793817389; x=1794422189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LpKRkKwQx+08ZKK0n88HqebA3HQE05QwUnG7DaxX2gM=;
        b=HfO0UJr7uobwI07BhX30umHB1dCqYAQZ+7Y60rc+71s16ce88k7Dtpars7TEFvwhdu
         UgM53LXVpVqlz3ByyU+Hhwf9+svvQlcvNf73+VBmy9Zk6zj6mnkch05vjYPqjLfhVvEc
         j88lAOeGHLB0vRvlaQYGIcmKTb505DGxxFBH570xI4b0GIT3ReAzz+mTpF/L5GbP3/uU
         +6SXkeE5uKHuxtk92eUEEFVNKYSFvN1f35aOmco+t68zAZECkrYGyj69zM1vPHK1Rt3M
         OFUAueCWEUOKDm9U4/6DlYWajcgO+7J0039si2A5kB10ezcG70EXchKDuxxuYowAhMwH
         c5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793817389; x=1794422189;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LpKRkKwQx+08ZKK0n88HqebA3HQE05QwUnG7DaxX2gM=;
        b=RGPoElSHAkZY2Den1lS09VIS2Y7RsPfcZB06Zc09j+/NYjJ2UIX/pfFJwHFESw9Odb
         3nYTM0XTnquP/fSc/LYyox58f13r0OdbQEfO7+MQlqmf1oT0AvSrG3hDxqWRTXY6JHcg
         RysU5CCux+tWKjmB6eNuubU1Oa82aVwn6VjW+kg6ZcnbRhVKF5HysRmgOzhRzeSafBOQ
         B9oieeRnSBcG3tFwduyRmTd01lq7S8IFq7Br3AJs2n0yMrT4byszdYnFdnR5EOBD3xe7
         AIR6nLAdeWOoUQCbKlOqWulKOhuGKec86/6udaEIoCpsOI/+o9+HG4wS/3mN9UKhYq5n
         4OMA==
X-Gm-Message-State: APuU4Z8MjDcDzgzvNCpIjX3rTpKh0Dyl7ywOL37SKE/5L48981LPlOSk
	zv5UF7ZkEcHz34zNzVoqZr81om9xaNQWO/vXemkoMnxrHhATH0lwqNhkcKQf9Q==
X-Gm-Gg: AYBFou2Jo78MAz22Mq+B8ug0XsRCnMadWLpe1MsdBiEAVseqLcPw0j1zYIjEf8gGxSG
	S6GuCqUMHNejV99xzav+/zxf65UdZops3FjdQHWazlf2sOfmIuAfGrza0LYknJC4QXXyJ0fn3sY
	6F1xMV+46UzbbdD9dJy8mLHwYI141ra72TAQQ23kgGLNByLkc7WSuR9VICFS1zy+7mDB7slf9oq
	X74S4ZEZtQt+SOenuXA4BDzRKWYmJsR+HZ30EuHQPqkqG4+ifbC7FOKvOQP9eFTs4/27uVwEUyv
	T4bDOYTR4z0QVtTKwqXC/1Xag66+XYFDLgtc+dbRKS7JzfZ0FoQVcgqqLo/8YlVHMx1NdUz4OKq
	ow7AIdnydQrWbEkcrGoN01e0m/tmLI0XWckOYxBuT43G+5VmUzbWKD0xRCm2TH3ZyNrTXVWAkD3
	R36cbAxOULMqrvvNeAE3BBzhYqMyvN0xdL6E77ndtdqBKhXUTC73Z0hCBoZ0sUp7I6yNfYyu1fx
	b1d2yW4xdyD0KiMQ/bMIacpdxSdPnP2HhA2L0SzP5AX8p0KFJ8C3pF1esqsRX9XpZ+X3CoOsWDQ
	97sBj4Kp7jwcVIjhKv0X06bPeqYtZcn4gemEfAoebmwPebB03AWl7Q5YU3HEDsEYZG7IbdimBaF
	QIXmHHl1TXcqq9RI/pQnkDR2fn+5tSkC3bsvKHLghQy+zQPi+qL8NS2J5MoMstGWgOgQ4HCEGRw
	i17gw=
X-Received: by 2002:a05:6102:f11:b0:7cc:1192:563c with SMTP id ada2fe7eead31-7d072ca43e3mr6210531137.25.1793817388631;
        Wed, 04 Nov 2026 10:36:28 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d9a9ca31sm2509812241.10.2026.11.04.10.36.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:36:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 0/6] Bluetooth: Add support for HDT and EKS
Date: Wed,  4 Nov 2026 13:36:20 -0500
Message-ID: <20261104183626.838825-1-luiz.dentz@gmail.com>
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

 include/net/bluetooth/bluetooth.h |  73 ++++
 include/net/bluetooth/hci.h       | 211 ++++++++++-
 include/net/bluetooth/hci_core.h  |  63 +++-
 include/net/bluetooth/hci_sync.h  |  11 +-
 include/net/bluetooth/l2cap.h     |   7 +
 include/net/bluetooth/mgmt.h      |   1 +
 net/bluetooth/hci_conn.c          | 236 ++++++------
 net/bluetooth/hci_core.c          |   4 +
 net/bluetooth/hci_event.c         | 571 ++++++++++++++++++++++++----
 net/bluetooth/hci_sync.c          | 601 +++++++++++++++++++++++++++++-
 net/bluetooth/iso.c               | 151 +++++++-
 net/bluetooth/l2cap_core.c        |  44 ++-
 net/bluetooth/l2cap_sock.c        |  23 +-
 net/bluetooth/mgmt.c              |   6 +
 net/bluetooth/mgmt_config.c       |  39 ++
 net/bluetooth/rfcomm/sock.c       |  13 +-
 net/bluetooth/smp.c               |  64 +++-
 net/bluetooth/smp.h               |   2 +
 18 files changed, 1879 insertions(+), 241 deletions(-)

-- 
2.56.0

