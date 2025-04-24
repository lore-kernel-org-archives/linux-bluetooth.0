Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA1328BAA0
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513978; cv=none; b=NEokFYv4pVk/SPVHe6/EdcnjvuttouuZc4VUiFu8a1dJM5pzDsf1Y5kt0tYT40o0kPmzrbNagm37NlHcQLX5/YuI8ajGHyjBq82TW3MDPv7HKeAobynthTI/wmcy7jVTPuujW3fl3W8v1MXPYPhVs1OWgJ2bVjdd3s7oimd1IbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513978; c=relaxed/simple;
	bh=QMsM5SPdmKZklZQr4ifH/U+mPpkMZjoP12u1R6POoVk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WN4cGzD+pQaq3zZXFLB2tvhxBdw0JGko9xMfqLkHtW1KX/gbUhhEMTBOhz0qZt269bfHDi+6X77lV9AtfMFwbczsK/PrddBruJzDQxD1zd0gq+CFFpEzDo988lRO1HSsFNLANCoTvBQ1OB9qpzQapZIDTudH5uYscxO6zPUS5LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MmVwCrsu; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MmVwCrsu"
Received: from github.com (hubbernetes-node-962c776.ac4-iad.github.net [10.52.152.32])
	by smtp.github.com (Postfix) with ESMTPA id 30CF570086C
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 09:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745513976;
	bh=Lgf7Yf94kepKO1bn2EDZbdbwqZl4Yw+DVEV2EaxEpqY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MmVwCrsuMP0JSToDXxTMwTUdxK2db300MeOtNTj8yyflOLAwCUcECPT5JJJEtvz8L
	 /UIt1sAs4NExUUnaXhy26BtKcP+hvhqIjFcLE+BzjreOazxFFS790nuEcPxM0+kkuB
	 SFkIz2/QXnS4FGexOj4lTtvchpmk9Q5XmUlmwZ+U=
Date: Thu, 24 Apr 2025 09:59:36 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/956690/4b6ffb-000000@github.com>
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

  Branch: refs/heads/956690
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
