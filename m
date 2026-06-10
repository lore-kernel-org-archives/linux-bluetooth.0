Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC96312826
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781099381; cv=none; b=B6o37PQa2pWxXhLPNW/v5WsY5ixIecrFlAv8w6iut8KvGAo1+rd5kP4ht84ARDazyf6UdzE+5u0ZbIkU4fykflN4J8yKlI8/Gzg4ROQ8+OUUgQ6RK67oErtoLoEAcdV7dxF7n3wWcDkXlxsgAiHJMwYoBgCUAujOQM16cPwrgCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781099381; c=relaxed/simple;
	bh=fwkYmjkAx2MkfbRuEKZQI1mkovywMKycEwMlyoMIw40=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tNw853XAyP6kqHCVq1ckXLu6YwlxP4Sm9CkrzhzruQHOM8wQ9VNaax5PHA9ByDP33F4MLpvDpm3ZtWyI7IwUZ+H+ReCHzMS/NPgJ6v1gNOMaLQwZ/mwZtKQxaLkM7jOS1Sf2PffaT68iwm5nOpiFUN9+ub0b49PaPJfbqkVzre8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=DPShqABw; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="DPShqABw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781099379;
	bh=0DmcIHEbI4uH2ZHuSrgruv594jOxAtyJK+71QUJ8B+Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=DPShqABwRyTFev+3HtHxcvF9rLVq9YYm+yw0hn+Nxj/IHF9JJ+Pb2kt77Ao3suwOf
	 ZzKSPiH6eru/SULMokvJh5s2dVdy3tI28Zg8oWnXXRAZKQc+wihRys8Yp4fiJMiRE8
	 rH1+VH1D1YOeYko0KCimd35fOANGZlXHWMmohYGQ=
Received: from github.com (hubbernetes-node-049d9ff.ac4-iad.github.net [10.55.88.34])
	by smtp.github.com (Postfix) with ESMTPA id 9B733941365
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 06:49:39 -0700 (PDT)
Date: Wed, 10 Jun 2026 06:49:39 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1092705/4246ca-000000@github.com>
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

  Branch: refs/heads/1092705
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
