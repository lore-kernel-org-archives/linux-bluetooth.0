Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34B127934B
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769100091; cv=none; b=JSixPbZ1pFHVJqAhxHj6BvmgrhMdPwymqndzhhcqZAZnIL89WhpK+SZWtrKA/KvlMh3SsTqEUYbLYG68S6BUnjVeYg6+1OptUHdqt15YQorQrVHcKJqn0lEDnAynRivmCpJFRjiUeGPnwHsHjI7ZqVxCi3mYo4la+z7UXquF59M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769100091; c=relaxed/simple;
	bh=j/AUlFnJPyXsU/h/HEHm3+cFgL+YVsKEBacjAvRBSJo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oDP7l2sGDgYB3z+WHDaYBr4FBV3cI+Wg8deFCqMP0LIpgwLLXXpj4gBIvxBzH/Gf6v9YfZd90ld/Te0vXe7BWtV3CUJ04N9Gu3Eux22mCRUHZUtG5qrG/Tq9vJ2ZVL3Mwmpnd8ikf2kEQL1ktrecSaWdlbF5KMDjj7HVSTZNkU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=e/LKC4BD; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="e/LKC4BD"
Received: from github.com (hubbernetes-node-6eedad9.ac4-iad.github.net [10.52.211.28])
	by smtp.github.com (Postfix) with ESMTPA id 688A8402712
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Jan 2026 08:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769100079;
	bh=TZyeNvJcZ/6PmuSfT+ZttcKigoyqIXkXZMuPsa1zw44=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=e/LKC4BDalNs85lIOLzDhD8V6YlJrbusxbw04u4tXKlx5kJaiQ7W3PbfJFu8VnC1R
	 4REg8S+y8XYi55kYv2YObt71GOSuITT+mPMGXXtghrJp9ILX5L7URCn6l4BUdNAUaB
	 VMjF/B5vVGz4YDXBk6u1hDqWrSN7QaEB1ZyuXQ/Y=
Date: Thu, 22 Jan 2026 08:41:19 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1044781/0d4960-000000@github.com>
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

  Branch: refs/heads/1044781
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
