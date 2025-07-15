Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82114201113
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 14:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591232; cv=none; b=bnMRE7kl+ageGtW00aLcQP+cPzi1UAIe6Mndp4LGbq1419bTE9VFtR/qJST+wKiRfI3wyW4nhWyivL8+E7PTZD1rgLJgwDXPIq3S1wjoZg7F5hHCu+X/S6Izc6ujtHCuxK1hyyETgv+L0UOz/9fsw421t8kOvFGnWw88hSSahqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591232; c=relaxed/simple;
	bh=Rce3CAjWS7f4i2y+Bvk29RhlkRwAbSTY27WpG1bdZU4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=W5yf6MyydX9F5cafBLxTc6Mtf5raG6tySPPRXY8sfLqQ8+DQw17ZoGJWE6nlJ5trjJjOIXGRnr8aU4+6TgEFwDoG5nBB5fy/vBxg9ceMm7c7aiaLcCiklELj3EIaPjLNNynjdQkmTN6V1459IpK1d6VsZymsx48IJvFFA7uIX8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=S+qWJZwT; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="S+qWJZwT"
Received: from github.com (hubbernetes-node-e11d38a.ash1-iad.github.net [10.56.193.35])
	by smtp.github.com (Postfix) with ESMTPA id 9A2C3600D09
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 07:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752591230;
	bh=Bt1Z1ytP8V9x8VbSUNHeKR+2tvNunS2SDDmKTHwNB1I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=S+qWJZwTOSRKhIrNeAdyjR5w7KAH2mGeBOEGyT51LQLZZ6KNFFQqf1WMOJonATi65
	 NGTr9LPiyYxw+VW1rvd3u9UQ0zJr+FPHG32Ga/h+sX4vA+qbIujO2g1Voy/Lu5hmmH
	 hOk3OFaY6vKNxVOf/sRUlpH85jLhc06yLh24JdQI=
Date: Tue, 15 Jul 2025 07:53:50 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/982440/d4f17d-000000@github.com>
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

  Branch: refs/heads/982440
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
