Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80486427FB7
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 21:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791841810; cv=none; b=hC2IT5Obugvz7qac8fhqdkfdSIsOUC4UimadxN4BwoXeMrQIiCfv6PYQZ8GCOXVSgGD6hjtqiDr7d7eTIDiiAtldsQODlO0QQxvLFQ6e1knxIQEMVO6qBsW7uLTuWgQsKiJ/wu8WgNU3y8AEUVbAQgdDu78lPP1suzpjG8YRLy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791841810; c=relaxed/simple;
	bh=h+LcuQQt6TgMxpxIdHEkJ4paB572xpQTktxzQxhlXpw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VvxFc7onNKmGRBnIAZOTtgeis4BPNz9/XcTiG28/F7Kuj4aOaxr1z87xJj5/DtD4v/jdLOx1QDeT+kPuFcpOKip9to8K/E3me2t/cK/sQVOVFmF9s0Vi+qAdkDZTdz5yKApMoR9VPkK4g9sI9hzCbacdqVNYnqTW3m6ix/tz+Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJJh/1yq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJJh/1yq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF4F1F008A1;
	Mon, 12 Oct 2026 21:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791841806;
	bh=HGGJ34fiWMRFopo87zX9Rw7ieqVkPuXlDeHjRDgLC/s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jJJh/1yqU7U9FwqfKHhffGuUacclT0lQ3OMNp2Am4dqMqoeAUtPcWMUfX5xTTiL0H
	 YaHs8Tp/JS5ESvq7jyJB4lp/By/e1ZaTjwGY0lAr9xUHgQ/AbkCc7Qk8cbOp9PO6Ih
	 yMqfawce41xhZ6I2pp18aXV2d5jsTaEyrySRolvhz02NrDzwnaJeJiCnjY4gi3hMmu
	 NuTHzBkF0glifW6lUCdlI13Blc4/6crA1/XPDmrlvd5TC+NcWqyt0HltZat15XP7hj
	 NJbP0DhAlv8X5yFatEzi/8qwHyQJ1TtiAmqhzkjYlzCNAGu9ER7MaovvSn9zg9vRzB
	 CevZ5Hsirsexw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B443039253C8;
	Mon, 12 Oct 2026 21:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] unit: test-rap: disable optimization to speed up
 compilation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179184180552.4115061.17190692838137610653.git-patchwork-notify@kernel.org>
Date: Mon, 12 Oct 2026 21:50:05 +0000
References: 
 <ba9d7cd83367a994657de01f124f1fee19f7485b.1791630862.git.pav@iki.fi>
In-Reply-To: 
 <ba9d7cd83367a994657de01f124f1fee19f7485b.1791630862.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 10 Oct 2026 14:14:42 +0300 you wrote:
> Compilation of this file with optimization takes 4 minutes with ASAN.
> Disable optimization to reduce to 2 sec.
> 
> autoconf puts global -O2 in CFLAGS that cannot be overridden eg. with
> unit_test_bap_CFLAGS. Use pragma instead.
> ---
>  unit/test-rap.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Here is the summary with links:
  - [BlueZ] unit: test-rap: disable optimization to speed up compilation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bf98544491b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


