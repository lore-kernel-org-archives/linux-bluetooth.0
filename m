Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804CC3CF677
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045143; cv=none; b=W6rEGKp9JqGr21rHe3IZ+1JwL5CU7X3bTMcuooICJktbI4cg+X9z77IgYG1t9BkMION8mWxWG7jY9SbBXKj26GLgsmOeQa2uhAKcZ5x1v0FOXNH78tHL4ecOBXQSLbi9bcOEjOrtbBgRt2IFSfSIluKDJm+S7le7eRSIbbPWqXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045143; c=relaxed/simple;
	bh=zN5K3zhcJgiubYxW8eRW+OvtVsrtsbnvB0Ra3lnk7Xg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pFOibBoTBfz8Aw4qddZUJhvog9Zv+dcnToiKRl1MLT4o2dnj9AsJiYO3HbKnDa0gEE6O5xd+1jXU3+XL76e9CEdpxTrrPhCbi7HcBh4QtOG8vrb1q5DpsvEdcf/80i/Rato55P5sKcY55nLFtSQPFW/iia22BXdx9gikmw2h5j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=idIZeGXK; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="idIZeGXK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777045141;
	bh=2NsrNgC+UdF5aqpRSYNVDRuYqLyqI2vlxmFgKIT8xdM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=idIZeGXKuDUC9setR8Nv1kmMLvrY/SmQt0dWXsy629mzbG+XxKtOT1sz2QO63OF3g
	 m31esSOaL/8sY6DQclBZinxQ9xbTSzRx/YAO4JC+M6C0yGOBpX0xpB8iPHZJwiM38P
	 QWyzWv9A3yruWi9uIzRNDutxFyBSVWWFenxhFKds=
Received: from github.com (hubbernetes-node-2ebd71e.ac4-iad.github.net [10.52.207.30])
	by smtp.github.com (Postfix) with ESMTPA id BBD8B940FE6
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 08:39:01 -0700 (PDT)
Date: Fri, 24 Apr 2026 08:39:01 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1084434/e0de29-000000@github.com>
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

  Branch: refs/heads/1084434
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
