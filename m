Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575FA340A6F
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 21:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780607646; cv=none; b=tnnFYa6eD4vndWIYdq5yEv8tMcmv26JM9hmZm1iZpYPniaimEZR3g5Csvz2jlvWMMvkObiV/Lp+W5Fpg7omnlIK+HzDCXVAaDEOWeE8l/DNk5dOCVvV35KjT7068exUtgIotf+VRMBi3W8jCOtqmOdQod/uyjje7Vc5GHKOuopw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780607646; c=relaxed/simple;
	bh=CDtvNRjAMtBV4prh36x9w6synsuzfJm5xFdJLrCwrsA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VF7ZoNyaLAMsKorUKe1vXa3jIuzkP3e+uf/HvJvGFQBeCRjhqln0LGEnzmRj4twL1+G31aQ8o8KlJOXFM8XlaioQt6Cj677DaN+cDyuFFZBCTV7RZEPZDpoKhjWY0LzO5LxuGm8pzo4i8ML8G/DHJZLiq3CwkdTSKqIVCke7qVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Im4odnNw; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Im4odnNw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780607644;
	bh=GL4wGdWQc0oFuIIpVu5fzlScY/F4zfSybypPLs4u3uY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Im4odnNw/krr7hDa5UztAGBfRjbAmAcHUkSYS93pT0DdDBBJXsIlivv5/WrkJjac4
	 wlYLSAdNElgb1/afM7Tx5ptjTaIV7Pp3+/zHvLIfxzCU3XzlFe3gP5lScCUNps1b3+
	 RB5v0u8s6/u+dlPIGg/zrrDlGHddtiEK972qp50o=
Received: from github.com (hubbernetes-node-f4ae001.ash1-iad.github.net [10.56.128.25])
	by smtp.github.com (Postfix) with ESMTPA id 561C01805F4
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jun 2026 14:14:04 -0700 (PDT)
Date: Thu, 04 Jun 2026 14:14:04 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1105853/db3304-000000@github.com>
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

  Branch: refs/heads/1105853
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
