Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793830405;
	b=JabDfYTvWIXTghQkPfwlrIkOhXpH9MpFJJV1LH/IKOvojZH5pzSQ8oQNeRpt3kIgPEA9
	 LDU40RUr1vXs5oge9F8UcnB7zaly5cQCBECE+UC3UCeoSLtsO/u6qAVddOYo4cjGe7TFV
	 5uRBOMfleqfKXL+YvVqToRmNjvs/sqOvCJseZ0vDO9KZYyrfX0EfbvL8Q1e3aYB0dF+88
	 z4Vpnmx/BmgfxCm15k8HRKWggRO1V17hwlLr1M8kEj2wk6Geynryguq6xVZcghGZWTVd2
	 DtC3tCIBwlTWamEEh9V3vFdfZdDSoNtWBCCM3KfLPaUYRACnQ6ZIyQ1bj8P7MhsHzKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793830405;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=WoBtpaEYnSbQqX4np2oJSDAUkkTR39XZPu0RF3EPWg4=;
	b=im2u5PvNp+HzMLfnM8+GyjC2fwckoSClKIAo2HU9Ozodj8/RY/VB0qSdfHwqe9rmGNtT
	 xMAHGgpaJcDkY0bwQSGaTHWLyXS5N62St4NqIKyOR0YMEbhunr8aTD21VhyhozOrrH5yK
	 HTVlzUuC0YjBfurou9nobm6n8m4zq+okFYE5sc8kkV0PHPaCy27u+OuMo4zrzo2IBFjiw
	 u/jA2BFjCi+Nevq+ORqKn0+QEhZLYqW19cLxi6IxcY0NScb/DWvZxoW26ZRjBNK/50+49
	 YmhwfvtvCNueFALFzEXkGn/4+R7BVBsx3dSrW2J3tzAk2GMAoZCMhz715lipGP26vVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T975q2ov;
	arc=none smtp.remote-ip=209.85.221.177
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0CB606A33B
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 22:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF0CB606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T975q2ov
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5eaaa9b1591so836420e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 14:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793830403; x=1794435203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WoBtpaEYnSbQqX4np2oJSDAUkkTR39XZPu0RF3EPWg4=;
        b=T975q2ovkQp5ijIDtS6o91CYpKnYdDwfsqG/RfUTH1yBqna/dWRyhVg4cmi1Ua/diW
         J2ocJ0CQnnp6AHHccGVOgk77R3jp4WQE2yPAqp7ZTV6xYt0QQPktS/jKkDRLzMGR1ZIu
         aSmxRw+BAt3Y7iYSTSMK98lT3ktHoOj7WLmRDXh01ddADvvrOiRSzd0iixvRUo+lQKWj
         E+SM1zo3vhWew562+2KGz95B4nkpTqd/vqnl6m6PaRS0b6jnEQ1YhX9SUFghCgCTE5wi
         SKKbXMrjJWOVlkB+4Nqud4PFZQhn69vVZZdUoaGboh1eAfZjTkdRTUlYBQjxibVzdWkI
         KRUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793830403; x=1794435203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WoBtpaEYnSbQqX4np2oJSDAUkkTR39XZPu0RF3EPWg4=;
        b=CTzEVxW6ogUh+E4BQgNJAyjW/Ud7u8M3Z9byUVqqGgFsZ+ksyXi5ZCZ1eV+e31vleN
         wpevg8gDkVOVDM5xMOlLJgYC8zkwAkeB25OJrAQVpClDhesR094etZkHzQIH/9EMF2vz
         vyuUMW6G06SPAgN/LPP0my/qVYnOsVVj9klz6P+TMXzM+l0fw5e/riaI3DltC7ok3+1Z
         YaaQBHL8JthCmLFCMIF0VwWn6zfk9iaxJBEZ9ij3LACiX1yoGFTHSX4bM0SDKWlJ55to
         aZ1fxirnfvVeJypm8Ob3KE2x925fY/YjGFNkkf3FisNSu0zHI3e6LIbnlJLnSxsEFoJx
         5KMg==
X-Gm-Message-State: APuU4Z8nLgOqVqqpl9GfznsEAnR008FMTiNvfNa/VvXj1LIc4PDiYj8h
	cwbXRQ15IqSdgKm1w4qHF+o9fc+iyrJ5cYc5ESV8ubaUGj9OkGVOhB1dyKkyfw==
X-Gm-Gg: AYBFou1hNUJ+RXSuZH8s+q2Ok00dOmCjnH70+dQY0CugvhtOpky49w7P6/0lI23a3g5
	bauGMrGUKUALb62t/Ph7HanKRJgwvwgLJ19is0gOaNce2G9JF7M3P5jou0p34RW20KoqoDBhB76
	G5CJ1alyphly+uClwWAAwrRRSAK6w+EIXG6KIylbn7FSh0nGFP9vxZxyVEf8lwUNEgjoxinho8i
	wH+Lbr6O4WUmi+8LkYSnDQO1sTMYKDgfeXkB9iVCKhqbYp4su8EhB456TcfWj+mOHxgfZ9TyH3A
	g4n1Xi3Ne8285sqjN0ftMc0X6Gczm9VS7NCVg7iRxvB+7Z0iTQHpNs20nQuww8d9mk0NZl2Nj6g
	qKU7ouXcPXzakyg6OBUb2wYsP8h3zPVJDIIpUg3DquMB6vcQ3CfVBKDBoHCeKB2BNhfzaCDT6KO
	hXwWMJS4JWp6VaJBbPIm8Zoi0LVaNhUiikhLlVIY2A+/xfSbhpXIIyA39oNE/ogZp5TqelU8Noe
	udS2v1BYflP6dKMIYrh/pJjQun9ZitLB36thg0P16r1WlwgWaIq+pCV1ckV7rChva6O391/nrIO
	m/b/HgJe0Q8OXVIMFyAd8uB9WZg9zs7KlAc+OKN68gS59RLcS6XKOkmEMtYfThOMN8k1Hfqt1dM
	EFObObrZTEpv2BiLDmVsNuYk8q2iQVaCaJzw+2LVR/2mT0v9KQ2my+pH1mMN7DvbXxJdcxkjB7g
	7kKPQ=
X-Received: by 2002:a05:6102:c01:b0:7d0:5688:f507 with SMTP id ada2fe7eead31-7d072c596c4mr7464539137.20.1793830403468;
        Wed, 04 Nov 2026 14:13:23 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998da178b59sm2934001241.12.2026.11.04.14.13.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:13:22 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 0/6] Bluetooth: Add support for HDT and EKS
Date: Wed,  4 Nov 2026 17:13:15 -0500
Message-ID: <20261104221321.1200529-1-luiz.dentz@gmail.com>
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

 include/net/bluetooth/bluetooth.h | 101 +++++
 include/net/bluetooth/hci.h       | 211 +++++++++-
 include/net/bluetooth/hci_core.h  |  64 ++-
 include/net/bluetooth/hci_sync.h  |  12 +-
 include/net/bluetooth/l2cap.h     |   7 +
 include/net/bluetooth/mgmt.h      |   1 +
 net/bluetooth/hci_conn.c          | 259 ++++++------
 net/bluetooth/hci_core.c          |   4 +
 net/bluetooth/hci_event.c         | 606 ++++++++++++++++++++++++----
 net/bluetooth/hci_sync.c          | 631 +++++++++++++++++++++++++++++-
 net/bluetooth/iso.c               | 244 +++++++++++-
 net/bluetooth/l2cap_core.c        |  50 ++-
 net/bluetooth/l2cap_sock.c        |  23 +-
 net/bluetooth/mgmt.c              |   6 +
 net/bluetooth/mgmt_config.c       |  56 +++
 net/bluetooth/rfcomm/sock.c       |  13 +-
 net/bluetooth/smp.c               |  77 +++-
 net/bluetooth/smp.h               |   2 +
 18 files changed, 2125 insertions(+), 242 deletions(-)

-- 
2.56.0

