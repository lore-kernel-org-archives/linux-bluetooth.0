Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A411293724
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748019093; cv=none; b=UZc1im+G9L1rxy9qwzKE9J+7ziYQk65BMSOMZ4FTuVmdb9+A8MQafv77Bd/92+eFBWK266H0K+MmcQAOgt3zoI1dGb4s/op0vDSUPRj+vzgbOiYG8RszNdVYQtTktnbqFb2PR2/Aedh9BtR+5QNN1Ukzg1gIavQesN3GL3wgoLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748019093; c=relaxed/simple;
	bh=FmO6mPM0B5/4K0bwnrXZbb/G5pSzAauO2QoE/0nP3jI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VDDey1+G3JcgKQ+benIapIQr4J1Nf+05b16o8/8BWLBuQ9vpqpC5hsVDCFWLOUHhVEEGHZZ3CTKLEFHWPaZ9CFYRI2lfeCM7bnQ6t5pRNTmcVhQadQ/2LQmEtt+A45rmJSdSR3pYEdB5QZKiLTTozI5bEl5AlgC61aEZ14KUoLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kc6FvOM7; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kc6FvOM7"
Received: from github.com (hubbernetes-node-732e04f.ash1-iad.github.net [10.56.206.61])
	by smtp.github.com (Postfix) with ESMTPA id 83DC2921205
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 09:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748019090;
	bh=AgQRmYJ7hgusVvCYXRX+t+qyQjLGZc+SLDbkOxBUeFs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kc6FvOM7P481FgKrBNIYja9SxiqdeQStWiXg3MdUqYQaOsjvVMLBU2Ym2Gvw9+Kmp
	 c7D0Krg3m3zBMOhvBS1URXLkjaC4i9n08gtpo71BNhLwNezG+z9P8BwNxfdtCdW7qJ
	 jKD+DQMCfl+K4/JXCa5Lnj7TSsfggib4YISD85V4=
Date: Fri, 23 May 2025 09:51:30 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/1fe5a8-c888c6@github.com>
Subject: [bluez/bluez] 3a8d77: org.bluez.Adapter: Add AutoConnect to
 SetDiscovery...
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
  Commit: 3a8d778b0a9acc5459c23c0e73abd1b1b2c1fb29
      https://github.com/bluez/bluez/commit/3a8d778b0a9acc5459c23c0e73abd1b1b2c1fb29
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-23 (Fri, 23 May 2025)

  Changed paths:
    M doc/org.bluez.Adapter.rst

  Log Message:
  -----------
  org.bluez.Adapter: Add AutoConnect to SetDiscoveryFilter

This adds AutoConnect filter option to SetDiscoveryFilter which can be
used by application to automatically connect devices found matching a
pattern.


  Commit: af7d5dc61154e2ad226502de8e5b0f32cfe34312
      https://github.com/bluez/bluez/commit/af7d5dc61154e2ad226502de8e5b0f32cfe34312
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-23 (Fri, 23 May 2025)

  Changed paths:
    M src/adapter.c
    M src/device.c

  Log Message:
  -----------
  adapter: Implement SetFilterPolicy AutoConnect filter

This implements AutoConnect filter option in SetFilterPolicy method
according to its documentation.


  Commit: aba81b553348f28621a06ace350629de84485709
      https://github.com/bluez/bluez/commit/aba81b553348f28621a06ace350629de84485709
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-23 (Fri, 23 May 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Add scan.auto-connect command

[bluetoothctl]> scan.auto-connect --help
Set/Get auto-connect filter
Usage:
	 auto-connect [on/off]


  Commit: c888c682fbd4e02dce6bf4c1f9a47328ceb02716
      https://github.com/bluez/bluez/commit/c888c682fbd4e02dce6bf4c1f9a47328ceb02716
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-23 (Fri, 23 May 2025)

  Changed paths:
    M client/bluetoothctl-scan.rst

  Log Message:
  -----------
  bluetoothctl-scan: Add documentation for auto-connect command

This adds documentation for auto-connect command.


Compare: https://github.com/bluez/bluez/compare/1fe5a858bd97...c888c682fbd4

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
