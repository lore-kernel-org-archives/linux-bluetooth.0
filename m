Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB6B2D5C8D;
	Mon, 23 Jun 2025 19:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750705789; cv=none; b=iDBEzRw7AeIMgIQMD5U6xEcw1Nu7KR+ekiVe4L9JJMfLcXnQKwfXXZ4MjCbjmcaUGxQ0yXKQcBWQimdZsrghqh8VhuIH4jUeXGnGmAlG7r/JM3Uwvq2d/5GWCPLzFU+C/wEbQ4D62EeRPkTizTT8a76nHvWe4mYmsYA4kUvPggg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750705789; c=relaxed/simple;
	bh=WEqi+uKBMx8lRLCnGSSxXTcZMZKVB27R29HoEuM/T6A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b2s0DFiaFrHCwXv3iPjL3+THkb+yqX3Q2h3aLQQZIa8Hz/bZbuVaG1xCAKSzQv01ezkWROFar8EnAch4dogUH1Aizp5CLL0vTd/bXTivIH8lFP7knFlR8gU17uEKv43vVlRDzyG8vltJLuVoqts4OvdMSVd64WxyXIRdvgGQ/Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoo5q/kL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoo5q/kL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2499EC4CEEA;
	Mon, 23 Jun 2025 19:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750705789;
	bh=WEqi+uKBMx8lRLCnGSSxXTcZMZKVB27R29HoEuM/T6A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uoo5q/kLJ0qgQi9ZaMe6zIEiqop6fxK+A33UlqJwXzP8+bJ9tlhRu0XINmD9aMZs/
	 T8oOHBIv36t9jkWy/BtQSbE7SkBHh68pkr66vuEzVMgU9jOmShv2UgT3dDqSruIY0m
	 R5mAkm+T2d4n5wdoAH74AU+tvE2nE/4BCWN99rIlsXYPjAr5Mvm1G+PBw5nyMXHPRN
	 qLnf1d03gu/NnnAMTF0j7cjjnrNo38mmdXAdO9/xUS4q0lCe/vVK8X0li/TiOI1pVW
	 9dwvp5kuWfoHg0G9/Dr8bKA06jju2TbvZ1pby+t3AdwsCxZalAjvmu7WiNVDFORqZm
	 3lYQJ2H0lfx1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E3138111DD;
	Mon, 23 Jun 2025 19:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] Bluetooth: Trivial cleanup
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175070581624.3268784.7052271797439895514.git-patchwork-notify@kernel.org>
Date: Mon, 23 Jun 2025 19:10:16 +0000
References: <20250623-bt_cleanup-v1-0-5d3d171e3822@oss.qualcomm.com>
In-Reply-To: <20250623-bt_cleanup-v1-0-5d3d171e3822@oss.qualcomm.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 zijun.hu@oss.qualcomm.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 23 Jun 2025 20:31:15 +0800 you wrote:
> This patch series is to do trivial cleanup for bluetooth core driver.
> 
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
> Zijun Hu (4):
>       Bluetooth: hci_sock: Reset cookie to zero in hci_sock_free_cookie()
>       Bluetooth: hci_sync: Use bt_dev_err() to log error message in hci_update_event_filter_sync()
>       Bluetooth: hci_core: Eliminate an unnecessary goto label in hci_find_irk_by_addr()
>       Bluetooth: hci_event: Correct comment about HCI_EV_EXTENDED_INQUIRY_RESULT
> 
> [...]

Here is the summary with links:
  - [1/4] Bluetooth: hci_sock: Reset cookie to zero in hci_sock_free_cookie()
    https://git.kernel.org/bluetooth/bluetooth-next/c/6d7d36f62bfd
  - [2/4] Bluetooth: hci_sync: Use bt_dev_err() to log error message in hci_update_event_filter_sync()
    https://git.kernel.org/bluetooth/bluetooth-next/c/482e06a993a7
  - [3/4] Bluetooth: hci_core: Eliminate an unnecessary goto label in hci_find_irk_by_addr()
    https://git.kernel.org/bluetooth/bluetooth-next/c/88855693e5a0
  - [4/4] Bluetooth: hci_event: Correct comment about HCI_EV_EXTENDED_INQUIRY_RESULT
    https://git.kernel.org/bluetooth/bluetooth-next/c/b02c1d6f2df3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


