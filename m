Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBDC3CB57B
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Aug 2026 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787169058; cv=none; b=rY8fpDFvot0ln7T7O6xvIbD31IF0rTjH3+vykEkOc3mVEAZT3xySFANeRjGsZT8baBoZv7deCLMvrqUOt6QItHrTHajt2AimWee6LVsJUrMl2R4KSmbocn0DMoE239auvbQZYIQMbQ6FFksamwpONawGOcmesT57H7D8jNEf2KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787169058; c=relaxed/simple;
	bh=+t9fUylwvNo28CWoEwH7ztRr1Kdd8f0Z+D0tFntDvKw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rOV4DfRxdxYND8HlS9/erL+TbiI1igoTgKSgbKn4cfbstqaEruUvGcpXMx4919FOGkmWMg17T2nTwaV1QzzLPxFWvgNK7KbUN88Pb4dfO+2wcnVUmf4nh11ITup73kiBBto7w/Pd4OtbgnQMxYbKAiv8u2QTFiE3izmFwCrgy60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlN/UxHo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlN/UxHo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AB81F00A3A;
	Wed, 19 Aug 2026 19:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787169056;
	bh=mfEjSlFcRKSICGPA2+LHcGYj2sQ8GTetjDE6VN20maQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mlN/UxHobMiomN6DarCnOQ2XdQLezdBtnh6GrkT+8c8C5ukrnyZksH9R1VjKU5AjO
	 gS7eb34bn0sMl3VxV8YxvPx1FEGUA4g9PuXfqeCe2SYlwt0cAyZ/7OCq4xHH+O6o6Z
	 +ivatHJ8STaUaeFRjJeud5zlkNUTCJJSH4U9A2pMTtOPm+7XlraQUBaxn/87N7P2dO
	 uAak1183fZtmaLQ8ljxThKyNS1s3iwL2iWJhyyUkQs/O78zr38QRnpmhrCkafTiJTy
	 O6GOl9pyv1RfU3po2d8zXA/ZNxMt478k9jGJzbTy3yuiQ72kNNbaWBPHUDIr7I+tM0
	 lg5jaYus/rCqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D08C33811A47;
	Wed, 19 Aug 2026 19:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ] doc: Fix typo in test-runner.rst
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178716900756.3669166.8746606926794477351.git-patchwork-notify@kernel.org>
Date: Wed, 19 Aug 2026 19:50:07 +0000
References: <20260819091333.1203931-1-hadess@hadess.net>
In-Reply-To: <20260819091333.1203931-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 19 Aug 2026 11:13:31 +0200 you wrote:
> s/lunches/launches/
> ---
>  doc/test-runner.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] doc: Fix typo in test-runner.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1280c6f9d00a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


