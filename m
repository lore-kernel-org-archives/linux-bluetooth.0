Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EC21474BB
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715608832; cv=none; b=pdxk0GwjyVeZCMTSe7AnMJJZfaOFBoYuBumusFdo0Z3KJphylJoYU6uxeOB00Rwk5tZBQfDzvC5hP+KhYNLVHdhvFdXyW2sMpKESpDvVeHEJUXghGK1980Yv+QIuIItb8OcfiPT342powRyZVAV9ruC+PgekXDykNAP8nSVPfL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715608832; c=relaxed/simple;
	bh=Lg4eaznftMNZMmuA6lejJJB3YTjqitLoBM47C0NYbzc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SKXS1Ao23igiqzObIAQRQhgAceghHmh8h3JMUVpjLI0acKdPOa2+oP2LdTG+l/HUZNV0W+Fku0+MKHlnCHU+ajqkL+rdWSbz0Ly53CzOwUYtCPOaZc937j7dT5W4UkzK+fmzFl0d2qKiD4R51lyTUAJXl/xGQPwPqxUc6RKwDDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWbqBWwB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWbqBWwB"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04C0CC4AF0E;
	Mon, 13 May 2024 14:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715608832;
	bh=Lg4eaznftMNZMmuA6lejJJB3YTjqitLoBM47C0NYbzc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZWbqBWwBZmUT6kHD2ANd6RZ/ULKUUSO1EalJHWqgqP/9bf/LkTThebmSshvA+5RLX
	 JgMqWUI0NqLECjaqyqTngmXiM7xozuBZris8laVrnGdBnG1X1eg3tus8fQGHHfUHbr
	 ySyAhlUcR9B28D1es1W5Nn8D/VQe78pjaiVc5253biGqjIdxGx/ku+NfHYnFfETs2M
	 IvzHXpp3mF4EovUJmoyXwX933YBFr2YhdePOLwbEGPe0SB5bRT+Z4BDdIFM+H81JoB
	 Fi1BX+P9ZaBBWuOTveUcQYvu3IhQEx/N6VLj06pcuZZOk8kYCs9qOsoLxub2vi0cqs
	 MKPD5z/M9ca8Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E23AAC43443;
	Mon, 13 May 2024 14:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/4] test-bap: Add Broadcast Source SCC tests
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171560883192.16121.2248821930726811006.git-patchwork-notify@kernel.org>
Date: Mon, 13 May 2024 14:00:31 +0000
References: <20240510142754.3901-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240510142754.3901-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 10 May 2024 17:27:50 +0300 you wrote:
> This patch implements unit tests for BAP Broadcast Source BASE
> configuration (4.13.1 Broadcast Source Configures Broadcast Audio Stream)
> 
> Some fixes in shared/bap.c and shared/l3c.h have also been included
> for successful test implementation.
> 
> Iulia Tanasescu (4):
>   shared/bap: Fix uninitialized field at BASE generation
>   shared/lc3: Add missing LC3_QOS_8_1_2_B define
>   test-bap: Pass test_setup as test define argument
>   test-bap: Add Broadcast Source SCC tests
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/4] shared/bap: Fix uninitialized field at BASE generation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=33fdb06e7de5
  - [BlueZ,2/4] shared/lc3: Add missing LC3_QOS_8_1_2_B define
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=969ccb526ba9
  - [BlueZ,3/4] test-bap: Pass test_setup as test define argument
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=78bf2ab7bdfd
  - [BlueZ,4/4] test-bap: Add Broadcast Source SCC tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ffd538cf7757

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


