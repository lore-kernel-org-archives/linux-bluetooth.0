Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60641DFDE
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 13:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746107722; cv=none; b=OONTNzupwOrE3W1X4FHQSqacyASaEuj7+8UOd6Ny3k4mp7KMklk1SyUrJGLtILUSygVlp7obMtIrC+UDttZ8nGhjI7rNuYSinZevn2HdrjRo4+AlYfDesakdlAPZTCrPkf2VQtSR470iIOmj9MdVB8Q7L9u09MNUmpBOScoodok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746107722; c=relaxed/simple;
	bh=Ufx/HkRJKfzdjm3VR7adFhIIb0kmOOwr+dL15WZABm4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=l/yp82jRqVGSIDCyLozDqdWNb0Q8w4v+AqJ+5aU9keUL228ffXub4OPLjr/uLpK21NfVsEiiSXvX3VO90LuLbvn0mCMjTeorqtoJBZT87ebHIbWfPs5lfG82ceo7qVBnMEY7M8FPTLuGANs/iI3/HXGo5pQKBfLZjEPjJaE2BsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XT7/SsSM; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XT7/SsSM"
Received: from github.com (hubbernetes-node-8313f33.va3-iad.github.net [10.48.149.35])
	by smtp.github.com (Postfix) with ESMTPA id DE4004E044B
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 06:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746107719;
	bh=GRuQqGgln50vw8QcP+o31HLiAyB+eg0mvxJNRaDRIMw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XT7/SsSMA1B3pBDYXo/MZpVWfgSFe4Q/e5EJ+xHfvVy64E0rwZn9C/8mfuJaP089/
	 TeCFO3ZomopEEKrfdj6sbhZiFP+lAZI1ndqyFNOfSmO//oSmH2pEVjGSsrOORNhCmG
	 kMjrmgNysYizWiflE8lUAPCsU1JnLE/KC1ISgF54=
Date: Thu, 01 May 2025 06:55:19 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/958531/771c0d-000000@github.com>
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

  Branch: refs/heads/958531
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
