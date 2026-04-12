Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4056730FC0F
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Apr 2026 11:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775993034; cv=none; b=rjUBGSuN8GsRxbbqgeLtAF/htEkzqoZRGPRwt3nm9sthID5gPD5uWZ+RvFuKs7KPUjKY4aGG4w8DzFSr/+i36p88kWp6TPEdVCEPq+0Y511D+5O0WsGKDyvZZOOaOYMinlrwVJDRP3RiJi8GFRygoqhqeb3V5yYRkeG2Xxe6gSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775993034; c=relaxed/simple;
	bh=oNy1IpLWHwPzg+NWW+mvQ7LvD8uGm4cQCA4mAXlAQ1o=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=M51hOqMPdBiaCkf3orzG/gJj0ZWd7T/FjbhrBNzP50SriIzGNXMA65bgB6Lj97XXkGlC1tf57LbGlIVmppUaIuvvBK1r+rLSJSocFumHQ6JYeZCVZQdhMaV0KSnZMxZ4KFvGzGOM9WOc3sMtM7mqM9oaw3NfWdzA+/qz1I9g49Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iAznMYRM; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iAznMYRM"
Received: from github.com (hubbernetes-node-cf385fb.ac4-iad.github.net [10.52.211.92])
	by smtp.github.com (Postfix) with ESMTPA id 63AD2400300
	for <linux-bluetooth@vger.kernel.org>; Sun, 12 Apr 2026 04:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775993032;
	bh=Rfq7NdE3jBvUP3VbPgqJNbbYbkkZvPRxMx9WTAaHld8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iAznMYRMFTt2/8+bPigDjExRZRcaDNSbX8XjwmT4kg0HvGLNzLDDqxAqzlDr7tH04
	 v8ssWVEPq9M8uheW8VM6NMDJDYwa6MPme70yQtsG5v8Me0vT+Rx0N+kRCipUgZbfW2
	 ZL+Nt6uCZSX52icq8kvOzOyvFDdJowP/3s9OMgS8=
Date: Sun, 12 Apr 2026 04:23:52 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1066232/13a23d-000000@github.com>
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

  Branch: refs/heads/1066232
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
