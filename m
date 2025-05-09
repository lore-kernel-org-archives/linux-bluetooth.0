Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAB029209C;
	Fri,  9 May 2025 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799193; cv=none; b=oq3pRHoEgxWOsGMgmjp8oMNNfr+SlyfvMLtE8cnGKhcf030XQMrbSue7qfPIHNO94Ij0sngGPZqDPmZRVi3kFHklsuf4z0hMCTL2T8JWdAAJZdyJGMDjXrzO8DkE+W8YDnIu0yWccjjtVvIK6//HBpX4cMnIG597VIOLgH12M4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799193; c=relaxed/simple;
	bh=ROgWdid7c/yEmb3uqb2vXZ1HBfK4dRYMC8OhxqMwhQc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VhZ4jwS6dgwGFKZhOn0u7kshIm07pQsk2Fjl1jMke1P4s1rJQ6y5jW9wpxuDEQnYyE5uLYvI+rn5Wy2VUXJ0qD22MD/YX7bOUyfnMNQOH59PN4iqCPCcY5o2j/yDSoNQWzGPAevFZZhQ17DVvqIo6TGfIol+eUNPwrBe30lSDkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLYe1CXl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLYe1CXl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B26AC4CEE4;
	Fri,  9 May 2025 13:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746799192;
	bh=ROgWdid7c/yEmb3uqb2vXZ1HBfK4dRYMC8OhxqMwhQc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GLYe1CXlUmGWd4rai+giAFHlVBlN3QxQE2SrV2vTRoBMvCBv5b46LEdbVl3jnbOzS
	 dbXAA+AYvCsUZE/j3qUyjPbG6UC7Y05n1XC82KRlwsPMQJXjjm2hVqqWTKsIgyK9CB
	 hdeOturOqkyPbi4H/7MXtWxin7zFBPEA6B+BsVAfE+EEXrKg809ar6KZhcG6QP7lu9
	 RLu48fkA+T1d36TuQ/u+24Kq06VqaVJxCfHplV2o68fiExDz1DaWyJ8JmXj9Kd3TK2
	 P5wmAih/WJZvOnod+IcWvcqhPd/WXBoKKhhd5MAHOTq+ZjSkQj/N1oZfdNgrE9Egtm
	 lhS9J1LoS1PQA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id CB7AC380DBCB;
	Fri,  9 May 2025 14:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btusb: use skb_pull to avoid unsafe access in
 QCA dump handling
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174679923075.3627564.8490985602611263681.git-patchwork-notify@kernel.org>
Date: Fri, 09 May 2025 14:00:30 +0000
References: <20250508141520.440552-1-en-wei.wu@canonical.com>
In-Reply-To: <20250508141520.440552-1-en-wei.wu@canonical.com>
To: En-Wei Wu <en-wei.wu@canonical.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 pmenzel@molgen.mpg.de, quic_tjiang@quicinc.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  8 May 2025 22:15:20 +0800 you wrote:
> Use skb_pull() and skb_pull_data() to safely parse QCA dump packets.
> 
> This avoids direct pointer math on skb->data, which could lead to
> invalid access if the packet is shorter than expected.
> 
> Fixes: 20981ce2d5a5 ("Bluetooth: btusb: Add WCN6855 devcoredump support")
> Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btusb: use skb_pull to avoid unsafe access in QCA dump handling
    https://git.kernel.org/bluetooth/bluetooth-next/c/259a6d602310

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


