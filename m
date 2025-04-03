Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569FE1D6DB4;
	Thu,  3 Apr 2025 20:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743711600; cv=none; b=oIm+MRUtcfahvoBtMEqlMoqpSNDqLozMdWQqCTPo2lFELq8YU+R4BFy5eBUXrhqipm95uJuD83jGZtjUO4/2NadhmDCboE3LPl992LPZ+w50h/Fy+jZMdnJweovijULe9jgPTHOOd79UsOkizXNCncifjItaTwdUhCFOSz7Rkgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743711600; c=relaxed/simple;
	bh=Ep8fp0SBr9TkStJxxgW2ebyfhtZWt3yVe89HY0d+/Fs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CoCw5iZ2u7K4rvNy+R+8oJ9deIYL9GFyGkf5OoT5yHQDJd7EKdGaUFTKpS8peD1sEvuxaCPSq5i+MwE2jo8p3rzTk0QydKDoqxu0Ud5NZ3K3l0t2uqp3VMqKZSc20IUoG6Zs6uVrU6TUZahzuyNKo0JYiQoKcU1T+1WHxAOfJJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glurjIlh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glurjIlh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8123C4CEE8;
	Thu,  3 Apr 2025 20:19:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743711599;
	bh=Ep8fp0SBr9TkStJxxgW2ebyfhtZWt3yVe89HY0d+/Fs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=glurjIlhgIbdc7HHpZ5kRJg9eYCAbtNEpJ+IJMnsHO1l7Sc3YKSgS0zWqUbfP0nWu
	 shqlKosx9bjj6MeUJjGat33KkTaQfbhZMPtvQlB6hkjmmS5057Z+/sjaAJZG/6ulot
	 catQe7RaGEqAShQszK7QugKn4wd4SAmezOiKOFQtDGfm4kTdWVSGrZvc22ts+zsSA6
	 aQnnrqoISTlwTjvn0W6jvUKwAxZZ4rSP377O8PxKTvQHxcNWSAmN7hEuz6O5IDq5lI
	 bkJkLf4L2xni+LmqhFcNdMC71Jbi+YpLGn3Je/4bvPr03awW/MN2PiTC6PjkhMUPJ8
	 wgenG+SSl/Hjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB304380664C;
	Thu,  3 Apr 2025 20:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/2] Bluetooth: btnxpuart: Add msleep() after changing the
 baudrate
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174371163549.2672071.11589670566595157295.git-patchwork-notify@kernel.org>
Date: Thu, 03 Apr 2025 20:20:35 +0000
References: <20250327182523.524534-1-neeraj.sanjaykale@nxp.com>
In-Reply-To: <20250327182523.524534-1-neeraj.sanjaykale@nxp.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 amitkumar.karwar@nxp.com, sherry.sun@nxp.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 27 Mar 2025 23:55:22 +0530 you wrote:
> This adds a 100 millisec sleep after change baudrate vendor command.
> 
> It is observed that when the baudrate change command changes the
> baudrate from 3000000 to 115200, any immediate HCI command returns an
> error -22 (Device Busy).
> 
> Adding a small delay after the change baudrate command complete event is
> received helps fix the issue.
> 
> [...]

Here is the summary with links:
  - [v1,1/2] Bluetooth: btnxpuart: Add msleep() after changing the baudrate
    (no matching commit)
  - [v1,2/2] Bluetooth: btnxpuart: Add an error message if FW dump trigger fails
    https://git.kernel.org/bluetooth/bluetooth-next/c/061e4972c48c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


