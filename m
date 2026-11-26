Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795679760;
	b=Ul8vVnaAs6/OBADQTf06MDmhIeZDtkDd1jeIU9jyv/p0c8xu35uXG3o14qffqaFS+1nA
	 buhutYzGSvH8vypbJbYIHOOUSvAa/V5hWbDmKMwvxW8BsOSoxWtCBVPbBMP+8LD76Vjcp
	 gFnM7phIcjK84Y7F01eQutVl45rzHctmGhucK4fcQBgt+iWHbUs0sJJXQnw2U5Lmsz/L3
	 CsLId2QsR9E24/i7kiNCsr/HHhxEIesc6omiElh2FGF8AwbK99VLX6t0q3uipbDI1W67q
	 fKuMGVonVo+Qfity82hg4Dg0s4zjCgVUKP2ksNWJQgXT3WOEBVV77cDJP3t1ZNc6GQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795679760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=crXowXqxLPttCCSWDd6acmRioxTezv7WhIgrsEki5Js=;
	b=FtEbx6mEczwKk2PjZHy1eHY6qNW5O7p2gZhe0it/R60a3FYdr6DgkztICcZYtTSauBEy
	 NGAPutb1Y6A/uFeGghJGBBpLNla1lCl9/dtNoFyvDNZQN3d/QDuqhx7FW8LMtPQbP5OXC
	 w6Ky+xrOjIDNt08+P3RH2KLhn48lgZ6e8OxH5dixnl4tPmEbynW5dX/WqTc3de3HEuTNo
	 TAi+bvzw0DQzezrB+qXLt+E3CIvuonp3dmzbhbKkSKnALimDTEpL+BsE+cMXGpFYEZ9Fn
	 mTU8Prnp2kFCfC+ia/GelTz2SFAg0Ndpo2ZC83HsqBk+qQ1smmYObZWPk/p33/eqjMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zY+l7WzD;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E413606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 07:56:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E413606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zY+l7WzD
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3b40a522c00so775473a91.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 23:56:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795679759; x=1796284559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=crXowXqxLPttCCSWDd6acmRioxTezv7WhIgrsEki5Js=;
        b=zY+l7WzD5y5mzETCJxz11WJCxbTXZDWG3udmbzxJzLUdjioJkIhkRQyIQv/+E1VPSq
         BqXFqve1CzY3fH43KkKfYEAaKk8NISHzXLZYNpP5CnOiCMQsrqxFBaI/ETWPAUv4lHhz
         ResksybXRFO0H/dNmBpDOjXEMCP/Cn+tOW4oVhRrgLaOP0gbFL2i6YYnPvUGY6UjKGhR
         1C25cccW9uIlB+Xl6SQaWOOCGWQpA3KQNzioZmefBmjzdzkOsZJMRqtOyrmxfyLwNqlT
         4YJGmAkHOuYK1HmK2MqmwNz5TYWfCV4DDbmC8o2iS11PmItMT+X58n4YDAEyLDO2uatt
         cxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795679759; x=1796284559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=crXowXqxLPttCCSWDd6acmRioxTezv7WhIgrsEki5Js=;
        b=dxatlgj0dBZl73+2+LDR7yC38yxaewWN8yY6V02vziEcNveE7XTuJz4A6bjKhkpOQi
         C8+R4ojW1URfT+NJ6ZIRlkTk/w6DyiuBJMukOPHEO605NzsNXz1gW1k5qbY7ihuDCBjQ
         OZe2Pdf6KnI6wyavA+OtbDQkcx6cEcR82VSr+DSYohj1GmmxGUfo9hfwNubTAdrefqy1
         rCYQsTJWhwdI70zeWrFwAXWYtNKISeXpaL8Gl9aPmu3AHc+RekP4cvSll9sx48DKYiGx
         vLREB/qNCFfv5MgSHPmmVc0YMaKmO0Sb/ZQsSxm+/U1lNWUiJpRCJkupKfe1235wb6up
         teqQ==
X-Forwarded-Encrypted: i=1; AL+hErGgoWDLQgTmpZdxGinPpzdstECgBqu6olbNVBFNlIjGU13V/6MuvttivVpFLBwJ7F9+BYjD2oW8nqLEIXb/C28=@vger.kernel.org
X-Gm-Message-State: APuU4Z8t/C1t4k6iDOUpixOZpuiU1e6+TxFTaZm+SYpKJhRNJZzglikS
	lkDuh6rCa4UBwMpD3jJcU6TF1FyK2g1CnP+nQxCM4ox1CnF5ri4y/cIP
X-Gm-Gg: AZFdTZeuEHm+5esNhjr6b/glqRupLyf9DH7fNEvdaIZkKV082OflMZGsiEW9ijq4Vkf
	cfjHqNQY600w6A1OiKxv174BBKUryJocR74siOmcBP4kLClvOIPKW60ypEW9e6WdDAYW2YIzDN0
	7/jNlsnf107cp4sAtsa95J5hu7bktcFo90qUN2M6DnS2icfKXaq4J68aCbbHaP/qdFNYkgUqpJr
	M8Q00lB1Hml2KXYfMNHLXSdc8KKckwd6D4oMybzJlDG5cZfH3TGhDC0/VNYUHv1zA66yotb4o9+
	6sGVd84bUyJgCAxlxjv1m3mdDWrSipLispLMu/dZNmp0BeCVq6kNJK0ysrjToJSykpT2IkgIOVC
	NXg4iHx4H6MD/OMZceyfeQTfGk7GywOlW9sOv/YZ1nZEvIsVFjiLe/iRz9IISWd1kl/fmUOWwQ1
	rXC4QaRCu9vISzhMv4nKVxHUv6I7uiBwTl8IlyGZz+YjGNKTvMioaXA0mGvhnpZbSflLFDMHqGL
	jmFBn8eVsr/GsJYTwSfYMVEE6Bf825ygHJsIWH1w/atXUpZ5xmFJ8yX+l3ARExemgZag+Q9htR5
	cqE1N1B7LZCxiw16uE34wVE22V6g8jM1Z+HaB57YV1lqukQ8LQ==
X-Received: by 2002:a17:90b:17cd:b0:3b4:9d6:5be1 with SMTP id 98e67ed59e1d1-3b41c93b187mr31884782a91.4.1795679759440;
        Wed, 25 Nov 2026 23:55:59 -0800 (PST)
Received: from security.datascience.hku.hk ([175.159.181.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6d03adafsm10690855a12.23.2026.11.25.23.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 23:55:59 -0800 (PST)
From: Yu Junzhe <junzheyu1@gmail.com>
To: stable@vger.kernel.org
Cc: Yu Junzhe <junzheyu1@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 0/3] Bluetooth: hci_core: lookup hci_conn on the RX path
Date: Thu, 26 Nov 2026 07:55:51 +0000
Message-ID: <20261126075554.106-1-junzheyu1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026-11-19-1-daily-reply-0012@kernel.org>
References: <20261118123533.25-1-junzheyu1@gmail.com> <20261119035758.45-1-junzheyu1@gmail.com> <2026-11-19-1-daily-reply-0012@kernel.org>
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

Sasha, this replaces the 6.6-only v2.

79a2d4678ba9 ("Bluetooth: hci_core: lookup hci_conn on RX path on
protocol side") is in v6.18 and is already in bluetooth.git. These
diffs are for the stable trees that still lack it. They do not apply
to bluetooth.git HEAD, so the BlueZ CI apply check will fail. Please
review them for the stable branches.

6.12.y already has l2cap_conn_hold_unless_zero() and
iso_conn_hold_unless_zero(). 6.6.y and 6.1.y have the L2CAP helper
only. sco_conn has no kref on any of the three, so SCO is unchanged.
hci_conn_get() does not pin sco_conn.

Booted KASAN guests, same racer (patch-test/repro.c):

- 6.12.119 unpatched printed slab-use-after-free in l2cap_recv_acldata.
  6.12.119 with patch 1/3 finished 371 connect/auth/disconnect rounds
  and printed no KASAN report. The racer exercises ACL, not ISO.
- 6.6.162 with patch 2/3 finished 123 rounds and printed no KASAN
  report. That image is a build of this diff. The earlier #1 image
  still contained the v1 SCO and ISO edits.
- 6.1.193 with patch 3/3 booted and completed one connection with no
  KASAN report. The racer then lost sync with the virtual controller
  (unexpected command-complete length), so it did not repeat the
  6.12 and 6.6 stress.

Yu Junzhe (3):
  Bluetooth: hci_core: lookup hci_conn on the ACL and ISO RX paths
  Bluetooth: hci_core: lookup hci_conn on the ACL RX path
  Bluetooth: hci_core: lookup hci_conn on the ACL RX path

 6.12.y: 4 files changed, 66 insertions(+), 47 deletions(-)
 6.6.y:  3 files changed, 28 insertions(+), 23 deletions(-)
 6.1.y:  3 files changed, 32 insertions(+), 25 deletions(-)

-- 
2.53.0
