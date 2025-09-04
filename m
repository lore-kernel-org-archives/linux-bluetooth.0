Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4C0161302
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Sep 2025 16:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757005055; cv=none; b=UxMW5g+XmpI4sKYua95mngnKciX1NPzIap9ySr6etxonpLjknRZvbTP0EvzGG0scL5kwNSk0PRFr46rF4sU9C+1XkbDtHaGg48aI43pfNjkSQc0SYzHYBsV7qOKGWW+Vlo8rYl8lAIxJFRDRQ5sGJD+xx9KEa9L7OchMMmoE9Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757005055; c=relaxed/simple;
	bh=blq3Kdbro3IQ/OA4S4N9su4wZI4m6cxes3xI6lbpEo4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JHe02i3YKTcVYVTlnHYhjUJVZLKuMTZ8s8AZAKLJgnSRxGmUthXNhQcWgABY2pWSBK6qZBZ8nXaFaABXsWdgKNCc8/kEjdEw5J4m9rBKLXL3ShlxiPMjYq2U0JJYFkl2hikQ8dDo8DjHPUOBgJomJiey3DUPp8muyiuQ1riTnL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ieGtQDHB; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ieGtQDHB"
Received: from github.com (hubbernetes-node-cdc5f36.ac4-iad.github.net [10.52.131.26])
	by smtp.github.com (Postfix) with ESMTPA id 8E52E7012DF
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Sep 2025 09:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1757005053;
	bh=AwEIaCvTTfQZaibDVTWH2OgjV4QTEiUVYFQNcvGl2nk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ieGtQDHBJSklI1C41mYxEFqKoOMNpAv23+rFOuyq7qusVdUsSSyzwJlIUaCf48i8K
	 n4+z1Bcwry7Rqu4OqGRhmf1iPeZjn+Vx/3zN7aitSRpc1ly5+d4gb+h9au4kF89aRv
	 0qXQACiCskLK8Muz9b7n4gGRBZJ+s1XEPRhJEbDM=
Date: Thu, 04 Sep 2025 09:57:33 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/998542/20a982-000000@github.com>
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

  Branch: refs/heads/998542
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
