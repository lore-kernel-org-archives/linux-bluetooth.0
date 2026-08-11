Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B905E3FB7E0;
	Tue, 11 Aug 2026 20:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479068; cv=none; b=kczIyD9uw+gmY0ISaTTGPCZnXNBAYeQJQzb4+HDlUwxJ+Bt3AQhS2eLXHHqVjWtbwqnwdNqpT7RRZ1hIGD6kPdAgtcjth5iD8U27Jsu1a7h5sTbpPiNwkdXqk83VHtS9XaflprrlX3NJch0C9bTAt+kvDCRmQPHZiOcuib6SKIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479068; c=relaxed/simple;
	bh=1WWqBzUhHfAti4fAbUmba5/s7Ki5+EYSB3hV5eCOpt8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qk1fFuP1Yefoqisvp05bc31KOwsS06fcasJZ6uGaOJaJOZV3q8Zqg+QuZfwafaWzPluG63uF9YVCw+NpG9i1vmBC913/o122ae/JP6IrTwP4YuP1HahLgOMTCZCsKSIXkwdKKqugeQGnGoaEhKpVFNywGvtNclLMvvILOD/WHyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnE5FJcn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnE5FJcn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14701F00A3E;
	Tue, 11 Aug 2026 20:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786479063;
	bh=tc/nB767G1nkDVubRACPA+W7cgIuXh5AMy01sEYVezA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dnE5FJcnYoRY3LkinC9/xq8+QrZ37rKApIZx1AxzHlAa3SModoz8i7dHey1CCI9yF
	 uM83bhQwqN2iw9iLUoEruz6BsCJPLey5wdDXfAAw8kZZXpuzSlZWCBSuXh7pbpDdhh
	 iCLenak6aKWEmv09i1hXh9Gi8yLCS5i3rlNt+uF+mr+s9juIg8NlSKEB+8pd1aOzOL
	 ZAss4GRhSwgMGI83yjGaih/DctEanay8jWKp4XnzGeQfF3yvxGA2upEYVDXObzcKZc
	 ThR6wLKar6lnCRrIhPOnLb0MPdiL0Pad2/vIOLD8uokbsrxGHFaGVw9LkFELj5BYre
	 9+AQWE2nfXTmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A5D3809A0A;
	Tue, 11 Aug 2026 20:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: hci_serdev: Fix use-after-free in
 hci_uart_unregister_device()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178647901938.1134064.357441239366725882.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 20:10:19 +0000
References: 
 <D747A53C08BD2456+20260810-bluetooth-hci-serdev-uart-unregister-v2-1-690493a6ab95@uniontech.com>
In-Reply-To: 
 <D747A53C08BD2456+20260810-bluetooth-hci-serdev-uart-unregister-v2-1-690493a6ab95@uniontech.com>
To: ZhaoJinming <zhaojinming@uniontech.com>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, marcel@holtmann.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 10 Aug 2026 15:08:45 +0800 you wrote:
> hci_uart_unregister_device() frees the HCI device (hci_free_dev)
> before cancelling write_work via cancel_work_sync(). If write_work
> is executing concurrently on another CPU, it can access hu->hdev
> and write to hdev->stat after the memory has been freed.
> 
> Additionally, HCI_UART_PROTO_READY is not cleared until after
> cancel_work_sync, so the write_wakeup serdev callback can still
> schedule write_work via hci_uart_tx_wakeup() even after
> hci_free_dev has freed the device.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: hci_serdev: Fix use-after-free in hci_uart_unregister_device()
    https://git.kernel.org/bluetooth/bluetooth-next/c/3ea6bd320276

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


