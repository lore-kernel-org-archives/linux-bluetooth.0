Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DB64657F8
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 18:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778178363; cv=none; b=FW7MrKYpSem4g8UbDVfiG4Zq4VJC0Hhp+7JSsJD5ltFISbMFmmT9q3qfVz1ODYSrP5vbp1FMu/GCWi0GQF65MUKH7jWFl2sC7s1zNTcOYTBtNncCXsf2klbiOZGDLYYtxP0FgGCvZ0J0fSld1Gr69Yc152Z8mX3UTLJ4JOsk04c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778178363; c=relaxed/simple;
	bh=WKDdHjC6drv8Angh6Ox459jkv36IRvUxn0rAM0GKmRA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=SQN03MQR3JV37xR1KxHmwQ49wcwlfVt5yBjDTS35dAzAPT5L+WQArDtTms12MwzPtl/yuBjki1BpoRopauXIZxfPd6K0i7LGj7wBTwJh37yoV0KB01GmUbU2o9LlZLCHNkVrp4UJ7lCGFQKXlpd/ge7ZC0IgIrh1uxho+kYXdTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CRvS7EHa; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CRvS7EHa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778178361;
	bh=84HN34eMgzbegzNtAZri2Smhh6bSsnVC83HZnEk4N3E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CRvS7EHaxDezd4HJ7C8HCTBah7mFhOOJcA8LgSn2lEHDZT6T90w6MdqI/q/fo9suQ
	 xF2dTrjuVqm14d2sOZJG2hdpkaLDdYc3QruGnMZuCYrzI+rP1UHQGx/Fq3aC3RVj2K
	 hFKJLRP/Ngx1TqVNxzHCZZBe4dCnohXJRr0qB5RQ=
Received: from github.com (hubbernetes-node-ed49da3.ash1-iad.github.net [10.56.200.47])
	by smtp.github.com (Postfix) with ESMTPA id 3F409521059
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 11:26:01 -0700 (PDT)
Date: Thu, 07 May 2026 11:26:01 -0700
From: prathibhamadugonde <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1091197/000000-27e1da@github.com>
Subject: [bluez/bluez] 27e1da: monitor: Add parsing of CS step mode data in
 RAS N...
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

  Branch: refs/heads/1091197
  Home:   https://github.com/bluez/bluez
  Commit: 27e1daee95cfa9081887153b978ec5a512c45945
      https://github.com/bluez/bluez/commit/27e1daee95cfa9081887153b978ec5a512c45945
  Author: Prathibha Madugonde <prathibha.madugonde@oss.qualcomm.com>
  Date:   2026-05-07 (Thu, 07 May 2026)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor: Add parsing of CS step mode data in RAS Notifications



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
