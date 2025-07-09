Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEB32E7174
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752073969; cv=none; b=LJyCiMXhU6ZVR/iz1TwN+rwinXr4+lUtlRvBf4an4GDx+TZtwzmSrsRIKALzYEZQmjd1C/8yU8hTnnrSizN4SwPOXYdquxKb+oE253eQio+kPjDdtL7jqhxgloufhVzrqSLJGqO6Sq4yaGcQxmH4r5Fxf7qzXxJM+TEAYtDDYAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752073969; c=relaxed/simple;
	bh=AbaK+Gv2UvYzLc56smytdJ6WowGgCD+z5KBjJnmRpqM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=llNAIjqDCrp9luo0WV7U84c6muQhdxm8bZmo0grr3AGGDCgHJyCKWmlU4EJB3nNYzPtZkN/ktqqVbB7pOBcZrGtpWfcAGEQPs3ki3qglLlR5jIRJ0Rl2kRXnIe5t1M2W/I/pH6Lbt+bz2Jc0ics36anA3NytwPWzcPjvccjw3kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Si5AHW3W; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Si5AHW3W"
Received: from github.com (hubbernetes-node-3c76092.va3-iad.github.net [10.48.137.38])
	by smtp.github.com (Postfix) with ESMTPA id 8B4B48C0405
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 08:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752073964;
	bh=mmFyvpYikx/kweVuBtFp97HFeShoTpYtQqJi5s+r6zk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Si5AHW3WTnXYl66gw/5x/raIfwxPS74yhWTr1RJThFxxVXApit7b4w9SbmWFMdjDK
	 fthnXQC9/j5M/jxMsy9MhEW2MmwV6h99TLqr/KWeK8mVGyfR93hSmhDtXZLNV185Ws
	 67qtKprY7BYTvs/83wpZaZTtn7BO52Oa4Ndvx3mI=
Date: Wed, 09 Jul 2025 08:12:44 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/980525/086150-000000@github.com>
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

  Branch: refs/heads/980525
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
