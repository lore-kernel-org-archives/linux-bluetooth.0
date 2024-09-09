Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271451741C8
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Sep 2024 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725874536; cv=none; b=nZPXIAr1ZElhaADms8ZdQD30ZrJ05r0+GJcSNWn2OBUo/bPpq/rfZW6pLJNIZAGNp7MvS1cchzJuX7OTFgw7kxT4l+/pr7/aT9Tr20YF8nhxBJh9ec6cMiKl0ndjNIh3yQqd927QM3kd3y7Lt1SIX80x0kJjO9h0CxySaYtwlkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725874536; c=relaxed/simple;
	bh=m6udcIbVbajT87VZPz0FwR9aAyr8zAuZgsRXpnyv8BM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Q2XgG/r2uqquPyMx3fqFKs+Wn7FkA1qYLWfO6yypyAALnFEjnEhJRd5u/6m0lItxvRq+lbcTjJ5zLQ7BTc599InDYCrw+MFyDhNRoTPxrxmEJqK4SDmfQhwrPCZ9y35WKItT3F48x8NwvnEgAog3rq8Pw1wAl1oG6j/5+YpySEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JaLJfotp; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JaLJfotp"
Received: from github.com (hubbernetes-node-88bf5fe.ash1-iad.github.net [10.56.154.28])
	by smtp.github.com (Postfix) with ESMTPA id 21A096C106D
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Sep 2024 02:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1725874534;
	bh=N1nmqtlcAev5SBk4AeVr0SU3TXu1a6ROcxHeQ4MAAP4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JaLJfotpCyDxY02o9Avyu+YQ+mHHI3fSsRrLxdqTmt2rHJpp7itfeOnpGz1Bxi/I6
	 bJfhYE3VbfQRA2prxYLMiZ1pFv9lPrir2c/+/z3fCcUYw+p2W2c1cVegh+ysC+DPRy
	 Sn3tYW3orkJCMPNfSlzshlpvbX4Mem1UzyMNTPMk=
Date: Mon, 09 Sep 2024 02:35:34 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/tags/5.78/000000-9fed98@github.com>
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

  Branch: refs/tags/5.78
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
