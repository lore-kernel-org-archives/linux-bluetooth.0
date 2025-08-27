Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB88302741
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303993; cv=none; b=gom6kMdxzIEfw5YngBtkZUyDKboKh8FHy1Dqleh0AZFE6RHzN2ED9BmQ1ZZIPWRiyaVLLYX5ZqmxENNPNXKT0Z1V9fNqBM0V6ddEyl+cxEKjEhD8d4apDpxH8+fFROCl+RuXeTnU6LaPVq24FWvEK2Opz7j6ASuaOX+ptwwWIo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303993; c=relaxed/simple;
	bh=XaNLaFmd7EHUYcyU5V0gPkHGbvmqJev3bFkJ+ncr6PI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JItvtGFq0Lp5kIRaqMyI5uc4I8fXCqYOImwnaSuNyPPsRqrLKb+HBV6C3fmtpI8bqYP71ZfjnIoEfw+pEpb+rgaTERq+kCvKpvOVXHLKdD6CCwNnLPE0RKLxcqIU0vRqoHEGIiL0kOkrDvPn9AnqdyP47yKNTKi36YozgC+VuBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VviFmGPQ; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VviFmGPQ"
Received: from github.com (hubbernetes-node-8fc6b07.ash1-iad.github.net [10.56.143.36])
	by smtp.github.com (Postfix) with ESMTPA id CEC8714138A
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 Aug 2025 07:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1756303990;
	bh=9zwLTw+o7FpaBwoJh2B13pi+wkgk5XxFHtq2VzR6MZQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VviFmGPQT58vmiv5m0Qw4S2/RIjYI893AizpdKrMpeS0kTE7rIZ+mTv/wobk3J8kq
	 RHlsQtk5EFKjGsIz1SySqWs4FdjKrNaGFQ5LWMeLcmX3vwu6YZnI31/eqH8TRyrPcw
	 OhL5nBA3kjJUpARTJwS62qau9GM8CAQaBRZQULdA=
Date: Wed, 27 Aug 2025 07:13:10 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/996079/000000-6b5b35@github.com>
Subject: [bluez/bluez] 6b5b35: client: Fix transport.acquire not doing
 anything
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

  Branch: refs/heads/996079
  Home:   https://github.com/bluez/bluez
  Commit: 6b5b355da4722e156729420bfa0dcf7ffadf0d48
      https://github.com/bluez/bluez/commit/6b5b355da4722e156729420bfa0dcf7ffadf0d48
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-08-27 (Wed, 27 Aug 2025)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client: Fix transport.acquire not doing anything

If transport.acquire is called for a transport that does not use a local
endpoint it won't call Transport.Acquire as the bluetoothd does not
allow controlling transports of other processes, but it doesn't print
anything either leaving the user blind to what is happening.

Fixes: https://github.com/bluez/bluez/issues/1532



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
