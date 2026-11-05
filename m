Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898741;
	b=nS2xSNw7YH3Aar5ON54jSmGHRlBSzs+x7i1NhvqYal0ud9r07mXbdYME2Qp+Cg5DZm2z
	 WXBsxttuUb2X1crE0H0nk/U/wjiCidsmda1rHO2umbL0/qTyxDo7QAPFSV6vDum6nRNuZ
	 h1HRz0lso49FcKHhM10YaDkiW9bffPTTs/9CYXRDiWBMN4bmw5sSW5g5FFQMw3ppAJwwl
	 tYXzAfqSzNZJD5nnj/QL82ofMYfooonWNS1HbqUqbyF3kNbxZ0NFTSnXTEJ4CVEMX90b7
	 xV2jD/zNOlpPptiocpOFnrPeg10+I8Lfu4OSwj5jvi/dBqS4gRKsK+EJOizO1CNAKAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898741;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=NB6WSwKcOEfE7h93fXappoe/XPk7rizPBz2Ycw0n22U=;
	b=sCcHOD1uD2slqKUIPyP2ea+DjqGHP62IO7xWh2KHNGZYd8Ob39IZKCR/40XnzO8cAzUs
	 HPNRHMoQJS/phu+I+jgxwKHS06mUbI5VRe1RNg8yIPH3rQDG7H1LDxixKlGeAMPHXnRx2
	 4nZkS0FcidgaDVeWtt2Awjy1gL4UxXrWj2bI/l7eafBIuFnhByvN4SvnMYbFqY75FjEHD
	 USmx+jflMp2Ndw6OkHCx7vcwlnMy4e4OrMA9noSAj5ECNIWmNSlM10DfMZ08O6DiaSfih
	 GCj995uK26dO7vAN8CjokGn2RAnra4WXZJb1eQlURGw/FcwUJy0ONEBAlcnYqGV/KKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ymhuVgzC;
	arc=none smtp.remote-ip=209.85.221.175
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C67B606A31B
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 17:12:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C67B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ymhuVgzC
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-5eaf169fe3dso729197e0c.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 09:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793898740; x=1794503540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NB6WSwKcOEfE7h93fXappoe/XPk7rizPBz2Ycw0n22U=;
        b=ymhuVgzCFfMoJaegte1FD2CIsFpixuiSINOsWlOb7DP7x4wub3UN9Aa1Ye1hjeA1++
         Mw9tDFAEDH6BxDDp4yFLvXSDMcHUZAAXrLK7SN3W7PuDN11QI/KcUALV7j0dxhg6WxSw
         cZhX3IWnc1nUR+QD+L9som9Ss6YrWWPLcdJAQytWX+bBt6XInnz9sP2LezVJmf5vTWul
         6l/KUw/J1ccQga8s60puRZPb0KHgHm2GvItRX88nJwIaiaGPsZd/zu+D/YHjAARRFgAN
         L4XmINZThWd/CHMNQn4YKVp1d2SGrZum3YZsOS/2ty3N/wjlz+z45XE2+6LMv4YZeXIv
         AWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793898740; x=1794503540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NB6WSwKcOEfE7h93fXappoe/XPk7rizPBz2Ycw0n22U=;
        b=XWQIABn9WnNxR82UJ9KYoXYm27Oh6aikFI9ckpNWYGqp79jchZdJZURLWQF7YQvXmC
         joYMUrXfxnUb5JduE7yYg2f+2GyoFyVF4+AKsZiGSKf4LaCaJ6z5ikJiEweM/gxgEsG8
         GigxgXigcC4mkow+BmI33+SarGANUa8iZl5njdKNGj6zWCRBt7eFWL76ahNWBf/pbaDr
         zskzmGuRM5YwbfDgalsBlV+4eM8fkch0VXFk6y8PgBiufsRK9t6tM91X7MV+rRIMaSgH
         DgfCQ7aIE2zKm8zMCzm2nf4PuqGT7m4MvaCImCpmlo9fArMnQhblH5MhTAt6AcSxU1c3
         Axgw==
X-Gm-Message-State: APuU4Z/jZGDnsmM0b9TDfEgrAFiomwPMgzVf5h6e+XFan9jEd+FOQgS0
	kkXR3E4mf6JguaWt//HY7OYW2dBvbAPvMPurzpKjVLTFKewB5N2m7s4i5gX2LQ==
X-Gm-Gg: AYBFou0PTuPGRU9TWbNFiQf9ITQvQhUniFVn+XCnn7JHj0OfJhNV8anHeud5XC19i+j
	wvv/uKIqHWaw4Wapb0hPuXZRGj3+YGwyx7uU3mP5EFImVY+s0M+Jqw8S8a6oHcs4olg8WBt0Uwp
	0HKji9ESKDXYyJLLGrcPYOzLBEU4qVrG7RgbV1rGtcxCfd7k1cPXS/gfZSwDVIHun8OWFzjtAMX
	qpgjSq/IBygV00/P/CSXfPqN0/sujuSHEHdxne280qqZmIaVVw1f4BpJ40hPveuKXDEoLEUpcp9
	aT9gNNsFfpTqCxj0uH11PiAXVzjRMQrI1iB6Am/n2EnKh+mIFGb3NYOPeVps98XOJajuCqqu06X
	FRSxxHEJm5Q1f1lD9Qb8xu1iET+cj6vWo8iHUQBeAx+wQbF0Bo1ULnVykWBrFUnqldNGuGuEJcY
	zp/9mCB6SfdTi24d53hLmIr0CyjgcRxsVizwN+kutWu5sxJvoHWZzmf4QszDgilKT8u9uBYwyDR
	WAnRqXz7+O4cnxjmjin4K1w2uKfQzycWJ3794kB5cslggINGg0OB3XiQxoWXjLbEQ/jixegxaPu
	5jgqBKRKvs6Nz0RhRKhpxX05YSBgQpHY0KHeiB9dqcg9b+aIy+u8t7lg5ZWBZOm4wu/ZLex9gAd
	cFR8LhfndEtgDoKnGihoLfbjx3UYSJADBckgApEgbTrcovj2Fz65rOhbAP7dZnj0g7eq3CABysS
	odl9c=
X-Received: by 2002:a05:6122:6082:b0:5ea:d649:d1bc with SMTP id 71dfb90a1353d-5ec68979fe0mr10586327e0c.18.1793898740037;
        Thu, 05 Nov 2026 09:12:20 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d9d62bsm4551846e0c.8.2026.11.05.09.12.18
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 09:12:19 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 0/6] Bluetooth: Add support for HDT and EKS
Date: Thu,  5 Nov 2026 12:12:11 -0500
Message-ID: <20261105171217.2053745-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/hci_core.h  |  66 +++-
 include/net/bluetooth/hci_sync.h  |  12 +-
 include/net/bluetooth/l2cap.h     |   7 +
 include/net/bluetooth/mgmt.h      |   1 +
 net/bluetooth/hci_conn.c          | 273 +++++++------
 net/bluetooth/hci_core.c          |   4 +
 net/bluetooth/hci_event.c         | 627 +++++++++++++++++++++++++----
 net/bluetooth/hci_sync.c          | 634 +++++++++++++++++++++++++++++-
 net/bluetooth/iso.c               | 255 +++++++++++-
 net/bluetooth/l2cap_core.c        |  50 ++-
 net/bluetooth/l2cap_sock.c        |  23 +-
 net/bluetooth/mgmt.c              |   6 +
 net/bluetooth/mgmt_config.c       |  56 +++
 net/bluetooth/rfcomm/sock.c       |  13 +-
 net/bluetooth/smp.c               |  85 +++-
 net/bluetooth/smp.h               |   2 +
 18 files changed, 2191 insertions(+), 241 deletions(-)

-- 
2.56.0

