Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4684A2E19
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 18:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786733728; cv=none; b=Hcnv9uVv10QAfNG+UIZV2vcFSPez66r2uIS3klmvRymZLl+JlnElXIIkuu2E7rCTgpbUghgnQOIgwaTq9XwFAFym3WbMn/0XJ6fY5gVXQjOgnSr8YIzxyMnofX7KRdnJecLfDC+uyOcZUpv+x1HO99ty2IdFYJqfxEhNyhwMGd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786733728; c=relaxed/simple;
	bh=6cUfipfVM45UJp/X+lwXPlUnhnnPagjHT6uxIMgJX3E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Wqaqo/N8er7/ZSWezQx5dEvck+i32NFTbeedOhb/kAKgt9v0C1bBIfH7c0yv2yNNOxgjgqGivUuiaJiqMD7MgRjOlRmYTH161ZeGacgrm1NL69wEfrfKthwgJkFl1SlZGIbHR//gB4vjN6avOorSinMR5rkfnJ5u/CVaKcW46ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=W02S2OOc; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="W02S2OOc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786733722;
	bh=vzYMofoR4HhNbANygq7BIrpJDBQBZDv4htHWmgdDsLw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=W02S2OOc356UrBxfAXc2urf9x2Af/5IPV4I8Uryu1homwxNBYEB9kXPHQ/wkMco88
	 3SjC7EuCbpdXURAroCKqf/fEfPm95vFGXnLZ5NAIw7xI7MLS5CrK1ZRTMJypSRaz9b
	 +ePmAK9c2RpH9v5gknTchnUbmOObpQ3o4PUBZqm8=
Received: from github.com (hubbernetes-node-b418832.ac4-iad.github.net [10.52.182.33])
	by smtp.github.com (Postfix) with ESMTPA id A69E89414D7
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 11:55:22 -0700 (PDT)
Date: Fri, 14 Aug 2026 11:55:22 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1145981/3ca1cb-000000@github.com>
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

  Branch: refs/heads/1145981
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
