Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA8C2EAB72
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 21:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513786; cv=none; b=TYBDVrO3bqqjVc5xvSRFTOwlUEIMxnnSgjG8du9S1QdfK6JxT5I0hvT/8YJTwxN+62e5eiiTvZw0kSNjEdCujsiBVg0PBUlNOOshGBQDD/7eAOlYEBYjbLPnuLOgaW22rYrC2iSqpkBTWePGOrMlTMLBrLNGH3eaWlibtoyycVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513786; c=relaxed/simple;
	bh=oL+dvg2gQC/EM/KtG+hhWJcvXJctCjyA7p7tho9AJro=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=uydCLYKrTxmVahHnn1FXFVogrxEfgVywNxOpl7kne2d3UrCbGbKsJYWMNdlmiUpFMmHadoqeX+rOHDIff1Dncf1dJOcPSz2cDdLZymKkF8tKmF35GE2N3mv3e99vIDS6Lp86hDMp8CZX0WBsCW46ZxzqSCFxL+8V4aXf77fDPUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UZG+fWMu; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UZG+fWMu"
Received: from github.com (hubbernetes-node-b52ccb4.va3-iad.github.net [10.48.204.54])
	by smtp.github.com (Postfix) with ESMTPA id CD5604E0B89
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 13:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768513784;
	bh=AihMtoD1Xx2OCTn943boNl3c2ifCF0AdufxPiwY+zqA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UZG+fWMu1V3JwjAxbyoFk2dIBVjdyuvT0uBrcZEG4LKFYkhTYUEetf6yv0s6l5w+w
	 JFjpzLHj3JcFfYZUM+URMxEcaWQVQGm6Pjzrti67R7N1BQO56JqmAN7Ao17j0zHS+J
	 AZE8ycKu5ZyE9aV8JiRf/fHLmz/Txkv4p63uGGEw=
Date: Thu, 15 Jan 2026 13:49:44 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1042857/0dd500-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/1042857
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
