Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815924E1C9F;
	Fri,  9 Oct 2026 14:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791555625; cv=none; b=ckl9BxTYJkwB3ci91ZO9trk5acn/eLC24mc9ztuIHFSSQVDr1OMZ5ReILxXgkLbt94cqHweq8UKkJKeLB7YSPcEnMmfFsstSM/7AChTv9LkGfXeIUzgCQ4gP3W+Wqv4dTa3dIrMoSn4gssaVc6VkCaGGhKacAvs0bpRwx3v7Opo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791555625; c=relaxed/simple;
	bh=jtdrcBbprCDd++ii8S2hCj8pwSrucCqgSlFDfkt/mfk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TP3FBL/kr7bg8BSTsmYerCv4s0KITotR5OCMhHyuLqW1nmiotsZMZ/nUWuCstODoTm5zhGcZ8gwQxbH6FZzMdB30QtVJ29lz9XVwwQWEwq0+lt8Z/Tre12m7CKud+LtixxrB+HSkTIFApomV4TMJ3041Wx8kHp9rsyRjoJ2fjnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sa00Ros/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sa00Ros/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AAF1F0089F;
	Fri,  9 Oct 2026 14:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791555618;
	bh=ue6sMvCTKhSKDGOY6G36pM+CnT5oP20XVcN0AKJiArU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Sa00Ros/YAWyCKp6UF/DkD51Wgf+xOQcfWJt0Qmi9iVbO2IXMiMqX5XdXmqNc7Ybv
	 XYX3QHi1l6DNvQfXV78IIGRb+e3LqUR7qdXs8TdvBLl9S35FV9m/XFm5HI9NLGjHdU
	 boIPqmc98D1QWXpOB5BQ0LAYaSZhmbHGpDEVNtnKELEBoxPAtNcLP29JUjl8nSSBo2
	 fPE5KMyfy4379h1z7TJbe0DnnBDhx4DwCIfqBdrdNurwNIF1zTRaEmX/O9rIRAhJjX
	 gmRbEjTkHiVDGweLDo4n5VNWO6Allfw0BaWIlCXZthINTkP+hvEkmzccZZCmJ6eUAB
	 kVxfRYC6Yf/dw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F149E39253CC;
	Fri,  9 Oct 2026 14:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: L2CAP: Hold the listener while notifying child
 teardown
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179155561651.812174.13580314758223313991.git-patchwork-notify@kernel.org>
Date: Fri, 09 Oct 2026 14:20:16 +0000
References: 
 <pm-bluetooth-objects-candidate-0072-v4-c08f7303b91238d86930@gmail.com>
In-Reply-To: 
 <pm-bluetooth-objects-candidate-0072-v4-c08f7303b91238d86930@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, jjzuming@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  8 Oct 2026 12:26:26 +0800 you wrote:
> A pending child's listener must remain alive until the child's teardown
> callback finishes notifying it. l2cap_sock_teardown_cb() saves the raw
> bt_sk(sk)->parent pointer, calls bt_accept_unlink(), then invokes
> parent->sk_data_ready(). The accept queue holds a reference to the
> child, but the callback takes no reference to the listener across
> unlink.
> 
> [...]

Here is the summary with links:
  - Bluetooth: L2CAP: Hold the listener while notifying child teardown
    https://git.kernel.org/bluetooth/bluetooth-next/c/0d5d090d235d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


