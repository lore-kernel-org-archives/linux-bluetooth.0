Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6373E1E492D
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 May 2026 10:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778497144; cv=none; b=h0dXe0FjH2d1hbUW/AKUooqLMaeEd7aUT4Rfcre9iin3dYdQ8YDptKxZ2L3tlfZhqzJyv8g16oV8GRvkaY+Ch9XIbPODPj6xM90EYir2LPDxYXXzdLP1pIoJjk3TpKf5gJtV9J5VKISOxp12LJkLTDEMm7x+4ZD31huGUvVYvt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778497144; c=relaxed/simple;
	bh=6zaXh1lX5LzcACZ0ormuWBOqzw8Wo5KNf2k8G1sZYjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tq1VYy3J0WI61jeDJKX2XGg5ilDyjc1nNVysmua5DuZjkvb9HiVddG4xuauPo9Lj8BxMux6fQw6uME2ynl2X4+ueFloOUq0C9p663f1jGfUbsoaqGzC0P+A9L7ZcWe0WlFlkrmLWJhQtC4o7JASWg4gveGHPD5ldZcSSJof5npU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QkdO3nTE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QkdO3nTE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1778497141;
	bh=6zaXh1lX5LzcACZ0ormuWBOqzw8Wo5KNf2k8G1sZYjM=;
	h=From:To:Cc:Subject:Date:From;
	b=QkdO3nTEYrPcXVFidwK2E5GPCy30L0VrcBXqULsUwk3q+GbL1UdIoriu33nkWWDwC
	 3v6McAKkYRQ7KsVjFegUlFG/Lk0bMo/G4CZg1jWzWj6aVRwHtBjZ7ABdU63E7gyVlq
	 5ky+Uu4BHAbGGj3E2Q08syg3UFc06a+CQydrelU0XmGQNs+P3I1WSg1p+BWsOcT09f
	 JGAlVU/RYBFxJ6TNPwwrUN/6bMChLIm1BY4QyNse0H6Zyqf0Mmt4Xq6vr/MTj1NfNX
	 4eKqRd5zSof1/xfs4eQsS8oPJ9f3ST81brfQa+Po2g2hi+HAocmsFoSr2XbObT50lM
	 0NSz7NyU8lr1Q==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E343917E131F;
	Mon, 11 May 2026 12:59:00 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghu447 <raghavendra.rao@collabora.com>
Subject: [PATCH BlueZ 0/1] /bap: Handle CIS loss during streaming
Date: Mon, 11 May 2026 16:28:44 +0530
Message-ID: <20260511105845.8008-1-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch sets the QOS state when CIS is lost during the streaming.

This is used to pass the PTS tests BAP/USR/SCC/BV-167-C abd BV-168-C.

raghu447 (1):
  bap: set QOS state when CIS is lost while the state is
    streaming/enabling

 src/shared/bap.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

-- 
2.43.0

