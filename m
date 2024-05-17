Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E656D12F39C
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715960434; cv=none; b=eEBfcM1w7T+395xVnWibV2sofLOkhHOkxWqGOpeNUY6BJEzSynsioUP1dKrqZE3v+r0oTIfXrU9pXqtX/KQ9R7eEL9upfkWZChN7CPDSuIbQMDbEBvqxN8nMgsHUVernhpQ1wlHysUevjfg5V1hT490S/Nd/BAnKeHApYc8+CCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715960434; c=relaxed/simple;
	bh=thueUJ0hFyx6lrL1oH+SX0/tl6OFzETlt7lWv1RAU8M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A7+XNI5KuO98keyAEWbKWIL6K+EB7C34/XXgS+C30ZDjVqc7VZXDU7FojDN3ssnvkUCyWrOMGvUo8/1kGnFYcV1P+R4/F+dyt/TZhpJ4zrZ5Mhw7gRCg1HdS9Q4h8FII+XvwmLhiJrf+dn5b5us0TakN088Uo8gchMbvVwXT6T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtuA2zqd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtuA2zqd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 61A13C32789;
	Fri, 17 May 2024 15:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715960433;
	bh=thueUJ0hFyx6lrL1oH+SX0/tl6OFzETlt7lWv1RAU8M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FtuA2zqd9Z4Ri0cP2h5JtKS6n7N0heUZ7laygHRaPTadBw48VJqOE9fo99ZmBNS77
	 AbczCoKYgAfgj3kdoowscdZwlp+sbF2MfuxE4FleaxrNovARcOM4DisLzkzPjrQOVU
	 aTdUZjTXOkcd15vTtMRiVwQ4umZ0WibluFtoF37UdcswUqpEtKa/gCqyceFKGuiSw2
	 qidtaE8IHUfx8fE8cSR+WOG6rFOnp3pRwcb7GXX2Mh+l1AW6/ZTg6tySVZvjQyxRSC
	 yUDWS74RoxeS6ZVBZv2EP0l5YEWjmO3bLd5Asq0M2omgcWR/PR/8A35oW7ASbFjZLJ
	 BUtJnVZaJu5Ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4B6CCC43339;
	Fri, 17 May 2024 15:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/5] test-bap: Add Broadcast Sink SCC tests
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171596043330.3528.8286063651864328472.git-patchwork-notify@kernel.org>
Date: Fri, 17 May 2024 15:40:33 +0000
References: <20240517123436.146332-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240517123436.146332-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 17 May 2024 15:34:31 +0300 you wrote:
> This patch adds BAP unit tests for Broadcast Sink Stream Configuration
> (4.13.2 Broadcast Sink Synchronizes to PA - page 177).
> 
> Some shared/bap and test-bap fixes have been added for successful test
> implementation.
> 
> Iulia Tanasescu (5):
>   shared/bap: Handle NULL caps at bis verify
>   shared/bap: Add detach stream op
>   test-bap: Update caps to accommodate 8_1 config
>   test-bap: Make test_bsrc generic
>   test-bap: Add Broadcast Sink SCC tests
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/5] shared/bap: Handle NULL caps at bis verify
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f473d4404679
  - [BlueZ,2/5] shared/bap: Add detach stream op
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cd3540107f25
  - [BlueZ,3/5] test-bap: Update caps to accommodate 8_1 config
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=61ed4b4b60c3
  - [BlueZ,4/5] test-bap: Make test_bsrc generic
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=94c1c776ca25
  - [BlueZ,5/5] test-bap: Add Broadcast Sink SCC tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=62d38d6c9ef4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


