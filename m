Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239211D5CE5
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Jul 2025 19:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751569785; cv=none; b=Z97Ba5QdrDp8kzJ49a/X3v0sibsRPa/rRRvhlxVjOs5F1l7lKOhWG+Jyhwmc976Q/nRGLld8CpJwsPL7OP+UadXywJx4CJmvVYJX5yO2k1esSUEYZIixaBXHBQqrx8pHWMQw0LQEbrQf+0N7hNJhZWpJ0RPaFORaMuMX1O2nbr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751569785; c=relaxed/simple;
	bh=TAty2+RbRMpon4p31fgVuH6smez6hB9RXAN9hvk0bpA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ieGftcMDJSyUHJ9ngKe615Eg0AfgCq+vZA9qy1nwFhicVTFIGGTfXaB/fif56CRoX2U2hNfS7nXylRtnXY79QUyBkVLcqjZJodn4kYp/HXA1JZR+jG10CtnBOtdY5e9O4uO/EyQrNCqpE3JZtUCn0g0n1khdcsJeORvI5yB4Ps8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k91bDilP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k91bDilP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFDB5C4CEE3;
	Thu,  3 Jul 2025 19:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751569784;
	bh=TAty2+RbRMpon4p31fgVuH6smez6hB9RXAN9hvk0bpA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k91bDilP8n1xA3lTkWZQiEdzzIiDGMMW48VP91cF82pqbfgeSVq5ypWdXYxlQM4/v
	 zC2cTO+MNppBRqu2kSk8t7acfDDSRW+9D3Qafr767RGxf+lBScTShspkB1QahGDoVE
	 iuokOVplBi5j8aZnVZ7rDUODroHcxObt7ljjyAme64B1CSdTgC1JJKVVAxI8J85iQs
	 HqZ2SlGxQuucEgG0fJiMnAiE0uBB65o2lxpHdaOvfY4QaDp/vcH07qrXrnffeakB5K
	 +wZN6ZkPQJ/uMAROB9HTP/b7WBe/2UUEwGkDnARL2LGohflCRHs7aXVuKYntOrXozv
	 dv2XttFJCAaJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BAF383BA01;
	Thu,  3 Jul 2025 19:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] unit: Remove dependencies to android
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175156980874.1591867.17412875040979465030.git-patchwork-notify@kernel.org>
Date: Thu, 03 Jul 2025 19:10:08 +0000
References: <20250702192610.1547665-1-luiz.dentz@gmail.com>
In-Reply-To: <20250702192610.1547665-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  2 Jul 2025 15:26:08 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This add copies of android specific dependencies used by unit testing.
> ---
>  Makefile.am                   | 8 ++++----
>  {android => unit}/avctp.c     | 0
>  {android => unit}/avctp.h     | 0
>  {android => unit}/avdtp.c     | 0
>  {android => unit}/avdtp.h     | 0
>  {android => unit}/avrcp-lib.c | 0
>  {android => unit}/avrcp-lib.h | 0
>  {android => unit}/avrcp.c     | 0
>  {android => unit}/avrcp.h     | 0
>  9 files changed, 4 insertions(+), 4 deletions(-)
>  copy {android => unit}/avctp.c (100%)
>  copy {android => unit}/avctp.h (100%)
>  copy {android => unit}/avdtp.c (100%)
>  copy {android => unit}/avdtp.h (100%)
>  copy {android => unit}/avrcp-lib.c (100%)
>  copy {android => unit}/avrcp-lib.h (100%)
>  copy {android => unit}/avrcp.c (100%)
>  copy {android => unit}/avrcp.h (100%)

Here is the summary with links:
  - [BlueZ,v1,1/2] unit: Remove dependencies to android
    (no matching commit)
  - [BlueZ,v1,2/2] Remove android support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f0512114aacf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


