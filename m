Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A263A5E6F
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Jun 2026 16:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677012; cv=none; b=qyr+H0YpOgjVqFP70lCMJDIYGdezsXAYRrnjY3j1bYfqiOd+7+hYMeT1kHuOflLhjH43raedlQXMLK+ZhPxmSF2ReRAKouUghu2ZxWWshOV9YwWNgyq35M7HEmxifrT7uuEvz6uCoW66gaUjcm4h+QYEz0ZgCNUdHg9I4Pd7yKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677012; c=relaxed/simple;
	bh=DEgJ9vPRd1BQ5A3At1dzE2oEbrSeiGf9Sm6rL85WeWk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cazgwGlf8P/vL3K6NYe1eYd5DVMVWiU3JUQ7BpzGDlLhehMVyVVP6ns3CWJIFQx2Mb5QQP5R6dp22kYLrHMzdj+s12vwCvhpoLZfP2ozItlwhIyUeDejLT4E39B+51vpzytesFpNp7uviU5dhKKMlJ7bKQec62vqYT1/f+CfmLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jn04byG0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jn04byG0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813551F00898;
	Fri,  5 Jun 2026 16:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780677006;
	bh=bO1RgQqbCXiac6nai3yiW3Z8392CMwN7XBg2muqGsSI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jn04byG0zyoa1ASLcicrq9LY1FUEaYGHCohGXl9rdSyhV+6/7Xd5/bHUBR1SRq0c+
	 bDxYf2f7LNUSU1p6z/TQWndjm/LJ8wuvHroLbJ3rH8oIxR6TSVbLi/S/rOX+jtgIm1
	 ayNLE1HQvE9+Ry+EBcIbrIK0y76xSbfyVMuAI4zON4y0EsVUWMeVxmKMnSJl1X92b8
	 MOnJ2dDtSakaDyg62M+v0b9ZjQzrk09IQCOTBNGMlhJml84gk4e1SBz3c2U0INcD+x
	 xslHn7XypBc6lRL3lP+DGcR/pq69z2l+/lC6UZ6s/6m2sSZwmVMQf8f7sEUB1S0zpL
	 eSLbj3zfG9x+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1983E3930BAC;
	Fri,  5 Jun 2026 16:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ] test-mesh-crypto: Fix retval for skipped test
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178067700663.3831182.17546933147006464108.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 16:30:06 +0000
References: <20260605093555.1969171-1-hadess@hadess.net>
In-Reply-To: <20260605093555.1969171-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  5 Jun 2026 11:35:53 +0200 you wrote:
> Skipped tests should return 77, so they will be marked as skipped in
> reports:
>   $ make check
>   make --no-print-directory check-TESTS
>   [...]
>   PASS: unit/test-gatt
>   SKIP: unit/test-mesh-crypto
>   [...]
>   ============================================================================
>   Testsuite summary for bluez 5.86
>   ============================================================================
>   # TOTAL: 39
>   # PASS:  38
>   # SKIP:  1
>   [...]
>   ============================================================================
> 
> [...]

Here is the summary with links:
  - [BlueZ] test-mesh-crypto: Fix retval for skipped test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=80e9eb51c4c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


