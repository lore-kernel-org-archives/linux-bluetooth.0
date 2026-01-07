Received: from o1.sgmail.github.com (o1.sgmail.github.com [192.254.114.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E50318B9A
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 18:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.114.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767812173; cv=none; b=F0lGfGSgv0OsDstQe4QI2LtNRUqYh7KKNbwZp6djoqAe1/lyIItuj+WkU5bQ4VkJTH6Ca4KL/5j7mQb608wpKScPc/1TP08HtKKaBvzi3qGg3F+DWzos1z14EAd8v5LDzn3FGyJCxCDsxVxWmsqlHmYEJNMUKqmGgYJEJpdkQtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767812173; c=relaxed/simple;
	bh=+jVyQZmPMU/W90NWvl2jFXr++6fmR7Jud0lP9mthfQs=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=FaayFPyoyqkXPQJMkID+jkwhwqs4kPF8dXqx3VnDgC7WfmbByOoDxNaLlcwB2e2roOLdzU/mwzZxm7zY3zykAz6UO5KYuvW0CKpIcJGPBNvUza+ucsfZOL5taop+l338vdm1QduhEJ60C1rtkmAKWdqxNXmIcAipbPrlQPQjao8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=sk5fbjaq; arc=none smtp.client-ip=192.254.114.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="sk5fbjaq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=NVPvEmxCV3J93t0qTa3zmv9EFNVa/d6C2E/+sjtNdH4=;
	b=sk5fbjaq5vtHgwTlDJ78vA7YQoj71iX+VFCs3JLZyzL+8HBIhUp6uwqsbT3SPALHByNz
	Gtd/KVtRiLW5iIet34q4vV/MluHWdIvvrTDyZXIfKrURxO/RYQHxbXm27mf+KOTPUs0CCX
	/YIOO2LZuZGuj/uPQ9rLSG1vgwL8v2WEo=
Received: by recvd-6f6cf997fc-x5fzf with SMTP id recvd-6f6cf997fc-x5fzf-1-695EAC49-3
	2026-01-07 18:56:09.06991426 +0000 UTC m=+1802681.143718353
Received: from out-18.smtp.github.com (unknown)
	by geopod-ismtpd-24 (SG)
	with ESMTP id UY2yR1JdR5S1ZrsUGr08MQ
	for <linux-bluetooth@vger.kernel.org>;
	Wed, 07 Jan 2026 18:56:09.021 +0000 (UTC)
Received: from github.com (hubbernetes-node-5e5fe1f.va3-iad.github.net [10.48.139.40])
	by smtp.github.com (Postfix) with ESMTPA id 677BAE12E6
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jan 2026 10:56:02 -0800 (PST)
Date: Wed, 07 Jan 2026 18:56:09 +0000 (UTC)
From: BluezTestBot <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/1034905/ae4c1d-000000@github.com>
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
 =?us-ascii?Q?+TD5y9uUDiSc3WCQ=2FbFOxbFL1vD45pIo6y0qB9v?=
 =?us-ascii?Q?LSBUJCdrFwJHJzA8rlBCUQ9lxqkoYv8j7IqE6Yh?=
 =?us-ascii?Q?ml9cVbo+1FzdnW4FmtyHOTwqW6eKXa=2F9o4aYYww?=
 =?us-ascii?Q?FBjTtR+xn=2Fg0Ar4sf4NhfhkKS33K=2FC6iNwQPgY7?=
 =?us-ascii?Q?NNWEsaIexDJbsM7=2Fe4v+SS0l0H7PoKQlOrNC61D?=
 =?us-ascii?Q?=2FK2d?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/1034905
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
