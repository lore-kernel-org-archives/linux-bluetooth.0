Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC8D27F005
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 14:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773757641; cv=none; b=PgMssT+WYrkekvUfHMX1LtzKAG/xBKqxFM0RiElm04R8Krb+B6BfG+0lsKGtgnrp212M4FA0vOQk6+g3QH/tJPBsXv691trblCqcl6bCkns4vczqobIahrOdF8sGygIKEcJFj3KLtxGZd5Z90mnWL9ciZLXFks6C5yz9d03Mk+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773757641; c=relaxed/simple;
	bh=jWxwnDYJ5hnKKXsMZi/BxZqnBTUL+0TEqrZTeIbZads=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TSdBDwUmA2PVbvdRZ7Y/NLyzHoIksLftLHm1cta/nAdRQ4RcESYxLBCdkeZHbjQu7GRmxhXU8Zpxzp0NZz1c6VkOauNYUc8zjhr/AdN4UYPBlOmn+ZtCGgSqHGYieNkIA4+P+Q1ISc4gD4fKoiQZdulHX12XrTErr/OWQEbHurA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SMMQGjJu; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SMMQGjJu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1773757638;
	bh=jWxwnDYJ5hnKKXsMZi/BxZqnBTUL+0TEqrZTeIbZads=;
	h=From:To:Cc:Subject:Date:From;
	b=SMMQGjJuDSj9KuWk3NMFHswqqCYLepZe/3lE4LOp0G//xOCm/OZ6S5j7Oadcmq5cV
	 C6apsKNtAGu13toJnxEXvAikmOFYE6svMUUF3OwxS3MnJG4yNvf9JZD2Rr8kT/y1Tl
	 B5N/64ZVHBO23+qJZo8KAg6x3qW/DzRg2Fl9Ly83KQ+zhQcFAB3PXIIvISWX6N3IlI
	 FFapSCMNBM+HdxZBD1bQySGOXCMGbsmVtrIwp/mRPH+6xl074dzu3RQsytl8Y61Dv3
	 oegV1S9B67RYxgK/WvvaBgqbo2/UWT1mXYUJwXXBonlKuBOwwm9lEPvCG8ss/RZbNS
	 1LH5HZb3Nod8w==
Received: from fedora.localdomain (unknown [49.37.150.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7083C17E0E3F;
	Tue, 17 Mar 2026 15:27:17 +0100 (CET)
From: raghava447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghava447 <raghavendra.rao@collabora.com>
Subject: [PATCH BlueZ 0/1] client: add public-broadcast advertise helper
Date: Tue, 17 Mar 2026 19:56:44 +0530
Message-ID: <20260317142645.6332-1-raghavendra.rao@collabora.com>
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

