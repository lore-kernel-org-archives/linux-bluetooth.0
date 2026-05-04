Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8933FCC
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 May 2026 00:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777853535; cv=none; b=fvunhl+qTMKdBAWouUX2CGo5ZZX+umUgQuX70Q7Rz7QP1hlKrbWo57DmNpWNg6D9010Py628lJl2l8/LtExI7lfuUrsKXzaOOPju1txYxZRSriWpeiYq9aMa4vz7qR8EvG232DsYSWoL8r+YJwRNtTA2RBJ9RgxyDkKxmVTf2Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777853535; c=relaxed/simple;
	bh=GdRe8fYGEGYTWFhjOc59dRb4sdpYUIuiUQ2Cbn+GSwM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=rVpyTJ7S9TemS4BogCCWDEdF8Jpi2loDz3MYfB4q1yHDCCZUkehX1w9oZFUha4zxVRiNhQWC2F7Sz9xfJS5TICVYzDEVhPeYdARSZuGQB34Hu2ThPYaxF512fJUVbgK0fmf57RUWEjIj3E7h1eHDz7PjV/LdruSyUs+nB/d3Ut4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NhmO17sC; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NhmO17sC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777853533;
	bh=kwXtz51pG5lugKD5eBniQdw2WsDmeRp1fY9hy70bPQA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NhmO17sCNy6YPdLh8NHrNo94HpYV3XvuRLVw/IhsNCCLs6ms9YRfzQqcOxPglIT02
	 DNzK+8VABY4OUiuq9bbxuDMydx5VW3NrfRMxh1d5L8yKLaNjoP9zwiXRn1DXLEEOcV
	 4uiZJUhZCjiGC1tIWy/VF+7PiAIrtFKCi8lotuvE=
Received: from github.com (hubbernetes-node-5d8cf9f.ash1-iad.github.net [10.56.202.60])
	by smtp.github.com (Postfix) with ESMTPA id 5397E521111
	for <linux-bluetooth@vger.kernel.org>; Sun,  3 May 2026 17:12:13 -0700 (PDT)
Date: Sun, 03 May 2026 17:12:13 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1077174/bd528c-000000@github.com>
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

  Branch: refs/heads/1077174
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
