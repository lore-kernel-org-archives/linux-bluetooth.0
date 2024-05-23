Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3DC1CF8A
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 May 2024 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716482434; cv=none; b=q6KdRWYawCZSTLixUwlsRNKSSiI4NmRRC/gCuZfSSsCmQL0PE+T8gWc1K+kj7PElsuvjacdJxQHzbaEiV+1Y3+l3Ctm1lsU4WcSqsebdxUwAIQC6SJkYehi5wK30Q8+x7unldnXUJYF3rXpckUBnQVr0GiV2C+okoQkmkkkkSlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716482434; c=relaxed/simple;
	bh=ZizcfXl5YH1f+gmqJrEyielzz6/UZL+/MLmAZ7EkusU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u6SKa3pdhreDSeKdaVRprn8kA1S49MpVRrsPxHpiIxytfnADEXTUuKhifx91/1Ry9xyagSHypyls4clVyHDQIrQHQKQJfw03F7qqGa8S5htLJYNwDTghTi2zQVx9C0Z+9fmevRUrph6qqwBCHEPvaGyoDY4DUTTBFF63cFxnZ24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HjU1TQVW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HjU1TQVW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AE0AC4AF08;
	Thu, 23 May 2024 16:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716482433;
	bh=ZizcfXl5YH1f+gmqJrEyielzz6/UZL+/MLmAZ7EkusU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HjU1TQVWlqRbrKz3lzoLwRHTm+fdgqEPERkgjsVVGJLP7WIzdqp/R1ru5maArfRqW
	 iDGeldwebJ5fNo8+AtNWb5FkGRzO8ZACxxjhtV6MN5s0wt5yFiNVuxxVriGImr9JR4
	 NjUpA1BfFVKv40Zevg0BbB6qw9X2DKZRcdywGMDCJu0XYsj1/hVxxggoalw3FaUvhH
	 gk2PAhJNgfNWa6hpY8IsdNv7fhW1lO1t8TCoPilJbC11Z78lIwFBl/MN5Y20U+oz93
	 ehwB+uXSjMm6imqEfC430pX1+wRGmIvfDvG+bvkiKRob2AVpM0Q0my1BOSWYqgbyRY
	 XNAR91Q3b5Iaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B105CF21E0;
	Thu, 23 May 2024 16:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/2] Update BAP Broadcast Source state machine
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171648243349.722.2700809383644914438.git-patchwork-notify@kernel.org>
Date: Thu, 23 May 2024 16:40:33 +0000
References: <20240523154754.39451-1-silviu.barbulescu@nxp.com>
In-Reply-To: <20240523154754.39451-1-silviu.barbulescu@nxp.com>
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
 iulia.tanasescu@nxp.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 23 May 2024 18:47:52 +0300 you wrote:
> Update BAP Broadcast Source state machine states to use BAP define states
>  for source Idle, Config, Streaming, and an intermediary state enabling.
> 
> Updated test-bap to.
> 
> output from broadcast-source.bt
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] shared/bap: Update BAP Broadcast Source state machine
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5da00f712989
  - [BlueZ,v2,2/2] bap: Update BAP Broadcast Source state machine states
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=75893035705d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


