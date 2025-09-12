Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF842EA73B
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 10:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757673819; cv=none; b=Iy6MxywjHCoeNwfJwboJVZIN7DPO3YAZbvoNNBWjyzt3kUTM4xcP7OEFUlya7Gcfb/iGFiF53bFJuPsOn29bt9hW5scb2gDDnrzAO+A2+C77PlOTLZDBeGYOBACRn7Px7De/bI6JnG7werDFqeYPdCvJMt+a7+nSCzR0KiUA2Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757673819; c=relaxed/simple;
	bh=gxWPoMdzp0hskhXWHIpp4Ya8q+aave6NlpyddM9BYVo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZSyHyVD+xW47eM2FWLwLQ6FafFkk68uALnfWDoyXRpC4wvbK5tQQilxgQE3XHGp+TtMuxBy06VRg1y8hoOdbHuMykrJt9+b8F/diRR3DVWt5RSRgS0YemLzm7KhP30ghKMlKTY45BEMZz7hCfeOAlIjePT+ZXEWk5plxoUK7POU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kF7snt4y; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kF7snt4y"
Received: from github.com (hubbernetes-node-7a60172.ac4-iad.github.net [10.52.179.65])
	by smtp.github.com (Postfix) with ESMTPA id E4B3A6404AF
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 03:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757673816;
	bh=OFJfsAjncSPl//wZBiNyMvdmE3j9XHvf83b7Lsig+aU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kF7snt4yXuhkmPsIXWLfZgfr0SZSHydHrOWQ02VECNl8wdvBbg8/3wI8qbNQxpVAy
	 aDbjD0r8QjZMF1YmwIgvl1UOuUOEkM0Ai1dAlbmkFD5Nc+Ia2DuFAs0RK6PB2KNtjU
	 63+1jmKfNwrzoJKTvz6fOFkFbWpRyd3wiKeoakLw=
Date: Fri, 12 Sep 2025 03:43:36 -0700
From: Andreas Glinserer <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1001717/000000-e9bac1@github.com>
Subject: [bluez/bluez] e9bac1: src/adapter: add timeout for missing discovery
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

  Branch: refs/heads/1001717
  Home:   https://github.com/bluez/bluez
  Commit: e9bac13f371845d3e38d7040862fd092c17f40b0
      https://github.com/bluez/bluez/commit/e9bac13f371845d3e38d7040862fd092c17f40b0
  Author: Andreas Glinserer <andreas.glinserer@canonical.com>
  Date:   2025-09-12 (Fri, 12 Sep 2025)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  src/adapter: add timeout for missing discovery

Add a timeout to detect when the controller stops sending discovery
events. Without this, the system silently discovering new devices
and the scan list gradually empties due to DEFAULT_TEMPORARY_TIMEOUT.

When the timeout triggers, issue MGMT_OP_STOP_DISCOVERY to restart the
event loop and resume discovery.

Link: https://github.com/bluez/bluez/issues/1554



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
