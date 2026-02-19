Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DEB2C1589
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 17:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771520990; cv=none; b=GAY1wZc523rYjuqW83iEK5+sM9cGIrxSsi1UOJXeNge1DB5xAPztVvy3Jnwicfo0HuZNnSM7xStS1FOJhnxIvAJO5t0iXIpyLr74svQJiKkrxL140Gfs2Qq/IsKkZAP+rRpEClBe8arjSN1m1VW/xXAD+Xd/zH0eWnC7eeadEq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771520990; c=relaxed/simple;
	bh=CBrTiuKCYxhZIpD+zUHDpDEq+dZVOYDpS3ay6kpXkYo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eyh14IjWYsAT7rcBWhAot0LYXzisEdbDBiZXXQCyM0agoaA7pbLvEeHpnHx5gSCfVvM1JDU/Lrv5pP2tUglOCxPtcoG0XA/vz3hnYCo9b0kKc5YBkLyS8lO1TPHeJs5OyTmUGDcjW7ilgdhbRosVCobSR+Ei/Cq9LzeiQQGrCI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=i7SfgTSv; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="i7SfgTSv"
Received: from github.com (hubbernetes-node-67e9ede.ac4-iad.github.net [10.52.178.45])
	by smtp.github.com (Postfix) with ESMTPA id DCFFD40136A
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Feb 2026 09:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1771520988;
	bh=WJBbemKfMiA33FsBeuCa2+oU+eBxgeecLRsGckMbr18=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=i7SfgTSvvtM1cBz+/c4mzX4czP3+r+8XGnsRGajTSI31KP7HoP5+vk8hPDChho1jR
	 eRXb4v5NNM322z4ERfkKEjRqBgdj0E8lA/VEo8ohOPgsOb3RiRPiKcmbsCRO462QCj
	 muhSHzwfUaehDOb0XIR5a6b7eJ6TU0K50/v5FHQE=
Date: Thu, 19 Feb 2026 09:09:48 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1055296/d2476b-000000@github.com>
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

  Branch: refs/heads/1055296
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
