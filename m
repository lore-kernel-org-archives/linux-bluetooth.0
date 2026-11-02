Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623679;
	b=K6PcbO78cG7o9MPTvEmmwhqSSQc+RA6WLLjj6UHbZqqxQXxhWepWw3RwhfFcg898FUb3
	 9Zu7MjtPELnE2WxdTMNE5zJ1euUkBuX/XLwH4gMaA5djPmSw75lG8JOHJlLbOtwJPlL/M
	 S/L0QB3Hc70D5KTL/zKCU7tgDvt/UKsNx2b0OIStKhgvxM+gpIgAnLRnDNrRqK9RDOAwk
	 Xfv3o1e4s8aNvZCbvX30hR15gpnNds94Wf8Kld+sWYhMHAeusC74r4tvDRTgyXEownxqF
	 5Yd7jk70QgV/Nt29jfVVsNx+KLCVxvTDNLrW+8U8I9fQP41Igq5LUDgHI5abyaIl8zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623679;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zqoWqaP8cnZQxZpPL5UVASrgtfs6Kly9E6CJOTM41tU=;
	b=t0SgvsshcmKofmf1iGPsTMKH/kt+c4JVHmh0cY8YoicDcc0fQWlikaDR80PsrMr3ZlOB
	 8xmvADq4LSghcEoWdmf3icve+L8WiGxmKt/+T2wNP8o/hjPavjRuZllL9ZYrSkJoSoDv0
	 XTx9Tq0KhKnPOMRSlNxxe5OEyXbwdU4q53Y49LqLe3g7hUkglF0LKzDTxNv4L+g8/fd6F
	 Ou6x7WhRf8IrTIfrDSvBr2qIS12l16eubHlF5+WLV2aF/emmBuaFAevS3GxINqDG6tRto
	 0Asy/CFnH3/DbKfGEUBBYmhmiwkuBKJAjHadet9x1cm3Xj3aI4jUKOW5wR8A7hWTcQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rw0n5fK4;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE3D606A338
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Nov 2026 12:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AE3D606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rw0n5fK4
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a05effaf8dso1640260b3a.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 02 Nov 2026 04:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793623678; x=1794228478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zqoWqaP8cnZQxZpPL5UVASrgtfs6Kly9E6CJOTM41tU=;
        b=rw0n5fK4MnaD3IQJIzm+vgfsJelHJJy6+EQ1mLdsTyeE7nAx35qWOOW/mWoj6tYKjs
         +8yF4uneyKymfwNOiZDic3km4qFPavWLlhB9ZyBa+Y2qjQ4fttIyZPm6nW6mOIVQjd1g
         KyvI3W220e2TeBv9Jt0ZKs9KW8psJhnbvUhlbsbIt8dyCiYfUZMxlHsoVvBNxV8Z2Ihk
         YXms1PI6KfpFETKzXDT3JONi4ocbKLoZLl59qNggXiCn4NO6Qax6NWQuoteytEqRSI77
         X4kD5MVZ+mK9jHTkczscbYPnvxfck5NX9BbdmyHR0KnYFnkZkuVx2IHPK4voN0KGy6Jw
         n6Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623678; x=1794228478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zqoWqaP8cnZQxZpPL5UVASrgtfs6Kly9E6CJOTM41tU=;
        b=l9otWFb1nJhydkNkHDU/DcBBnWN99XqeY82WnC60zekG8eJjW1n0vlcdjGItPSG4Hj
         cqQy0aHg1qNrPqAeaPob5SNIcsPgovyr4Ud6hi1S/vvdXuHBLAl6DLMq/Zl/ALxhDY7V
         E8y//Es6fbNKSOz7o4sJRyg01GTTq/na+wq47ymByR+yJnIx3MfJFIbq7/dLOnyY+iNk
         VM5uatvyIS5FkX796YPv4ylBZfrh3SuvvcysE5sHJoPKbTizIxPl18P8fXqj340M+YRa
         kzvMzDtLdf5HPZjlh6zd/I2NzXB1uEvjUSixlpXaB+hUT6CS8ys+qvrUynHAVOLIESJd
         RepA==
X-Forwarded-Encrypted: i=1; AKwUvBzIFoOrK/J0MiFcJj1eEuO3axFjyG/PTdJbWnwiSf98UYhRlgUrI7jmox45lgeoJ80noy5k8l1w1kEjPl80C2s=@vger.kernel.org
X-Gm-Message-State: AFq9FYIrwjhTu82H4sKg7ypU8OWkrj0Kr+H5c134h9vTJAW1J8WlZP2O
	m9rH3D44LpGQG6bmER5g3BgyO90ede9fnHpkgDUKS2aFHtm3PVZbV30+
X-Gm-Gg: AYBFou26LE48/DUpj830/7c1e/xM9deykArQ6wrOZwk1/CxuXMieOO2IdiLHPg6whrv
	2HQ855B6zYwlXBilxMJSDOSCVpTaLlYooPBT3YpEpyExuybETTQ4dbW1tm9V4TB3i1rtrASEgyM
	DsLIZv8JO3qGN6y4CzPV4GUfrItQ0WwIvkN4Hgd/7aEygSfHsC71BcoqzSAjv8yacZPkALj5QAx
	kEtcjdWrb3maCdbZl6Be5vkZKyag9Kxy99ejBoIVzDJGoWi0dxy+GUwZt5Tk8OE0NkAEQAOaaCy
	ToSE/+qbhBgTZPbWL8MCX+ndrZvumItcucoz/Ysh5lQY7UBGdWYumz2Z4WfwylNlhkMNlRHSC4/
	iml/KatVf7THr3yTibtz817Nca0eVHeNAvbca3wOlUXEQCJiMI7WkvYa8iTqIyR309rHXLdxQ0I
	4JKneOXvBuDGa4581WAe/gj4uihZ7RYWI8EhCBnzqu/1BZ4JqpOUa33MwAImBFcWbe3Fpqu2V6/
	Zd2HaCy0TlVe2Bp6txybYznC6VU1FsNX9xzuHHGiOx3kWHGTHUPLLgzsi2zpzL104xDgeX83mMA
	J7JCDFCSypdaYhO24x4CfDQ04o1en3/xt0IQm7+NxyhgLlXf9Q1NjsPNq0Wuyq3k2Nqm
X-Received: by 2002:a05:6a20:a126:b0:3e1:c1a4:91f6 with SMTP id adf61e73a8af0-3e928c5c937mr9229349637.13.1793623677157;
        Mon, 02 Nov 2026 04:47:57 -0800 (PST)
Received: from KRHW1CJW23.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aad77fda1asm1908357b3a.6.2026.11.02.04.47.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Nov 2026 04:47:56 -0800 (PST)
From: Zhao Li <enderaoelyther@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Johan Hedberg <johan.hedberg@intel.com>,
	security@kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: L2CAP: Match LE responses to outstanding requests
Date: Mon,  2 Nov 2026 20:47:33 +0800
Message-ID: <20261102124735.23199-1-enderaoelyther@gmail.com>
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

An LE peer that can reach a local L2CAP listener can use unsolicited
responses or Command Rejects to bypass deferred setup, remove an
established channel, or leak an unaccepted socket and channel.
Authentication requirements depend on the listener's security setting;
whether a default configuration exposes such a listener has not been
checked.

Patch 1 requires an outstanding request of the matching kind before a
response or reject can change a channel. It also completes socket
cleanup when a reconfigure failure or reject arrives after local close.
Patch 2 clears incoming identifiers once their responses have been
sent, so a later ECRED request that reuses one no longer matches the old
channel. Patch 1 is the security fix; patch 2 is separable.

Patch 1 extends the BR/EDR lookup from commit a518b9a9ef6e ("Bluetooth:
L2CAP: Only accept connection responses to outstanding requests"). Its
stable tags request 5.7 and newer with that prerequisite or an equivalent
backport. Older LE-only trees need an adapted backport without the ECRED
hunks.

AI assistance was used.

GCC 12.2 and Clang 19.1.7 builds passed at W=1, including full x86_64
module linking after each patch. GCC also compiled the Bluetooth code
built-in on x86_64 and as modules on i386. Sparse reported no diagnostic;
Smatch retained its one pre-existing diagnostic. Coccinelle 1.3's
use_after_iter rule found nothing in the changed functions; five
unchanged parser gaps also occur in the base.

QEMU/vhci testing with patch 1 alone kept all 445 established channels
alive. In 40-pair close-before runs, failed reconfigure responses and
Command Rejects each destroyed about 40 sockets with the fix and only
boot-noise sockets on the base. The success path destroyed the same
number on both. A 1200-pair base run retained gross Slab memory after
listener close while the fixed arms released it.

With patch 2, new ECRED requests that reused the identifier of a
closing LE channel completed instead of being refused; partially
accepted groups were not tested. A KCSAN kernel with both patches
reported no data races in the close-before runs.

Hardware validation has not been run. Patch 1 does not apply to stable
branches as is; adapted backports of both patches compiled at W=1 and
linked as modules on the seven supported lines, and were not tested.

Zhao Li (2):
  Bluetooth: L2CAP: Only accept LE responses to outstanding requests
  Bluetooth: L2CAP: Clear request identifiers on incoming LE connections

 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 87 ++++++++++++++++++-----------------
 2 files changed, 45 insertions(+), 43 deletions(-)


base-commit: 6b4b543fa18757297ac756a6fe6e64f506b7844a
-- 
2.56.0

