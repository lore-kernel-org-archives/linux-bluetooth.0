Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795072436;
	b=oOzSHWNDksZwv5TQDvL/SwERvhqO6JrOpvrl2aRmTrPOa4BfweJVipFGdGHPUPxzNTRN
	 QVVaj9Grrsh3MVaaoDXsxj6cOn2lB4IZUvw9NhI4XN+ICd7t130fSTPR9HxdPA/lVTxW4
	 qrbRfg+BzmLxJbIKSJPOCGZUomWFSHfmtDmogyEYo42HGW7Erz0WR2tGoVE5F13G7gUbF
	 Dnp/+/V43AT0pqunfIQ5C136uu77q5pVwSuZMwjcH0VbCyiOiT9c5sFJraXFcl8rSkXN+
	 bb9G2FB1aS30eVmu/9Nin0OryUzuOvh934a824sDJTdxno+ZM9VchrLiUNGKNeELAuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795072436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=k4UhT5Jq8Y8M39+o9mbaLIDjF2zv9aikpB62F4omhag=;
	b=cjq3gVndN+MAVDTdbXWn8JCC5JXdkfr3qmTXlZdF3/LF2GslS5/ubhnW39EvTifO734B
	 7cKGVY2rIwXe1RRB4YuQSaE56rFN0p6pPxNX7NPtnugxpDDE/JD6bw6Jj6MIcGuQ4m4Ia
	 6ICjF6ygxnun/Efv2Z0Swru2QJlRdgxXaLEPO784tEaSSg80FHrOVM60zbvYzufsUpdvt
	 D0xdtaDZ0hcWixU+h8Gald1NmEcgojirNGHFKc9evmGYV+O5wpbpT4lz8L22w9qRgABnu
	 q/KvNKnx1HiNl0tnTA9Qmo9kgzwDa0tkTZNS01HBMs9j/nSGkCJ9/uT8VGtvA2qX4BQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0GLPnCnV;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7970F606A320
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 07:13:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7970F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0GLPnCnV
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a56e05568aso3464745e9.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 23:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795072435; x=1795677235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=k4UhT5Jq8Y8M39+o9mbaLIDjF2zv9aikpB62F4omhag=;
        b=0GLPnCnVuxTdLulFsMYthAQAmKfQGZQHrVU05B0ACvQQ9QEZEtE2BG1+oMODH9tLLS
         loKw+3sf3pBQF6mMd8IM68718asbD0o01sedg4dC7ulCvxFo4dBjv4dMXx3HHZ+/sYF+
         uErOSIrtpbA1oVLY1qXPzktkE9vg1EaxINpOxDGJaSxhAEwzzZ1+e6ZZi7H3LSldHTqO
         h2jHIKu3bbzIocXpiwZ3s6jTx2ghxIk4ifc9eM3x6ZkKlnv98UV2jOXbMmnQ4k//Wt3v
         +Q0ykLJrBGulRKQKYthyVpZK4/mFGM64yMLYNf/7sHz90DIXbbHVnzB4Yj9WgDAweEvj
         bPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795072435; x=1795677235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k4UhT5Jq8Y8M39+o9mbaLIDjF2zv9aikpB62F4omhag=;
        b=A4y5q9Hjf9UMUc/b8wJ/UUKdhvP963hwERrSH+u9P6NtCDMXO739y3tWcp6jFJWsyp
         PmvcfTKugR2pQ9uyT9ipsGjRYk6qORj5KoCmGfsoNKrBeNL94+Zha+k0UG3ErWRbPmTa
         Dm27nXtkfawtSGXzA1Lah8TFzWoNafk4Dv1GS/vOvbfGENVCl73cSvyB1ggrJu4A+mJh
         z04t0DhAVnC32V5aYZ72WwQMvONScS4HqOWWl6qUhjriL8XQtH/f6SG1KCoXbls/FJ9J
         rYsKGjX/xro8gjNyEHdZD88Huhb3+e7poNF/wlC1+Pn92sT5pC9CQFHQO4eCFc9EsDBY
         ke+Q==
X-Gm-Message-State: APuU4Z9Zsccj5rbonwghMcVeLayfA/UDPDg+6wwBslgsD4cqBQ+oJQHF
	+Q0vLx9LD53kFQTpyIviILInhsrGqtneat59GcZ5s6Bfg/uKtWLgkQSRxdiln08G
X-Gm-Gg: AYBFou27TLp4bWeg7Y8bmKDe2rmC/MxyOg6TVb/U+qOfJ0mQP8BE8KryhUC7Yqd2cvX
	4A36Cf+XW0KTqO5/D3h4IAvzf5ma9iZkVLyu6mNpwMd2ezmcDGGmOS92HOWxTM8cwwBoEUfY5S6
	2gUiPwqqevkbzzuaw+arVXD3Jxh/5aU+yCZNES34z/AWypnhE8VJ/121/0MWQ67HeSGUjA6F3n9
	zk+j9qTSSRFlJHMt9W7OLZXW6qnmKSauKehTpajMW4Kk8SNnvMOBDNmAXUutYmNRp3nxRxRnUgn
	yIQEgZnNZIoOSOx3IuGjlm+KVXApUZhaj2rDEbd8q2oIuzd12K4Tu5qcbOvc76r7jmefZnxOuTJ
	QkNqrNI2zVtg2gEd+ZXaiNVyB/pjpd77iidVvIMq3kxyNi2UWemJNld01pHCVbGG4duttkEvLUZ
	miF20JWIQmEzxWSWw3P5/u/3J6LDUw1uwZTQITUr4a0S0iAPMv07lLH+Q4BFxj8ViQob0Fdm4t6
	YiffvHNHqD8GZBrRG3P6oTkCphWp3C+6HFZLMwA2FnOu33ZfHkFukvXlESi7wEUv4/GSZWzNICq
	QaNBib9Rz1devTKFqRVM+iL/LZxB4L9dx9JS
X-Received: by 2002:a05:600c:190c:b0:4bb:7ad9:2f22 with SMTP id 5b1f17b1804b1-4bb7d57ccf5mr94693155e9.0.1795072434624;
        Wed, 18 Nov 2026 23:13:54 -0800 (PST)
Received: from schinder.corp.hoffmann-group.com ([2003:8:2:4::5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb85343607sm17549165e9.6.2026.11.18.23.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 23:13:54 -0800 (PST)
From: Roland Schober <rolandschober1968@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Roland Schober <rolandschober1968@gmail.com>
Subject: [PATCH BlueZ v2 0/6] monitor: Decode Periodic Advertising with Responses
Date: Thu, 19 Nov 2026 08:13:26 +0100
Message-ID: <20261119071332.32424-1-rolandschober1968@gmail.com>
X-Mailer: git-send-email 2.47.3
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

This series teaches btmon the HCI commands and events of Periodic
Advertising with Responses (PAwR, Bluetooth 5.4). Until now they were
only listed by name in the opcode table and the events were printed as
unknown.

It is meant as the first step towards supporting the PAwR advertiser
role in the kernel and in BlueZ, which is what an access point of the
Electronic Shelf Label profile needs: being able to read the traces
comes before changing anything else.

Patches 1 to 3 fix existing decoders found on the way:
 - the Connection_Handle returned by the Periodic Advertising Sync
   Transfer commands and by LE Remove ISO Data Path was read as one
   octet,
 - LE Periodic Advertising Report trusted Data_Length and
   LE Extended Create Connection trusted the number of PHY parameter
   blocks, so truncated packets made them decode octets outside the
   packet.

Patch 4 splits the LE Periodic Advertising Report decoding into
helpers without changing its output, so that patch 6 can share it.

Patch 5 decodes the five commands and patch 6 the six events,
including the [v2] variants of existing events.

Testing: I have no controller with PAwR support at hand yet. The
commands were sent with hcitool to a controller which rejects them, so
that btmon decodes what the host sent, and the events and the
successful command responses were decoded from hand-made btsnoop
traces, well formed and truncated ones. The output for well formed
packets of the existing decoders was compared with the current tree.

v2:
 - Add patches 2 and 3. The two problems Copilot found in v1 were in
   the [v2] decoders, but they came from the [v1] decoders they reuse,
   so they are fixed there.
 - Patch 4 keeps the new Data_Length check in the shared helper.

Roland Schober (6):
  monitor: Fix handle decoding of status_handle_rsp
  monitor: Fix data length of LE PA Report decoding
  monitor: Fix PHY decoding of LE Ext Create Connection
  monitor: Split LE PA Report decoding into helpers
  monitor: Add PAwR HCI commands decoding
  monitor: Add PAwR HCI events decoding

 monitor/analyze.c |   1 +
 monitor/bt.h      | 174 ++++++++++++++++
 monitor/packet.c  | 510 ++++++++++++++++++++++++++++++++++++++++++----
 3 files changed, 646 insertions(+), 39 deletions(-)

-- 
2.47.3

