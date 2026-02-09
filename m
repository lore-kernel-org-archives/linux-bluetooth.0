Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE0C30B539
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770672153; cv=none; b=F/Jows4UCuSzqcRz9naoY84GZaGGtG2pB9Aambt5gf2hdjvupw3vVMjU6dIdQ6QmlqBGgfSGftQB9wKpTVt4cBpexRK7UfxvF6I993VbBvsT0l86KWwSZJw7Ee2tiMJEreuP42KYCF3PkzV2Ko8ErsVvpNFyzBb1EXtgnXXEyls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770672153; c=relaxed/simple;
	bh=WyJyid9SEzh+u24/yGUaHmmOB/sQc73eG2krv6PVlmM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RZ4eu+FyIZ8I8/N95mnITDmk2I/+e4c3YgUC96uyOH0XyGTfrZ2ClhGcchSi8XEax1yvZPvMqN6uj6cl9O2IH5nF3KcRd/8XJU/j8JtuYwJyA2RnGCgtOMRrQQ3EmndIEr0rjYi3x4Y5rhN+P4+xYZUPSBwHCv6aS2BI9OWoUIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HBt6RTNf; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HBt6RTNf"
Received: from github.com (hubbernetes-node-2c2be67.ash1-iad.github.net [10.56.145.39])
	by smtp.github.com (Postfix) with ESMTPA id 5EC73601324
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Feb 2026 13:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1770672151;
	bh=qEtD+l+PJXQ1aJy1mh6f22jw88pVl0xuVe6nDlQMvgY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HBt6RTNfDLVK8JJpO6WW8ESgR+t+eZ9nZ6/6ywD2zXh+kGX6lN280a4TfFKCCwNTo
	 Ae98jWl8FkAv4RwWngVNbAbSei+OqpNCY6UNHyae5DeT5chkAipZcXR7siaHgWKlzd
	 7T0MFF/K9Oj3hJslHE4KRlP/gEVpWeVCBOa79pNQ=
Date: Mon, 09 Feb 2026 13:22:31 -0800
From: Copilot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/copilot/generate-release-notes/761c22-ce6a16@github.com>
Subject: [bluez/bluez] ce6a16: Add comprehensive release notes for PRs closed
 Nov...
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

  Branch: refs/heads/copilot/generate-release-notes
  Home:   https://github.com/bluez/bluez
  Commit: ce6a16739989941784252b668a15ecd565dc37c1
      https://github.com/bluez/bluez/commit/ce6a16739989941784252b668a15ecd565dc37c1
  Author: copilot-swe-agent[bot] <198982749+Copilot@users.noreply.github.com>
  Date:   2026-02-09 (Mon, 09 Feb 2026)

  Changed paths:
    A RELEASE_NOTES.md

  Log Message:
  -----------
  Add comprehensive release notes for PRs closed Nov 21, 2025 - Jan 8, 2026

Co-authored-by: Vudentz <2156363+Vudentz@users.noreply.github.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
