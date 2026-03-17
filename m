Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CF531A7F6
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 05:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773727187; cv=none; b=gRoK8sgqOXe6qWpV1MMmQa6vqBvFbv9ifIPvGbwl6n4x9drWfyzCq0ia2QotfPOoBfxhr3IRunjmzdHsAsFVQBxGJOXuz9hh3I9OERTw+udpLfgs4poMcs+BiPWcfokxWp+WErPHmrJjSFPUzDPtSpyhQZLxJEj8q3fY0thyHW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773727187; c=relaxed/simple;
	bh=jWxwnDYJ5hnKKXsMZi/BxZqnBTUL+0TEqrZTeIbZads=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gnQW06WIbRzjYDEFztjhMZgCaNq94rw/8YSumv7jzTej5BTXP9VkkudaXH7Kt+Y2k+dq1M9mKV3ThalAGooUgX6OQ7REU6NvwzHGPuJAlrAUafsLiLWj2OceNJdxwBpvv3G+HRKUhPrcYGNWExk8Fnk9qqQ2swLHWUrUl9x/gUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UlNDWLGy; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UlNDWLGy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1773727184;
	bh=jWxwnDYJ5hnKKXsMZi/BxZqnBTUL+0TEqrZTeIbZads=;
	h=From:To:Cc:Subject:Date:From;
	b=UlNDWLGyRPzQd65B+ZwX957pSReqnL3q4QuhjZ/Cuwy/MU0lKD5Vf0T+0IslGsSKJ
	 aeH6RmuetXS+ZoZM/+YsUbj1Ezv5G3Y8ELZBZGpWWAQHBgPahSJ8NP2k9FdmOMhPfr
	 ozOMAvstU/pID2fkILXRrkVb7USe9N7Su8UYC7NmouiiC7qAI4OWSRVCCTNcj+3Acm
	 n2FE0LEThBc0+DdeYjXtMvcM1GSY/3dtfzIfgPgftyiDRcVdbgk4Z/la+87qKCBwVA
	 YD/tbfgSqcABgqKCSdcDt91tzN5m8Yxow3PbEEEU1moD3T1VdPUNZdpLPOaVJn8oD6
	 dmDo3AGPD0e1A==
Received: from fedora.localdomain (unknown [152.57.158.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1AB9617E0FA3;
	Tue, 17 Mar 2026 06:59:42 +0100 (CET)
From: raghava447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghava447 <raghavendra.rao@collabora.com>
Subject: [PATCH BlueZ 0/1] client: add public-broadcast advertise helper
Date: Tue, 17 Mar 2026 11:28:54 +0530
Message-ID: <20260317055855.4096-1-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a bluetoothctl advertise helper for BLE Audio
public broadcast profile advertising.

This series adds a semantic helper:
  public-broadcast sq
  public-broadcast hq

This matches with current commands:
  service 0x1856 0x02 0x00
  service 0x1856 0x04 0x00

raghava447 (1):
  client: Add public-broadcast profile advertise command

 client/advertising.c | 70 ++++++++++++++++++++++++++++++++++++++++++++
 client/advertising.h |  2 ++
 client/main.c        | 19 ++++++++++++
 3 files changed, 91 insertions(+)

-- 
2.53.0

