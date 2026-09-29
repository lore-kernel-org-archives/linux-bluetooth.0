Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2B9551997
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790695229; cv=none; b=LQS/1j7WYRrL1lCcoVS7JY1abRmCfJAe7AEdo3XkbdzsO3IYZXCKQG/KpZG54Scm6eJgH82IRdB6g4RC5O8W5DEMAR1yW6OXZq/hXJZ8GG5NLSxxbJkvyHtGck7OWwX/7e/HcV4p5LH+KN5w9PHGshJuYMJxd6U03dRJ3bfcY5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790695229; c=relaxed/simple;
	bh=YzCoMZ3vUeoitQ1c0p0Ju5Z8lN0QYic6g7TSmzbaXBo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tXQkrWWIE1IhbFsw2lw9zAbmAmAnSZMf8ccMqRNx3QX/boryDlMg98HQGeq/XW6QAfIODoPqcKN9g6KAFoiP/oOrVsKjiEl41MAWjqj5uyW7avlCiD0OlJPwB0RPKqC+jKi31lihI4x2dxMpAjhjiyelzG0m0GirdpwXfkxRwY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYOQqPxC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYOQqPxC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7401F00893;
	Tue, 29 Sep 2026 15:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790695217;
	bh=nHJcjuzzRQE50B//tpOuG+UxpaODArwKsCYp3VjRhdU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VYOQqPxCuIxOPucaFkMWXndwa7ij/i7wII8t3fKVFoUaavMFQrK/zd2M2jSjW3Soo
	 HjLFnjsCnV2I7ndXt5qExHl3MP9G1+bSdOk4jx989Wte+pMetc0I6MNv+Oc88oPIsH
	 o+5IG7AigTMSywBSVFQZCyKcQHn8mc6nsKmVrHQvxIxBMVhxvxRAgH9S9v1iCVfkPn
	 jClL2vj9HoTVgbFimIrh+2Sybs+MZYqkCWaZK4k2hKpXFAdwncmPnoqpGffI9tiWbl
	 DFHMCls1bchV1D7NzKg6Q4JyUaTwuOz14cTTEFyYJQqJ4SW01XOXMMRJukQVBjjCTO
	 8agIVKV86apmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773A2392704A;
	Tue, 29 Sep 2026 15:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] build: Fix coverage target failing with
 stale
 .gcda files
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179069521602.987606.1397475380776965493.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 15:20:16 +0000
References: <20260928204732.1265535-1-luiz.dentz@gmail.com>
In-Reply-To: <20260928204732.1265535-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 28 Sep 2026 16:47:30 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Coverage data from a previous build is not overwritten by 'make check'
> for binaries that are not run by it, causing geninfo to fail with a
> stamp mismatch once the objects are rebuilt. Zero the counters before
> running the tests and mark the targets as phony since coverage/ is also
> the output directory.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] build: Fix coverage target failing with stale .gcda files
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8814ac26fe65
  - [BlueZ,v1,2/2] test-runner: Share build directory writable on coverage builds
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=86713777f91a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


