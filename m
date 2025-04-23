Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B6A28EA52
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 19:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745437020; cv=none; b=MjzIKA4X+bN6M0vSC94qPcM2tdk5n2+bunzdiZefwJ4lX3xTcO5nes5ak9rfYKmAR69B9zs94XQsMR3+uKa4z32VP+nSHv/5Ds3BGnzB7GJTxBiO4UXR+EapQJnhVmkMsVYMpmNIMPhg+8RS6fsZR5JpWKrL1D3hFMgXElDJrNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745437020; c=relaxed/simple;
	bh=H7dkkzZiRe2VZULiemxdcEU7Ez6ZC9cmnGw3WLVPlc4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jISUi02wkftnEuCgBsnHInxrE190XBfWF6UiXOe7OOerYB1gqbnx1wtaiSe6C/Y0uCv37qHjq6nuwfz95O2e3p7DJlDaNeFt+RA+F96p3WBvv49z+A1diDYHzVQ8iNC2c7yuOkWZiJfwd/05/IpN7taPKXyS4n7lWxmGzbXJe44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KFUsho0J; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KFUsho0J"
Received: from github.com (hubbernetes-node-cddc1d0.ac4-iad.github.net [10.52.160.15])
	by smtp.github.com (Postfix) with ESMTPA id 85DE5700703
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Apr 2025 12:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745437018;
	bh=H0HQcI5weO4jUFrdoQ7uscO64Ho02NrTI7dzHLC0vyg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KFUsho0J8B1MHJCpZg6mZjqh8GiiKIR/shUR3dYVdMzMX8RTPwSE0cR0ACa+ZL8Pr
	 mw7T7V2bXEuY0qdl+4hVqZ8Fvd0XdUC9fjS15YErbZqy+oExTClCvleRmcn9WxB07M
	 nJ3P21AxaAh4gtZUH/8NNtzt9OWD2ecBjY+o1J4I=
Date: Wed, 23 Apr 2025 12:36:58 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/3e9827-e06ed6@github.com>
Subject: [bluez/bluez] e06ed6: workflow/sync: Fix workflow task
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: e06ed62241c49436066591ee7ec683c5605dd63b
      https://github.com/bluez/bluez/commit/e06ed62241c49436066591ee7ec683c5605dd63b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-23 (Wed, 23 Apr 2025)

  Changed paths:
    M .github/workflows/sync.yml

  Log Message:
  -----------
  workflow/sync: Fix workflow task

Sync repo from bzcafe does assume that syncing with master has not
happened yet, thus it aborts before syncing the workflow branch which is
required for patchwork task to create PRs.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
