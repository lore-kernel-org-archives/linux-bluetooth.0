Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827E944064E
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 19:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787169489; cv=none; b=Q7+9wETXRGK6Bb4Wjixwk7QNnlt3/hUto/TmCjWQCgjXclsenKDLeVhuMOoQ4MdgHSWuyrke4jHhATPQuCFWGuMV15goRr1C8TmKO7ImXD4D1+7hpJN0JbDLPhtntL+VK2CFQm+aX5aquBo17Z5iDIXFkkO0wfs/tkg+8Q7pjco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787169489; c=relaxed/simple;
	bh=zuf0RVuCuWVFaFyQ63gjrH/xXoTjK6CzN9pM79/nir8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aoZep+ad4ZeNclPgJfBnx75m0YcnjChI7nOTJ1t0ePetzv68FRUUrPKMRuBieXmDctW7G0HITcNg3610WKl4xO/7Wv3GZp6TqV3dsDzTk1ycc9qXZtpopBxaU027AAJoIcq3Aph3ffNvasCY5DaBnSwiBulAjhWQYya9gx/VcfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EU+SInPr; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EU+SInPr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787169487;
	bh=sKhkzChjDm+guAzQF7JKJlCyinU1Y/4EuHjhKu4g/8Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EU+SInPr5JWVynTwcMUhMfDSoqWfpEVjy1k1uYz6hOnyczh2BYZZuzexgY9GkXKfI
	 zUHhdAbNM00XpDqNw77XBppYG+vDclsIiWQbB+WSqjO2+HKNqapT4T0EF6Asm6vnmJ
	 ArL4+nrIz1gG/0r/xz0zC+l9E/nsVdr1Oo1dDqtQ=
Received: from github.com (hubbernetes-node-d6fef83.ash1-iad.github.net [10.56.131.35])
	by smtp.github.com (Postfix) with ESMTPA id A5CC060138E
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 12:58:07 -0700 (PDT)
Date: Wed, 19 Aug 2026 12:58:07 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1147094/bff6d7-000000@github.com>
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

  Branch: refs/heads/1147094
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
