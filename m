Received: from out-43.smtp.github.com (out-43.smtp.github.com [192.30.252.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48A62D73B5
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783614655; cv=none; b=cgDdxQ7k8q/eF8pC/fhhah4cXlgJIymsS4mgvhaZQbUFrQ63w8UYWMSrJsy/AHPY02mutjH4Ho6U9DU5nEVXX24NTizthnWGZ+rlHqKIxJj3HOcOrDDk7zH6HiNQQHK9cxnqYj5qSaA2yHSuzsd/zk61NECrn+5Im/Xf+ygYfxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783614655; c=relaxed/simple;
	bh=5xx2t/IAyk9M6vJfky3JQONZ9gsGqu27QZVr2pwstpk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Q2oLd2E4ws0mURgyQyBkLr35kwemG89NQKKwlVAOMpF/d5O+vG4hwTB+0Pp7ppUghN1p/WbUHz88mKLbbKIFTRQxjMJwHe0IEp2nXZhIj/c0rUKmtDzIv3iR2RPkw2LUf+uVIP5Bt1tuRWDejZJImSjWwbFGfUFqYe2lqn6nKTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hgKZxbkL; arc=none smtp.client-ip=192.30.252.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hgKZxbkL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783614652;
	bh=9WAnkTgCmRPlQUTax9fn061FEQS1OurEiS4p9wejrD0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hgKZxbkLvgfUyf+Hnxn9gvrZ9cq/0i2o0GnZuKqxLTvp526uB/tqANwC0SjkpeumE
	 5OLoSFY3xzedkCw/kcuA2xLXs7XT3tJ+ZN/FLdUbArMcbkWCG/SY5TPcOLHtxv8ANB
	 wGjG3xzliEvzsIUdoSk1a4fuIVpGRsdgS9AbUsDg=
Received: from github.com (hubbernetes-node-ee6dcb9.ash1-iad.github.net [10.56.146.45])
	by smtp.github.com (Postfix) with ESMTPA id AC32C847DCC
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 09:30:52 -0700 (PDT)
Date: Thu, 09 Jul 2026 09:30:52 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1122826/db4489-000000@github.com>
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

  Branch: refs/heads/1122826
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
