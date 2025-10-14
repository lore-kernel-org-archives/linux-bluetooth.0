Received: from o5.sgmail.github.com (o5.sgmail.github.com [192.254.113.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D97D30146C
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 19:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.113.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760471614; cv=none; b=RC5C0+C1RhCyg1jU5IhClS8p1eLD7gBxaHwy7w2Xt9woT8BV5xG18MYfGdmVicJkTUkIahS23WpHCLTrKYWoTmgOQFdecToIVt4SbgIDm4ui4psdoVIUk/Jo4rBJd0q4X6P91EEAcvumL+hrCKdkmiMPTy/gmnnQeodobj+1DxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760471614; c=relaxed/simple;
	bh=4jAcmUjq9OAXClXV0KbCelGCwu1u0kaW3+aAiD8bFVU=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=pQbw0J230ivhdx2KdWKaLMysqtNQiYwckgSGfvuhZ1Yz5ZRxWX2T9SrH0vOmykSyf8rAkK/5ykZ2i22wffjWC9r/D3oQCI3beOOQHEfnsi8ey4EpwMkBNW2al0Lk0YjKTqawfXdtIU+gD/jQnOC+ndxCXW7irQyqwLriEoAOvYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JTJYDcpz; arc=none smtp.client-ip=192.254.113.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JTJYDcpz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=VY+aovWZjW6/H7L5mLE4BbA9dOAUlllroSdosP2lCKQ=;
	b=JTJYDcpzWqCwX/6MJHV2CWCyh5++OsLtbBgkI1SpoWup/Zl/3IBF84574TBptNrdAICf
	hpoCm10wOUVEuUAYvaudTYfbP7zxvCldFsj98Vq6sW5vooqlSbZaXEpthxzaZAQlRzAA8s
	RwSR+yODbBSFjJndK7HR4aNaolNreYjs4=
Received: by recvd-759dc5847c-xh26c with SMTP id recvd-759dc5847c-xh26c-1-68EEAA3B-35
	2025-10-14 19:53:31.399176253 +0000 UTC m=+3616624.691477208
Received: from out-17.smtp.github.com (unknown)
	by geopod-ismtpd-36 (SG)
	with ESMTP id fzewp0VgRCCsZsjkqZq4Tw
	for <linux-bluetooth@vger.kernel.org>;
	Tue, 14 Oct 2025 19:53:31.376 +0000 (UTC)
Received: from github.com (hubbernetes-node-c692bfe.va3-iad.github.net [10.48.14.102])
	by smtp.github.com (Postfix) with ESMTPA id 0429B4E09E8
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 12:53:24 -0700 (PDT)
Date: Tue, 14 Oct 2025 19:53:31 +0000 (UTC)
From: Luiz Augusto von Dentz <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/1011502/000000-9edcd7@github.com>
Subject: [bluez/bluez] 2854af: client/player: Add 'auto' option to
 transport.acquire
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: 
 =?us-ascii?Q?u001=2E8ki=2FFbqwlQO04QBiriT34f6qhM6wd38+BQvADylPPTIQmeZqt0Mdj+E9P?=
 =?us-ascii?Q?ngWQlMPxccS8u9EBUyRL9UmZaAIAiJh3dXvRbAk?=
 =?us-ascii?Q?ZhjIYQRPny6rbXkAb6bHojEXjAK1naE0xTV=2FdWo?=
 =?us-ascii?Q?J8u6egPrknurYxmafM3Let0uSjAttp5UE5anqnX?=
 =?us-ascii?Q?+FTST8u5qEsVp127J3I2ruP0nv3h88B55f9Mmcv?=
 =?us-ascii?Q?D1KXmCYSp0EEl4HnI8I5mLSCdSXrcBaU5yYjE0O?=
 =?us-ascii?Q?uR7vXt67=2FPcRubkHpPfd7mQ4wg=3D=3D?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/1011502
  Home:   https://github.com/bluez/bluez
  Commit: 2854aff2d35328469b40f4a57deda49c311c652f
      https://github.com/bluez/bluez/commit/2854aff2d35328469b40f4a57deda49c311c652f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-14 (Tue, 14 Oct 2025)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add 'auto' option to transport.acquire

This enables transport.acquire auto which enables to overwrite the
default behavior of prompting when endpoint is registering without
setting auto accept.


  Commit: 9edcd7c691dcc5c0e0d6b6e8f9db5b5b6e05fd9d
      https://github.com/bluez/bluez/commit/9edcd7c691dcc5c0e0d6b6e8f9db5b5b6e05fd9d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-14 (Tue, 14 Oct 2025)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add 'auto' option to transport.select

This enables transport.select auto which enables to auto select the
broadcast transport configured with the local endpoints, the selecting
process will also dealt with linking the transport so it needs a timer
that waits all transports to be configure to then start linking and
finally select.


Compare: https://github.com/bluez/bluez/compare/2854aff2d353%5E...9edcd7c691dc

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
