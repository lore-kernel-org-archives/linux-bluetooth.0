Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA4E1B1421
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 17:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445673; cv=none; b=gyqTDgvBclItzEfHKSHPLNhVq+7xLVwuJMtHSC/srNS+Ma2xZSanzdQaTh4IDkBmiGIwvjIJXamQ98bUgjG3jZWzQoQfwZOV26gGbniH0WZyPtcdSgByokFKPJX6PSeLvlS3o3nVEY7v06ZQ7laaC8wIh53aseIAIqxz1cHzIoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445673; c=relaxed/simple;
	bh=CreNGhCwzMRt0ou+nW++w3N0OMnKkudWeY6MVf2bvXk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=nPP7UPsMfNh6jAiAN9+n8IDY8pnMp6yutz3RGOhvVbczYnbvB0QvO+PxBSOQgRQPwjITspfzpqqnR3zfc2p2e4NiUFxiI5Ty1aBIhJBMSOKCfcesJzzN4l8Gg19TuIjBeC9SZgz8DlulQBwed2jM+HITVBzll4X8EBy0Cxax4rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aEhNHHCb; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aEhNHHCb"
Received: from github.com (hubbernetes-node-0ac6ab5.ash1-iad.github.net [10.56.146.23])
	by smtp.github.com (Postfix) with ESMTPA id 6ABB46003BC
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 10:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1722445671;
	bh=WkSqIsTxjWICJhZnHHYPCR5LJVf4giiqbOO+jOcjv6A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aEhNHHCbUJGLiIBpc+1sIztcvNw4vV+HKVVk77mK3rvlVW3U6IG6h2/+ZcrZtb6mD
	 pDQI37djqsK4HAmfRbbmiDZBKKUd8vTNbUb7nA2Ki5ipCydfetue1WgLOn4EJ7Lz7W
	 oYb2SxgVrj4cLhCowqA39ZnAv/tGJVm4cSJY8kyA=
Date: Wed, 31 Jul 2024 10:07:51 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/fcf391-549d38@github.com>
Subject: [bluez/bluez] 549d38: client/player: Fix not setting config
 target_laten...
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
  Commit: 549d38852f665d8251b2c0c0e8c9f3d5574ac99b
      https://github.com/bluez/bluez/commit/549d38852f665d8251b2c0c0e8c9f3d5574ac99b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-07-29 (Mon, 29 Jul 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Fix not setting config target_latency with edpoint.config

This fixes not setting target_latency with endpoint.config command.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
