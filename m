Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC60F24A07C
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 07:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777448783; cv=none; b=C8fJC7n4BlicfUB1rzahbNqVsZ4yEpuuHEq2dcGbojuclkO2fk2f+5EmdRLx+R9Y8PJD2y0TtlQGzu3dFl+p5iBhnnZC48JzDiWBAcbTC1TSRS8fgB1Ppge0PnLzGJYmmfV0udnnXV0z6WkzjPtzNapyXeFTm/iO+ZWNM6nEA48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777448783; c=relaxed/simple;
	bh=19+XXzZMRTUsfzBnN9HP483iBK7MRNoMKbdvJ8uKIwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hu1lOM9sxsLy+xbDkCBn3z3QH2Lblj0q//8xVwo1mtFbmvzGCloKcWg+PWanZu9naiYtSj1D22IvTNdwBtId5UdiHmuihOyui7uIh9WvmAlJMY1azxqpqRYDyQk4a0OrW00/rCOU/yWddJtYnSnM2nZkHGqjGM+3MeUy1/Y1STI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Whe4B+re; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Whe4B+re"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1777448780;
	bh=19+XXzZMRTUsfzBnN9HP483iBK7MRNoMKbdvJ8uKIwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Whe4B+rejwVcHDaQDDbJ8GD8TcNJs1x02Gjhh61/ySLtvcZ+nTc5HKZtsUMiMmrwl
	 4eHuaxWF+swAuiXHdPN2H28giNhbxgEwVaWb1hF9pOWXctSPy9x5wQintZlkaXU7iT
	 ELHZR2hd9ElxRyje33cEsYW46ewnPsAQwyxqiD1kWkbNfDCcfrH39X4cZfxI9cZ5Kl
	 +99LJJnXb9JJeHBZKq3KUKr8hwBVS5XCxNysB75eSKcfKeHxzKUU13yjqgqPhQUyW4
	 2XnfaRiRN47eu+rBGV6KuwwrIl6z9QOPArmu1HRq9WLmMPS1B5x7BdE3/Jv7poI3iZ
	 Y/NFQvOsWZ66A==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5DAC717E1313;
	Wed, 29 Apr 2026 09:46:19 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghu447 <raghavendra.rao@collabora.com>
Subject: [PATCH BlueZ v5 0/2] client: Add public broadcast advertising support
Date: Wed, 29 Apr 2026 13:16:03 +0530
Message-ID: <20260429074605.11774-1-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429061045.9115-2-raghavendra.rao@collabora.com>
References: <20260429061045.9115-2-raghavendra.rao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds bluetoothctl support for staging Public Broadcast
Announcement advertising data used during LE Audio public broadcast
qualification.

Patch 1 adds a public-broadcast command to the advertise submenu. The
command stages Public Broadcast Announcement ServiceData using UUID
0x1856 and supports SQ and HQ presets.

Patch 2 makes advertise.name broadcast-aware. When Public Broadcast
Announcement ServiceData is staged, advertise.name sets and gets the
Public Broadcast Name using AD type 0x30.

raghavendra (2):
  client: add public-broadcast advertising command
  client: make advertise.name use public broadcast name

 client/advertising.c | 148 +++++++++++++++++++++++++++++++++++++++++++
 client/advertising.h |   2 +
 client/main.c        |  19 ++++++
 3 files changed, 169 insertions(+)

-- 
2.43.0

