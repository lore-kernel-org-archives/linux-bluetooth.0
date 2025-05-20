Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471162528E0
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 21:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747775369; cv=none; b=Dyo/lLQ2ZNpxTCb2fBEtjOpjPdDnlX6k0bVDe+29aXHolx5w8PRLhLMTZfvVF6HZx3uQqgoqVo1TTPZACz05ZXYx2eCAV5XxPBxRMLX9MSnHWNRvFgcVLIKjrCiOzA1jMwFtt9ms0a6n4bTVn+FxpBJPrtvfK3QU6kLVMl6ayVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747775369; c=relaxed/simple;
	bh=zvSnqvh0Sbjzw8Dl4Tt45APz/YNEB5H3KRjdzDvuEf8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=apfsEw08u4FPpDDPMuMA4HC255LAi5e2J1nhkWQaoyzneDxqHktaOfj42z/yKiIZEpQ8eTMFFAhRhl9L5D4y1NOx8nbTJf4SigcsjWu6jifDurxG68HBuDakaMoc8EVie04zGzGvnRnX0kqEveR2k8xliNNVGCY1IBcgmhhwUv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PG0ejG2x; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PG0ejG2x"
Received: from github.com (hubbernetes-node-87e6ac9.ash1-iad.github.net [10.56.154.24])
	by smtp.github.com (Postfix) with ESMTPA id 4B696601113
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 14:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747775367;
	bh=gGtMuQBAXKD3fCfM57IhDD21cBKrv2W2yYzaoan8JzQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PG0ejG2xhaz1yOAfFHQjgVb0CgMQzMdQ5txf0s3pYYp8Ih/OLLd1DrPxBDzs7DQHM
	 JJtlc/u6tM25SpWHqXZu3E3EZd9M5n3HUZ7r3XO6GDtxQyTZcBs0vTr+NpuUFql6Ao
	 Bz8ov88AFZ0wV0kzUIntd0VEc9zk9SSJlRs2TEdU=
Date: Tue, 20 May 2025 14:09:27 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/6a8fb8-f39b3e@github.com>
Subject: [bluez/bluez] 940717: org.bluez.Device: Add last-used option to
 Preferre...
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 940717e9fad451349d012ecdd121e59d5ac33e45
      https://github.com/bluez/bluez/commit/940717e9fad451349d012ecdd121e59d5ac33e45
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-19 (Mon, 19 May 2025)

  Changed paths:
    M doc/org.bluez.Device.rst
    M doc/settings-storage.txt

  Log Message:
  -----------
  org.bluez.Device: Add last-used option to PreferredBearer

This adds last-used option to PreferredBearer which when set would
make Connect to use the last used bearer first.


  Commit: f39b3ec12e8f7cdb999d88d6e76fb798620789b6
      https://github.com/bluez/bluez/commit/f39b3ec12e8f7cdb999d88d6e76fb798620789b6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-19 (Mon, 19 May 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Implement PreferredBearer=last-used

This implementas PreferredBearer=last-use which enables Device.Connect
to use last used bearer first.

Fixes: https://github.com/bluez/bluez/issues/986


Compare: https://github.com/bluez/bluez/compare/6a8fb8a00e53...f39b3ec12e8f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
