Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379B343164
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jul 2025 07:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752910182; cv=none; b=J9Tr2kMAHo8ZJ1LrFtapxeTXtExZnZbE+dzzZCinkxczB9zo7WOBYkNkza8IJt05+9z8KvpMdASv75NzMbfEV9uodjo5lCGfgBK77/7FwNyoocm42ibDriMF3nbMs11xs0BBqgXRAq0+sCnCw3L7p2VaHk4MV74tY6CSBYGL34s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752910182; c=relaxed/simple;
	bh=+4TLTB5+rOOTO3XmCpN6xdfwkpFc23596Id6kq+/xPs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JLJfkOjhVzR7y26h+v+N9yGakbSRgVDvir2BIA1/zhyKjmyO+5kNInCpoi6Jq7HB8FGr8hYQn+3GmRLhHR86drNBWXpwBFch+fEvzFe3PVqO9BPyT56IHK54tskm4oWR1Qg94grEtnA0dL6ZrGbQbtqF7Bzd0Gzf4vHloT8av4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fCpFxMbM; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fCpFxMbM"
Received: from github.com (hubbernetes-node-a0e73e2.ash1-iad.github.net [10.56.203.86])
	by smtp.github.com (Postfix) with ESMTPA id 6565C1404B6
	for <linux-bluetooth@vger.kernel.org>; Sat, 19 Jul 2025 00:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752910180;
	bh=zuyQG1zGvvwjSi8QCeAgvdmQjonyPWLfV5XV1PTxb+4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fCpFxMbMqb0mAQF9H3Rm7hYCSJOh3calHU9jEJoicm8qwAIoHM7qyp7YTCO3SPaiB
	 0bPq7Y2fdKdaOWm6S8xandUk0Tkx/CrLOPqCinOKT/tYwq+EH+kEAaFlwx4z7AyJcU
	 X8UpEZqch3ZOtiOyfvAlDlIUraaPFQRCE3yT9ulY=
Date: Sat, 19 Jul 2025 00:29:40 -0700
From: Yao Zi <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/983945/000000-3d97ba@github.com>
Subject: [bluez/bluez] 3d97ba: client/mgmt: Print UUID and flags when showing
 exp...
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

  Branch: refs/heads/983945
  Home:   https://github.com/bluez/bluez
  Commit: 3d97ba578915604e7e44bc0ff0c713d941aec27d
      https://github.com/bluez/bluez/commit/3d97ba578915604e7e44bc0ff0c713d941aec27d
  Author: Yao Zi <ziyao@disroot.org>
  Date:   2025-07-19 (Sat, 19 Jul 2025)

  Changed paths:
    M client/mgmt.c

  Log Message:
  -----------
  client/mgmt: Print UUID and flags when showing experimental features

Command expinfo in mgmt menu queries experimental features from kernel
with MGMT_OP_READ_EXP_FEATURES_INFO. However, currently only the number
of experimental features are shown,

	> expinfo
	Global
	        Number of experimental features: 1
	Primary controller (hci0)
	        Number of experimental features: 4

and lacking of details makes the command less useful. To ease debug,
this patch introduces extra output for the expinfo command, showing UUID
and flags of experimental features as well. A typical output will look
like,

	> expinfo
	Global
	        Number of experimental features: 1
	        6fbaf188-05e0-496a-9885-d6ddfdb4e03e (flags 0x0000)
	Primary controller (hci0)
	        Number of experimental features: 4
	        671b10b5-42c0-4696-9227-eb28d1b049d6 (flags 0x0000)
	        330859bc-7506-492d-9370-9a6f0614037f (flags 0x0000)
	        6fbaf188-05e0-496a-9885-d6ddfdb4e03e (flags 0x0000)
	        2ce463d7-7a03-4d8d-bf05-5f24e8f36e76 (flags 0x0000)

Signed-off-by: Yao Zi <ziyao@disroot.org>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
