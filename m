Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF5619D065
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jul 2025 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753866223; cv=none; b=lpTWvlP2dXlTKQYWDA0RJYQuvjl+4E8dSGi7QnFwWhCdGvcgF5N/eNlfl6biwq2neb9ayEXWSZheQQqugdEuaAdmiT50rb00xw3nEbO/82mg356ZrdtPHYJ3OfrhBcpAd5EKaX0O2m2StK58/CpGXjFcKvuZXjnf6j1WoYHPmvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753866223; c=relaxed/simple;
	bh=oR1CBlVIyKT/3JOhDpZ1e5No4AZRSJ0IM/FnTzPAENM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tP3OKyDbQmVt+luLFWxMzL/m3VuD/YG9879HWFPQ/VAjUk3UkPMg/ZZoO3ItAf3hIxzrrrT9LiCkQl1MIQTawVdXRKuA1+0Hn6w42X+NbjfP2+xq4MyrEctsC+SbskFXU5EdycmHFAuDgJd7V2cYxQIxtFnO0qbje8aaC8bDsEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZwkHozk1; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZwkHozk1"
Received: from github.com (hubbernetes-node-d89bf7d.ac4-iad.github.net [10.52.173.33])
	by smtp.github.com (Postfix) with ESMTPA id 763EF641275
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jul 2025 02:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753866221;
	bh=1p/xYZSBSSWAE1DdAy3NZjqF9wgIn7e0xY/vLWI7zB8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZwkHozk19yxwpeYyjwQTdynh8zGWSCYQNKeFr2OnOK3FUaManF65tJeDdPg4hiM7A
	 DBMT2ZCHvWzqAAg74u/R5pFd1XTdPo10aC+iCa5S55m7kIsWY2rwCGc1q4EtVAZHq7
	 iOgK4+d/ptA+eKdGkVe/EQ/LCcFpWMidA3Bc3dSk=
Date: Wed, 30 Jul 2025 02:03:41 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/977201/baedb6-000000@github.com>
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

  Branch: refs/heads/977201
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
