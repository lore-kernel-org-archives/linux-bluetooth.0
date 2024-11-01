Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FB71D04A5
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 19:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730489870; cv=none; b=tve38fdn3IvtHqLtV+S8+uYvn72gNK+gtdTcBt8dn3zSVucO3Xrne6eJGXRqiHFsWqPEVnwebV3T6+FO0VCxCbkui1/qojmmdxESOW0ho95pUMFItxzA1Jz0bpJcSCqTQjdHDRsB3Thi8YRVL0JlXFXSt8WIqE7oHaFz1zYbu9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730489870; c=relaxed/simple;
	bh=ASvObvyuHw0OSwLxRW/lWxaXJZkkm0Vhc/u/0XCXjKg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Aje9MVi8zVFjtPRxDMMFLmoVv89T/CUGIZpd0H/T1jffu9G/emkok90LBxPOoY8k7pn0r309vQKAyeiFxueSdkSEcBbJbDa7Qd1BQm83I2k/FuabWVn1i95rXpbp/BNTjXtbkt7uy7T8ObGqOzHG+pi1DU5/RWKullbI9VPcxYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HETuhMK1; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HETuhMK1"
Received: from github.com (hubbernetes-node-5f207d0.ash1-iad.github.net [10.56.163.38])
	by smtp.github.com (Postfix) with ESMTPA id 3DCEB1412DD
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 12:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1730489868;
	bh=hcjr8Je5s0h7nJexvDisLTGO2XSmCDVFaVO/vSLl+jU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HETuhMK1mm4dmkh/MqCbup90al0YAzRShFksZdHQngKI4lCi+G/P1igOwlrAzLSbi
	 gYwIgE1X5BA4jsew+SyAHvmiugc0KkpN3n5+Ky56NiMv5qrpp3YJ9Jm6wc1TasyM3+
	 zPoYcxNG5Umz+sKpIQ6zGfPWmr/pLztDCDVIzXFo=
Date: Fri, 01 Nov 2024 12:37:48 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/tags/5.79/000000-0066a2@github.com>
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

  Branch: refs/tags/5.79
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
