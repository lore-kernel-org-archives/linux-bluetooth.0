Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB382225405
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 07:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748330380; cv=none; b=Pjqjf3/q8dQeqFBDpGDxjAVlv8sK4/vB2mQZ2uXl98cJ6aUU/rUrv6O0MZFrK/cIDu+Znu79weixZrVhRFS2wyhd5m2Ax7Q9oCuKVLRdJC31mUDFaDlPEfc6qpiIhxNYYxphZt4iWR1sVLjiVdC+pB9XYUmTPDcuRwv5z6aTvYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748330380; c=relaxed/simple;
	bh=AR/T8zyfLZcNbn8kDZtHkSY5X5ZeJ3B7iA0dfL682Ys=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dVWeaWbrHApkrfd6DmWyac77MpAZ82su5NWMJYcyh5hp7lAt8pkH5+hef4MgTVQydlQnW42Cz+3DWj28h+tNFCgt1Bkx5QFDdnkz+nZCMji/vgR9xfX73UTzKG35ADXKSZGhlWNvokSValjJonW/Q9Glv+FR+3DW/Vys075acto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iAiWjg2R; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iAiWjg2R"
Received: from github.com (hubbernetes-node-2c15ae4.ash1-iad.github.net [10.56.15.15])
	by smtp.github.com (Postfix) with ESMTPA id CBDDB6008FB
	for <linux-bluetooth@vger.kernel.org>; Tue, 27 May 2025 00:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748330377;
	bh=E9c/NpRg2v8ePyGaXGie5MZj/KNJlLnCOoFHVTXHYGo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iAiWjg2RwxUhPQxFb0pMnQEddUjUAJlflZGUSdBf2ckGvZswyMXxEpI/e8CLo0LLi
	 yDuOeoyJtqNLAsmEgDKGDQt+KNJ2gcF7IsokpG6dzuQos8fC0nsdO0YeKSHsdeDwfG
	 qL3E7LTVXHcoZYqLbxPuK0EyWjHmBtAXcRGiv0mo=
Date: Tue, 27 May 2025 00:19:37 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/966564/000000-98406f@github.com>
Subject: [bluez/bluez] 98406f: shared/gatt-db: Add read offset to record the
 prog...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/966564
  Home:   https://github.com/bluez/bluez
  Commit: 98406fa1a492d5cfef73ff6ade5a39105b4cba1f
      https://github.com/bluez/bluez/commit/98406fa1a492d5cfef73ff6ade5a39105b4cba1f
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-05-27 (Tue, 27 May 2025)

  Changed paths:
    M src/shared/gatt-db.c

  Log Message:
  -----------
  shared/gatt-db: Add read offset to record the progress of att read blob request

When processing the att read blob request packet sent
by the mobile phone, Bluez ignores the offset and the
payload of each att read blob response is the same.

This patch add read offset to record the progress of
att read blob request.

Fixes: https://github.com/bluez/bluez/issues/1294

Signed-off-by: Ye He <ye.he@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
