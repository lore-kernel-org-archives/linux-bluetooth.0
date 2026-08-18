Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A097846AEFA
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 11:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787052542; cv=none; b=HMUiaDdIJtCejH/jmUnKwa8GA5GXQ4OJ99htU84XCZqnsXYyzyHHb3frkqCME5Gg2y08vdTVhX/7pCD4hrOoQCNTTmjQlrBmGtcG6wlJ4CdmiSk1KjxqHn4AWIw7MXNMmjTx9qThbXm3UOALWw0XeYP1qyfqHX9xMu8Vb3HgPDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787052542; c=relaxed/simple;
	bh=bIiPiemJOOZsNKlC8N9xdkdreVU9LfY5pbDqRs+OgLs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bV0+UpuDCxaOPmQnTQuhAu+YbABVI9qy8pBj2LJBTeqrwhX6Jtxkt1efBol70V4u8Z05wChQPbEhYYNFbB4rqS3raapqqb78kM63QIoqQRjOeQtztaBhyxirzFTWxyUZKivRQuyYtxk3z+kFB+Yy00kSVWDVCf092/pqbhVFuC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FRQSRPA1; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FRQSRPA1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787052540;
	bh=ZZJEwNKzw9kiLxkF23WLs9YoawdcXDsXzCMpRzhPfgI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FRQSRPA1RMTVTZkEWKys7hFn7OrNY7r79hKhq0b4u/J2S0qPLG4mjjRcGX+uYscDX
	 NnLK+Sdb8Ib69Zt0etzETGqe+RuEKMTc/jOUk1vdudwmV9pGsOsnRHJgh+HXX8KdIx
	 VxESAeBNVYxgSmXD1Ale7v3mvBd8GlVvKWBH0zRo=
Received: from github.com (hubbernetes-node-8a002ed.ash1-iad.github.net [10.56.225.19])
	by smtp.github.com (Postfix) with ESMTPA id B42693612FC
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Aug 2026 04:29:00 -0700 (PDT)
Date: Tue, 18 Aug 2026 04:29:00 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1147758/000000-0e3336@github.com>
Subject: [bluez/bluez] 0e3336: avctp: Fix typo in comment which contradicts
 the c...
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

  Branch: refs/heads/1147758
  Home:   https://github.com/bluez/bluez
  Commit: 0e333676dcc3aba34370afbf1e867bee3617dee5
      https://github.com/bluez/bluez/commit/0e333676dcc3aba34370afbf1e867bee3617dee5
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-08-18 (Tue, 18 Aug 2026)

  Changed paths:
    M profiles/audio/avctp.c

  Log Message:
  -----------
  avctp: Fix typo in comment which contradicts the conditional below

The comment says "If the request set a callback send it directly" but
checks for whether "the request did not set a callback" using
if (!func)



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
