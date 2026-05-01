Received: from out-34.smtp.github.com (out-34.smtp.github.com [192.30.252.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A27275870
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2026 15:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777648005; cv=none; b=D1Bz3A1BENVdKBHCO19QHD9iPv9UeJIPCZJVXhJSM04W5sZaM31s3NlzKxhmpwswfT2qwhCT73MmPtmPic8PAMweXR8heYFpHo/ImLfeo/9Z4wANH6gdxT/UCju7ON7JJYxNAffiP5SdchtwSKaNQlvn0Vy4ScVHKEUjYiSA9+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777648005; c=relaxed/simple;
	bh=S37FzSeJ/7WTyVqQDv2RaVK4ALN6eOjSeXLWjVV38Ac=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Eh7tRLHEh1yWBgVvW2ljs4ENpcn/UgTj/ewPKdF1wHYTNKjCCDv5eErskGu6aEXGdu4Nmb9W8EvAYGp4/4GyiLJKrJROtpHFKoFKsoUSwl7nKb0Envy3xncsAncMNZaagD4LAAZLpl499xqAu2HuRCTgNAHcNuzw7OIraXLOZyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=loHLULIX; arc=none smtp.client-ip=192.30.252.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="loHLULIX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777648003;
	bh=bNrEm/gcTK0p+ORdv9DGSMtj9Lj2q+XXQqq9jqeEK8E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=loHLULIXhIosgbEjZQNnZKgNHObqp1RSBSURjsvCWnCbKQVSYButIJ6cpT+1chO7a
	 R9SB83FTh0Xd8pI7a6phqufAX/kBUvrk/7QuMXmSNJfcvHIrUPOLK8JjUvmHnUNekj
	 hPt6JL0ZVlOReRwYfOlM/YwI0WOCg7st7p/0u4JY=
Received: from github.com (hubbernetes-node-f5548bf.ac4-iad.github.net [10.52.207.32])
	by smtp.github.com (Postfix) with ESMTPA id C6B7D741148
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2026 08:06:43 -0700 (PDT)
Date: Fri, 01 May 2026 08:06:43 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1088223/e6772a-000000@github.com>
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

  Branch: refs/heads/1088223
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
