Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1806C309F1D
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Mar 2026 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773397162; cv=none; b=OpvGGgbkpVsrQFGdKhiBqERqUHg4NsfIHINW2JWkOXzIgAyTTJMCpg2Dm9RVlIoGC05anOOMRTcOJoHx15RB78aclwCtcQbNTjUgNoq2iRpZfjQXMas04AQ6RV5sAgSjUhmLtQ1Nk+aDM5OHozr/CrcSkIEaE1zDk842yyhvlZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773397162; c=relaxed/simple;
	bh=rDlR1R5pHP5D3uldpREn/18L40Lo7uxBXqgYSWAXZGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SiN5dylGyM3l6XT2ag9mi43m9d7TkAioxhIo5SCbMxpFZ+ok2Gd6yuyl38Z/bnk2t0jW0GgVqE1vSEnUtkyepK2aAPeDmHJrNqKDPHYdnTulGtOzhHvLPdlBXLkRbhVcKgUXA07qB7lxzkvRSROzKU3co6ks5//JZVQB1NFYvSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=M36JBmsD; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="M36JBmsD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1773397157;
	bh=rDlR1R5pHP5D3uldpREn/18L40Lo7uxBXqgYSWAXZGc=;
	h=From:To:Cc:Subject:Date:From;
	b=M36JBmsDjfFBRHYUVH67t3pqytOKIHXnQiwAzHKHT9aiY8VfvB327ZQqnLbjHHV3R
	 59WqihKIsZIQbDpHoEjJZgsj4OdrJ1T69SYk3ew2uOFc2p77INOF9WyrX/m9tkW8DD
	 mghYQWdxgo81TYZkV/uLYb5yA5zbzYWYzEFG/ttYXrPlHafIx+WLGLqyjQ9Hpnh7yJ
	 VxWP8Yzc+0lJx9DgAE6/WMKPG3Azsu80XydU44W65V/ohyuJr7g9/eMNOoKhebdXvN
	 UZrR1wNSlyMkMJiT0S++sj/mzNmkiwz4JWUFIJVbori8Z81MxLqPObGauM3nDKmAZy
	 AZsOeN5ShjmKg==
Received: from fedora.localdomain (unknown [49.37.146.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: raghavendra)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1D8F917E026C;
	Fri, 13 Mar 2026 11:19:15 +0100 (CET)
From: raghava447 <raghavendra.rao@collabora.com>
To: linux-bluetooth@vger.kernel.org
Cc: raghava447 <raghavendra.rao@collabora.com>
Subject: [PATCH BlueZ 0/1] client: add bluetoothctl broadcast-name helper
Date: Fri, 13 Mar 2026 15:48:04 +0530
Message-ID: <20260313101805.46784-1-raghavendra.rao@collabora.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds a bluetoothctl advertise helper for BLE Audio
Broadcast Name staging.

The new `broadcast-name <string>` command stages the provided string
through the existing raw advertising Data field using AD type 0x30.

This patch:
- reuses the existing advertisement staging/update flow
- supports multi-word names
- makes sure that the empty input is rejected
- adds the relevant bluetoothctl advertise documentation describing the
  new command.

Testing:
- built client/bluetoothctl
- verified AD type 0x30 staging
- verified multi-word names
- verified empty-string rejection
- verified coexistence with `data 0x30 ...`


raghava447 (1):
  client: add advertise broadcast-name helper

 client/advertising.c           | 52 ++++++++++++++++++++++++++++++++++
 client/advertising.h           |  1 +
 client/main.c                  |  7 +++++
 doc/bluetoothctl-advertise.rst | 18 ++++++++++++
 4 files changed, 78 insertions(+)

-- 
2.52.0

