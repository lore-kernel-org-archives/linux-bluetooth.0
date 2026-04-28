Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A2A38B15F
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777387238; cv=none; b=qp4avp7oLnhy4bcshRNmVpkmE4j1sQfq00cyUbZW90eFC5itYojJYy4Ihs2zOlU9LGuXnFZ68m57zBgJDxELuUsq+IubQHUB27i+oqA7TuSy1ZnA5e/sSAGaAfx+phj6cnpei/n8uhQCxleDpATjeBxQc3grZz57SgbkfAA7MbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777387238; c=relaxed/simple;
	bh=tTu7r0CiZM1o/rgKcbVQrmJiuPihV8QUuKsKvZFszYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sPURD+6c4I9UdI30KPVg3MGZnwAwO/vk4ZFCTwsp+RJfNig9MrB1aic4BmTRva12Wz8gYuN62Bs3x8EbemPUptHf2wjIWcHRqETRTobEq4HbBu+RUVbF50odHGM8YIIyZK9QYK5Z4MvMDBpoEXGUe+SqrzADLQm5S0OKgRs81rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JwGdGxDA; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JwGdGxDA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1777387235;
	bh=tTu7r0CiZM1o/rgKcbVQrmJiuPihV8QUuKsKvZFszYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JwGdGxDAt1v43+3Ife66Z+8J5ziJE1Vd+JzXRqfatbx9lsOquZpwwquZuqtoqEnXI
	 Xq51JYbVYqxZOqNf4WX4zv3UrxukIaCdg5WSsd5esHfk163x8xXbbxwo3VLRVdiuD6
	 DJ7uGv8ysfj4zA0aWwlTe7S4ZDKKU0OoQBOOFRchwnOn93aM4qgSzCXAN06r7EH4NW
	 ZsreZXM3//1AMMfzE4QVUZ8qfOiSTU8E4WiB8JES29aV/isO9B+PIKo0cfkVu2xcsg
	 mIcvC2icQAULfMySnyToGJ3E23vhO6BCJjxCn0siGRcNgvWPFBI1GCxYXJYko3K+dK
	 Furu49GU1GMMg==
Received: from raghavendra-XPS-13-7390.. (unknown [100.64.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2294517E128F;
	Tue, 28 Apr 2026 16:40:33 +0200 (CEST)
From: raghu447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghu447 <raghavendra.rao@collabora.com>
Subject: [PATCH BlueZ v3 0/2] client: Add public broadcast advertising support
Date: Tue, 28 Apr 2026 20:10:06 +0530
Message-ID: <20260428144008.7487-1-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424141831.9172-3-raghavendra.rao@collabora.com>
References: <20260424141831.9172-3-raghavendra.rao@collabora.com>
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

 client/advertising.c | 147 +++++++++++++++++++++++++++++++++++++++++++
 client/advertising.h |   2 +
 client/main.c        |  19 ++++++
 3 files changed, 168 insertions(+)

-- 
2.43.0

