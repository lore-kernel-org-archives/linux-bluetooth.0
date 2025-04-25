Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAFF2580D1
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745590800; cv=none; b=Mc84ik0coFoWOawR5ByfxPZakpsMxI/9tc1YOIt2Mm8X6MeQp3PRCMQAB93JcIVYRjib2F2UjTTLRRGyoJTQLokX1ZjNqU+0elwUb6WhHLy+R92V2mX/CQ8RJwQk3qMvl+Ylr345boo4bi6UmyRhX+qUEHAJRSZqheDeoW+Es5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745590800; c=relaxed/simple;
	bh=4NsTYFHDLfwaLPn/deg47uuUBqVK0fsKW/8xBwmsYqo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KPSajX3aQXBiM4jz3YsmcnTIJGruacCwxpugnH7HLCIeTUwqbaeHhd73zzMMo2i0ARY9XYKFVpZP0EhPTthRVq1FcFM/13KubN4vnVbSAmMnKMOWTINhrHuZkwGlaH8f5D8gKsNKHpWUGLsKnzmp2gltrz7YQ0xxpGsSDFAhzJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IFlC0Mcl; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IFlC0Mcl"
Received: from github.com (hubbernetes-node-771dd34.ash1-iad.github.net [10.56.173.26])
	by smtp.github.com (Postfix) with ESMTPA id 903EE140AEF
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 07:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745590798;
	bh=zPWTuN8r/8XxnqG2FtKKWa1Gf4SJnZ21erM93xjDjTI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IFlC0MclKL+mKqpPoph24m0WIL9WhrehSWyqq4S4VMqjFhDQ8Jt538VnGC/dowfWF
	 hYUUduiB9XBdr9JCUw2epBAueANRda7O9HwUfn/JmKc2dxOh7PyzpHzFYGlW+pPH+Y
	 mkRtvv4qNwHBSjx0c/gCROdmb89PUNrJVVpdttPg=
Date: Fri, 25 Apr 2025 07:19:58 -0700
From: Arun Raghavan <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957057/000000-592727@github.com>
Subject: [bluez/bluez] 592727: shared/asha: Only update device set after start
 su...
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

  Branch: refs/heads/957057
  Home:   https://github.com/bluez/bluez
  Commit: 5927274f22728affa6de7e3067752bc9f85b095a
      https://github.com/bluez/bluez/commit/5927274f22728affa6de7e3067752bc9f85b095a
  Author: Arun Raghavan <arun@asymptotic.io>
  Date:   2025-04-25 (Fri, 25 Apr 2025)

  Changed paths:
    M src/shared/asha.c

  Log Message:
  -----------
  shared/asha: Only update device set after start succeeds

This ensures that one side's connected status is only exposed to the
other after the connection is actually complete.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
