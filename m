Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3028F1C4A14
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Oct 2024 20:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729108827; cv=none; b=uiu4DksS3RSGP/zWSbBvB/Ffo5s8LWo8bVQJvkjptcBCwTerrJblzdnjd9ExdVdBfLnQl/96uFx3votTiXrY/U6xM/O5f2bhS7gjrOAnTY7kRu3Td/0VazpVfAeg+z2+3lbkiXqzFiHiDbrJ1yS+yCNsuuoe2zI3bKBqMYYO1+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729108827; c=relaxed/simple;
	bh=f8EKoHb1hcwN/Oe2KcJSCM5rZDwtBR1pQJdJIOCMv9Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y2YUe8YzbAe7/k1du1S6WtDAxHeFqAgKhH9+qo1tF4r87aJQzptUpVv7ZRrHiIv0A/8V+Rf/iY1AYQVMFkQSy4t+vIsKu+4eJr7iQklFjCJ90szYLfhVUKOJCo7dqTKZD6yWmEu7BgOqSRfgCTz7dCmbVSpqDeqR7sIsqXmaIY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drAdW2kD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drAdW2kD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54AEC4CEC5;
	Wed, 16 Oct 2024 20:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729108826;
	bh=f8EKoHb1hcwN/Oe2KcJSCM5rZDwtBR1pQJdJIOCMv9Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=drAdW2kDEj0TSv6OxgpEPP0gOyQ5O1bPzZRLO4UTYkbyU/+DuN6eNe/di6UeBmhFL
	 IQWCt9lja2xDYLbj/Ok4x/8UgsbDrfi3nCobHWloDYxig9lGMMW7Q87OKMYkZv/oDy
	 QkCPT/L5R4izlQ3v3gI/NqEApx1QGdgCPAubYZSUz5m2FKLMHqeMi28aOehcChA+Mu
	 0TOwXwBAFbj8FvLeRZERRyb21iO/Y6b9GBHNTvrT4Kwo1XFC6uTNMPSdNwS6Z1It2V
	 H3n3EpxL6YxXBabGcmrc7hoVCv7iKZPah6L7w2unRIe2TNXcw3srK7CsvRoQaLUzVi
	 7vN889lUIUTAw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A833822D30;
	Wed, 16 Oct 2024 20:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: btusb: Fix regression with fake CSR controllers
 0a12:0001
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172910883173.1941839.12095683348470531394.git-patchwork-notify@kernel.org>
Date: Wed, 16 Oct 2024 20:00:31 +0000
References: <20241016154700.682621-1-luiz.dentz@gmail.com>
In-Reply-To: <20241016154700.682621-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 16 Oct 2024 11:47:00 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Fake CSR controllers don't seem to handle short-transfer properly which
> cause command to time out:
> 
> kernel: usb 1-1: new full-speed USB device number 19 using xhci_hcd
> kernel: usb 1-1: New USB device found, idVendor=0a12, idProduct=0001, bcdDevice=88.91
> kernel: usb 1-1: New USB device strings: Mfr=0, Product=2, SerialNumber=0
> kernel: usb 1-1: Product: BT DONGLE10
> ...
> Bluetooth: hci1: Opcode 0x1004 failed: -110
> kernel: Bluetooth: hci1: command 0x1004 tx timeout
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: btusb: Fix regression with fake CSR controllers 0a12:0001
    https://git.kernel.org/bluetooth/bluetooth-next/c/b29d4ac72975

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


