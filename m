Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442B33D9E
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 20:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712002076; cv=none; b=fRHnpuHDLOVrI47dSF3oLVTvqttO/0zpdSvHDT9sfiEmm/93e5ZSL+AZr4WqUzP7xvqgCVW20h+NqFzBbcfXcso42wutkmaoN+nJAycTVYAMwhgLJpEEpzE86nDCaEYUKf5nh8qixhVZ/Ttwatg3xc1TcLp1C4hcGarRc+PB09k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712002076; c=relaxed/simple;
	bh=ZHlKTQ3YJ/gEuqV/CYP3fmOVCkV0/qPXQsh3WFZ6oiE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Xrpxy3XFRjx1UXUD1EV5kCFpuXnABWLXEukEhQSe7ofnBvSlL9ORgtNr4LMjzQZqDCjhUTGSgmY3v+QReE902Ht4CByZYHsmZJ/wO0HCOCdDWw5OzruQzfhw/3I9IHV6qFUGItmADPLeETC09wc272zrcaw6Y1oFfFdPgYoJUF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OOuekOI7; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OOuekOI7"
Received: from github.com (hubbernetes-node-31aca59.ac4-iad.github.net [10.52.137.37])
	by smtp.github.com (Postfix) with ESMTPA id 3144A700804
	for <linux-bluetooth@vger.kernel.org>; Mon,  1 Apr 2024 13:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1712002074;
	bh=FR1XAciD3R5YN2ntjUk2bFCguI12OimtBiOXS+ENcMY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OOuekOI7KfGIFWMAReHukupt1ilyenxV2t/5SHq87y05fm4ydX6eJYWkNcD6oslVJ
	 OnMFEXDazNPvh8JDLhFqUB5+mZ5ogjIpjKwfxl2brPzysFQeSoGw59A3837UQZ8ItH
	 ZRoFlyOwgr7GoaBm8uYonuVU1QHOkm76OvZprnXQ=
Date: Mon, 01 Apr 2024 13:07:54 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/3403f6-4520ec@github.com>
Subject: [bluez/bluez] 4520ec: mgmt-tester: Adjust Coded PHY scan interval and
 wi...
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 4520eca3e5d81be77dba629cd62f8d59632240c1
      https://github.com/bluez/bluez/commit/4520eca3e5d81be77dba629cd62f8d59632240c1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-01 (Mon, 01 Apr 2024)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Adjust Coded PHY scan interval and window

Coded PHY interval and window recommneded by the core specification are
3x of the 1M.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
