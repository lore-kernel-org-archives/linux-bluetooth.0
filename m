Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E11538AC8E
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 17:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778779189; cv=none; b=CM1CSKCA0e++94WURaCcRrfG+R/6dyEGkYHayIH/xIb8Y0ntc3kMWzbbWc3wZ0o9YlGG7RX0bNwKGlwLRIxt5iiIRUavqupP7SBXjI0gBEQCrdmB8etkJntE0hPxECSuCfC91CAs2kgyvK6iR37pVz9NeD3y+cHEuWdcZ7yxyZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778779189; c=relaxed/simple;
	bh=xD8T7uYb+cpEwltqEbAORGHLvoSCHdyPtw2ydF3b2VY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=K5u7XgpT06nHd/8v6+mkfDuScJEhIanUpo4wUytGSizuSw0gUs9UgxgCU1f1wEvOlEgK2VDy2wDxXrB5Qmg2zAApy20J+NqfWc8Fu0wZhIp30e33DFswJiQ8l7+ii0y8Tn4qjqVeWed37nOFk0lWUgAOmCUcqJBF+9FALEVc1SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jxPC/b+1; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jxPC/b+1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778779186;
	bh=JicPsKuPLpz5/sT2gqV0erzbJ6Wehx42IQk+DR78GUI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jxPC/b+1vjYQQJ9alIdD7uAT+IN+BfjQK4DJcgwQVwIpiEiajkiTFMk7tsC+QvreW
	 RIu358ll+OjyCL1I4fQkRbDB57ZUi7EWhEdsSR1/cBzi7wW7KCtmES6frSqK2nyERn
	 O6coSjGldfqbmlZGsvFiXqt4JrRfBqcilcnOVcJo=
Received: from github.com (hubbernetes-node-062882b.ash1-iad.github.net [10.56.190.35])
	by smtp.github.com (Postfix) with ESMTPA id 7F0711811A1
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 May 2026 10:19:46 -0700 (PDT)
Date: Thu, 14 May 2026 10:19:46 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1081191/1729f3-000000@github.com>
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

  Branch: refs/heads/1081191
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
