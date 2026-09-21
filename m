Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9274AEBF5
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Sep 2026 14:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789999881; cv=none; b=BLAAtb8dGkNynUDvPZKeJmF5I+azLsTlaHknE8K0kgZFY6okU28kwhPrJHVSio7y2/oAZDAlQdyxojhLoq4hzevSOFXGQ5QF2MCKexRF/nAYi5L+ZgORtjUqzvZvpXblochYJSNYod2n2dTncQ0Hrp12ygE3HfjWVrzudah9/yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789999881; c=relaxed/simple;
	bh=8mg1oYzs/Ah8d16+R45Rgwy4C6GIVmrpG7hMoKAhHwk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZQJunwhTfO2lPyF6j59gICI1xEYCuB4nHEvAO6i+ZpLSQSpDkFIQkGIH3+T0J7QoATOzGKL+KbejRLz/ZnAqIzQCAUjTNn9jsaKNMa/Il8DuUDYvhahgHG0utsDc0OhjTfe7ERbfJltsnKOdswKdkwA5IWM4/sA4iXf0zmUc7AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+6W+JfB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+6W+JfB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369C11F00893;
	Mon, 21 Sep 2026 14:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789999880;
	bh=hQM4xli75f1OfuTxq6Qn21QKzudRvawMMy1MH1Hg8gA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=S+6W+JfBuE6bv1U+q80TXRqe5qX7uBUxTYrk4F4k9RRHsozsfFXL0/8IRbC0fwIiQ
	 NpeLJMlb5EHzW+uPrrh4eJxPyWVdChuZ73SNZpQdOvPFcE8scZCf5oW0N5TBhExyd6
	 2pN5U90CP7Kcmibz8E1W9jBqJr6AzPHMrxm+xXKN5Ap6Z/c3bU40hOI1AkKvOxhRy7
	 NbhbQlE7CN6w9XUJwFO26UAvcdOe5n+7u3V5wZFCHP224QiIcUJ8HdGmS+qz9U+l/P
	 vPFbpsrV2ly4YHwQnRearP1e1NleD9ZjSuRs9vd8YdzjUIiZ1YWIpSULktHdAbnLc2
	 rzO22YtZH3yEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199A73926659;
	Mon, 21 Sep 2026 14:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: validate device-supplied DMA
 indices
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178999981163.3047822.11881464017430827292.git-patchwork-notify@kernel.org>
Date: Mon, 21 Sep 2026 14:10:11 +0000
References: <20260915051215.2691851-1-ravindra@intel.com>
In-Reply-To: <20260915051215.2691851-1-ravindra@intel.com>
To: Ravindra <ravindra@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, kiran.k@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 15 Sep 2026 10:42:15 +0530 you wrote:
> In btintel_pcie_msix_rx_handle(), the driver processes RX completion
> descriptors (urbd1) written by the PCIe device into DMA-coherent memory.
> urbd1->frbd_tag (a 16-bit field fully controlled by the device firmware
> via DMA) is used directly as an array index into rxq->bufs[] without any
> bounds check. rxq->bufs[] has only BTINTEL_PCIE_RX_DESCS_COUNT (64)
> entries, while frbd_tag can be any value 0-65535. A malicious or
> malfunctioning device can write an out-of-range frbd_tag, causing the
> driver to dereference an out-of-bounds data_buf pointer.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btintel_pcie: validate device-supplied DMA indices
    https://git.kernel.org/bluetooth/bluetooth-next/c/37a111293453

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


