Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16DF0339872
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 21:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788557832; cv=none; b=uWObJD7ZwS1ROfgpo8uuSqBeiOz9aIMpvH3PAGDKHKnyJCGSCtzb25kBIOO4DTeszNfauSGxm2P6odJxVmVCFk+GCHRdGaP5b1y6X0VXa/mmrVMLx4YFtvn7c0Xyz6PIrPvbC0QhnREprD6ok8mKWAeSmxNM67l+pYyqt/ZIGJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788557832; c=relaxed/simple;
	bh=V0ESk7XUmOU7oEZiziIyNgziey5OOlqfQkL2jq23ffw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TLfgc6IhHC+Gh5ldtHygYrr6kgbghDbSPA3Hc7mFJHCoeKGUqu5H7XvyEuTZL7DLrCt5TaYUZcEI1rOFhCWFpumELvLqe2JPyJaMqwMbvMC+VZoR8xAoRRk927sptZ9X6QlBoNVwwlYK3lirShsiRc5hoBDEjTRihKG2Hmb6/Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ke/I8aqx; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ke/I8aqx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788557830;
	bh=I8xeX+SyF8VApgmNuAiVsxiZRZQCbMXkYf2eS9rRuDM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ke/I8aqxhtNb7cQJwz/l2rZ7imEEcT4so56BwHYS8yaWPWiP695XJWvwSan01FTNo
	 PfFQQvR46vD6NQvziFyTNDGQZhHDT7A94DFMx1ndWqwhRFjFTKY5bpWwkNjuEa0Xuy
	 RbrbmQtj6TTot0S96yFQ0HR3CAMM424TZ8Ppa2+w=
Received: from github.com (hubbernetes-node-b1426d1.ash1-iad.github.net [10.56.84.27])
	by smtp.github.com (Postfix) with ESMTPA id 36712600989
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 14:37:10 -0700 (PDT)
Date: Fri, 04 Sep 2026 14:37:10 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1157432/37b825-000000@github.com>
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

  Branch: refs/heads/1157432
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
