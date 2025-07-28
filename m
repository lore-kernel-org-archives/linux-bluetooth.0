Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4057A290F
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 19:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753730980; cv=none; b=a9fC273F/W38Qzl8ii6DaIYGkVJr3NZyNod5Fxr3rsAifG4ctZoM+GATVpxusU3jZVoEXejb88wp2irp4024lWVjRTuUa80qVfjZk4jVXXCLnt+cMdHVKmTRu9xCEgrJxpJT+k5eHDYLSeWays5amIZUa2eBmpU6KRHcpb0k0uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753730980; c=relaxed/simple;
	bh=tHVfx7YAOxDPR1ETRnYNiCQCZkk2tmgvYcSXPy5fns0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=M2kd0g2Z51qDKcCJ6h192oN3yTTUX6iXXqiypcAz9SzuGwMh82ulBL3kOJbYeSMjn2g6xzsoEMstYWiJx/T8UGzZbFCCDlfLPoojYfqrMjCEWcDLzjUEXcKIyJh+10yTH2rXrwgo1Y0F8G12wylk2RuH/t/HlqXJFufNBsnf0Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=APFEourH; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="APFEourH"
Received: from github.com (hubbernetes-node-a7ab39d.ac4-iad.github.net [10.52.167.41])
	by smtp.github.com (Postfix) with ESMTPA id A25E820A9F
	for <linux-bluetooth@vger.kernel.org>; Mon, 28 Jul 2025 12:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753730976;
	bh=sfCd3R1/T7GVAJMLDLlcq9GjCTK6N/ufuzNGZ+jlZw0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=APFEourHwwJ5e/Gyb+2HejR9Pt6WuS+s6emBLtZmi7QithxtF3s+PgyXeFp/xO0gW
	 zVf9+L0G4yh1arPBC33LSsBo18xA4q6o7qrPhZjQSpHhCG4pBcnbccuvqI1EHLUUZC
	 tARETlRoCYBY9WHg5RYYo1OtNBshML3fDNbEUtT8=
Date: Mon, 28 Jul 2025 12:29:36 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/985227/765a05-000000@github.com>
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

  Branch: refs/heads/985227
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
