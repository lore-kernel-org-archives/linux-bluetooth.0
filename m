Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DFB21CC59
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 06:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777443324; cv=none; b=rCH/GcdsIDnJ8t2mt7asgh5dPnp1hYK3dRqab1Sca5uzBh6J2cSFlNEzWs3tMr30o/GXxmA0aFHyfixvkm2gL9qrpNbY743Bl6IhwYgmvZtafRIdKgT+LA9W1CfNBElXvnYAW97ie5s4bV+Kc7pCvJk32x1yZZShVnmiuQ75EsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777443324; c=relaxed/simple;
	bh=81WvFiJCYSdwMSIskVGRz1tUbWRq4vPoLhDk7+1OGNM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WQ+I3ZXqGk+wSav/PwchP9lYYHdBeGMSuWD977myd+Fum9sUdKeTZbvANCFFAp641FYZodzAaHUjlhtTV8nTa1vOiQzIWw1traYhdsG3sTtaXjZndAIjRCh27Xv4T5hUabX7EkFPXwjGmnWRdeq+7EWiAbT5iO/EC7aNWq/uJSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jmDCLRUI; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jmDCLRUI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777443322;
	bh=bTOXOdJHaPigD6FWrVlJaY7j0jWC7U4VZgLGKfyBXJo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jmDCLRUI3/j9WNcLdjiaJyvwgu3eTUb3A1w+gzjNnzUPlETeFy/xEqiBaNTwBf8iI
	 O8nC50Qqt4TVH8/GbkjOGnVL7DxTxOpWGu/7kKA88GSyW5wZn/6yIg15iqKxi70nTS
	 xytQuZSbz2vaQN7atwruFSC0v/HD+jk8pJQaYXjY=
Received: from github.com (hubbernetes-node-8e61edd.ac4-iad.github.net [10.55.94.31])
	by smtp.github.com (Postfix) with ESMTPA id 33EEA2108A
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Apr 2026 23:15:22 -0700 (PDT)
Date: Tue, 28 Apr 2026 23:15:22 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1087242/000000-a3c0f2@github.com>
Subject: [bluez/bluez] 69d9cd: client: add public-broadcast advertising
 command
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

  Branch: refs/heads/1087242
  Home:   https://github.com/bluez/bluez
  Commit: 69d9cdab0db74e7d638cc2103c122fd358048b90
      https://github.com/bluez/bluez/commit/69d9cdab0db74e7d638cc2103c122fd358048b90
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-04-29 (Wed, 29 Apr 2026)

  Changed paths:
    M client/advertising.c
    M client/advertising.h
    M client/main.c

  Log Message:
  -----------
  client: add public-broadcast advertising command


  Commit: a3c0f28d5f298887d7c190e64d8a483fd992ffaa
      https://github.com/bluez/bluez/commit/a3c0f28d5f298887d7c190e64d8a483fd992ffaa
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-04-29 (Wed, 29 Apr 2026)

  Changed paths:
    M client/advertising.c

  Log Message:
  -----------
  client: make advertise.name use public broadcast name


Compare: https://github.com/bluez/bluez/compare/69d9cdab0db7%5E...a3c0f28d5f29

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
