Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0237280335
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jan 2026 22:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768344196; cv=none; b=qbT2Mt3VSmy3fvhNEuKdY1V7BjrcHR6j/brrK471KkqSPS15dBLR97DQ3rjf9zRr6jQ5gi2kUVfRICxoMBPMDHU243bJwIeaRtprjlYh2O9dpQypNfMKfms1Bs93o8c8wUVS7R6hcsac1AhedtGWDZ1gNPJ7le26xW2lkow1gFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768344196; c=relaxed/simple;
	bh=3RzZs/Z6CWWbziI08d0PygRs2oC1Qf0bryO7KshaCOI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JfjuBSMD+bj1ejSks7en4J0MZCMhTZ1H5jMUwrBr2W2W7IKCTMCHYwZWKTblo7C9ZqLd7W0i2y3grTTt/BIvURNxOJHCLN+t51/adGt5zPmqpKlo0DYRVPjtkCpK+7HfyCrTmZdZALAmUbqOGv+obRMCIEo8tkDfUMad0s7LQ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EDs+jl13; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EDs+jl13"
Received: from github.com (hubbernetes-node-d1211bb.ash1-iad.github.net [10.56.211.49])
	by smtp.github.com (Postfix) with ESMTPA id 056DE9211B4
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jan 2026 14:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768344194;
	bh=RC7pW9kTSrOlTeP3jjahw6SjCt9Xz9KdRxyDuiUyQac=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EDs+jl13JgJgmiWSAbqali66Nja3zTCe2GT5WrC+8BHDOUiEo2Dr5ErT0jSXumBod
	 I1dPKp8bmB4eLyPIhtiaA1r64HQ2KcOicEs3bsqPj8Q/Xvz+FOz50lZHiQ0HaTizh8
	 AsYBXAfZ3ORFc5oVluDrBWEBKNQUEZbtkwDcn/aA=
Date: Tue, 13 Jan 2026 14:43:14 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1033906/f555ae-000000@github.com>
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

  Branch: refs/heads/1033906
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
