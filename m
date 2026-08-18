Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A76A3EDE40;
	Tue, 18 Aug 2026 18:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078303; cv=none; b=S6KhH/nvu1gvNaFm/92jjXw4/URaccPEauOtW7ASrXKAWD0Py9L4wKShUkSdFG6hFesCpehZ1+wB3um04FLKB6X1Ymn075zKRlun+rRzywp1ZH+SuPjbYmOuSmJDQQLLHI2FM13mIYTH50EkiOKs+vuExMgLqzLG5bBqgWP87gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078303; c=relaxed/simple;
	bh=aKuivCN96HNJq0l+WnSpey6UBWBeOlB7g69WV0gMgtk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iMio4dJQzqWLBDuKNWca+QautQbMlfrYqg0dXeGsewF9GTvPqgESIo/WOjVu3gmLpulsq+Xflnx1qkQqb/QTTOL9KtOMG2stGa7pHy0R52QFu2IrXZzuyf8x3eVwmrBMN02M+AVcOalAOPvQng89bqrVXmKUfRGBRNBjFiffUYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmBpFdZE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmBpFdZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8CEC1F000E9;
	Tue, 18 Aug 2026 18:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787078301;
	bh=8Ou0y/MVVaKfSMn2vT9T6eGYkLqNoyI18uIjrgXskfQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kmBpFdZE6QneMZaA6+uY7lk0X9MwAUogf1wtFnffPFqkNyLcEKrzeal7lMyG1lKT2
	 EBgn3GusEFK/nUuH/TiAmydklNKXODw4deECAWeGsx9kX66xAixQk/Ehng7aFWZPuE
	 8H0S9oxdpae9E1ka/yvbdjw+mr+WbspcYh3T8hhIS+i51jGcPaA/L7MbQh+VNhJ0HY
	 XkACTvV+ro3QXISYKjwqumITxfR+qnb0xZ4/HtavMtBUmBBs5jIuOrJut5GXxPOT1D
	 4IFW50Gy3OnOMxw+6aRupjT5MhvtAIvt0NDZUQONW/L+8TBn9K3VB/R5Lpb9b8s/R1
	 u7DmfsGnjqu3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93956392704D;
	Tue, 18 Aug 2026 18:37:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: mgmt: reply to cancelled mgmt commands
 instead
 of silently dropping
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178707825319.2194892.1917826317801040923.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 18:37:33 +0000
References: <20260818114116.3228662-1-shuai.zhang@oss.qualcomm.com>
In-Reply-To: <20260818114116.3228662-1-shuai.zhang@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, chejiang@qti.qualcomm.com,
 quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
 jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 18 Aug 2026 19:41:16 +0800 you wrote:
> The kernel sets HCI_AUTO_OFF when a controller is first registered and
> starts a 2-second timer. On slower boots bluetoothd and the HCI_AUTO_OFF
> timer can race: hci_power_off() is already queued while bluetoothd is
> still in the middle of its adapter setup sequence. hci_cmd_sync_clear()
> then cancels any pending mgmt commands with -ECANCELED, including the
> MGMT_OP_REMOVE_ADV_MONITOR sent by reset_adv_monitors() early in the
> setup sequence.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: mgmt: reply to cancelled mgmt commands instead of silently dropping
    https://git.kernel.org/bluetooth/bluetooth-next/c/b03f74d42e24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


