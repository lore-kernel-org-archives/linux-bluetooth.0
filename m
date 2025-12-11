Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311AF1519B4
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 00:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765411278; cv=none; b=Y//n49upAWfO2JyCBD5tri5nB3YIRsypzmriTXAfh++Dk255YvkHNauue4ro0+LzsoRdduWO29qNugjl+LSZldLq/dEdoKPJtuICt0CeurEOgpJUWH+daa1yEwuN5MmFolptkkkVZZPFwQUqk6onY1CONeJFbVFnZf6zboCtXpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765411278; c=relaxed/simple;
	bh=pe8ARXKAHuPGYdHlrpSAbk7EPGvh+FzxJMZgqfTadac=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=i2QgErtkqCgDHLZcP+v4kXA4/E0WC7KgaeCRpzMM/CmJyiSoPZc4Z/m81MWfTU5FzUgAzpmCOhEEVcA3HZ7SNxz5J9K1bi4Y5sWTbJMxOaLNgTOXTgbdODqQGk3SmpgJLTA0V83sIP/F7zogGHYGJD00/R6m4N4P33fmWOc4UuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UkXDc8tg; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UkXDc8tg"
Received: from github.com (hubbernetes-node-5f3a108.ash1-iad.github.net [10.56.178.11])
	by smtp.github.com (Postfix) with ESMTPA id 88BD8141202
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Dec 2025 16:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765411274;
	bh=TeI2Z3rMJNCIXA2OsIqMdH7AkmiAsc0EJYkUpw7b7gk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UkXDc8tgw/SnqqCnRdqzNAcCjbBJz6+xDD8nZCSJajoOTM9HMEe7u1Fs93wdJDUkB
	 Kch0EBzGtOVG5Vrvu3V5MSL0vSVFdb/Xi0Vdbq+btMvl099MMRrQySQ9QKDGGsUyIx
	 IDz1x9s74i6U/m2Z4mgeIN2uyQbhr1eb0yzi4mb0=
Date: Wed, 10 Dec 2025 16:01:14 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1031008/22059e-000000@github.com>
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

  Branch: refs/heads/1031008
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
