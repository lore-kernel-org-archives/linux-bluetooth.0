Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC212E9EBE
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 23:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762471065; cv=none; b=EOnQQi0dFZGX/e30PxaFFyW2K1nD2XFV7wThuu3caqkNh79NblC/Zu+0976dEH+o6zlGdIUekCtGLGMvluLjjgRtide4C4FpDU3rZ+QD7lPNXQYazOwh15Am5W0XLH+mIVwN9eyo8ssrEQCWQMnH8hdD7zvwEmllDKLd1oNULPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762471065; c=relaxed/simple;
	bh=UgEQc5eat/rXAREU0MMihrl5fje9CfqOwXtaEfHMM0c=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=atLrZNIG9LB6m5M6iYzl+n7fVIBv2oUPbmkR8jkTf9gCzTM/SJcucOuGpMO+BC0XzFHM1hjS5f9Zko+JpfElplMezailVGfCDOXEHnDq0U0hVoHnia0AQpuPS4OxtplgptiOiBjeFhRH1hPvUfiuLpOgQSc5sG9Yd3wgB2V2HZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CKB2Xwwa; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CKB2Xwwa"
Received: from github.com (hubbernetes-node-af79c01.ac4-iad.github.net [10.52.154.57])
	by smtp.github.com (Postfix) with ESMTPA id F1A8421270
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 15:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762471063;
	bh=SL/mC6mYMAlGssaaZwP0Dpnx0Ll3NIzLwlAQ0wsaY68=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CKB2Xwwam30h6Aufo5W4JAF5ORBQOEbummdVYvPtU5gdi33AzN4cy84BUyjR07M+e
	 2dVw5mTe8lsr/quRsT2uHSfbrsRLYNvfuA/MlnNTeFF1ZbADRH0ZLATYaS9t5TKMcq
	 +BHpGlsCkvUS52dIA5+jA4cbo7+K8AzT6jv4EWvA=
Date: Thu, 06 Nov 2025 15:17:42 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1020034/1812a6-000000@github.com>
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

  Branch: refs/heads/1020034
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
