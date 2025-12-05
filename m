Received: from o1.sgmail.github.com (o1.sgmail.github.com [192.254.114.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AB028D8DA
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.114.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764966351; cv=none; b=EgTWlxHM+g9/JPC4PXXneq0+vGval+pFXNPCFvqHcTLqOv4mHD1D73dF/c+glEshOvXsr7AR04UnqKvPQOXvHin6xFzx2gBCplGpVVWPQrEMwLtSvLIkdgwyppPPLNUIjZ+nCXqCEy8eA//ReCX+sHF62b2fBb2TzBZ79OhOb/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764966351; c=relaxed/simple;
	bh=lYCZe5Y7mPgX6WOQTWk3Z1r+9WAOqDjv9zWk4g3JEfA=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=ULO8pYxCb6W/pvH6sE6z9SbHNFQFP85wdJqQhVzCsSDx62yLa7YB7FeMyg3EgAuEomKSuA+98mRDJ8PZf1XrRgad+86GrtuDL2wCEerkyGwgIZHVgYGsYBtl4BHkLF0RtjkJcP1IuoOoprD/4XFgn9MY3IiJH4niS2hzbQrOEus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=uvFKHL9q; arc=none smtp.client-ip=192.254.114.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="uvFKHL9q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; bh=9vc24O4kCl82qsJ5JDUzK/hxkhimapkZ1Ur1QzyLSm0=;
	b=uvFKHL9qWMEHPEmjUvWM78JagwGQw4xjYcjS2EWI2bcArwrV6aUeq2hBtzFoIFGGJ85+
	NRjtSYdF3Dwl/0sD+PoIbTFiVoMZH8V1xpPtkbaMrLCG20/WU3x0tsNYOFOe73jUd22pZm
	ooSujSkZtRe4+vIps9kLVNtUr6k7/wtn8=
Received: by recvd-b6bf78b66-nd2jj with SMTP id recvd-b6bf78b66-nd2jj-1-69333FCC-9A
	2025-12-05 20:25:48.963263661 +0000 UTC m=+1553363.720147153
Received: from out-24.smtp.github.com (unknown)
	by geopod-ismtpd-50 (SG)
	with ESMTP id ZCExX6NlTD-J8YJhRJLTNw
	for <linux-bluetooth@vger.kernel.org>;
	Fri, 05 Dec 2025 20:25:48.949 +0000 (UTC)
Received: from github.com (hubbernetes-node-d71ae00.ac4-iad.github.net [10.52.158.56])
	by smtp.github.com (Postfix) with ESMTPA id EB778640A64
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 12:25:41 -0800 (PST)
Date: Fri, 05 Dec 2025 20:25:48 +0000 (UTC)
From: BluezTestBot <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/1030870/8f3910-000000@github.com>
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
 =?us-ascii?Q?+TD5y9uUDiSc3WCQ=2FbFOxbFL1vD4=2FDBFXp1tkJ4?=
 =?us-ascii?Q?WrwD4uOn+9kQ6uqyU4OkV2lqIkF5go7FRNPM3LI?=
 =?us-ascii?Q?xBe4ZiZcna8vsGO3zS7pDtK4YbnMwpCCyb8pmF4?=
 =?us-ascii?Q?lwUHCAUWuT9WjYMavAmLD+Wma7MELuWobc9Iikg?=
 =?us-ascii?Q?FdSaR9pQnw=2FL104tKtSDQdKrWWooVY5FeNxx4fc?= =?us-ascii?Q?v1lq?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/1030870
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
