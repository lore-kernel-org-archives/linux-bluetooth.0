Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A27125DCE0
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752512342; cv=none; b=Ni9wVnaOX66Re8R8f+lgjo+fG08DUhEqmLAZKu/IuyDWcT/bjpqpc2k9AMw/o3a6DUcsu2KB11lBBGltOf5PTyMbV0FfWVdU9tMwemaESXEsW9Yp9qt1Qyokk33sZJJe5mq9AjQjTtqW2RmUtQjTTbN1LVyM9iSU3sCPZGKAC6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752512342; c=relaxed/simple;
	bh=VmDJRdyYUdS8APAfqxbwF4u8bAlpilHV6HuCPEePsRk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SkwXGCfHncA7Oq4l0THuqU3z6n4fLcMS8HB7t93o3NYcgIzvKFL3HL0G/BduRlhZnRrEhHb7SSb4xmt4syF3c+b8gcVv/ef9aHCpqYjt6X5puKMXZ1q0CDcvjz6Me5/9op4F6T/y1Jj1brMDtTrZKtDUxWUjNzme3bVpzm6AFeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RWm1u9jr; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RWm1u9jr"
Received: from github.com (hubbernetes-node-1c2c9f6.ac4-iad.github.net [10.52.138.38])
	by smtp.github.com (Postfix) with ESMTPA id 3A428700C75
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 09:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752512340;
	bh=cxophqlY6NTjj1jgTzSotE8Ox9ksiFzCx77XQCfQmRw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RWm1u9jr1RamXVap5TZPHcClUWbwX2K3aFLeuJnrGA6RCsWc+dg/shwCJ7UWMoA1Y
	 HKPnJgrhYU2f6cPuguBbIVWUWRuaOHtEu0mKC0gZ+sjDMvFlJwSbRYzxuRnzpYmCOj
	 zCcLkYH+8H9PTm5MPC/8ZTHyhxVVtARAEE7J6Sxc=
Date: Mon, 14 Jul 2025 09:59:00 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/982089/19c427-000000@github.com>
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

  Branch: refs/heads/982089
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
