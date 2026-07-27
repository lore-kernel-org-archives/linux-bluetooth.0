Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D679942A145;
	Mon, 27 Jul 2026 20:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785185444; cv=none; b=cnKjfP9LoyftsskTlNLyHICo/+fuHGy1v8WkzWpg/NpY90YAkkhNvQ9swIzy2A0whQK4qgKUYlKIwo3HVq+n6S66KSeymlpjE0IWt5XoOwI04eZ+xTYtBPjCxaEt0agGDM9mHL5yN9+CPteu+qcroitrwCTcuR8OHgQ2HYFUEaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785185444; c=relaxed/simple;
	bh=4vMLuN/ZGh8fsRt9B2zgAWRGfbRm8uTyCmaSq4jQYaI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iR1P27+9OIRGf8vsh6M3bqn+5mwEU9VR3LkouYqpalcQ3NCmdh3cpJ7jrTa7WVN1jRmXvMHUNfEw2fs/MK0iObEffcjXjz0Nyj1k8b55QDq/RVd8gmKzx6z0gC3kj2KzgmxpDdzGmPYps5d+aokOcLQd7Z8smXSgfft3SV08N+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShaxVeCI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShaxVeCI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A76D1F000E9;
	Mon, 27 Jul 2026 20:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785185442;
	bh=Bek5K8MpSEcPq0n8AmlhIm0UXmOy9Y9eeNOvMKm/NIA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ShaxVeCIX/P0dn6AI9xK7iIKca/wqChDH+NUl4TooKyBYyhFAmyHGDVMZ0DIWSNOi
	 yZLbnn97y/OhzuLOtuKTnRSBwT7VYrfGRydZqEo/CM2t/0w2JlB9OZ7x3mJZWZHH5r
	 q9sMBLRsRL+p6JbMDcnbRbFLOK2ROd9OWoJMpRKvY2vL2FrW+6SAfkKbez9GTPhB/b
	 Vi7GYoaQmMR2xzWgGQXrhfeqg2hXP0jS1NwBfJvwwt+muYJHXRrTByagPL56Gw2Zfk
	 ZLIwol5O9RqrXvP/pMnN5aks/sqi3G52UaLPzhOEmEYveikpjHpLsz6ndYeMD2cfX4
	 c6qWmQsFXQn2w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19866380664D;
	Mon, 27 Jul 2026 20:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] Bluetooth: fix short read errors in usb_control_msg()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178518540763.1412337.1240855663216361705.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jul 2026 20:50:07 +0000
References: <20260727-bt-ctrl-v1-0-2e8650e9df01@linuxfoundation.org>
In-Reply-To: <20260727-bt-ctrl-v1-0-2e8650e9df01@linuxfoundation.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, stable@kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 27 Jul 2026 17:57:31 +0200 you wrote:
> There are two drivers in the bluetooth stack that suffer from possible
> "short reads" when sending USB control messages.  Fix that error up in
> them which allows the error handling to become even simpler.
> 
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Greg Kroah-Hartman (3):
>       Bluetooth: btmtk: Fix short read errors in btmtk_usb_uhw_reg_read()
>       Bluetooth: btmtk: Fix short read errors in btmtk_usb_reg_read()
>       Bluetooth: btusb: Fix short read errors in btusb_qca_send_vendor_req()
> 
> [...]

Here is the summary with links:
  - [1/3] Bluetooth: btmtk: Fix short read errors in btmtk_usb_uhw_reg_read()
    https://git.kernel.org/bluetooth/bluetooth-next/c/3501d7754c85
  - [2/3] Bluetooth: btmtk: Fix short read errors in btmtk_usb_reg_read()
    https://git.kernel.org/bluetooth/bluetooth-next/c/abcb881d99ad
  - [3/3] Bluetooth: btusb: Fix short read errors in btusb_qca_send_vendor_req()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


