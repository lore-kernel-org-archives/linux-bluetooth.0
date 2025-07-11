Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0561D27CB06
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 09:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752227981; cv=none; b=NykuV8ABBw0Z6fMmb/+vPeuRf1SoBHSMgmU27vOGI55rZKzT4K5I4tWTm6EWn5virel0vEniFXO7a9797OADFd2twzmQHTIivgEofqfbsgCzlN3vgEJCkwy7HPUXs8wX2/N/AC7NXmc0UUYUmBOFT7l1AT2+Y58Ky4AXKDwy4xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752227981; c=relaxed/simple;
	bh=xp1RK4kfA1QgEkBQ84wO+iNrCzGPVm7h7V+AL80y6nU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ogl8lCWDtgr0BMwSrotIw6jfuX4cGbKV3CPHPGpn9uvvi1nY5qPUm+po2h8kZi3PPvkPySCE7aKOUv6z+b034GQgrz4RQ8kDePk/ofJjFFIFLzbaVqX1/TnsjWtScPtSVT4VuL/fjA8GXznYU1bYjV0DjZ4Utmrx6ZSjV3LCOyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZfvXDc5B; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZfvXDc5B"
Received: from github.com (hubbernetes-node-275591a.ac4-iad.github.net [10.52.166.20])
	by smtp.github.com (Postfix) with ESMTPA id 186D770087F
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Jul 2025 02:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752227979;
	bh=rcNpz0SrtSDvsQYXVC4FSIwPd9l9m0eTsfa0ygSRT6M=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZfvXDc5B8FbljGiGJ89X1yudtmtc4J1HVXOJl2315bi6+NPP3Xy3kdDwSA0be/DbF
	 vgorNvcSMypGJNjI2WHzO0cRmiuKkDGXkAo/Dndveqa20vWd9L0Jv1rRr92I4ilyAS
	 cGnjnIDBAl4Gfc4tLZoKp/ID7ueeuj9lc4/FGRIM=
Date: Fri, 11 Jul 2025 02:59:39 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/970719/4f1054-000000@github.com>
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

  Branch: refs/heads/970719
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
