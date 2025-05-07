Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E84D209F56
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 May 2025 20:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650803; cv=none; b=EKm0QCH+/R6eMjTszUtSSS+ZqMNRsTkZkBfkY5ansaV1NRpbOYodrbDmX7mTklak3L+2BmCpHb8Cb6Cx++TeB9vGMQAFSLU5p3bc9aH8GJnYZcYF/gcY1EQRbk0LMIa0Orsw310hbv6do9B8meEzzzI0WBp12KmfU/5qqcaCABI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650803; c=relaxed/simple;
	bh=AibVLDAvhF+02mPy+t5yThdlQIaHTEDjyXQIY6xij7o=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=g5MUi0Cab2P5ol3vAE1jpIw8yQPVK9nPMdVP7doe5Ffw08dX3rTFlLTmBa3N5z0puacxcXHx/eXipCcKKQbBCuc/UekcjbtsprqVykv7T671wPNyuS5Zsv6qLJFLsk4d2iM1FB7uYeKEO9pe/CPVBSjx7X6PaCxgsrbgh4KuMBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WxoKC0G/; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WxoKC0G/"
Received: from github.com (hubbernetes-node-de4c40a.va3-iad.github.net [10.48.205.55])
	by smtp.github.com (Postfix) with ESMTPA id 14DDAE03EC
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 May 2025 13:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746650801;
	bh=v7ZJ0OLtVOkwq3LIcVOWIZ4sdOlOIaZlOO8qIGGHRn4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WxoKC0G/qXStJqskhjcgSsJqMtjaEAZiUTao9P5gt3Gn3DEwVn3g9PRTzuAq5Ux0N
	 QGN5939FYrfDmXCXyRjvl1j7pgQVdOE6hYB/3rybac8Ao0oGdFPspozCn2Y8txej8x
	 jcEEXMsxBJdvMvF0I/dJzKHaDh0kHoz3fOb6jun4=
Date: Wed, 07 May 2025 13:46:40 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/62f0b9-72dddc@github.com>
Subject: [bluez/bluez] 72dddc: btio: Fix not being able to set security level
 4
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
  Commit: 72dddc80def4f6de4c7d30687b0c0b379b79c162
      https://github.com/bluez/bluez/commit/72dddc80def4f6de4c7d30687b0c0b379b79c162
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-07 (Wed, 07 May 2025)

  Changed paths:
    M btio/btio.c

  Log Message:
  -----------
  btio: Fix not being able to set security level 4

This adds support for BT_IO_SEC_FIPS which shall represent the security
level 4.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
