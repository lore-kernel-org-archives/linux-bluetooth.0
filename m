Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52621A6836
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 06:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777443068; cv=none; b=Kvk4497ftEZW5j8UVOpy6DU2oxcdhnYTScklxNx6h8qPoZA7AEsKzOUExUc09PkgbgUlHFBx49W5YoSErey5ca6jEWqb7tntkzm1uUFjHSoWYsCDrKoh6cwsmXxenC9WxRnAY7DXGTromzAJNGS77y45iwzkIHy2e07C2igBdHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777443068; c=relaxed/simple;
	bh=LOpTxFZkwYODx1QbOxQJgwpn9DiNcSuAdTT7A68U5rA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ffwpKO34skVRy/cFRlgZifQvXzO4KcBus0XeH6g0114WlYL1IHvy4ao3LU/JdZCYRsSKjdwWDJX8B/e12Ct+u5oj6PYsO2YYuuP7vmfHWYNoXUqZ22t4m5WjUwr5MEwezSe0RJjS7TBprT2d7I1nRXQRGQqXU3a6Li0t7ow2yT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FgIugLhe; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FgIugLhe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1777443065;
	bh=LOpTxFZkwYODx1QbOxQJgwpn9DiNcSuAdTT7A68U5rA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FgIugLheVAinnrdDDfCRF8nelvQcydhNatHlbVwD7SzFQhK8RVZujn/fBN7bL8oi2
	 w0Cb/sBXbjkTlSD01jzuFgUheuqAPJo4Cq7LnLOyEbSz7xw1aQSkeKlegqtya2RuZP
	 xKpXzHH4pxz6rgcftIkeKteiuXocrw3/rtHQsq6y+RHZ3hTaQoJDbNDOaF6D6ip97S
	 zqiBMYOl7ak1t8fMxp9wDBMpehmkB/yqJqQvUtIsxOe92BJ3YOVeZhuBA4UL5FbSo3
	 jUoKw6FMZnu58HTwEWhHDLBUL2hahr/dj+HIdu1oKGj/aPl7HALRLAdd7qOZ1KQva9
	 11KFLV8+ZA4rQ==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 356F617E1502;
	Wed, 29 Apr 2026 08:11:04 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghu447 <raghavendra.rao@collabora.com>
Subject: [PATCH BlueZ v4 0/2] client: Add public broadcast advertising support
Date: Wed, 29 Apr 2026 11:40:43 +0530
Message-ID: <20260429061045.9115-1-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428144008.7487-2-raghavendra.rao@collabora.com>
References: <20260428144008.7487-2-raghavendra.rao@collabora.com>
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
Public Broadcast Name using AD type 0x30. Outside public broadcast mode,
the existing LocalName behavior is preserved.

raghavendra (2):
  client: add public-broadcast advertising command
  client: make advertise.name use public broadcast name

 client/advertising.c | 148 +++++++++++++++++++++++++++++++++++++++++++
 client/advertising.h |   2 +
 client/main.c        |  19 ++++++
 3 files changed, 169 insertions(+)

-- 
2.43.0

