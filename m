Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CDF301034
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 13:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755176843; cv=none; b=LeRaAa79cem8wp1hBCiAfFc7xpBQW2kfGYNfWrdFBdxaQHQhRJq1FydRP2PZHHBonhUN/EOdecm6vybbl4fl5LJCKAHrGl36rNLgTJuEQu8brAmkZalnoFpLPKf0rRmzeZW20GcjE+kdv10i6pRdlsfvPYhigln28BbyI4BeI8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755176843; c=relaxed/simple;
	bh=OtuAAMLZak78s2jUR4Bygn/Jw6amkpVhrFG79y4I/xo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CQlSKuVVf5Wpa8kt4nsMrZ7lqumDIq8ce0g2/+zYQFNL7bliZJ/4WNCbagqyczxRpJ0Q+68BZ5KptORUgwVXoUgA+SoshOG81yKeOJY+XmAZrfdMdGYHdlISP2gwFDTNcMLzH4ovM8y70OYp3VEymog4ofA7X8vzFMxKi/gPnTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hFIWFPkl; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hFIWFPkl"
Received: from github.com (hubbernetes-node-62164d0.ash1-iad.github.net [10.56.193.37])
	by smtp.github.com (Postfix) with ESMTPA id 4424F140726
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Aug 2025 06:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1755176841;
	bh=SX+VHr8NlC+jsremNGGguNxMnaHzY19edmV2QGlXeVY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hFIWFPklDUbMRMdq0lHJxHf+c4NyQroIqv2L7XEwMIbxQcTM90NzjKxK8J+VAoIOq
	 Tn3RRownTSBsxj7JP5fXR4L6pU8Ufz78tU5zF8+DRUVCdB5f8I3q47PZlvfc+GbN4+
	 E2LZCF4TOt8SR60walpQisewLxB2sw3ZzkFi8jRQ=
Date: Thu, 14 Aug 2025 06:07:21 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/9cdbad-c8a82f@github.com>
Subject: [bluez/bluez] c8a82f: mgmt-tester: Fix tests failing due to missing
 LL P...
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
  Commit: c8a82f19c5c2ea1d0389b3be24231f87690ec29d
      https://github.com/bluez/bluez/commit/c8a82f19c5c2ea1d0389b3be24231f87690ec29d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-08-12 (Tue, 12 Aug 2025)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Fix tests failing due to missing LL Privacy

LL Privacy setting now depends on LE to be enabled first which was
causing the following tests to fail, so this removes LL Privacy from
the expected settings:

Add Ext Advertising - Success 22 (LE -> off, Remove)
Set Device ID - Power off and Power on
Set Device ID - SSP off and Power on



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
