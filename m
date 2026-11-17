Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941418;
	b=DqGqRwSASZuY2NRCCBJQ+/BlOYU1q5EytYK0SgtIPv49vopkmdlhvSM1++EumKS2GXR+
	 Fw8nDfAbhrL+r5lSeTKe8/lRqXAYXahddSJyvA11b7KrRyvnqUQjoMHckqPxWgTXHf/Yl
	 zGzjOGF0d7Y6PKuZM6+pO6Y2g3uemgdGUIYCD6DsjUoBRbzBcBOQmCZOOQr5Uu2DkcWfK
	 /x7UIh2Dz8uvXJCIQXP8MaRdASL+fF76q+TsiiG8Q1v6fvOUELeq9tlI2aFqnY/jAvsoJ
	 qirQ/tAHa8PAGbkizOY/9Mry7fOTLeQiPDlXGtt8FlG/cDHoMSySdX3r1mjpxjJc9Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941418;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=dhaqQFBevU5t/A5R732u5te+NgZi+LIPrNTPHDtBZ6U=;
	b=GKEEp1O2QmBNVw2M/XCIdsYZVAeroi1MeAU955rIJehHdQRBZa8PjFn69Xv+XGRiHmuF
	 n8br1cbattpa+MIztneBAtJUxjxLOaId4AcGmOJdhX8DFMZUgqZl1OBvTkrt/P6p4cJXZ
	 TlxDYLbiBu+ldEuiO+eeX2aDpOjh9caIbbzkBhvTroAdH5E3GKWz73RGKMeKPXzLtYep4
	 DmswBsUbGpGSnKL6ZGT1uS2GPV54Bbp4i+ZogfjWSZ1u6j6t0xiOECiOayikUZvuuRNTa
	 7S/mL4aNA8w8X2v/nuCJRizaKadgCzw92xYUIuv/pvVwueqqWgn8PEhuNARztpy0eOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Lmz/ADXU";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC4B606A893;
	Tue, 17 Nov 2026 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lmz/ADXU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425D11F000C4;
	Tue, 17 Nov 2026 18:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794941418;
	bh=dhaqQFBevU5t/A5R732u5te+NgZi+LIPrNTPHDtBZ6U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Lmz/ADXU/rzUmcGzBZ90z5sn2FguQPnqnicvccJPFpr2PXX9MOqBWQY9J27iElPkl
	 g8OtbadbnT9+dP6QEFNe5HcWyFvq4Wlb8vSUJs+xCLhDT8xm1WeichSzmBeR9seBoP
	 twQGR0yUHb/8LQkR7uLaDye1f93NVri2eznzvAf5c5vOTqVtHT8xgI8FfngU17cVIS
	 ejohexTDaSkPlMmqvOEg4fLp90Oo7Uj3My0egLY9jSUZeMivoeLutsNulDTl6vXifs
	 BEwn4t2lQnNgVB2wFZQ3w/bySxCf7NzWiamEBtzKMbMBH9ACnndApnSKq+kbA1a4Dk
	 oBFPY3gsvZhQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3A6392B1C5;
	Tue, 17 Nov 2026 18:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_serdev: serialize flush with transmit work
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179494141677.761488.12705162409776237119.git-patchwork-notify@kernel.org>
Date: Tue, 17 Nov 2026 18:50:16 +0000
References: <20261116080538.66575-1-enderaoelyther@gmail.com>
In-Reply-To: <20261116080538.66575-1-enderaoelyther@gmail.com>
To: Zhao Li <enderaoelyther@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, robh@kernel.org,
 sre@kernel.org, pavel@ucw.cz, me@michaelmcallister.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 16 Nov 2026 16:05:38 +0800 you wrote:
> hci_uart_flush() runs on HCI close and reset and frees hu->tx_skb while
> write_work may still be sending the same partial frame. The worker can
> then resume with a freed skb, or both paths can free the frame.
> 
> The tty flush has stopped write_work before freeing the partial frame
> since commit 1b0d946d6f08 ("Bluetooth: hci_uart: clear HCI_UART_SENDING
> when write_work is canceled"). Do the same in the serdev flush: disable
> and drain write_work before releasing the frame, and hold
> HCI_UART_SENDING meanwhile so that hci_uart_tx_wakeup() only records
> HCI_UART_TX_WAKEUP. Then re-enable the work, release SENDING and replay
> a wakeup that arrived in between.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_serdev: serialize flush with transmit work
    https://git.kernel.org/bluetooth/bluetooth-next/c/ee43bade37c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


