Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0447631717E
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 20:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777927330; cv=none; b=E0KRAiCQtqP8a037u9PCqUCm1MXVt8GVFATykKeDWAk5w9q8iPEvqJhIfghU2kCG+2Y26DgFtH+7AM5Q0nhgcF6BbpRjSPUUtYPxE5KMqlQZb7bzJRFFa79XfGpcQ+83LTjuuZ4zSP20qLmvtKaQjqZVSPEQDjhJUdXQf1GImVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777927330; c=relaxed/simple;
	bh=o5CyL5X6xTaWahN1FRoDyT1mUfbSnuOsyfHN5Fx7LC0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XWCAfNW6yzgzcJHOw19A2B5ysIFcCFDY5gfFRnYcKVgO+hTkx6sys+mqyefHKu912NzGDPPqzD0RrfWbj/Na5WT1ANp8EIyuDvhGqi8Wna4bPeMky1Ee3sOSFZuBNtho1++8v+M8z4D2/r5GYvfetxWMyrS04M1jMZZxacmvOig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lZA9TET4; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lZA9TET4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777927328;
	bh=PiAzU9ByiHEphgI82RzbkFETxGdDLUxdX6yvFfAHYEU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lZA9TET4MzP3k03geIhkAQUn3DMpKc6vQeDp9fd6eMMHgwOxxbpsm+Z4eG9TOfS+A
	 RtBsWlXvx2J4YkI6UdXTQzlMZjJbehiYVIg7EQh9jie9PIIsYODTw1cxokgrxC6lWw
	 lbZIFsJ8Rf1x/BetPqmUR4Pb7rrEpGmRY85NEzT8=
Received: from github.com (hubbernetes-node-a55abba.ash1-iad.github.net [10.56.206.73])
	by smtp.github.com (Postfix) with ESMTPA id 2C9E952121D
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 13:42:08 -0700 (PDT)
Date: Mon, 04 May 2026 13:42:08 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1089431/dd093e-000000@github.com>
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

  Branch: refs/heads/1089431
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
