Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E901552FD
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142716; cv=none; b=AwMJf8ZOqm83AO3jNiCZ1/v9WeBBPC8+o0y8v6nlCTkyPYnPFxJ3veSkjPOjx+UICKfbPc3/KhL9X9+t6PfjaXSMBXeGMyrLCwVfv39YGQBSqe0layFx/mJmNikCjY3fVtwmE40RH6ahx6djggys5RYY8iYON94gxW23zAoFg7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142716; c=relaxed/simple;
	bh=myTCpG0ZDUy0Bu5R2rNGGKkJ6u1xo+w+xyngt4ycYYk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=aH0C/oD5R7wFE8+AvBjl+L+gQxeqN2aK8QfDoIrPaWjs9Oij5gLw/rAu4qz0PnyifPpuqTuzkQWDcLmiE2WK/SupespqE0hj/WOgX2GP6qbnVhy0l5GwyLcgG9mPkCPFpScqou1BsRDHCm93PKHst0i6f3BSocK70b9yY2iAgoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WX1Wuthw; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WX1Wuthw"
Received: from github.com (hubbernetes-node-af79c01.ac4-iad.github.net [10.52.154.57])
	by smtp.github.com (Postfix) with ESMTPA id 6DB6F213B9
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jun 2025 09:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749142714;
	bh=YhpDJXZpZOlha6DMqEXWhNjiYQtNxy9E04pXd/HYSwU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WX1WuthwtHg1feWlOZ24CbUCs2nLg/p1/9GsEYtCyJUDmXLmMHIT6X2SwANFZ0wQ9
	 SrK+o6fMXd8whhClOZPXrUrkfY5p8ubYbaX5gr/+RM30yrlBmra7zP8EgHYOkY9IKD
	 nwdIvkR2KBKKHmGGpg4tDHzKikFQW5f9avT09bXc=
Date: Thu, 05 Jun 2025 09:58:34 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/968819/5fa8c9-000000@github.com>
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

  Branch: refs/heads/968819
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
