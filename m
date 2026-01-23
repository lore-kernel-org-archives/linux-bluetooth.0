Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4B2145B27
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 17:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769188591; cv=none; b=ltBavV+9YqoeYNJ8T1jCDsxqFonNUAG1nCmZeUOAqlobgZt0zNxtQwH00zos4esgd2xmhbWomrVTgW8/m64kNS6BJZNQ++YUKkeEIYZqYwdYgwIMjS8HNRdSBxrNkPY9LdHsYeRhX9n0f+OYIvfSFkBdHMjuyi6Wy02KSW3OQOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769188591; c=relaxed/simple;
	bh=xUgtU7eWhutr9tbYiJeUB7BilHH4dIDetAkUlSgJ/Rk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kS6phPsiVUvQIEycYrc0H6Bm9s7tY/WuNQT2xS3jIFSa8UtgdGeqy6UgLuUYvSc9pmC2iMHSaG9HtiiZLGbXy6QjcJQ55h9CynpwA/VDQ9cR9Si5dagzdivB0BIhW5Yc1Qd3BoxEJPgXBpzY95qJjKKQ2+w7egYfJOvLcfgnXZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TX58EsPq; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TX58EsPq"
Received: from github.com (hubbernetes-node-333bd72.va3-iad.github.net [10.48.176.36])
	by smtp.github.com (Postfix) with ESMTPA id 027743C1252
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jan 2026 09:16:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769188590;
	bh=4aAifP7h0C8AXb2u15wT5kZ2kH/jKP0x2Hcbk3IyTAs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TX58EsPqZLy/xqe14RB0PCXDAxSCrowlU9BAazHZTA6du8IjvvWTX7tqcPNFZhlkh
	 dj9Kkdu+hrD13sA7iovW3cOCDA/lZLHHLl83/xL0sHfwkosCqn2oDrUiltljmMAjdB
	 8Z4qUwA2M3nzls1/kRhD4sZYV6PiVSxConXQ7Uz4=
Date: Fri, 23 Jan 2026 09:16:30 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1046201/fb2c7c-000000@github.com>
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

  Branch: refs/heads/1046201
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
