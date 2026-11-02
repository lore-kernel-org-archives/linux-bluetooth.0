Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793643179;
	b=J7FK0Re9bbkpiGYvRCjrr1FvydQ9Guv0ZcCy3ozuO/2m1Xx17Z//vSkRH7VqHDamLsrc
	 hIpOKRWt/+MNc/Tub7PGypAW1bqHHb8vElk4Uxxckj84x0sVHUfmyq0tGrWki8Qqtladj
	 VIa8ajUqlHVY+YxYoJqHQyB71kUuIgnsn6Ohe8EbYnUpLqtvMTd4WxkWLBx64OmRn+wvR
	 vpWGBCS0f1u9H9On7jl2/IXCwfePKty3L4nJaMNWT/Lunlna6Dp+mOsqndtmA27TVxGs4
	 wIMuA8+hqwPKM4KokX33/19u5DLKSbvqsWsV340Hu7o8KB/EDz7fHfWLqYjusx5YJYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793643179;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=hnpv8xTDUmvgVb6+REDbmUIUIGrSJxR7vr8PBGUlERk=;
	b=kVht1L+36NyaW2MBcnPnkjm4K5WPgjRLt5n7Xkvl6Qu53rmp6vjhNCA+jSTeRq0s10sJ
	 +X/ML2hdkkFwGZjPtaIdGdhvmVmydvpKv1e1dacrD3+EcJCJod0BJWRU0aQjzV94W5s5d
	 a32FCygvB8lVmry1N4DhHvOQ85ODLlm6tL0e0A/9hMUBKPEZKIqh5+aNITj7E8SOof2/h
	 fRj8iKSaWQw38utYMjD7TevXL6iBJMsQ2c3fufwHmrIRjNVyvHB8sfDspZpev0X5cWHHT
	 qO0USeh5hVMNFdvj/Poqf/pGn3waj1gJyo6zyANyN+7CIBD4oT+k4nKT7ByWRqnWY+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GXQDvMJd;
	arc=none smtp.remote-ip=209.85.221.169
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C43606A324
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 18:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45C43606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GXQDvMJd
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5eabf7d5bbeso2681447e0c.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 10:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793643178; x=1794247978; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hnpv8xTDUmvgVb6+REDbmUIUIGrSJxR7vr8PBGUlERk=;
        b=GXQDvMJdWqHLmTtMZ0yjMr/AwFlQ2DA9scqLNAgmJRVD5pWIXTDVbkF7MUVut0WOGt
         lt3gTz0Ql0+/HTZgH8Tv0aIrkJX0DDtVBS8Uyp7VgpVxX8cqR+H15WiE2peR4tWnCFkH
         U+RusI3JYbbgLnw6gwETu43JBbB+y2gRbB/hXFj+Bpn8QIKrS8uLjzcDbWQgddubrHYc
         c+0JuTPiGUrb2tU1oZZzNITfR9zF6vAtmk9/k1RacvU96z9TRvxZsA5SjoUfaqlfJTXR
         G8AsQNAYyUPtCX97QXMjZDWYqBseQ9xARXnMApHTox+MO8blwxZvOszn7mJ/0a1XomEo
         Oq8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793643178; x=1794247978;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hnpv8xTDUmvgVb6+REDbmUIUIGrSJxR7vr8PBGUlERk=;
        b=zVSCPmOUG72amvQ90DkWWSw2XA7GpiT3sQo57SamdD5sDJVHfKYOw64uPWijuFHSZh
         siTWfolsArvCBWuQuN1KiGwnU3fkgUg8ayWfM4M0oOrORFlZ7SFdG/Oc5fdEPxqya525
         RTpCmCQbQNT5+uYLQCSyfyd2FbGo62/k7D7IqZniR0EU4lHO0fNFGxGkLwy/lQyggGEp
         MEEMzCSwcnIZCCl8vnHWLWHXkHMd3lBxF5KzTHzBry0BIUnllARkjh60DmEbUbFA3sLS
         IKCDPRQBAjsZIJarhJeTCKTs0kUsHhC6NWa6TPEoTDnT+lqqtO0YSxl/Mj19Tu7x/vpC
         Op0g==
X-Gm-Message-State: APuU4Z+G1GTEVMHzDnt+bCIOk/D8QXDzySgRKbSNR7tLtFWWbOMTWGER
	+4KMZDPM9UClUB8dDZ3imytz/CLuYICdDbRNHbPfMzw0gL9Nd8k3pKiiCZhfqq/m
X-Gm-Gg: AYBFou2fz94uGy4gkxZErcQbwTzcAdGlEnuxeYQRzZ9sHs5N/83ht+27GTBsqRZuVzy
	ldq/g3+EzZi9l2JZSUbZIRjnTa7Rax1wXeM6UILcuvdo6R/P7JvXLV/BFZ+QcsNhbY/TXZnfZan
	woMqj2eY8bZvJw6xJtgYo+EOIuBzmUKGHs29HvENzCWqV4nUiq7D5RbUbd+Yy/CYPJkEjqOhQB7
	0yeMtjxmURhCKD2wxZBZ1P7tMltHAo+MQcnv1vgq8rwGlqo/hQHNjjtZ+P+zhlhVDFq3t8F5E74
	nY4CQn6eHPelz1q8vPtzipRWSvf8BuRCsnCPjmLxqLJcYftGwas7RSQPa9zNfzQ0C23b+CNnK01
	1etPIsJvEiwkNWsFjLTyb/tKxDdCweES+glUUOGmivw1ny0CGDT/VPcfpYMSB8ELgPmbsbmjflF
	i1uReeW7+RSqJGBo3HbT3XwePOXr+W+q+GJHO3nyUwICPYwe/q3aOOnXZ7FBJQ47Zkm7dqDtAzz
	/VPjprC93as8UuhPb5+QRndLDhpk8ku+rsJyURVDpS0ASpYQPvOPruM1AF/9GMp35oKXcPnAGNL
	5mHPJvIHlZbSPV88QprfLpYi17ggN0ePH18gXXgjDCrC5Fd85vckQcjdNO4QLDrhAfdW8t7TSF0
	wwomnO/V4Gh99+pcv4IAA0boujabTJt86QWnTto5aawPp3zIX118clQ0gLff+Qc8u4OCbLRI0zG
	yKEnLbxg==
X-Received: by 2002:a05:6122:6081:b0:5ea:c6c8:7985 with SMTP id 71dfb90a1353d-5ec6851faaamr4674528e0c.3.1793643178157;
        Mon, 02 Nov 2026 10:12:58 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69bf220esm10300208e0c.7.2026.11.02.10.12.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:12:57 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 0/6] Fix linked transports of an ASE not enabled yet
Date: Mon,  2 Nov 2026 13:12:50 -0500
Message-ID: <20261102181256.2321329-1-luiz.dentz@gmail.com>
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

When acting as an acceptor, a remote initiator may enable only one ASE of
a bidirectional CIS first, e.g. a phone in a voice call enabling the
Source ASE of a headset before its Sink ASE. Once the CIS is established,
the transport of the Sink ASE, still in QoS Configured, was set pending
along with its link, so an audio server would acquire it and either get
NotAuthorized, failing the working link as well, or have it made active
through the link while its ASE is not enabled.

Likewise, once both ASEs were acquired on their own, disabling one of
them set the transport of the other idle and disabled its ASE as well,
stopping the other direction.

The first patches add a functional test reproducing this, using the
Desynchronized property of an initiator in testing mode to enable and
disable each ASE separately, and the last ones fix it by only updating
the state and owner of a link once its ASE is enabled when acting as a
server, and by leaving links acquired on their own, or desynchronized,
alone when a transport is released.

Luiz Augusto von Dentz (6):
  client/scripts: Add bap-duplex-lc3.bt
  doc/functional-bap: Document the duplex unicast test cases
  test: functional: Cover enabling one ASE of a bidirectional CIS
  shared/bap: Add bt_bap_stream_is_client
  transport: Don't set linked transports pending before they are enabled
  transport: Don't disable desynchronized links on release

 client/scripts/bap-duplex-lc3.bt |  41 ++++++++
 doc/functional-bap.rst           | 105 +++++++++++++++++++
 profiles/audio/transport.c       |  95 ++++++++++++++++-
 src/shared/bap.c                 |   8 ++
 src/shared/bap.h                 |   2 +
 test/functional/test_bap.py      | 170 +++++++++++++++++++++++++++++++
 6 files changed, 418 insertions(+), 3 deletions(-)
 create mode 100644 client/scripts/bap-duplex-lc3.bt

-- 
2.56.0

