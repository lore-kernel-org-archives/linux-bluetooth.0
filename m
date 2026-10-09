Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA31331EB3
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791566409; cv=none; b=R35oGJFCc7ZwZf5DgU2059Flf66yuQBGJf2IwoCad62A9VUUGCzYnzX7p5QCJVru2uzv80XeJjOcIbsvrcF8BnjKHR2w527O3cP92AUIVps2NojZ8Jxw/zQa8wz+fivMUWcCzIHgAc1msY9lRYNFcfjM8QqgK9QY8y471RPgNZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791566409; c=relaxed/simple;
	bh=AiRr0aJvCsXIdw/39YKvFhhTbuhkSL2JLn4pUdOFY/Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=as+ISIIrm0ehRdpavvOiK2aDD6fQkqeoWcm3fIH4gZ6y3fbNWO0m7gHc4Nu5JDZh8V3+DMOgog8eFzeBg2E6AzkkCXruPYvnTDABd/mxZWqknaGpgiaikanGX5JjCcisTJffFTMjlbidGLLE3uU9p36YpOl2T34ZtZw6e2SC73Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxeERavw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxeERavw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F7D1F000FF;
	Fri,  9 Oct 2026 17:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791566407;
	bh=t07wWQB+sr180IHMZ7RejcMrBUOtwXHVT1nQkKrFFgA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bxeERavw3qo43lVi7XfdMsa/WJ73KTEkX/N5KFKchdvmBKzIK34NoxOxs6ewEqCJf
	 Fe7A+18Ll9Rnu1yhJV/oUdUvgk/nM3RdkktOZP0QCzrUWLVs/FUZvtb4aLMY8vN0Yo
	 QSFeQVdo5gQn0dwKh5gZCwzEzZtmZqeR3SKPobGWLrzQatHQiWomeL3xHEZ8ewr7aV
	 JpAu7N9olmdobJNJRtXCT97qmTwqI29bdn6Oe8aAN2NFDo/Z8RjfGMqm5PBfvK4q37
	 bS4czm5kNqjCOXfPlkMBtIRnrOuk73/Wekt7Yg3ONnYAg6RlisBuqkCYwlnkVl/82k
	 o6qEIWYe1uo6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7745939253F7;
	Fri,  9 Oct 2026 17:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 00/14] Ranging Profile and Ranging Service PTS fixes
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179156640627.904243.17709722202598866188.git-patchwork-notify@kernel.org>
Date: Fri, 09 Oct 2026 17:20:06 +0000
References: <20261009092532.3600749-1-cheng.jiang@oss.qualcomm.com>
In-Reply-To: <20261009092532.3600749-1-cheng.jiang@oss.qualcomm.com>
To: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org, jinwang.li@oss.qualcomm.com,
 wei.deng@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
 shuai.zhang@oss.qualcomm.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  9 Oct 2026 17:25:16 +0800 you wrote:
> Changes since v1, from review:
> 
> - src/ and unit/ are in separate patches throughout. Two of those splits
>   leave the unit tests broken in between: patch 2 changes gatt_db_notify_t
>   and patch 3 updates the test callbacks, so on patch 2 alone they do not
>   compile; patch 6 advertises Abort Operation in RAS Features and patch 7
>   updates the value test-rap expects. src/bluetoothd builds on every patch,
>   and the tests pass once each pair is applied. Squashing the pairs would
>   avoid it, if you would rather have that.
> 
> [...]

Here is the summary with links:
  - [v2,01/14] shared/gatt-client: Allow registering notify with explicit CCC value
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=52fdca35b8e7
  - [v2,02/14] shared/gatt-db: Pass the ATT opcode to the notify callback
    (no matching commit)
  - [v2,03/14] unit: Take the ATT opcode in the notify callbacks
    (no matching commit)
  - [v2,04/14] shared/gatt-db: Add gatt_db_attribute_indicate()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8199d710021e
  - [v2,05/14] shared/rap: Honor CCCD transport for RAS on-demand ranging data
    (no matching commit)
  - [v2,06/14] shared/rap: Add RAS Control Point Abort Operation
    (no matching commit)
  - [v2,07/14] unit/test-rap: Expect Abort Operation in RAS Features
    (no matching commit)
  - [v2,08/14] shared/rap: Shorten the requester Control Point response timeout
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bf0ce0541f28
  - [v2,09/14] shared/rap: Add real-time ranging data delivery on the responder
    (no matching commit)
  - [v2,10/14] shared/rap: Add requester ranging data subscription API
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=14ad98fba11c
  - [v2,11/14] profiles/ranging: Expose requester ranging data mode over D-Bus
    (no matching commit)
  - [v2,12/14] client: Add Channel Sounding ranging data mode control
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=68ac6ad752f2
  - [v2,13/14] doc: Document Channel Sounding ranging data mode control
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2cd5045f1ec4
  - [v2,14/14] doc/qualification: Add RAP/RAS PTS qualification results
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b111351fd617

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


