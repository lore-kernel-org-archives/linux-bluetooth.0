Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A61686353
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Aug 2025 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754064591; cv=none; b=WBlSduiNTakU8yMQ1NJtOjM1isB2V/DceGWjtQz1ZAy+fcUqWSgNghRi7aEicyKQHp2IYbI9YhDgyMERVvT22iCQeaHHjpnjhqfNiAazy4+XtCohuNZsAaeMJaba7bJ5DVbL2p7GJbTDrS7x2kmAJMJshJxv8d5ptBked6K4fFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754064591; c=relaxed/simple;
	bh=fv6uUc+j+9QCIPymSmg8eCqP8HDoq7cnxYalBgEj/ng=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XMSEoD7sEAfNv9XC6gxJ0ZmpSz4TfPXW8EU+ooPJFG6XP7OcP4avV1kKOGWSDGdn2lTDitxUhyqU5hGwg4lWKmBPJC6ULIRXebvHX33sby6hRem6dV4JYaR+aWco+Wcg8fikDw1WYgynFc7XcLiOFSUqiKF61iBPStS+7mC4K4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7DsKHW1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7DsKHW1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E242AC4CEE7;
	Fri,  1 Aug 2025 16:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754064590;
	bh=fv6uUc+j+9QCIPymSmg8eCqP8HDoq7cnxYalBgEj/ng=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l7DsKHW15XqTxn5iO0SHl71QFHBytQmZgeEsxkcERe6X9OmJAe3MDQ6MU3tZUqPaP
	 Vqe1QTjWGS/zuKmm2P22Tgb+SOKslcd7cxjQ3UXFwm6lfZKys0U8f3DEEUW7I9vbNq
	 IJL/pyzb9aNVK4+j6cHBJli6gwOYFEltRGVRKuqaX7W2jXwY4SFYnz4Q1437BGIVj1
	 R0hj6rCRugXf4hmNgZvUBRiFaqIVJbWqDYCL8e0GAIwc2KdfmPo00579Yk2gFaVlPC
	 XZClA0QVeHgWvxHaANkWH2ZCFyDCbQFilCMA4qDBhez8Co0r3U8PVXNSKqKIrYPa2r
	 dI7QMW9dF7ZjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D1D383BF63;
	Fri,  1 Aug 2025 16:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Define hdev->wakeup()
 callback
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175406460626.3987296.3223327461394877395.git-patchwork-notify@kernel.org>
Date: Fri, 01 Aug 2025 16:10:06 +0000
References: <20250731111711.1456427-1-kiran.k@intel.com>
In-Reply-To: <20250731111711.1456427-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chandrashekar.devegowda@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 31 Jul 2025 16:47:11 +0530 you wrote:
> From: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
> 
> Implement hdev->wakeup() callback to support Wake On BT feature.
> 
> Test steps:
> 1. echo enabled > /sys/bus/pci/devices/0000:00:14.7/power/wakeup
> 2. connect bluetooth hid device
> 3. put the system to suspend - rtcwake -m mem -s 300
> 4. press any key on hid to wake up the system
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btintel_pcie: Define hdev->wakeup() callback
    https://git.kernel.org/bluetooth/bluetooth-next/c/df18778595f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


