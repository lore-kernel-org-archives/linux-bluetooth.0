Received: from out-32.smtp.github.com (out-32.smtp.github.com [192.30.252.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F091B4223
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Sep 2026 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775984; cv=none; b=aj7xaoifcgNkCIzWYw6eBn3T5afJTP+pcGf7R1wglgqfneSDpkDQR9IhTZbRV6CkJkFvgkoDWh6AQDU92VErdQcslF0wrZEX8x3QAFEzJI7yywISMnlEmJkJuNR8XgGt3XOTdJkZIV5B8Qoh5lNI5BM6IqvdUmxjobnLGsle5Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775984; c=relaxed/simple;
	bh=PIymBQYkqipNpAd1dJye1lIPdBYZT1WQKNVDVwP1tnY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BgBt4Lg9YwZSaf3k4p0tK86OYJiUT2jH5dzR2/KL2KCHgY5csi6MQw5qmL1YFFXeL7GCejjX1xzP4DhCnh2dSdM+0tS39LFwz02ctLG1oOCkgUw7dkvLpjFwm4//hn8HJu276grtybA1lFtY2kd3QA1HYHifV/jydys0EowPzmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=k6utAvGw; arc=none smtp.client-ip=192.30.252.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="k6utAvGw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788775982;
	bh=9Qa9JNdkf1EGTwZB61TH14TuGzuowLLGw28yNaP10d4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=k6utAvGwUcbw4sooKmd6FCdjy0bTSBs/rS7v1SB4zDrRO3jntEms2BxLw5RFNGbp4
	 Xjim0C2iZPNbp2KhGwlS4VKBSC9huQ2tpeKSKRz+LCN6VsO2sy8jmHL+GDJEhv3ZRX
	 N4eJWYzyIm1/7Z7YRyEyZOiIxYC+R/aFG8RDDIL8=
Received: from github.com (hubbernetes-node-76efbba.ac4-iad.github.net [10.52.181.67])
	by smtp.github.com (Postfix) with ESMTPA id 2BA02320150
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Sep 2026 03:13:02 -0700 (PDT)
Date: Mon, 07 Sep 2026 03:13:02 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1142530/ac5a8e-000000@github.com>
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

  Branch: refs/heads/1142530
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
