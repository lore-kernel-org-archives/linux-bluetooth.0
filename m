Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793990033;
	b=slqEwCmSt54lU+UYVJhvy4wnN7ok8IA8hSiyGUkA6HEcC00mL40KA/GJk2qL4RRPzt17
	 YIs0MYBl1ihVhh3vo1yEeQBvM3Hd1MduYcx9aUAMnKOCwKJfaLQL3YDO/Ppb0CyaCGygD
	 WWKPnUxubiK/RGbyID9GscMwkxABPPemX+wdcigQDQTKFbnRLAP5hTIsop69MqZd46HcC
	 5phy993+1EwzVu0yZxubfXU/KgmYg+GqPMxL3a+cw/G13Um/OEZXtZQK2JStbkgML9uE1
	 hftcpCjRiY5hhvLb+RYAS7hROr1M/0qskjDEpqhO/+srIgPvUdSLrPgOkNjxOW2L2vQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793990033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=OjTTS8+KUCwzC/+5g/vdn+uP6UxkXzN3KZCxC7nSrIg=;
	b=aegsMbENXo9M6Zz9DL8cw91D3h1Afg9adV1pVhyt4XtrHgalfM7V5EXiqZ4AT2pFVT80
	 t4aNAy1CZglbr6idFqIc3gzmx/qt/2rMholBo27wYULScsxynlOLC2SOKKNAP5e4vveJX
	 35QZ1xPJTIaTA3cy2d12wgtogxUxrKSOA1y1mGNrMLOMWcgMnFeJZgbE7adTpqZ0+FdTp
	 cvUqLYJ9ZONB2PFTdvYNkHj8uh7sJxPWZgCcrPGx7lQHmlzZJBxNw4Gq5LhFp4LGuc9lc
	 6R/3ePnRzXFBCAJQNgxl4CliV2byg3lY9jnldg0g1TyPF31ckmCOsmhNc3NQCmV+VCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bt+UXmAU;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49FA606A326
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 18:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D49FA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bt+UXmAU
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5eadf48fb2dso411524e0c.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 Nov 2026 10:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793990032; x=1794594832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OjTTS8+KUCwzC/+5g/vdn+uP6UxkXzN3KZCxC7nSrIg=;
        b=bt+UXmAU+84QxfkMFNV7xish718tsuK/jtvTXSyfPdFGqJdj07XaL7X8cstxMTdsq+
         6GRIzLtO/UHWBcjvVNH3HeK71hw3AvzIXpldNnb0TXV/AKDt2LulQVRCFS3ZbZa6FwCS
         gvOfhrJEiVKbkXxNfhphcO8NiH0ZO48csU+lyOSamOxswTFBUovtzWxcrZ15YBEsMmnP
         tCEkGiMhXUGNFrXgkBQWRAqLtWgzP8xVZooU/dL+pPprq8inziuz9vIov6lpiVUBKBSb
         I+Wdz4UvwFJKEj+LQ4dkYwMvOhAA+VG0BYbjmzMnnEIXEcV0zhblph25saPxt633CmTf
         kLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793990032; x=1794594832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=OjTTS8+KUCwzC/+5g/vdn+uP6UxkXzN3KZCxC7nSrIg=;
        b=CIPBYza/c0nV1mE+c6TU3WzO6HBTKVyFge18/WXVM24MK4zYb978Db3RMzL86FeRzH
         dbse+OF6hS/DgbPkG8jSSOf1CWONoCnWGV9M2FbLMeOvrmt7IAcEDwcyNs4OTxG8HM+B
         QBm1lh1cfEG9wxMo7ys+fqSZXv1+HdSgdxjGcrXCjMULaRJphHyhqnSxblTacEa64DcR
         GwXLTZZqWRmP2yMb9NIzYfpxgA9V9rNVn5LnJ+qNPHpm438rcW9UgDE877gHW+JAgwOu
         A5hLX0FjoDkGhrhTYhQqBH4Ez8ME7no/cohNOZfVbWQabV4LC3/yK2xgz18IEBKMDit4
         mhsA==
X-Gm-Message-State: APuU4Z+zEWwdmRt71hLv+Q2Jq4Oum7wd6cotTijPOLCSYaOhOcPpqhr3
	FUxTzr/U1FdqkdTF90K2pYZHIs3bZgbUWaA3o5ixdbYPWlYmnmfINq+wgLUTIA==
X-Gm-Gg: AYBFou0vaoYINlOZOYk3zqC/mVO8ttPQ1I8V9vUDpW7KXuH2oE7ZNbs/wTtRAKXFYNj
	dClfkaEjoAHn8JiKbZp63VSux0e8JYIzEIpP6eF7WnSg8CNKmBWZNCeI4GKhepVH5yKIRvccXHt
	Gmn0jUczWAFA4zzgOq6cJcewgGK5D9IoFCTSuNu+xhAB23AvmwGoMqQnsE8SEjKYFWr3ivVNwos
	+FfAx/gLqH1Pis5iECQwzEkTGdVvwE/BApkmRWMdU6UbMcvNA2sVW2pThqVNQGHyTSx6bQMxItX
	vpuhy8O5gK+ZAuk1tKSPvgNgJLyjf4FDWLxd9Pf+3HhFucGuGUyNQG3WuDyP+uA9aB0lb0qp2dQ
	SkMwe2k40i9xHD9lpK8NyuSBiD3cYtIF9q2SR5mc18tnrSZ8/uTKTtpJWi289odUU22PhvuaT0W
	GA/I9BPr6LDd1lwAtMLjLz1F9VvzvOQrhicwkjOWL3PrIqLvLbFcxOAvwlNU17xasv2+AHR6Zk6
	uf0jTLVcudLABEJImf4cVahyNussh7EjC10BK4llIbEBaT2G14Eme/kageBXdsy7Fj1523br+u4
	Fdpm2Xc8AsS3Xq4g+0WT73jK0mYQJlROgCYBUvEv6C5dyzDhbz9cypg+18ECl0GCWTYjN9flM9n
	x5HFfUx8l5h5W7XgXLiaMfkOFOLXdFiMqikxA+n0iEqdGYmpw+M5znu/8L3hlK8taQcp7+3jD0G
	5waSM=
X-Received: by 2002:a05:6122:4688:b0:5ea:d649:d1bc with SMTP id 71dfb90a1353d-5ecc441b2a2mr1822158e0c.18.1793990031717;
        Fri, 06 Nov 2026 10:33:51 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ecc64a6774sm1910173e0c.3.2026.11.06.10.33.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:33:51 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 0/8] Fix handling of malformed GATT PDUs
Date: Fri,  6 Nov 2026 13:33:42 -0500
Message-ID: <20261106183350.3155282-1-luiz.dentz@gmail.com>
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

This fixes several places where GATT PDUs received from the peer are
used without proper validation:

 - Read By Type responses with an invalid Attribute Data Length could
   cause a division by zero and out-of-bounds reads during discovery.
 - Notifications and indications shorter than a handle wrapped the
   value length to 65534, passing data past the received buffer to the
   registered handlers.
 - Read Multiple Variable Length opcodes were missing from the ATT
   tables, so the server never responded to the request, and the
   client response parser did not advance past each value.
 - Database Hash and Extended Properties values were read without
   checking their length.

The Read By Type, notification and Read Multiple Variable Length fixes
come with unit tests reproducing the problem.

v2:
 - Fix use-after-free when a callback cancels a Read Multiple Variable
   Length request while its values are being dispatched, and add a test
   for it.

Luiz Augusto von Dentz (8):
  shared/gatt: Validate Read By Type responses
  unit/test-gatt: Add malformed Read By Type response tests
  shared/gatt-client: Fix handling of short notifications
  unit/test-gatt: Add short notification test
  shared/att: Add Read Multiple Variable Length opcodes
  shared/gatt-client: Fix parsing Read Multiple Variable Length response
  shared/gatt-client: Check value lengths before reading them
  unit/test-gatt: Add Read Multiple Variable Length tests

 src/shared/att.c          |   3 +
 src/shared/gatt-client.c  |  30 +++-
 src/shared/gatt-helpers.c |   7 +-
 unit/test-gatt.c          | 307 +++++++++++++++++++++++++++++++++++++-
 4 files changed, 333 insertions(+), 14 deletions(-)

-- 
2.56.0

