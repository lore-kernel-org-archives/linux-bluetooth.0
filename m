Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9893CAE6A
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 19:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776110083; cv=none; b=rZ7NcfPiSsS120Tp/FIGcsjsDWT6ujHY1V0P2h/N+EX6lkeUS44qYX0N0wvq7J1sF2TzlwL/J9Sk4Z7i9HtTFcnq1h1sxCXRn93whhVDIAQwdE4m2tQqw53glgKN4yrMvPWUqJOHUNR2SlEC9IY1OVmFkNC9P/97oontD7isZXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776110083; c=relaxed/simple;
	bh=ZIMOCK0ULPGsBhRu6HBM7wnivwc4Kp0Fs8IdMsglMqA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=H51FrMK8LJf9RifJ06CoZL+0CqABMrk6pAJw/2ZzSeJ1faFkvQnSFn4tdJSFeYWG3H7hXE0EezGaraFFgOmeMQPP0zlXFKAON39S/1pNpQF70jaJuy4Jiyu0Od8zHPvG6LZRRISYA5MVly2oTdq1F55q9KGyvYeAqze/5RIIkng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TX2kZ+st; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TX2kZ+st"
Received: from github.com (hubbernetes-node-a526bec.ac4-iad.github.net [10.52.211.102])
	by smtp.github.com (Postfix) with ESMTPA id 7E2C920C86
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 12:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776110080;
	bh=zMHpfiTa2ODtQZA6Z6lz/dc9U60oUJ4kVh+aJlBxYw8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TX2kZ+stiyLC3kI/4WOJ5fVp5CMCKT0dOGe3WCHJxOWJCwswGzkRHxdfkgTOUzwE/
	 SSv5NRvVSHh/fuPepyCqJwHjN1ODsuP/THTtQKDH+S9Z09o1a19pnFlhR8S+sto3La
	 /NcIVdDPrFERU1Eb8VdFebks74uQjl41b5fB7Mfc=
Date: Mon, 13 Apr 2026 12:54:40 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1080317/f3626f-000000@github.com>
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

  Branch: refs/heads/1080317
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
