Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF39261B97
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Sep 2025 16:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758903821; cv=none; b=IB/uxX55IevHpV8G0fuHrQchANQ+PJyTjfC5rBaixkI+pQ8vjsceRVRINT1trH18YRzWx+HCdAKTiffXT7TscjrnUMCjPrXLBtnFgfUusyt3quqB4VDcjVnXSQQMfJ7vQFZvduuLJzZLC+Gi0emu7U3IcKNOglxyFLQhInaU5iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758903821; c=relaxed/simple;
	bh=op2dIi8Z5MHYaYdQs7xdLYDrxmXg4UXAG83H9MoOgMk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PMSGLHkcQF5aXdLaX0t1A9hT7475QM5HXKuZH5bBemJPteprkHv9q6lbUf27NKO0giFaRDkcxi2zmSg2uq8mQqJJPgMEadzRdvjn50iQ/YnmsaIee2rHYRg7QacIUDp8cK3F5CirnQFpF5qguqajFUyullVSGJvuaT5JkUUBcG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=nIyaNDZV; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="nIyaNDZV"
Received: from github.com (hubbernetes-node-4082c81.ac4-iad.github.net [10.52.125.43])
	by smtp.github.com (Postfix) with ESMTPA id 62FE920C68
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Sep 2025 09:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1758903819;
	bh=bleUw8kq2xi30W42vz3OLQdomvSpex6Poi17YmDMCLM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=nIyaNDZVS6gnuwDzEA66uVVOnK1XkE51oa+bJklzo9GzvCAFClwSty3ZNASD63AYO
	 Ex7xV4tMEpZVxazPbDYRyO8KogI73kFv/NMsSoh9+5ieFUpHEK/dPUbkfrxhj4Vzjb
	 JwI1qS5IbBTwuFbj/ONR1CVWDx+ZSkNICeYg69D4=
Date: Fri, 26 Sep 2025 09:23:39 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1004473/deb76e-000000@github.com>
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

  Branch: refs/heads/1004473
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
