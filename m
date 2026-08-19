Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468033CBE91
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787169483; cv=none; b=h0Rr8rr171d3tR0vdB9kRsZUKgCF1OLOvrHlCXKWUUqDVCHrjt54vehNC2wCXDa0yaVGMjKJaCYcxxdrNWNTvOdAxv3cu8FyZQdEVzJJpSx9Xhf/TKIKP59D6dOinR11u1krtvt5TY74syJDMSIo7fP8CYsKfngDPzSXLIQcaxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787169483; c=relaxed/simple;
	bh=807YJABF1kOdrJiSVVErFlqMOIZS0P0mWdUWmeARtsk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IDbz6xFW+31M/tVHT+YROubs5pB7YKD0gE/9vs/QFvSHMkVeodkhCkaWR8WKNzcKQ4abn1anhwMO4kGWByWD3GfwNAXGrL+9yXLTJrYMyTMNRRVrkirKlQlQ5RTh9WBQTDHFCh2mCWumkKeQgbJQZLxGpRQvCJweWbHCPoQscB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EVIiOB5E; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EVIiOB5E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787169481;
	bh=bSSUFoi0p6CHTXLDZSPVfZpledFheX6S/C8t0WTW2mg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EVIiOB5EZBHedlE8E0CqRIoazNZyMFqyBrkhhfjybSefebQEQyZOHQjLaX3xOthP/
	 9DL41eiIcdOpZF7bTYvGkwj+T2NA5TIrOPOguPbdWTE3ATrEZXffbqwOnsHm/drcbu
	 jlBKj4BJOjRz69Sv36ZIut8BaxRzW7bT4j+dJ2GY=
Received: from github.com (hubbernetes-node-774fb3a.va3-iad.github.net [10.48.75.50])
	by smtp.github.com (Postfix) with ESMTPA id 5D578801198
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 12:58:01 -0700 (PDT)
Date: Wed, 19 Aug 2026 12:58:01 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1148341/a51720-000000@github.com>
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

  Branch: refs/heads/1148341
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
