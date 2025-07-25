Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB7A1FC3
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jul 2025 19:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753473505; cv=none; b=P7fWMOtoByge6TcwLBrH4VRhANe1i1nUL+N13CEQDzdQgccLYdKWAhfynNok926iGj28FsLuJB60PU7vBEiK6DxmXdCYdAIKaespiCU4VP2ETnwJh9P86m44N1MBD3QtKllkHk6k2i+OLKExVSS4XZ0FzjEaKea05ZWI96uQsO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753473505; c=relaxed/simple;
	bh=iJ/FTg+kNk4uvo7rLb1HSItfe522VEyXlb7gp+mW86w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Q+Guw3c2kKr/XiNWLVj4HaomFCHpHk5FJqnMLvnRs8m8yFqVBXSuzijo+TH9xeTYhomzcYncC2KSqX2lLsdAP0OshBMSsAuN1m4uEBXnyB4sEin1szjdQE1oN98tingf2YUxjjqTufamTprpc4/1zQiuzfSGECeUCJyrJ1FW2ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XERwouVq; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XERwouVq"
Received: from github.com (hubbernetes-node-e0cd5e2.ac4-iad.github.net [10.52.13.19])
	by smtp.github.com (Postfix) with ESMTPA id C49D421250
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jul 2025 12:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753473502;
	bh=13M6mOpIrMIWB6KkWfJ2f4vF6e0DAuqBQQirNKc8Uxg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XERwouVq/AIdDDtZka+MCwPCoetZa9+mTE8nl9kDBeisD4sTSsT5iSmz83jg+bMNq
	 5HVXwm1Oq1LEGQZFdUGMRGE5u3E/NQjOMi/BqRNVysbk/pa1903VXkE1qlpiuVqc1D
	 czs624otRPQihssuXTe+Sb1c/QI7S1oto123vd+U=
Date: Fri, 25 Jul 2025 12:58:22 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/975953/2ed556-000000@github.com>
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

  Branch: refs/heads/975953
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
