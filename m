Received: from o6.sgmail.github.com (o6.sgmail.github.com [192.254.113.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163532264AB
	for <linux-bluetooth@vger.kernel.org>; Sun, 28 Sep 2025 10:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.113.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759053625; cv=none; b=C07o02o5WcV6l8MLV2BidNW6AT+Q9BjCj1mK1c9MCMbHVtKa2XRRqqo3oJGSXPQGVouAM6xDiOCw0NVBqGqln5S7QD3vgmNEPrODsdLRg6bADbXOxf2MbFvMTs1fHhK4CJAIkRyd1S7DSttARBruPgjL2IaM4p7xUn9GWWbRoEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759053625; c=relaxed/simple;
	bh=VqF6kGn8IRt2zvQm/LIjmxIHrKYDbVAlyYW3bC/Gr4Y=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=LzQxbyidkvKiJkwSd0UJpRQVNM/FUP0N3k5iDjxNrXkdXkU420JA1ngaR7wcW9ZHrP5G2/h/ULdUCjtzGF+pTZzwBYyOw6msFaCRtZylSjiaN/XmeB3xEuo4wyiXncp0F+mmvIy9lk2ReBtHKDBoszCjvR3GDYoCz0nbLnxNijc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MKdN2aEw; arc=none smtp.client-ip=192.254.113.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MKdN2aEw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=Oidvtwhz6iaTOdM5SmPwZ0javthvqUWUvWogajWrBpY=;
	b=MKdN2aEwsjaQAwUP1ny6bYT6DKrxaYLsczNI3OPGvjIaJcjnG7i1/XSQuoHpPQJmO6RH
	rGG318lf6InVdvvij22rCXaKusM3CREvgYJyYdTSwOrQxzLvgObRMY8VVHVYcFOggxtluQ
	Wm8Jp4Adj2mN/l5jxaC8sk38oO68XW8zk=
Received: by recvd-85b768ccf6-cnhk5 with SMTP id recvd-85b768ccf6-cnhk5-1-68D90737-21
	2025-09-28 10:00:23.126764412 +0000 UTC m=+9998127.529885217
Received: from out-20.smtp.github.com (unknown)
	by geopod-ismtpd-11 (SG)
	with ESMTP id WwGFrH32Tw28Mg77nLfw0Q
	for <linux-bluetooth@vger.kernel.org>;
	Sun, 28 Sep 2025 10:00:23.114 +0000 (UTC)
Received: from github.com (hubbernetes-node-bbf6df1.va3-iad.github.net [10.48.156.55])
	by smtp.github.com (Postfix) with ESMTPA id 6DE5F8C0493
	for <linux-bluetooth@vger.kernel.org>; Sun, 28 Sep 2025 03:00:16 -0700 (PDT)
Date: Sun, 28 Sep 2025 10:00:23 +0000 (UTC)
From: BluezTestBot <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/996842/9b0325-000000@github.com>
Subject: [bluez/bluez]
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
 =?us-ascii?Q?u001=2EyVDaIUJfOTIVaBYkJvNzXFDwUvSfXABmYIMG7o2yQ0XjHiQN8HeKlKfUQ?=
 =?us-ascii?Q?+TD5y9uUDiSc3WCQ=2FbFOxbFL1vD40bkwri30Bbk?=
 =?us-ascii?Q?WzLBYn2OKGpUtiVZmYXH5lSJRGUfDXaNeDZXJ4S?=
 =?us-ascii?Q?haLwkfYxLrsZCwcyWdqd4b3212wMevDK2WYfVXt?=
 =?us-ascii?Q?djD2kzuWLHqtzY5X7Y2aGE0g5R=2F7mHyo3TzhLs8?=
 =?us-ascii?Q?24FmWzESZbFk0jINe7hwhiaRlFLOAWfrWYowtUu?= =?us-ascii?Q?QYWb?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/996842
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
