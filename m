Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59A22BCFB
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 16:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760372179; cv=none; b=Z4Zx+k/WB+t5rv+Itt/fA/aogGMsKi/y8vziJ80pw+UKUNcWcMnF95gGPnK7hkgUHtodDDS8Qs/X23K4+fADSme7vDMo3JwYfDHD8fwLl0+T2trjVXiKOG0awGyR/YqpmuS8zs+N93M2vihY0TdiIpJKcYrnnTS1ZijZMhuJA9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760372179; c=relaxed/simple;
	bh=/N59VcoblNgUmzU34ZGgA5Cdh/7uMfJRj4RzOr/8rQk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PtRDpDVdMS64zTEcw7TCJX4IRq3tsERII29ev6qSPpytyA+aKNJX6sYLIESnPwAsoGq0djb+xaa0PynWL2OxCs8f2xZgrr25QJvg/Z6853YCh4dnHqEL4hWEkpKNbO7pVVHtcy2L9o8Ba+RpTfJAG71i/L7nu0MqVDpSSzK1Qi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=apNRigTi; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="apNRigTi"
Received: from github.com (hubbernetes-node-28d4c94.ash1-iad.github.net [10.56.128.62])
	by smtp.github.com (Postfix) with ESMTPA id C13B914011B
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 09:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760372176;
	bh=zkCI1mLISfDiSW9fGYxJv9D62RYp2aTqI4QxbUawU7w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=apNRigTitmGu8eiD++eSNRHKW9Cf9DBESyi83RjtDRCP8GK9DidsS9ORsXxHW7auV
	 y/zORS2uTjrHz6S7rz20Qef8xRg9RoIt5HEdqTVMualGhBLyyQFhxMNcUMpE5uMXpN
	 aUqlciJ2LX7XWBPr+nIWxmCPvS4oVE+lDzspZc44=
Date: Mon, 13 Oct 2025 09:16:16 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1010398/b5a4f8-000000@github.com>
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

  Branch: refs/heads/1010398
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
