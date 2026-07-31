Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4978547D92F;
	Fri, 31 Jul 2026 18:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785523846; cv=none; b=sRlKcusvmyUE2jG88wqeqVVrtFlORIAtd0l7VsRUGa3xFBYa5DXTDH2P/wPHUzKnfbzsHfFX0Gr2iA6x96pDDzArhdIzbHGXIOjnHBOUQJ7xdMDeYGBNdxxX4JN7/+H11ZXbcqVuU1jwGGMDR+FMe+BxTrbYUJ/a15wreUppmPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785523846; c=relaxed/simple;
	bh=/T64qQ7O7cLr/PRKrXggmS4RtwLcPkk44xqlCKeDufc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mKXazNMbpZAeyLJC5q596fMIggati2whqfhjTo7B8CzL+ERXDh12LGNi2zUinOsiW3pPqLkmZwbK6Ol5c3zAmlhld70Out/ch8/yryJX3m+kZTvCBj4433VeqEe+3+cuupyioSEW5KRMLkSsiHXG9SdvFzeGZv4S4Q5f7X9Seeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6ArdbTe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6ArdbTe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07A3A1F00ACA;
	Fri, 31 Jul 2026 18:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785523845;
	bh=RqXdYl/mbhQd85tJNAj7J+cfUrXURw59SiW12LDV1cA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Z6ArdbTehYK1PdBGOMWR8ghzcj3+cLapuAuNxPQTPVQmAhjKKkdK0N03WjXgZjFrL
	 Z9Vmt/TJwvDeFoF3lgIR7LYsaSArcf+Kaqf50KlKr4YQsSsmssbjU/2qr3tkaPi752
	 fn+m/AbLoGuu1tSkr6jgBdIX7dldhVlbXWvK4uXfGcIi0TaZGGU+meZKZN9i9oKs9v
	 yVlxrapR7TUxaVBvkjn0pkBzaj7BUOZWilAZGwbfCCuqQpfIhCEKhXzzBrczA0Go/J
	 7JIjWOTIJ9HpPOyblDW43kNYBG5+WeU6zkkUivVX6Rrisi3XzU/FXtYePNq8w/LGPH
	 qQdV0x0jxvV7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198E539263BC;
	Fri, 31 Jul 2026 18:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: virtio_bt: avoid OOB read of build info string
 in
 virtbt_setup_zephyr()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178552380763.861446.6322185394985227268.git-patchwork-notify@kernel.org>
Date: Fri, 31 Jul 2026 18:50:07 +0000
References: <20260715121628.1590321-1-sammiee5311@gmail.com>
In-Reply-To: <20260715121628.1590321-1-sammiee5311@gmail.com>
To: HyeongJun An <sammiee5311@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 Jul 2026 21:16:28 +0900 you wrote:
> virtbt_setup_zephyr() sends the Zephyr vendor command 0xfc08 (Read Build
> Information) and passes the response to bt_dev_info() and hci_set_fw_info()
> as a "%s" string starting at skb->data + 1, without checking the length:
> 
>   bt_dev_info(hdev, "%s", (char *)(skb->data + 1));
>   hci_set_fw_info(hdev, "%s", skb->data + 1);
> 
> [...]

Here is the summary with links:
  - Bluetooth: virtio_bt: avoid OOB read of build info string in virtbt_setup_zephyr()
    https://git.kernel.org/bluetooth/bluetooth-next/c/d264c90ca22e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


