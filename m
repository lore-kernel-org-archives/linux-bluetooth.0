Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE484E80D4
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 14:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557464; cv=none; b=ikVIKVudKwe+N0NdJ9M/zqWJHzTo22KWp06P8FmzFjslCqf612bHbUhgf7MQli36RliKwVaqWlv6P7nPCv6kdWvp7vVzzMqlOnk6xuI15CSOTinHD70RGZTkVxbwMJexvAtAQLe5gaOmKeDRLeylWSWReIIQBPHnRc3gV324DuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557464; c=relaxed/simple;
	bh=mL9fv/TalPK+d0ki2p+pGyMD9LmBGoeWd/jwDEnS/KE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Fb4ipU0W0lfCQsLqWuqdWn4YA+ZCtgpuXnGETK39m+UXKJlzYzKbcWNXN2LxmRBZG3muxTt+VU6T8LPK3Z7/SB3k9VVoejgxbzD2RfxN+oW247SaIYpqsFMxIZlaoaWk8gWvSB9fuvryX1JS2Gh05yDWvLkHpK3Cc5k/aWn+vHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=BuqV/kGV; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="BuqV/kGV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791557462;
	bh=aKDs141OsriQ4thO79hJk9/1rsqR7dbn8PL3xrH54r0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BuqV/kGVqr4Yeow2DZH3s+D59O+KkKYwZmGpi79W/hAoN1LiSRPX6wbdt9vs1djVz
	 OzkpkUpYIJVHBkwiVA9tThKWrKnHirKEBPua8PN6CAMesMupBGTgkTvIp1Ubf3ylCn
	 VldjGKRCUEyvd/jODWfanFsjp5RjBrf0y3LID0YCPWklHAneMMNRhpPvyXIi8zxkl4
	 UZg8eflrAkf6I5EbUWZSG8QgG1c/+F8a/s2qT3hJGnmIt7atdiuqJmUuKARB1557aF
	 1T5YZJwyieqJQFNgebIcBSAcG83z4DCg+DpqOadCaCnMuNVxCaSDvZhhlmHKm6Md2j
	 YTEv2s6PEy9PQ==
Received: from github.com (hubbernetes-node-2801527.va3-iad.github.net [10.48.68.69])
	by smtp.github.com (Postfix) with ESMTPA id 32045281065
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 07:51:02 -0700 (PDT)
Date: Fri, 09 Oct 2026 07:51:02 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1177680/b69781-000000@github.com>
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

  Branch: refs/heads/1177680
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
