Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD3C492E32
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 15:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054771; cv=none; b=WAyPKnyhYQWORxyzUNJ99Ds161SfQgqEgTsMPmcOKyyGg/JcE36t/umjnU3ouJo70/CaWdtPkJtKg2zeE+ax9FhbADRdciyL2M7DQZzJCmzR49gfvd2d5bbQkUKiM3e4QrrwurhE9sySsyhEQ9WmjjS+sz+zU5CyiBTzAgu/0Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054771; c=relaxed/simple;
	bh=D5cVpyEBnHsIdim5klgU8IRcxmZvnJelgpl1NR06swM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dnlsWK6HN2Qgm7lYu+3FVUDzEk+KY/zWtijCjMOdI5YbzPHDcxY6XuaKJDyF69gFicc97lqu21R1dg+gOaQ+qkh9CrlJrfg4EeH+a1JWcGbza22GdUEmNi1BiXljlSQVNGEfWldj/tRMxfgyx6rICVNWbDckeP+wVGIhzoU9D7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ir0oQawU; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ir0oQawU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789054769;
	bh=OlvHP482IMuWCBHDFwwDVJg5fWzFIHj2sZVsUuCikPw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ir0oQawUEDwTjZnUVzerJDNwkITNYGS7bNdijTmDG7KzI5Hw4M4SQvFhAo8kGVmm6
	 SxsBxv4H1XGXXv1NJ5U1g7rTJ0ZThRQRr1wEvzcX/hzOpFE2KtOao+4n2pePeizET1
	 pmjbDog1dZz8wZmrOOhMAxLDKfVbgr+LRcCME1l8=
Received: from github.com (hubbernetes-node-adc5e41.va3-iad.github.net [10.48.69.82])
	by smtp.github.com (Postfix) with ESMTPA id 604A250155E
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 08:39:29 -0700 (PDT)
Date: Thu, 10 Sep 2026 08:39:29 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/action-ci/push/refs/heads/main/db1a03-8ef6a7@github.com>
Subject: [bluez/action-ci] 8ef6a7: cleanup_pr: notify by email when a PR is
 archived
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

  Branch: refs/heads/main
  Home:   https://github.com/bluez/action-ci
  Commit: 8ef6a7f4a1d340bdb02813105db904d7c410d0e6
      https://github.com/bluez/action-ci/commit/8ef6a7f4a1d340bdb02813105db904d7c410d0e6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-09-10 (Thu, 10 Sep 2026)

  Changed paths:
    M cleanup_pr.py
    M entrypoint.sh
    M libs/email.py

  Log Message:
  -----------
  cleanup_pr: notify by email when a PR is archived

When a pull request is open for more than 2 weeks it is closed
automatically without taking any action. Send an email notification to
the mailing list so that the closure is recorded and visible.

The email settings are read from the config file (-c) and the token from
the EMAIL_TOKEN environment variable. Both are optional: if either one is
missing, the notification is simply skipped.

Also fix EmailTool.send() raising NameError in the finally block when the
SMTP connection itself fails.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/action-ci/settings/notifications
