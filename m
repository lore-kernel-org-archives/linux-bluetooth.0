Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6393191F91
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 14:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745503791; cv=none; b=SRY58xd1gV5SAAsqAyUC9ktH3EpLeTFv2X+yK6FlO4BE2MqMEuQ7JRGipiH5U5EaTg1v/7A8z4oRnNP45TUMTjTO1csVf3WyrRGw75eAriqNLaqC0EOA/zPGVFG6fOXN2PywKc3a4cqH+/R9EO1ht94Swqk18N6PobnwPPZQEPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745503791; c=relaxed/simple;
	bh=Tq0sdc/JalhnYTXqDL0XveIRoAuosYhhCSx/+IX87R4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CxxV3EdanKFg7/ptMucbuspVy33zo6gvGMdZfgUHW8//6kB8Ng7738UqvxdZWopiVxvQorIAmqAGl3h8FBpIG+zlIIH1UxU682omIug+78idXO2rw9bY2kB7f/R/BYEk3HvHdY7CfunvDCoXuo8MPjKf4ibsj6AwCwJNt20C4Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2zwDH+T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2zwDH+T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17078C4CEEC;
	Thu, 24 Apr 2025 14:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745503791;
	bh=Tq0sdc/JalhnYTXqDL0XveIRoAuosYhhCSx/+IX87R4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I2zwDH+TX3qLVmjoEG6IB/wmMGMG7S/2YBRxhXDN56+f1xVo9HzMZP9RwT9v8sMQE
	 NYbiramDj5EIeGNBKK4LX5x9qqKsPV7A/G31wyWfmLOGD/H/1o0v2dncjDGH6T62uF
	 JjnVkOnqBONvgUVdQtFj8qcVK5iBRUvvPJqGgKo2uLlnkL6CbY5blgRz13sZT4GLRK
	 +8XMXU2OQdm30UY7kdjM/rzpS9TSJEZ/0VoGUlxe62XQjYQhoVW/xCWWzM0Mkk2L++
	 ncL5dvGCQnnojV4TtmFAzg3QpA34j5Hh5llORil52wsUSFupkVpQVYZCXEWJS8LSp1
	 IjgMzqaNCJ/1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0C7380CFD9;
	Thu, 24 Apr 2025 14:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Add additional to checks to clear
 TX/RX paths
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174550382975.3366851.2565866147493840939.git-patchwork-notify@kernel.org>
Date: Thu, 24 Apr 2025 14:10:29 +0000
References: <20250420015156.192605-1-kiran.k@intel.com>
In-Reply-To: <20250420015156.192605-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 vijay.satija@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 20 Apr 2025 07:21:56 +0530 you wrote:
> Due to a hardware issue, there is a possibility that the driver may miss
> an MSIx interrupt on the RX/TX data path. Since the TX and RX paths are
> independent, when a TX MSIx interrupt occurs, the driver can check the
> RX queue for any pending data and process it if present. The same
> approach applies to the RX path.
> 
> Signed-off-by: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btintel_pcie: Add additional to checks to clear TX/RX paths
    https://git.kernel.org/bluetooth/bluetooth-next/c/ac1f44f12090

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


