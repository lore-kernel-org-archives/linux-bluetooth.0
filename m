Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4A92FD7B8
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762810084; cv=none; b=SwNFnMGmtiAijHAHiEguyJpS+jNZgTc3x3IuY6wuqR6WoYVjtOrbG7iJemQ/AR9FCAVAEL0/+XmBdBZdiWzAbv1dIdKWPSBL7XnIUUvgJGVdc/MZvRDGWioGauuPzOQkpRJfOeBRa8XvKwe9E/xla+RRIvQy3YxVZj23YMIHaLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762810084; c=relaxed/simple;
	bh=FPGAkUSKbK8rOyxYQBUlOWp9qvf/PdGVgZ001QyeoY4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=NKDWeL9MLro2Yepl6mpFvVMOgYkwXXj/4BBAzcFmmh70kUA4JM029nEYzDeGJ3fzqAgi8iTkP+pmPJQZKPBqMiVIRgQZcPuRe2/rI8sRBFxc7IHodsLqL9cqIXT8svaznafue3RegWq1PhBTVHl74DYby9jto1FjHUis2E/ozlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=XCGLucjb; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="XCGLucjb"
Received: from github.com (hubbernetes-node-3752b24.ash1-iad.github.net [10.56.206.13])
	by smtp.github.com (Postfix) with ESMTPA id F2E50920292
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 13:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762810082;
	bh=rDckmKbf7XkDI1g1muCHy1mMq0LB+tX5qvWwGsBf0Tg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=XCGLucjbgFho3eXhFcH+3GEgEpsKdFovzGyDQk/kbp8DvkGiLsXBkHca61krfpZdM
	 lCgMRSnbYTI00D8VcLxTv03gMt0cMkuZx/unU9mOaO/NONgoPIfZdfRVKCeTMSBF2b
	 uIC6o2eroOZyfeS7GUHJBCS7vd++49Hck9pvdDBc=
Date: Mon, 10 Nov 2025 13:28:01 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1020865/102f4b-000000@github.com>
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

  Branch: refs/heads/1020865
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
