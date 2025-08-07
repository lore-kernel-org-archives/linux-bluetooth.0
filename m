Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4A526A1AC
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Aug 2025 15:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754582326; cv=none; b=XsZqw5CtgIGM+lL5g2VftnkOIZEta9M+6vO6lX0OuZSx5PGraQ0AU+6euIRJw5c8bDpcdALsRsnoTEj6qynrLg/hOhJS2Nm+32oUwug8Pu/sIS4SXBHrrTxabHISzR2Q37hEbNi/BOGN9biZ6fNNMaMe7nXYw9D9sFtgrg/En7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754582326; c=relaxed/simple;
	bh=NxBbYXND2DltswBEQd31MpZW6my1oY/j6vTazn5Ag/0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jecA2GcyL22G3hbjdkFitrLixrYpxMnziIQLQ6fBNzM1aHgkXFxWZ3cunwiOp8xiHQG8/4DayxvQHSd2ZFiut1X8qJaGKOybgg1+IzVAVsiS4AmyUicExWL10Vjez9VVWRfXq+di8cFO9kdmAZ+ecFEfdvH1wuZ+FZZ69581X5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LENrbYeb; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LENrbYeb"
Received: from github.com (hubbernetes-node-e1d2a62.va3-iad.github.net [10.48.219.47])
	by smtp.github.com (Postfix) with ESMTPA id 8389F4E145C
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Aug 2025 08:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1754582323;
	bh=PTTxw5MyVWKRluKg+uELPjfQP1HKCCFX6iN+arW5CV0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LENrbYebsUFHRQxxW7FryvsyXfgBflfd0VGIJtsy6F2d7bm0bAZblE1ef2CEwYIpQ
	 Dn0fCI4rkavV6Tae/diCoGxxFEJ7qF3wEeYcu34GVKAB3Nz2FWdof01djyA87P/C6x
	 Hg4QLQ4Fb2yvGK3A4FqUlJeTSVjESGBzEZA//tE4=
Date: Thu, 07 Aug 2025 08:58:43 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/989142/d9faef-000000@github.com>
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

  Branch: refs/heads/989142
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
