Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF9844237C
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 19:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996515; cv=none; b=idVVzT0caoM5JgccQi+Av3Q8NfglFmsNZmZmgp24coe3h82owpSJgfyJupAig1VaIUapcXkCSSvsNuWnuQzTc2YF0PX9w0PQbQNrbnOe+ILF35Prk+nvcQ5fzZMQBJxNH55uL8GbPnGozIOxY59vnqGkWV0eFHvUx9qmscDMczk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996515; c=relaxed/simple;
	bh=UGerogvGZvHvB9O5pU70y9w9CL5lrtSoBBF3vOxMets=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Wf/IT6BARWwyDFEycjgyCdyW2EO0K4cocBa9y2UDJ0ceMH9rQchJrdlavi4lZSQV4BKXkxEnlxkdNnXyJcR2cX1bzgaIF5i3tyrkg7j62z4rosBxUOEKtlSAL00md8KQFAuFVdPy6MVQ0yyt61eccJpWcTd7YPjfypwHF0mYFnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=GgRJh144; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GgRJh144"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786996513;
	bh=p0PrU+6zXM9vSK+q9Ar9NdwZ3AkfJJeLlXnhx4bF078=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=GgRJh144MIANTWgr5hS7iZbmpZakRI4V9S6X8jPFiRRR4xn/O7pHmluSqz+m7BpJu
	 LKQJd8mpGr3dshPodH3QdyYffFWVoFtETEBhXdrh7mW0Q2x8WkROui39QJew9W6gUY
	 hYETN0zdFEv5eTDAtTIMbtST8fFjbRV4aiplzWIw=
Received: from github.com (hubbernetes-node-c0b29af.ac4-iad.github.net [10.52.180.41])
	by smtp.github.com (Postfix) with ESMTPA id 54362A1348
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 12:55:13 -0700 (PDT)
Date: Mon, 17 Aug 2026 12:55:13 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1130150/4df3db-000000@github.com>
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

  Branch: refs/heads/1130150
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
