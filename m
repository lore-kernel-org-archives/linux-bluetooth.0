Received: from out-31.smtp.github.com (out-31.smtp.github.com [192.30.252.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001A838E8A2
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781208202; cv=none; b=dcaB52Q1xmVqhsKf1boSTj8yq28dfOJd5aVI82US3GwJE4DBqECo2Hgqna5WkgfFuRq9ytN8vHGFlWaAo/PiyqgcP1eBn04kkZRJOset2vZDOOUyzZji6TOdA49oT10JwYk1I2Evvr+rULriypHU0YgwH96CXVf40O1jK1/q8iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781208202; c=relaxed/simple;
	bh=IGDeuoFQgp6XaTGUYd7iqEPByzxI70Flb9Z9yOaADqc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tG5dVnWAOGhVBQ38S+LO7uyNjfOjzofKTxk/8xMfzwgySe5KclvvPR8Nrl8wSgGNanTcVKZckXMcfDd8JJ+dWHWp72Yj5GYvI+nKN5V7KomasTqKgsZBDw09QfSPr7ZhcCh9BBcHRrxb3GPn63VtoIi+/+IzQOiWR/FWvSTs3kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PTjZDlDs; arc=none smtp.client-ip=192.30.252.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PTjZDlDs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781208198;
	bh=0u9qrvY1T3xjI0OyzHihZC0m4I1y8s5nhnG9VJdtOow=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PTjZDlDsKmmazn/dT8D1jGMaIZ5I7GSq7cGIppAvEplzrNPDNpgEniWtgPRtB8LNk
	 EqPXLPSCYzr/WvoR54lC0ybrIh81R8nl2t1nZBwndf/9cmttADXhn+IRnA8CQHWhhJ
	 jKf3mCdxn0viFyBAt7WeeIb+qb7aoA0V4iEYN4ng=
Received: from github.com (hubbernetes-node-799d65a.ac4-iad.github.net [10.55.99.45])
	by smtp.github.com (Postfix) with ESMTPA id EE84D320929
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 13:03:17 -0700 (PDT)
Date: Thu, 11 Jun 2026 13:03:17 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1110215/ca320e-000000@github.com>
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

  Branch: refs/heads/1110215
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
