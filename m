Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC2E192D6B
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 13:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746450036; cv=none; b=KBaKD814heXmWN1rQr6FRzwySKa5MCDxnqAdVHjnhFr6/nJIBkLaVVBVBlXVT8/wP7p3d+VmDhdI9ThUFSNPD3XOilciLjpe2MoFTaO8+nTkXurMaDv4aE2dOSfopm7eQ+7A/o/q2QSkD4ZI2/b3EF9n/QyLL8o+a2fDt2vF7Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746450036; c=relaxed/simple;
	bh=FWuabbU+rZsdkcXm6t+D63ACQjPSLx7bFQprMVHz6FM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NbC7Wdkz/2wrBPQ37s5fTiIv4KLUC2esHotinVIqGa264AwYYM3fqNJsJUqEQu4WXhguN1Kp7Yn6WKwyAC3hYeBA2iDklVbmW49RTc4PGeWOmklGPf2gIMMrs3bgDS5azBsqvSDfunJ1D/L8CQ1pLNjrF+1PRN7Q2WdrvaGAs2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZprK3zL5; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZprK3zL5"
Received: from github.com (hubbernetes-node-4c6a6f8.ash1-iad.github.net [10.56.155.39])
	by smtp.github.com (Postfix) with ESMTPA id B91C01411E8
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 May 2025 06:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746450033;
	bh=9R5VP0p4OUGFrwnAhyqMx2VYEZAb6J12twlfKqzIfcY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZprK3zL5YP8DGw8UGLA8JpWBywn6Ut/El14kaajICd+6sZqMPo0k/t5ANKmItcPXJ
	 G70ob8rAtoQiU9fXNwHw0bUWPBbqgiy5efokrvvOqSw+D7kE/qNhVR/hn3hHzU+qhX
	 SDuvRCFz2Q7ib+YUx0XYacslo7lYN/8K8dRgAbf4=
Date: Mon, 05 May 2025 06:00:33 -0700
From: Christian Eggers <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/959622/000000-dcb585@github.com>
Subject: [bluez/bluez] dcb585: tools/mesh-cfgclient: constify
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

  Branch: refs/heads/959622
  Home:   https://github.com/bluez/bluez
  Commit: dcb5859bdf16c928166e81468a6f3ccb474a3e8a
      https://github.com/bluez/bluez/commit/dcb5859bdf16c928166e81468a6f3ccb474a3e8a
  Author: Christian Eggers <ceggers@arri.de>
  Date:   2025-05-05 (Mon, 05 May 2025)

  Changed paths:
    M tools/mesh/cfgcli.c

  Log Message:
  -----------
  tools/mesh-cfgclient: constify



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
