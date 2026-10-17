Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9D83B14DB;
	Sat, 17 Oct 2026 03:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206831; cv=none; b=eUYe+6PxzhCcjI30F76opqfqGKCBdB2+QsNnNCqVgOMC7WNo3oTB4+mFnS5VoItloxKXzZyF7KHvejbKbYU9LIImwtBMqtOx/cmQLZ2yF/XTV3NzDrnNo/cF8cJ2Dsl8d6PWZUucnsEYkHbaJKPeCAvhjMiuNtZyri4bBelf1AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206831; c=relaxed/simple;
	bh=0BH7DtBp6Fx86oNNHE8W5eJqa0CmKXZSEknhY/9f07w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BG1XbPimwq3j5KehGfwPnEOJbNojoFiiK1XmVF58kax6M8tZwg0IoH3PHNNxt8Zp72rFqkUNAWOJrvfsCQoSiy4A5b6huz/7px0Lo8DGE9EmboPL1VJUfjchLMtDkr9kYLLaS/FdyI4jdXYGu9fzU1jF/h6tKMGSLCKa3vu6ylg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QdD/Zu05; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QdD/Zu05"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=lX
	4dkiVavZcvxdT2klFqCDXhHzFe36qw65OF/MgHQi8=; b=QdD/Zu05Q86yt1LpOV
	4paioiqn37nG8ObZq5NeUQ5+4zlMta1bLWxGjrIF5dTYPWPueLKB4HTTL+DwTdRO
	YQZHbs5HShnWnb6/xSpkeq7OIJuW4LD4ySn7Xcmk+SbAB/qw1kol1qK9CSjeNe0P
	DrB8kLXFziTNE0EIbxgXA39lg=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDXv9ji59Jq_IJ4AQ--.25473S2;
	Sat, 17 Oct 2026 11:13:38 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 0/2] Bluetooth: fix command-sync cancellation leaks
Date: Sat, 17 Oct 2026 11:13:20 +0800
Message-Id: <20261017031322.3618900-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXv9ji59Jq_IJ4AQ--.25473S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw47tw1fAw4kuFWUWF4UJwb_yoWxKrbE93
	ykur95Jr40kayDW3WYyF4rArW7C3yF9F1xJFn0grZFg3y5Arn8Xry8Xr4vga1fXF4UGanI
	vwn8Ja4rKan29jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiM5d7UUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzgKBu2rS5+LMBAAA3D

Command-sync cancellation releases the queue entry but relies on its
destroy callback to release callback data. Two Bluetooth paths leave
heap-backed callback data without an owner when their queued work is
cancelled.

The first patch releases an unlisted management pending command on
cancellation. The second adds ownership-aware cancellation cleanup for
an MSFT address filter that has already been detached from its tracking
list.

Jiale Yao (2):
  Bluetooth: MGMT: free remove monitor command on cancel
  Bluetooth: msft: free detached address filter on cancel

 net/bluetooth/mgmt.c |  4 +++-
 net/bluetooth/msft.c | 12 +++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

-- 
2.34.1

