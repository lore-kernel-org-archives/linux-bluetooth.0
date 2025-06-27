Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5041272E71
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751014616; cv=none; b=o/k08HFDpYdiMybPWHs4AZnaGBEH8HKg1aG0FEv04KnHy8L2/I8bvnjd2DEWQRZRYefQIf7zt/ASA/XTD9ILlMOIpZCB5FjJHBrqiMn1iHbXgb+OAZZtjMo22RQR6uT177ag7biS4AWWHx8WiQ2e6ofxTHuZlHEHBtTthQNsrsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751014616; c=relaxed/simple;
	bh=1t+k/5a3Yk/GZkLdhZQd1gG/Uliw57D3vdnGXJn6E5A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dYDSt4b8wBt5wAy8DpnUQ38n5ILZBgV9GO1m4qGOJCQZiM/R48Z0S1raCC9jSAn4rts08seF9kpwHPVkNjZ/d+ibQ4ii8Iip+KeVJZbpg5lc/gT7MygYE2gAs2heash6RA9TvJSoQ0pu/NBE65uCRDBPFL0CHDTtJ2vcwRKhj+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KR6lF4V7; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KR6lF4V7"
Received: from github.com (hubbernetes-node-e3094de.va3-iad.github.net [10.48.161.22])
	by smtp.github.com (Postfix) with ESMTPA id A0830E04E3
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Jun 2025 01:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751014613;
	bh=RcL0Isqjj06PrsTsLn0znY0KuejvOJMKznfKAPhwQUw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KR6lF4V7eUKXArtu7CvNLPZyCGYSY9Q4HwmZWn88IDP6S5rLBjrCCz5369u+SeLIe
	 w5LcWp/Y5TM1BL1OVLjBYeBQomHbpb8z54f+nAPcixgbgSV70gUPsrJZZWTddKKeSv
	 jYjjh9KyCGP0ONxLvhk9leKBHPRO0i1ZxlwLGs4c=
Date: Fri, 27 Jun 2025 01:56:53 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/976513/277563-000000@github.com>
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

  Branch: refs/heads/976513
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
