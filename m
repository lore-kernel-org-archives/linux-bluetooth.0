Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A93A274B42
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Feb 2026 04:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771560488; cv=none; b=m2I9xqvkF0i5q/yP7CELGvHG5Xquel4yaJLrPIi6Z+A2eBIioBn9l3FEAUwSYq85HYxuyyNod4T0+8mVmqWK1kGuHQHEJqHjc9X+u9a1lU2Rg5hbfG8gZYa63ouUzNVQH1ROGF8tWr4oRYQ6GfCbTuDdpSd/s9qxTl5S43u96/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771560488; c=relaxed/simple;
	bh=JzGjb3dPWAu+S7+sBeChQn1QZnOw84x8Av/sWavbsTE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=i/fFNqpl0bYOmh29j6S8wIexMvXBEpwrijaPZcIau5uoWA9lnKD9W6GpxU5ua9vEj5Vz5oTr5XVuPJ8/hSAe1L6SravQi1P2STlYX9IA/Yj0gy/feh6+5tM/rerThZybHocRwulNE3UoO5/0UMikZUzbQ07kLIKqj1IHbV2GIMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WA1IRxgF; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WA1IRxgF"
Received: from github.com (hubbernetes-node-57520fe.ac4-iad.github.net [10.52.206.15])
	by smtp.github.com (Postfix) with ESMTPA id 5DCB321099
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 20:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771560486;
	bh=7udi9ya37NZoBuI/5gJW7qiL9WQ1KESLwgRR1jdQ0Gk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WA1IRxgFfSFLlMEVbaBJwqwEUqnkdFNs5I5Xtc6+LDSAOb77poj4HMhZcnIc1N1Dt
	 za++bixhY60PwAwI/ybltiGzkkB2P3b1z61/DJ0wanB7+x0uxuzlA6ECieLmI23pUm
	 SyvSX8czKc2wJWh0fuL1xGGHkUkTMlSN29wavLsg=
Date: Thu, 19 Feb 2026 20:08:06 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1044931/7e5b9a-000000@github.com>
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

  Branch: refs/heads/1044931
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
