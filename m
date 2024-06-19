Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847C71482EE
	for <linux-bluetooth@vger.kernel.org>; Wed, 19 Jun 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718806229; cv=none; b=l8+q5NSU3YsgwwOQ6bTCGBiBEVwA88CODz61aGvDCu3zJsbyNq294C6i6PxtCscij5zHq9jenZZuzuhAlhRxFvfWMlUsvoenlSiO7cz8DiCH5UUE2KjbgZsnHHlhyYIlkyK6TddDRfpuvCVA/neExec+bG/FRpTCiEhnAMr6/PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718806229; c=relaxed/simple;
	bh=7D4Ibql1yynvYT+ThhCoSlYMBAQmB/tw0gCVPdpV+JI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OEDrZ9aPI+r1UFCmIjiGutgJZUwvCJTbeeY5PondlhBXv3idy77hIxp85XKm6u5ZvoM7h/yznVXMFjtBjlgN8W+LGlkKwWFR/EKq728YrGLy/SoDBBowXsTsSeO2L8skdnefe59+AK/mPFvomJatlFCMjRcYxkfdLxXGXZnbKWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p4W0ri2G; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p4W0ri2G"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 314C7C32781;
	Wed, 19 Jun 2024 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718806229;
	bh=7D4Ibql1yynvYT+ThhCoSlYMBAQmB/tw0gCVPdpV+JI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p4W0ri2GOCmq8+wok6lq5TKUjBehTwe3ec5q7NOTq7kPP0cF65ypzE0nSYXH1vY6y
	 69Il+EPu2aR5cocZCkKiOUlmsk6bSyikH26r5mqSQ2YXAg3a8A3+6sHwVZvd7t74yD
	 R6MHUPKjXuHHci25GfrtnSOPY18GkY12FcRQ/P7Uav5ke7aRfvMGGZibTCFjS52mL9
	 pO0jdKntZiJ7+3DCVe0wbkE1Wx87tMeWgiOxjKxcDDGqESPSvCBJajzhyNu25IeiSg
	 lucLuw/n1v/RxcRvCscqqkYfgbwSnVzF3GgE7AeONP+4o4v1fisJihX8gMl7dQsa1Z
	 RXsHX/khqTvkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 114BDC41621;
	Wed, 19 Jun 2024 14:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/2] bap: Allocate memory for broadcast code
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171880622906.19669.10788137030713318361.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jun 2024 14:10:29 +0000
References: <20240619095119.167652-1-vlad.pruteanu@nxp.com>
In-Reply-To: <20240619095119.167652-1-vlad.pruteanu@nxp.com>
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com,
 iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 19 Jun 2024 12:51:17 +0300 you wrote:
> Currently the broadcast code is set without memory being allocated
> for it resulting in segmentation fault. This implements an util_iov_new
> function that allocates the memory before setting the user_data. The issue is
> fixed by using this function instead of util_iov_append.
> 
> Vlad Pruteanu (2):
>   shared/util: Add util_iov_new function
>   bap: Use util_iov_new when setting bcode
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] shared/util: Add util_iov_new function
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=503ecbc655c5
  - [BlueZ,v2,2/2] bap: Use util_iov_new when setting bcode
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5ec05848a9d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


