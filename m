Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56333216A11;
	Wed, 16 Oct 2024 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729105555; cv=none; b=rBhHCYLBQXd+G+G2Q3nVHKgrv1aKkwDiQ1K1GQ6NO6ouAOsEh4CoVL73loH9Du+SAZjEv/KmbXod8fSWDlaaUpGgSsS2YOhZcPnhQOQWQPIm4xnNmNb6UV/PyBAWaVfB+QQAeS7eHlqRqM1excHiWB28/4YDCzY+bKlJ+zgWxiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729105555; c=relaxed/simple;
	bh=QYnXOGF8R1NDKs5oSA/c2mA8M+lzKSI5dVC/N00m5mw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mDB+p42U4rRZC6zQcjw7aP3ICEz2bL+8S3G0uGvjwoK9ybPb7iiCRgTSwv8cb3UvcR2bNllumPLV7/iYhBtZHJRGqioDl3ab8L8rgvcw9Mw8TKdXAPHoHADXYxH1DXCNbutxfHxB0gCs+BDkThVXtVGnQPpkZ8cUkhu5ViMqeB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y58FASVQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y58FASVQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A77C4CEC5;
	Wed, 16 Oct 2024 19:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729105554;
	bh=QYnXOGF8R1NDKs5oSA/c2mA8M+lzKSI5dVC/N00m5mw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y58FASVQ6NNq6uxgMsGAKzEN4iZ6Q/EYA9Tx25JCUyZjAfZaVH8WdLKMddkRTAplv
	 psXQ0Pmn58m5GSt1EFDrCvzfhw1umwzFdxTaVUMpke7pTxq0JhThoVVv9WmJNyDtW/
	 LnV262S0MIByN+Na7LeTxqXUZ0hNwTdL/dgWWDPj+UrG9v/hlHHHkb/gn/nkzICI0Q
	 v/HCQ7MncFcymrtepJuS/MPMv0b9KVZubJ5FYmanqQ3+SEH7YCykadYKFG/nezcHf7
	 gK4W4Nlr8PaLYlrPoDOCzPJhiKLNdGEEofb9sMwCabTQFY/fn3WYIYJwwXpSWqU6rW
	 1h04NRr3nQo0A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DB13822D30;
	Wed, 16 Oct 2024 19:06:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH] Bluetooth: hci_qca: use
 devm_clk_get_optional_enabled_with_rate()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172910556000.1899946.12785708588610583517.git-patchwork-notify@kernel.org>
Date: Wed, 16 Oct 2024 19:06:00 +0000
References: <20240930080938.12505-1-brgl@bgdev.pl>
In-Reply-To: <20240930080938.12505-1-brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 bartosz.golaszewski@linaro.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 30 Sep 2024 10:09:38 +0200 you wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Use the new devm_clk_get_optional_enabled_with_rate() clock helper to
> shrink the code a bit.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> [...]

Here is the summary with links:
  - [RESEND] Bluetooth: hci_qca: use devm_clk_get_optional_enabled_with_rate()
    https://git.kernel.org/bluetooth/bluetooth-next/c/5fe50b4b2d0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


