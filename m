Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845D838F927
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 17:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775495088; cv=none; b=cIzXtO1eGGetwAeyASc4ytJt8pOLdwYdlGnRpeVx3hd0HbXw1ukSc3K+QN7FBFNIGd/J6VLkTF3ccCKHuzc3LX55xDXTgxrJuIjPNSC3c5hBclK3p+rr+Py6hvL5U8zz+OpBX5UwvmIfpqxxybB2TjVBRdWjUBBz28JE7RgfVZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775495088; c=relaxed/simple;
	bh=ViqhijXZRoQTc47zOI1MfHQ57wN4zgGKxyJq5irEthw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Rr/doAER5GlrsDoKYN7Hu+sp0FfpUhnjJNG+h2/2IxLvEk9/uX0/1OSdqJLIRJQFTGUtwK+DhYfLPzEryzlSCBcpPQvOF0zkL7y35x2iHbDQIGIfXRoAAGJ0ymwcTIUW5/rJBbIiG+fO/MZ4JMKsdemDozjFvTAcwjVB6+0JcfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=I+HiDgnG; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="I+HiDgnG"
Received: from github.com (hubbernetes-node-0980ecc.ash1-iad.github.net [10.56.194.54])
	by smtp.github.com (Postfix) with ESMTPA id 674D4920DDD
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 10:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775495085;
	bh=73g3l4ZtS/LSt17I8VWx50eapyky+RsAWZMb+gYBUss=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=I+HiDgnG9d2OkOJ2xo1qRSwWYOrHJOQERSh0Zmen050SBItBuko68WYMy4/okCW7g
	 9YjZNF5w5VjSHgERwVmnu1hxDEXLVpSbNuL84Y/htut/4EJaOsCELhsDdlqc2e2u6i
	 JKtHsHLxm+p8UnVSMmqDYyyjYkIN2ONNhp83oUb4=
Date: Mon, 06 Apr 2026 10:04:45 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1077645/6a5044-000000@github.com>
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

  Branch: refs/heads/1077645
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
