Received: from out-5.smtp.github.com (out-5.smtp.github.com [192.30.252.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F873F7A98
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774526785; cv=none; b=ElAipySyyI92CMqxKa54EzJH1EXVZPka9/wzYRtFFfasx6eoHZdf903Wm6KSFTXo9tNUes4ST+d8/4JN8c8+FSWwh4dA/sfjOPnJVws5TptMUXFYPtPbU4HNsKGokjChFtkJccPMXMcVGXLoncf3lhpQgYqj/IAPf0ZQ1yis/so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774526785; c=relaxed/simple;
	bh=4p/dZ0GLzzdfuKrV/PGl6v59nPNDnd86+hpzFYq1Swc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jt/K2wRO+Ksfz3zCdalb5S3wmnuaHsKtH3b6rLPFs2wipumXBRYm59p7KHaFvlyqoDEZTC+eSOtzw6dK/dsXnu9O3yklx4e12YuYa9eK8IHR8z7pZzOPPnuJ9KXnrksRPNPl+AC/8VI/VuN4pj1VQ921kyTezjB6c1CkJdCJSp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jbLffsis; arc=none smtp.client-ip=192.30.252.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jbLffsis"
Received: from github.com (hubbernetes-node-8581678.va3-iad.github.net [10.48.82.27])
	by smtp.github.com (Postfix) with ESMTPA id 69A139010D1
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Mar 2026 05:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774526782;
	bh=b4j5U6LlSBgs0pyznQUXigjHhAcsmZxumJSvTbItZs4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jbLffsisVml3y8Qh1ysMJsqM0i1DNGLM1JlysaoRWr1iecAooHwRSorb4OWI8+kWA
	 JiUQKxW2tIVSfUXCevWOr3yIJlMv/eLHIJXqyw/EupeXaSpUvVeQ8AeQPbe38DVtn+
	 ioS49nBzNaboHli1p35BVERgASuO7eK1eIZtQPis=
Date: Thu, 26 Mar 2026 05:06:22 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1057153/cde4bf-000000@github.com>
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

  Branch: refs/heads/1057153
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
