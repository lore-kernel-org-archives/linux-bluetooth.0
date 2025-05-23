Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18A443AA8
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 14:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748012294; cv=none; b=ZGY69QAooGpXAfDNaQfBT2vMFwoqhSSDnBOVXutQb8J2AYfvypl/IvwgbCR+HW6DHLI3/JQWBkIwOw30bvwROagP/UsbLb+SSYVZsKJHI7xkL+k/jRA7uKQBQCt1eGIA/Yx8/u8oGjOTOOh1RuTDaMH1N1m7Um9Dn/XNX02SgcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748012294; c=relaxed/simple;
	bh=VG+f4T3m957ySWXwJmX3IXMWjBCw1BWzxo/xpd/nQuE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=K8Y+JBRZGNGQQ6vw8mDJ6aecKKa3ucEVyFmwjCBuYx11zeYhwvvxtQfzy2hHiPaL9X31u8t4/5nJknPQvkYL5T+ou0DnkIBgIKG3ODrC2yeLSDZ4P67TQ42wY6r5v5l/AGNDypyEtTZblk+/tBk7CFG5s0olJcKYU8wMsRPbrfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HQlvi7RM; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HQlvi7RM"
Received: from github.com (hubbernetes-node-87edd45.ac4-iad.github.net [10.52.206.19])
	by smtp.github.com (Postfix) with ESMTPA id A9E5A640B3C
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 May 2025 07:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748012291;
	bh=aAX2Y3qqXthAd/E+pIII10HCw03ekwo8srIm4uIPdqU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HQlvi7RMsXPcY/HYi+b2knczPlwM6takuE2uo0Sju6taIx6hEA3tzKWJsKgrec+kk
	 C6/CT9KsZvIzqHO4RLYu0idN07Zqx+rb+AnJVVfothTvKFhvnVQoqHKQsW5YfNFmSR
	 qXRvEYk95VmKLRzA/1pyKBXlYrShhJjWtcJCB81k=
Date: Fri, 23 May 2025 07:58:11 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/965496/9e97cb-000000@github.com>
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

  Branch: refs/heads/965496
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
