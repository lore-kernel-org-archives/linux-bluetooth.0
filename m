Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11EE411F99
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 10:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786617893; cv=none; b=ufe7b+KDLtQbLAzJJ/JrRzTGDJ8x3QRJOkyeTCRM8XQaZCekCT+jAImwDmIlAbOq+io9QMPUVp1dY/OM6O2eknhf0DR6gBJR6BF8KZZV9Wcypz2pd37g7Fvi519zkFrXeBxYjTBA19iQLK5LZ6XdNyJBJkobkZ5O5hFfv07jeMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786617893; c=relaxed/simple;
	bh=lKGRbSU1iGvlQEbVLAqFvMLGpAF7RI2YU5SeaxU2vZI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qLs0xYT+Uom+fPXtRX4I19R4PfAd4LKh3rvWPgaqJDzCLO+wNeBCbrvLoUVqJyp6kTfq2sVWoLW+UbmLFRpXwLcrU+2Gt/UjYf5eWoVRAx4FRz3ENUfijsXRAdZrGK1hjp+vgx+BspL7BmjySbiY7RxBJ3BVZ0EmbN87eNvXwXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lBa0oVub; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lBa0oVub"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786617890;
	bh=giagovxSsQ2wqeKdRMLum0zn8DtmqyMD1o5Lz4MDlY8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lBa0oVubcvBZjP9ffxW2mOPZFF/LElFRd0Ttt5X9h65qmVUO7D2gLMBqdE9u5X2vs
	 FmBk6BHadBIX3MhP1ALrl4rge56DODr+V5DPZG5HH4hYiaKAI5ppvz5zDm4IHF5CpV
	 EI4IR3uu1P4ffMQ7N2pyL1R/jW95ucOOTKgPMdIk=
Received: from github.com (hubbernetes-node-359016f.ash1-iad.github.net [10.56.208.64])
	by smtp.github.com (Postfix) with ESMTPA id A843E36A28A
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Aug 2026 03:44:50 -0700 (PDT)
Date: Thu, 13 Aug 2026 03:44:50 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1127291/6de9c5-000000@github.com>
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

  Branch: refs/heads/1127291
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
