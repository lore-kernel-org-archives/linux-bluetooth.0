Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36AFC329364
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766090812; cv=none; b=orOaEm9WnKgzwWJYX4gUZyohXWNrp7lRmw/pf0pLuYGi8oOfDuiZQkyGDVUzz5Ky6pQ2c3kNQjyLTuikcVvkx7PzT2tqXe0YK6FHd6katbSee4Nc7kpBeswJFP5HjR20SnLdMj72KOMPgiPxWeREbKWavQPK+qms7jPfhszHn50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766090812; c=relaxed/simple;
	bh=XATDKuzDBl4ZPzVcYyiE6qHGQjCY/mT888jJhf+hUmA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=HEFqBGj6PFTYWrdeVxQ0e3Z/u860X81KeIyMzPcSPbyydqZrPtDUEIsZLBVAQxY5spa9MKuwoMahlC95ldC2mQ4DOH3FzKmz9MXZvPyoLSusJyNJGjGwPbqt0Bz4BVHhMmkyyWFLPoYb+l3pFz7i/fTQnvCdC8vL50rSjZMlGP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jkoZI5Q+; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jkoZI5Q+"
Received: from github.com (hubbernetes-node-bd1da1f.ash1-iad.github.net [10.56.212.85])
	by smtp.github.com (Postfix) with ESMTPA id 4CFA6600B7E
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 12:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1766090810;
	bh=MnuqILHGrpThcpp3I2W0C6lN4wkjFa+iI2RgiUV485w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jkoZI5Q+OuIliuCO48vfLOWaUUxg5DMnqWXLvEtYFm/riONRJ7b3ORnoOYzrZaPLc
	 fZQHF/BYdRxXt9eZe6H7QnLcsSMFzxuf6GZmmhuxusePWa7mWpKwlZMTCljuQVDMcr
	 QLBjoDhRNhcFjvebdjZP1sszewR+7YIlAjTL9daI=
Date: Thu, 18 Dec 2025 12:46:50 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1034336/0bb525-000000@github.com>
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

  Branch: refs/heads/1034336
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
