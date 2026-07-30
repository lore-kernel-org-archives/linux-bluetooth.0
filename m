Received: from out-5.smtp.github.com (out-5.smtp.github.com [192.30.252.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324AF446062
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427741; cv=none; b=ISDqKAUKJ7Lgk2tyWZ+YkwuQtmSXIy55xhEMSuB+OsaRI6TCVTs7jBUZkSpABF9+0iOCLh6on044pN2ZNLtTZojGS4foIfOfu3FYcg7+Lcn8RQhowv+4OGwQ4jIYoNgWtg+EwWhkPSAKXnDfU9wGqSJMVYfclsrLst3RafvyiU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427741; c=relaxed/simple;
	bh=gMtNyeDB/vfHdz8AuMdYZSJpcB3drVljJRXYOu4zCUw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=mO+ixtw69K7ICZUINFzilHIWLserOoQeNDAdwlObeYBoSrAIq5+ttAlyRlkv/MJA2cRs1J8wnRAvSe1mGs2VGJnIDIjJnUsA1MNcQ3hv6n+wwTVow+4PYUE09WqUFI785VZbDRcq9ai3OAWe5gKDdQFrpm5GK6NuJ25g+QjbaEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TqAxj1/U; arc=none smtp.client-ip=192.30.252.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TqAxj1/U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785427739;
	bh=SvihGl5VZ8GSdWTkfsJAum4dHm8rf9MndYtkWlKpsgE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TqAxj1/U/pdZADw66dskOsp7I5PKs/jCJOdr1gy8hnDcIGCUCoqBIqaRgjhYIJMoT
	 2pQYMlTRKW5YtWcO/RTxTc0+K/PnKC69crDnsUXkGj0daTkm0bpfHRmZLvzsEcS4MG
	 TJkx6St7i23NpaaxOM4/1GeaaLqQmQXQt0u0Je0o=
Received: from github.com (hubbernetes-node-5e2f653.va3-iad.github.net [10.48.69.98])
	by smtp.github.com (Postfix) with ESMTPA id 24666781061
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 09:08:59 -0700 (PDT)
Date: Thu, 30 Jul 2026 09:08:59 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1137145/6ecaf0-000000@github.com>
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

  Branch: refs/heads/1137145
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
