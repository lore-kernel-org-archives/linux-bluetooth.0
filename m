Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A893CE489
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 06:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787119412; cv=none; b=MLAG4TrLLNQBi2RKTvrSxtrAX0Hp9Ox7OnsexoHzRwcUnbri7441tt6E937uUzmfDTTdUNeMYqk8iHLs/mGm88ZO7JO0Ul1vG2l+LzwxYJfEEeV6fReiBnug8QRmLnKjb3psBBRwcytYuL62oUlEQ3w0V+hnaOj1JdNxC5WDCNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787119412; c=relaxed/simple;
	bh=qNirp8VQGy7QxmRAluiiVarPdd39oRmez/lLiws4TEA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OHcVhsEuzPju7qFnEXGOipklFhVWYFQ46AYbA+se3K6lmcjAH5xWYGnOQa1g/qD1Idg+BwWOjGX+T3GG7aRBLoviGKG4Mo28gJX64G2NmXZ+2JAGt8b8cdROiZDirEV9XNrRt5f9OJBCl0+N+arGeu4iKy9WHY2SrlY2xCSiLk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Kra7cgQq; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Kra7cgQq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787119410;
	bh=TDAHIbINKQYAHUGHuHClETZ65VqfYQD/2lIRDdNsguk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Kra7cgQqhPJdEua22rwo+tqK/RYD/TEnXz7qCocCVLnB+ysreUxYai21rhBrsmzmI
	 xPNf5Qu9ozmK7vDPB6yW+DbNXjz6bOvzzqVX8XnW+zwj68dx6dJEBJBAYUK3laWh2p
	 OD/Fo5dXjW2KMuyHjuGUwM96q6emRYxpQhPcoGO4=
Received: from github.com (hubbernetes-node-d278581.va3-iad.github.net [10.48.94.93])
	by smtp.github.com (Postfix) with ESMTPA id 242EC28144A
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 23:03:30 -0700 (PDT)
Date: Tue, 18 Aug 2026 23:03:30 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1130548/0108e6-000000@github.com>
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

  Branch: refs/heads/1130548
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
