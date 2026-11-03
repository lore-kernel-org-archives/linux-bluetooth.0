Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793744367;
	b=R3ACRIa9Og202WiIxOl99AMefGQ9tXvt6XhsBDc8h5VX4XefTAyPwCZxxZAuPXug8KBk
	 kZKYtnPEvlhuYml4etv6zAuGURFURauasqL5l9WM2Ynhr6Y/BvKPfMcJpToluye6CvEzn
	 7RRNk3hNpRvaxhueo3IeWH/SGN4UG/NXvNQe79qOHkQvQbTSK3Noab78zEc7Ipb81R395
	 fGkAgXZhDDaadzMJAgfHCocIo7DbPK1pl5oRqZdxNTBrYo7DVBve2gblqJ5a7ZfvXvypX
	 r+n+TtJpDMdNH3EIR7Znm+jiJm4pL6Gnyw0QASANzZ3ChqmvmKVMK156ASa23cjiDGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793744367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/Vgnr8BURVMoHU9P6jtOpg63n4tzG/2LMOYbtlQPkeE=;
	b=OhWCPHnT33TEqoNfuZ5oj9ZGz5AyJxLWbOYbz8sN3cfZRx2OIGU7pcVUkISeKl+L4ehM
	 16lIW/Twy3KQcTEEEvYpnVGVFR2f5RqI53BeSE/sBh/HVGSlDGV9Vhr9drwJBA19G21BV
	 WxKazW9PU+arRPx5tgVpU0BvU2rJaCQtwcQ6KDxlVKoC0JuXYEQz2JLlNnkcpICwlNTpw
	 +CE06zhdTc+bEbn51gUokJ+7UluncU65OMotuRGkeYKTYRtKpGBhPhuC2jE2haDJAOkL0
	 i15HPVkgKw2EEGiaQHuQ3/Wpn6MqqjDVwU9YfIGaB/xj1u5Lv3YMcpU9AM9qcP9awww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mSbu638b;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AECC606A31B
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 22:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AECC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mSbu638b
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5eac319a6c2so24702e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 14:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793744365; x=1794349165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/Vgnr8BURVMoHU9P6jtOpg63n4tzG/2LMOYbtlQPkeE=;
        b=mSbu638bTWKYu3nTgVjkd/vYntTjfKXweGSPACjxZMoQuyTElDNSHQrGHIwy08+tie
         dgZY6IV+l/mnJHSmfpDbu/55w0Y5nMdwmFrWTmef0BqgDOuuf2sVN7kYbouWVDtvPC7p
         5TjIpLHWH0PlwGP+RRpghaxxfpUDjKdCdWZS4ziE7Z5c39p0YGnWS05r0UZPuCTGj2GL
         I58o3e6JHw+XOFSXPQa2/Hfuky/KzQqMg8gl1DJUBLLtwYsOjwK2EBsPM3NWrRg8WPjO
         vfKm+4wYGVo8GXmjDIkbxpmMH+zeDFsY0MJw/IkRTTn3UYb3nrxcXk1AaYWA7Zzy0wEA
         D+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793744365; x=1794349165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/Vgnr8BURVMoHU9P6jtOpg63n4tzG/2LMOYbtlQPkeE=;
        b=dJfYQvkWsJWpk6BvFVcpWcMGbZxm0QT3ZkNFjHYzSeeu4qt0oT5H7/cZAG524O4LoB
         8q6nBDQz+M5A+Ww4FMwTP7+Zqdun6H+FnhZCdneRwpAY6hfTaMYOE7fu+TcYyuXYl/Ys
         gfrnOxnLNPC/2TIsAt1ysI153vixrYBjOBkzO/rB4FVmywZmf2PhYWpJFRjmM4His7tp
         m5B+xfjUcmgsCIWi3l2srR+8nLkQO6u52zvndLiDdQb0lffgOiRUt0jiahtQoEdMuCMb
         g39TmfPteRzafTT5TE1WUVfP55ek9ADqkAVf2w8X7uMHLOmtP7bd1hr76d/+iZB3mqFQ
         CxSQ==
X-Gm-Message-State: APuU4Z9eHLDUqeMe50W0ZxDn15EtzPGvyOHbcdbFcRw6KkQoRAUs86MF
	0V/WvDu34CS48Kp+94iLhID57nc2cUeuSjKeTbhYNTzl7r8M5LRpV3lDOvH3Wg==
X-Gm-Gg: AYBFou2Ne/AwL+ZU8IilY34IWM/Tfinw+VfYYUY8Y4jpyS0UYKGpd8au9c76GMBhm/F
	5k0KXZu8q8kdCxigzsxilguDAWkG84sva16XtyaKaZIV+lABgJgSHXHbp4CNLVZmwYTCYbl78QO
	8NoCy3ojC1FunmyVDDm06y8o3dfe7IXUF0ACtuYxxn9d7piy+2ITCMDZ65DayR6pKUNjWHBpsVx
	6aYlhqZ3l+U8dDKWzFjVG9tnk1cdwJGOGJtHhasUpFrwvmgAVt0Ev5TBKEcOr+czaYGQF/jXflU
	zvj+9G6iG1LopkFJKL1MHtIZQM4MI06frrZJfyCMqaLRgroHfc3m1e8FgbXUjtQs+abG1ULmfpJ
	KEYci/G0iFrOrLKvzcnjgjyXPs8kbOgYxsbBLNrg3SSYjfQg0OwBCxCH0ZULPI5FJxn3vQ3RBf8
	bUtH8h1KHIrSnJRv87lCm4PVBVyqE1MvUMUzOg4tQiXB0r/a+Tx4zJopvUeo/4ImfAq5vJhOqAg
	D1zPwgJFCNq78amKaI7FEdY2sF3vkvWpAOgnAfQK05cJMw5LdvX9VUUmImNCdkqLao0Jkj87qlf
	NE8G50oYJ4T/BU8+N7eQ3cR0Jiyj4iApq45N9Q1E4k6rRWps207dX0zxMGXuBCelw2dhFdqnGef
	H7F4PB/ME9jTCswpKbiWkZBxHyecLVWjPAUFzurapJKVNMo4QdpddfTbQ75UTRHoqqAfhCBzN2i
	ajWYCy+0eDYNo6LNsEfM5iEtkT
X-Received: by 2002:a05:6102:442c:b0:7d0:6cf3:d8f3 with SMTP id ada2fe7eead31-7d0726cdc38mr6365915137.18.1793744365510;
        Tue, 03 Nov 2026 14:19:25 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fef4ed3sm306572137.11.2026.11.03.14.19.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:19:24 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1 0/6] Bluetooth: Add support for HDT and EKS
Date: Tue,  3 Nov 2026 17:19:15 -0500
Message-ID: <20261103221921.4071765-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103221921.4071765-1-luiz.dentz@gmail.com>
References: <20261103221921.4071765-1-luiz.dentz@gmail.com>
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

This adds support for High Data Throughput (HDT) and Encryption Key
Schedule (EKS), introduced in Bluetooth Core 7.0:

 - The LE HDT PHY and its rates, selectable with BT_PHY on ACL and with
   BT_ISO_QOS on CIS and BIS, using the v2 versions of the data length,
   CIG parameters and BIG creation commands and events.
 - struct bt_iso_qos_v2, which adds the rates to the ISO QoS.
 - LE Enable Encryption v2, Encryption Change v3 and Encryption Key
   Refresh Complete v2, which carry the MIC length and whether the key
   schedule is in use.
 - MIC length requirements for L2CAP, set with BT_SECURITY, rejecting LE
   Credit Based and Enhanced Credit Based connections with MIC Length
   Too Short when the link uses a shorter MIC.
 - LE Set HDT Default Parameters, with the MIC length, packet format and
   rates configurable through the MGMT system configuration TLVs.
 - EKS opportunistic encryption, which encrypts a link without pairing
   when both devices support it, configurable through MGMT as well.

The userspace changes are posted to linux-bluetooth as:

  [PATCH BlueZ v1 0/9] Add support for HDT and EKS

which add the btmon decoding, the emulator support (btdev implements a
7.0 controller with HDT and EKS, now the default for btvirt) and the
tests covering this series.

Test coverage, using the BlueZ series above with test-runner:

 - l2cap-tester: 141/141, including 30 HDT tests covering each HDT rate,
   MIC Length Too Short and MIC length downgrade on re-encryption.
 - iso-tester: 209/209, including 68 HDT tests covering CIS and BIS on
   each HDT rate and the default MIC length.
 - mgmt-tester: 522/522, including the HDT setting, the HDT default
   parameters and EKS opportunistic encryption system configuration.
 - smp-tester: 8/8.
 - BlueZ make check-functional: 53 passed, 1 skipped, with btvirt
   emulating 7.0 controllers, which covers pairing alongside EKS
   opportunistic encryption.

Luiz Augusto von Dentz (6):
  Bluetooth: Add initial support for HDT PHY
  Bluetooth: ISO: Add new QoS v2 adding rate field
  Bluetooth: Add initial support for EKS
  Bluetooth: L2CAP: Add MIC length validation for HDT PHY
  Bluetooth: Add HCI_OP_LE_SET_HDT_DEFAULT_PARAMS support
  Bluetooth: Add EKS Opportunistic Encryption support

 include/net/bluetooth/bluetooth.h |  65 +++-
 include/net/bluetooth/hci.h       | 217 +++++++++++-
 include/net/bluetooth/hci_core.h  |  60 +++-
 include/net/bluetooth/hci_sync.h  |   9 +-
 include/net/bluetooth/l2cap.h     |   2 +
 include/net/bluetooth/mgmt.h      |   1 +
 net/bluetooth/hci_conn.c          | 241 +++++++------
 net/bluetooth/hci_core.c          |   4 +
 net/bluetooth/hci_event.c         | 535 ++++++++++++++++++++++++----
 net/bluetooth/hci_sync.c          | 569 +++++++++++++++++++++++++++++-
 net/bluetooth/iso.c               | 136 ++++++-
 net/bluetooth/l2cap_core.c        |  54 ++-
 net/bluetooth/l2cap_sock.c        |   6 +-
 net/bluetooth/mgmt.c              |   6 +
 net/bluetooth/mgmt_config.c       |  49 +++
 net/bluetooth/smp.c               |  30 +-
 net/bluetooth/smp.h               |   2 +
 17 files changed, 1762 insertions(+), 224 deletions(-)

-- 
2.56.0

