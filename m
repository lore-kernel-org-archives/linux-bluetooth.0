Received: from out-3.smtp.github.com (out-3.smtp.github.com [192.30.252.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2969B2DF3DA
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 19:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577439; cv=none; b=U74ePAbdaKiY5a9DQQme7m9nSRvDAkNeMUXOo7VMcaOXT2/3YduF1QSyEVJ77s7MbhO8PmXJJ5YMZAV61UehDzINrSkclKfLWpqf0kC2sQWbc05QF7/1pXsOsveeLCu7pRgmpqtLknAabSGpPCb/vNpalXtwE8s+NJTiJZ4o8tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577439; c=relaxed/simple;
	bh=6WnVqR2PoyfMh/Zh1VN8MRXzyYUjk9FP+6oXqx6UNSw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XsboG0El2YSdpF7GYojllfuCmP09ygVzL+BOJzs+nT6T3CaO6MR8gFR2BJk9tXqdUUrTdw2TfLWc7GtGdsD6zhxU5CWUYiTVrLWqNbeoMu6ziNK0eafHdrfDtUh57lK4JutQDUN7xiy6xU924HVbEdCBQUcNxidiX+jLrsn6GbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dOyPaHiy; arc=none smtp.client-ip=192.30.252.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dOyPaHiy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784577437;
	bh=wBz83tcFyQ6v/tfX+zjgEsXTbVlqmZ5znGCX3CEjpsc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dOyPaHiy4+kTTPgwUzYiotLYuulnmUi8gRd6efdL5m4+4bsLXOeswCeu1q9mSNbd/
	 +wnqbffwrmTL2TKXYh8jZtAFXhAXM45pJJr4OEqyY/C4rVT2hr8OqTsYZ19PSgr2C/
	 3hGu67KLWQ93ObL6CV+HsUDoZ0SKqQCGKOiCUWfo=
Received: from github.com (hubbernetes-node-2f991c1.va3-iad.github.net [10.48.159.13])
	by smtp.github.com (Postfix) with ESMTPA id 223383415CF
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 12:57:17 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:57:17 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1114243/ffaded-000000@github.com>
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

  Branch: refs/heads/1114243
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
