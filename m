Received: from out-30.smtp.github.com (out-30.smtp.github.com [192.30.252.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C19387363
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605821; cv=none; b=ZisednoiijNY2Rl6lweQXZautzpSikIDNb4AkMmD2xKx84KeFFndmRQhrQ3x4eePNtNoyZvKMHmVKtkJZu4X981vGp1ENO6jttcyWu2PzvoCEY8zCUEBXusBQC7OqZ0i0CHTvx/fXYm3cRobK/Cq0H3N1BL5RvjGvvIxBAJ06aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605821; c=relaxed/simple;
	bh=7hT80v1upZsj87nOqe49veeUudMQy5106UnKgwSAF54=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gL9gEqYteZXFAxPq2T7oJ9eRUdyohbXaRwdGLvyd/SS5YnXwi7tkY/cx+J3euMD3Zudw+vColIZld2FdoHCpFQ7ZAnSPdiJM6FJ1OPc+bPaG7cqfEvesT1RukZg8rVWpJgwIZ1DbWyx2K/zEg/Zi20WbRMiweJfbb9dsT4BkSrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fGaMkwH0; arc=none smtp.client-ip=192.30.252.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fGaMkwH0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783605819;
	bh=dxGWu4smESLIJAe6EXZerS9j/PrrFjVBCoApvfICiEI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fGaMkwH0zwI8EVekQL2d+lBWcGvMIdwtVCOdngcj36ZI1yIbgKr7dJgTEBnIpdyNX
	 vHxdfwuhbPXJNLYiNwgRAN73NGRWUkD4IVo15Kqym1m0kdUdxGiDWlpgyoT6XuaFl2
	 O2miZTipzaNv/1V0yVwd3bQZ8O1GD4eZqCL8119M=
Received: from github.com (hubbernetes-node-362f921.ac4-iad.github.net [10.52.152.35])
	by smtp.github.com (Postfix) with ESMTPA id 9348D323319
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 07:03:39 -0700 (PDT)
Date: Thu, 09 Jul 2026 07:03:39 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108616/e22bd8-000000@github.com>
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

  Branch: refs/heads/1108616
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
