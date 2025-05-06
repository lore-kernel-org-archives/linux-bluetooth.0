Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D8325F78A
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 May 2025 15:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746544323; cv=none; b=DwbS8qiyN118dBrRmCpSLwODWdNyMflmZ2VLUKrjS01ZzNxzQrxFB/H076W+uluWy/avt+DNRlZpfhrfPlmZP5otORAL42s7xj1Aiswu7icIiHzXwXmJbNufWLgODUxBnTqYgb75U3QifviIGC1Gm2Noy+4VAWMa94+N8Ef2U1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746544323; c=relaxed/simple;
	bh=LRve+qL5I+oxsLMKPy0gAJ7aWUhqcB6rc8rFIe16bTs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Sgehnks8SuK+4t/iKSAb/Q2/3Bs3wgsf+V9uicRuQWV+8jFQpP9QT6OkQHjOEhF+kdyxfgFm57npd4Lt7FQYdlpcjeiVOIDlvhhZmnDop6lTuzMr24U73Jj1tmA2WA5ujMQcYUNk592sr0DaQXY7b/w2l5Fxt2HrbM5BQ1xI0Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Fmw2H0Ml; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Fmw2H0Ml"
Received: from github.com (hubbernetes-node-46cdfd8.ash1-iad.github.net [10.56.193.30])
	by smtp.github.com (Postfix) with ESMTPA id 9497E921014
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 May 2025 08:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746544321;
	bh=94Fb0NucKaji87frMXNc3V2e4EfhoyZnb7Q4RjtOd6E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Fmw2H0MliACye37DtOgItyXQUL122/1YKyr79W5/z7iAcPAdy3+t0RVx3Qudo34dt
	 0oop9BTmU20f7o5O/GJP6gKMwH/tai1/EjsejXFAuAgd/AROHWpihnyby/9noBzssD
	 nMV/w7rOt4bmrlc2GmOfuyUt4m3IolMrEcrKu3eg=
Date: Tue, 06 May 2025 08:12:01 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/959306/9949cf-000000@github.com>
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

  Branch: refs/heads/959306
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
