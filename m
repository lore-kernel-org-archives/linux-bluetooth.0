Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2001F5409;
	Tue, 21 Jan 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737477613; cv=none; b=mbfs8WtaZZwjXNmKrjLxxHp1TzOM2b9UQAqsv/BUB53tEkt3ELGiKrBM2y4rBbdI1QrdswRg3PUw2kkGUxtGXa4C1fuzZGDXuFuhqqpBHgDtZzQcj9eiAJAm7Gfyj870lW/R+VKMGDkxyZCO7ssmiLjJb5Ktspid/saE6s3cajw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737477613; c=relaxed/simple;
	bh=I7VAlx2LAbUKhlFI9VMjWnBFKV+epykO0NLI40YmLwg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rnVxxp4EbwdREdXkU9mLnRj51bcvuHd1Odkkbp1z8GzJJZ7IjXDq2aqNpkm3/g0/HDXgqKEd9bHKwLxFx+hjRcr2OAGOapJ0z+qCgoEg79KwWvdiNhzgNAfQT9Nsff6kM6I6+O3Jip0fswzybO4G/wz6Pl4pKtmaAm46oErvljQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmcNNuID; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmcNNuID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85266C4CEE1;
	Tue, 21 Jan 2025 16:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737477612;
	bh=I7VAlx2LAbUKhlFI9VMjWnBFKV+epykO0NLI40YmLwg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PmcNNuIDnHTjBOClTPZ8qtHVxMYSLgGliflEYMKintitNO9HtnlnvIOwCa2bbxgZq
	 ko/Jobuslbusc3j5om7TpNdxqwVx/fhs5n5Vsu80c+dWjqne/AhmtDiIXEVwM2d4Bu
	 Ydjh2rF1mRQ09+Zdo5kxJhM0VwEU5u9xdejkZ+PKlaHcdu/euSZI9yPZCJt7/ETN6K
	 PS3HOdlJPeR4Li/LIIlwMwXw/4qTgpu4W/SNy5oZk84j4WCwUBgogtli2Nh44FizC1
	 81i6rTNp7ay/2789taLmcEEsGlPUT0S3HuW95o54HM/G4XzaxQswQquizJb+VuDrqV
	 DW4LpeKbQruZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB72F380AA75;
	Tue, 21 Jan 2025 16:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Fix possible infinite recursion of btusb_reset
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173747763674.49514.2712197702480683058.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jan 2025 16:40:36 +0000
References: <20250120183938.1.I77eb26ac40229001ac90a70cb877c902456721b7@changeid>
In-Reply-To: <20250120183938.1.I77eb26ac40229001ac90a70cb877c902456721b7@changeid>
To: Hsin-chen Chuang <chharry@google.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 chromeos-bluetooth-upstreaming@chromium.org, chharry@chromium.org,
 marcel@holtmann.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 20 Jan 2025 18:39:39 +0800 you wrote:
> From: Hsin-chen Chuang <chharry@chromium.org>
> 
> The function enters infinite recursion if the HCI device doesn't support
> GPIO reset: btusb_reset -> hdev->reset -> vendor_reset -> btusb_reset...
> 
> btusb_reset shouldn't call hdev->reset after commit f07d478090b0
> ("Bluetooth: Get rid of cmd_timeout and use the reset callback")
> 
> [...]

Here is the summary with links:
  - Bluetooth: Fix possible infinite recursion of btusb_reset
    https://git.kernel.org/bluetooth/bluetooth-next/c/9e2714de7384

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


