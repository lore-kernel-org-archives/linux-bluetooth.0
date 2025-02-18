Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0534026AA94;
	Tue, 18 Feb 2025 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893204; cv=none; b=kshxJG/DnMgzOdWERPEsQf458+U9Tje+D0rwZfT6oZNtR1r++hTQBdHuFLts6ved9mofMfPjBAXHA9PTdFym/uMvqaN3MtmN/DzyqeMQK7qa1AxeatIcVx/zKYmGnaCfyU6nryGgJ7qcYl/nVQXhrIKmSBcNU+u3bwjQcxYsReI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893204; c=relaxed/simple;
	bh=XDLGOLmyn0wulJbT4BNUmw65fD9aIRIqvKKT7IQAmLQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T5ENFNZDc2XIBugs0Nd/RaCPmgPbhVo5601YGLAT9M5Gi4hGzgRqnWbN0JYJJx008GwMvo0cp1b+oUCi/RE5t2GBYtEfQoXq/6KzotcqHmyrwM991FmsdpaKRNVPwEp/4+NkN5akmCZbFJnBRWWHpqH8xmepLJ6/Tk6cLAxgazM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPg6e+iW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPg6e+iW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765EBC4CEE2;
	Tue, 18 Feb 2025 15:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893203;
	bh=XDLGOLmyn0wulJbT4BNUmw65fD9aIRIqvKKT7IQAmLQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FPg6e+iWV7U6GYAKsEFeECI0ay/8cQFDMF/Yo14q+FgZOCyKbcy7nTIYPCCwOGZbI
	 U91zfrVstzMVryUcbYmKHzZDtjYnf6vjLKHwBHxXXwCv+O10Cxq/TPYSgcN1m32taj
	 29PKELS4gAojp2DlwOXigzDiIaIIMkJhYOg3zqfB/LnQ6b3IG8zdszwQfrihegtXQ6
	 G/0VF0lsKYEleBRR5r7+iaB3paY7em69xeDhxGqc7cj4Lq9Dwp5AbqZaC76u6F8+22
	 ViGeAoaRZG9K8qfPo1PZ+bLTV8ipFMVJgab7NV0LovvGlbV4zcYPtflF4hpM35mJ/V
	 ah6/R3F3v2+Tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ED226380AAE9;
	Tue, 18 Feb 2025 15:40:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH v1] Bluetooth: hci_uart: fix race during initialization
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173989323376.4126041.7605697940734991168.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 15:40:33 +0000
References: <c7f1e8e5-e752-9ea7-ffe7-0ecc282bd92a@salutedevices.com>
In-Reply-To: <c7f1e8e5-e752-9ea7-ffe7-0ecc282bd92a@salutedevices.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, oxffffaa@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@salutedevices.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 12 Feb 2025 18:59:46 +0300 you wrote:
> Do not set 'HCI_UART_PROTO_READY' before call 'hci_uart_register_dev()'.
> Possible race is when someone calls 'hci_tty_uart_close()' after this bit
> is set, but 'hci_uart_register_dev()' wasn't done. This leads to access
> to uninitialized fields. To fix it let's set this bit after device was
> registered (as before patch c411c62cc133) and to fix previous problem let's
> add one more bit in addition to 'HCI_UART_PROTO_READY' which allows to
> perform power up without original bit set (pls see commit c411c62cc133).
> 
> [...]

Here is the summary with links:
  - [RESEND,v1] Bluetooth: hci_uart: fix race during initialization
    https://git.kernel.org/bluetooth/bluetooth-next/c/e2040fe3b82b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


