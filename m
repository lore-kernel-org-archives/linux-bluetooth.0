Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE5B3DA7C2
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777040328; cv=none; b=OLPtUYIBEUuaffai9/QFkLMd2EqwTDFAgADsaTgT1PPU9bj4gB+fG4LXVaZsGP6/eeX2w9ZBOeW604H/pmUTy5I02J+pnE8b7UuktNzXLfwEGLgXFR3gY5FW/mIYuBclN4ciCPnAk4evDT47kJgOnhrEAydOnfAZFo8MZsOEKbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777040328; c=relaxed/simple;
	bh=YGag3SogmVa7pOumI7viSl8uVxQexADQfEXKVgC+ljM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I7dhWrxvVJZ/vPilPZOTgoWinKRTE1wXSVGlRvbtF7PNrWtSM0O99JyJlYxoaFAJpQfU+8sZd70TAz87Im33dIdBuHzLRrAwiT4e9jpTqDFvlYjyaz2UzpSwxLk4h0Z2nQqVxzumvgMjCCO/9EccgEfPmkEIJMKSJvETFlJ56RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kYFUGzfV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kYFUGzfV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1777040325;
	bh=YGag3SogmVa7pOumI7viSl8uVxQexADQfEXKVgC+ljM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kYFUGzfV1YxkuIkzJnDoBSTkfAvYALp3acrihDYZb0XbwyATX+J9zf2UswULxV7Ip
	 v/BP/MURgaGusyvWBs9V3Pj01xrPv3fusuwt4kHPNxPyMWVnPXJduz81tOyQ3wBmk2
	 Y6rD/nLQjjvfP6sxpNnMAhHU/Ie0smBWuz2kcjopXJRTWehmwQmvSWVnrwE7LnQmaU
	 3agOChhWErwdPBctZKMKfswQ8ubFE7yiJ4jgBpUi5gFFlw5CagO+F2BlYKDXvep7/W
	 xV6FwJl40CSQojjxOXwIMKgq4jK32yeWPGDD37jZTtcTQWc8mlP+I2tXfeoDpJxNDw
	 9cjQgIvKEJLBw==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C185317E107E;
	Fri, 24 Apr 2026 16:18:44 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghavendra <raghavendra.rao@collabora.com>
Subject: [PATCH BlueZ v2 0/2] client: Add public broadcast advertising support
Date: Fri, 24 Apr 2026 19:48:29 +0530
Message-ID: <20260424141831.9172-1-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317142645.6332-1-raghavendra.rao@collabora.com>
References: <20260317142645.6332-1-raghavendra.rao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: raghavendra <raghavendra.rao@collabora.com>

This series adds support for staging Public Broadcast
Announcement advertising data used during LE Audio public broadcast
qualification.

Patch 1 adds a public-broadcast command to the advertise submenu. The
command stages Public Broadcast Announcement ServiceData using UUID
0x1856 and supports SQ and HQ presets.

Patch 2 makes advertise.name broadcast-aware. When Public Broadcast
Announcement ServiceData is staged, advertise.name sets and gets the
Public Broadcast Name using AD type 0x30. Outside public broadcast mode,
the existing LocalName behavior is preserved.

raghavendra (2):
  client: add public-broadcast advertising command
  client: make advertise.name use public broadcast name

 client/advertising.c | 145 +++++++++++++++++++++++++++++++++++++++++++
 client/advertising.h |   2 +
 client/main.c        |  19 ++++++
 3 files changed, 166 insertions(+)

-- 
2.53.0

