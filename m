Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEC81A0BD6
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Dec 2025 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766650807; cv=none; b=C5CIO6MAae6Mi+w4LDvf478Iy6jMtelS75fJf+f7Uyej8zhW0vTG9odueuUXSdsr217IHPEbkK8px1JS0KbRPGYVAJisl31ccdUljZhzC/CX66H3GUF4JWEJF5jyosuJbzBn2RVizh4Vrg/TMnpAEsJgdXQnuY0mVwv5GG8RjUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766650807; c=relaxed/simple;
	bh=BUGPamKdoApHpZPPpY0H+BgLzlLqaava//NV8BRKxtM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cT20oB3yyUpXAk2lZTy+lFoBVGdZw96LeJ+j1m01pQ++9qGFfpltPxFBzqcpDOq5pVT8ugyFs/VMHpR774wsF4WwCBBdE1mh/bPWwJiNoew3iJKFRJdTGp+xDet5+dFvCND9C5b05s96DxayPqfhz80AayRCRI13fKM81snlg+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=igvdYZuV; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="igvdYZuV"
Received: from github.com (hubbernetes-node-d892af9.ash1-iad.github.net [10.56.224.35])
	by smtp.github.com (Postfix) with ESMTPA id E507914070B
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Dec 2025 00:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1766650804;
	bh=ofV/C+uI0ikVxvYjXSk5fERwlqLtmsZ9p0WoXEz7TYU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=igvdYZuV6b6RdgnGgIlgz+9xpA2Rq+H3JpgoLhB3gwP7GSyF1jflkg1CejoD7x9OS
	 bmglgr671RD1rq1P8HNM0mr3IHFtnkldutIhtTFGbwNdhFI6i0cQB6alsWDnlE5zil
	 JhHNXi4yCPrdE1jmnjoFQi/ER93X6nmobNgirXhQ=
Date: Thu, 25 Dec 2025 00:20:04 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1027210/71160c-000000@github.com>
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

  Branch: refs/heads/1027210
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
