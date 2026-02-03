Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF381DE8B5
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Feb 2026 18:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770143637; cv=none; b=DLwS2F18qle0/VUbjXdWDhc4E3UokH6HPm4NXHg4r4+QXiah5A7Ikx/FbiDg6ja294IKqRMN1yk6I4Tf4qs0GKtXw1CnfQAqw9OLZ8Uz7eGR6jV/cm6pEwo+kf7sA1wC51QqC7XXA2Lc2cI932/KetBdskDHnrciGRF0nXyeafI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770143637; c=relaxed/simple;
	bh=A+uokGU5prG5lWJQ9A9NeQJmq348wVDaRcREkXyCw3Y=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RwxLOyc4vVinwtFKAp2PfH55gukudkYHxk1AUuvYjpZOBZ6verNmG/BEOxdzczIB450/fuIpC6RtIJdaVOhfpbXkNHAKFPqnWJixG7jdOAJzxTMgSKvaWCbMyosmhQkGMsaNyq23bQlym66zrgRE4zkOfKjy9C3l8EaF3I0wv5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WGFyN06t; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WGFyN06t"
Received: from github.com (hubbernetes-node-968e6f3.va3-iad.github.net [10.48.200.69])
	by smtp.github.com (Postfix) with ESMTPA id C2083E0B61
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Feb 2026 10:33:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1770143634;
	bh=ixf693sZesoU8FvJHM2Z5oeJS5WlHvCBbhi5LLlJQI8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WGFyN06tfIK4GXPYsZos0Ga+7BpWYf6KXA49NG3kV+uKNo/GY35d9vuewYP+vkghn
	 PBHiEIbGWNZYgP9MciVlnLgVpUFMO2/tLflHvRLgrkEm/Dw/6EZk6odN1yzNxiLswn
	 u5SqVxePWFbBT3WqDUfU8Tj31/1KGSbRLoFawWl0=
Date: Tue, 03 Feb 2026 10:33:54 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1049160/6f2217-000000@github.com>
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

  Branch: refs/heads/1049160
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
