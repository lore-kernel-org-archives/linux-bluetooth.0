Received: from o3.sgmail.github.com (o3.sgmail.github.com [192.254.112.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D002831A7FE
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 13:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.112.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760447409; cv=none; b=akwtRICELyTP86AbIpSiA9ymRwn9znJUkPB0yLkDPa9mWNHf2cCHX9dhMFEmmMC2K2TyZAopEoMldMBDG78wWgYJYBGadqHK05rR47AYnxF7KtSrWoaik6X4ttwEIgv6z+bGG7VUbfpF6sy1FyaI+iJIVVFUNTztO9qXvc+Ddjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760447409; c=relaxed/simple;
	bh=0eia0lBhTzETUexiotLFAbUAxJuxjv8e1fFD1kdni54=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=JeB8V8SRZMph8nlkPFtbkUWeVA6a2K5J69CjG0GFpFNjEN5K038MD0aREGH/p/Ru+FRnFskgRjXaCWe60CCeW6/AlZGtTQNRKo2tyNlAhUGCKtNg8oxtMhnzrhALPbDdEpOUUXGUTrKjCgNSOTFV+glT9hc35UzqNwWtcnl469U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=quVwPKJ7; arc=none smtp.client-ip=192.254.112.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="quVwPKJ7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=h21boJ+k4rcup2otex9IwMIt1yHrOEIcPyUb/Dk01cg=;
	b=quVwPKJ7uvBBtEZJDv0sZIia7PwkePhSMRu4Up7OtQ+XqNYvPNXiCYWACIOAkCA1jXvc
	0P9J/wdUyGvuKZIIgoW52uD9FBfjfiJRkNmyoly4pjCb/24iLDxZ2mTjUqV2viyFEuq1vT
	wEbgkkk+8WDraZ4rPIReKNapetWBLzLHQ=
Received: by recvd-868874bfdf-q8mh5 with SMTP id recvd-868874bfdf-q8mh5-1-68EE4BAE-BF
	2025-10-14 13:10:06.770873717 +0000 UTC m=+5932115.866418625
Received: from out-24.smtp.github.com (unknown)
	by geopod-ismtpd-20 (SG)
	with ESMTP id gfiJGgLfRSOj3isrgWNokQ
	for <linux-bluetooth@vger.kernel.org>;
	Tue, 14 Oct 2025 13:10:06.733 +0000 (UTC)
Received: from github.com (hubbernetes-node-f76d6ec.ac4-iad.github.net [10.52.223.64])
	by smtp.github.com (Postfix) with ESMTPA id B7989640620
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Oct 2025 06:09:59 -0700 (PDT)
Date: Tue, 14 Oct 2025 13:10:06 +0000 (UTC)
From: BluezTestBot <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/1002158/249126-000000@github.com>
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
 =?us-ascii?Q?+TD5y9uUDiSc3WCQ=2FbFOxbFL1vD49bkkVvMEgga?=
 =?us-ascii?Q?9M9lP68d5e100KpLGjvX=2F6SQcmbfUa6ppds1HWA?=
 =?us-ascii?Q?qK=2FDHx0zrzhFObXvTwgnP7TXC8Z8o8jKzYDur3s?=
 =?us-ascii?Q?qNOe34OVLGcsV8FjNqQ1Q2FG5kB2Ab4pX9k4qKP?=
 =?us-ascii?Q?OvxfdCH1MkTYFcWA6sL6RbuCURPpoBzQvNXH0nS?= =?us-ascii?Q?cNd3?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/1002158
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
