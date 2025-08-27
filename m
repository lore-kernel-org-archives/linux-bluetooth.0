Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5D321ABB9
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 15:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756309249; cv=none; b=F9UAnyj2mpKS+TfHKCXQEFHXV7LnH1FsoAoB9qCopV/dIzVx+syTACseh7xp0jDIUsP4sgA26lZNT0GxEoF7xazcy8PswZemcEL+6mCwFAHynBCoiiGTTsj/nxC7BS/fESEAD+lx5yztpKNq7KahErJvHtgRurnAZJbwm0DyqHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756309249; c=relaxed/simple;
	bh=IVFbZc+F78HjsvNQxRhMq97ij4D4UztRNs2BC52bNxQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MlB7Ug0N7On/83WShqMaCncmAgoC/aAV8t6UzoCka6X16AZusndA2N0+aDmNYpSyHAVDmweBfYouQD5jphpIPi6EpbEyca3s1PhBQx+PSXeR7IdnN7av+NWfMB32fIAn6UAEUP1EcZoiA5otczF/eOFvXgYuDLEB2OC56E8Puxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ME2fdOfq; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ME2fdOfq"
Received: from github.com (hubbernetes-node-8012e95.ash1-iad.github.net [10.56.155.34])
	by smtp.github.com (Postfix) with ESMTPA id ABB9960125B
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 08:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1756309247;
	bh=DPr++HDG+RtnLN32hUp82echdwbmrB1JsaRQwaIgu1k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ME2fdOfqD4aMO6j4SZaGVyOcB2B74P2B8i//l0fa194I28HdaRbDvgd29Kkj8+/jF
	 bmwvG54gYInOtQBfP31exBDry0DmlciC1PptLPU5hzMkzrUglRGA8VUs1ZwOaERVgE
	 BYYXiSYK+qy6PZGj5MBvEHfjUQEzfa/wsO84eBX4=
Date: Wed, 27 Aug 2025 08:40:47 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/ba920d-5d4efe@github.com>
Subject: [bluez/bluez] 5d4efe: client: Fix transport.acquire not doing
 anything
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
  Commit: 5d4efe960fd94d692e51234cd5f81a5779b2dd07
      https://github.com/bluez/bluez/commit/5d4efe960fd94d692e51234cd5f81a5779b2dd07
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-08-27 (Wed, 27 Aug 2025)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client: Fix transport.acquire not doing anything

If transport.acquire is called for a transport that does not use a local
endpoint it won't call Transport.Acquire as the bluetoothd does not
allow controlling transports of other processes, but it doesn't print
anything either leaving the user blind to what is happening.

Fixes: https://github.com/bluez/bluez/issues/1532



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
