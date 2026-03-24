Received: from o4.sgmail.github.com (o4.sgmail.github.com [192.254.112.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9334217B418
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 20:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.254.112.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382731; cv=none; b=Gc9nYYuvvO3gU4ZHG9zQK/w2IMIE57TfoKK1tmmUO4cDzny9M2momjHp1kv/X5Yu8Ddws1ypXoiONdneNgwuwuLhQx1m4H1OuYLFB2Ar6XgXX0UAn+OjVO1RJItwUvZinElwp101/XbMrIbXPJ6GtwTYii7lst08f8+sEykhsdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382731; c=relaxed/simple;
	bh=Ihd/+ZeMFlv/VGG9KR/BIt1w7wwPaTpamT0TGDFhfDE=;
	h=Date:From:Message-ID:Subject:Mime-Version:Content-Type:To; b=mUwIXBPUUoF6XRdxJRC0fQWB4CFamQJi3aTuV3/kfrT5qPpN++ITewK6VUr3dy1hgKJaFA6aU8Uxh0D0a2+TVp/BvzmVS++MkLZkXL/K0517V3C+V7jAZRm70Je6FXnba4Ffbjr5svA5fbuhQJI1n2LX9TIS45O2OehS4JoDC3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=sgmail.github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=F4+qY6D9; arc=none smtp.client-ip=192.254.112.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sgmail.github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="F4+qY6D9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	h=date:from:subject:mime-version:content-type:content-transfer-encoding:
	list-unsubscribe:to:cc:content-type:date:from:subject:to;
	s=smtpapi; t=1774382729; bh=yVRM+/YEm9GHOrLr0rpakTBEsACKPAhzkVIA9VRlRdI=;
	b=F4+qY6D9RsPEwbuG++cbaUnO+RWvN0mqJS5FYReOvAHOMtyKEHI2E3gHruLaE1iT6mAo
	WjkBrtsaUrDbNpUeDQpyk+P43pHvSOb8fxsyY8UrK+BvDw9lMqT+nNgpLWXB7Lut+CVeZz
	ByHHNRdi/yvGFc3fc4hCPAou/tKNqc9oM=
Received: by recvd-76db7c4df9-tvtvn with SMTP id recvd-76db7c4df9-tvtvn-1-69C2EE89-8C
	2026-03-24 20:05:29.780584579 +0000 UTC m=+1299010.055967717
Received: from out-20.smtp.github.com (unknown)
	by geopod-ismtpd-25 (SG)
	with ESMTP id BfgQ12dSTBKH4LdN7pjqSA
	for <linux-bluetooth@vger.kernel.org>;
	Tue, 24 Mar 2026 20:05:29.756 +0000 (UTC)
Received: from github.com (hubbernetes-node-2ad8c87.va3-iad.github.net [10.48.142.31])
	by smtp.github.com (Postfix) with ESMTPA id 5819B1C125E
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 13:05:23 -0700 (PDT)
Date: Tue, 24 Mar 2026 20:05:29 +0000 (UTC)
From: BluezTestBot <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/1065807/15e0d8-000000@github.com>
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
 =?us-ascii?Q?+TD5y9uUDiSc3WCQ=2FbFOxbFL1vD4z0ZJL457ImA?=
 =?us-ascii?Q?qbWUp5O1xiipvw+rNlmwZW0AzkW4ZtcEONl=2FUlS?=
 =?us-ascii?Q?OyJeaM2bu0IhzhF64EQt0sLCVJdVKu4FAZRB24S?=
 =?us-ascii?Q?u0xkac8WMmw9nESrGH7LFZwQ4PAif19RGSIZNxO?=
 =?us-ascii?Q?TvE6nd3wfbSW2tF8QR92xNR6d0coPXNz1+RNThH?= =?us-ascii?Q?mFAc?=
To: linux-bluetooth@vger.kernel.org
X-Entity-ID: u001.h3RSp2myFsXwI84tgZKC3Q==

  Branch: refs/heads/1065807
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
