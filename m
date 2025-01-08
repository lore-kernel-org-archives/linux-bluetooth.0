Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03C31FF1A0;
	Wed,  8 Jan 2025 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736352615; cv=none; b=MBSj+SCUF4yav51mH6mH4wLNHgoiDBW2NZ5J04oe0+K3vbadevKrwu+kDRvxNBgNqNQMyGiY08twpfMs0DjCcC4hV/Feh6VH2t106QOyNUKXScY+BGyzHqRa87xj0iJra64bGrODNwqP/d6veIJU+e+sVxfbJ/VAg/1+OVBuIoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736352615; c=relaxed/simple;
	bh=OrjXXnFq4nOyoITQ6bQZlHljOuIuZnV/qxm0Jq1QCfo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J5Ah/OmC8SnIdvh7fJun5nP5GEYu3CXKwRt8H4Rp7Uz8y4rv2fWzZy7coBa7e817YzT3fVecZLnL9H8sDzgjPcfp/Zt0XFz7KfJ4hatcZrB2flzDkghKCttyTWPh+x7yDjRrAXNZFBOCZIZxW1e6V2SfUL5k/Jr6t6A8lJJn5t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TeQNw/Ve; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TeQNw/Ve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A488C4CEDD;
	Wed,  8 Jan 2025 16:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736352614;
	bh=OrjXXnFq4nOyoITQ6bQZlHljOuIuZnV/qxm0Jq1QCfo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TeQNw/Ve/1Gx5AcZlqV25iRx63yy6dsOljR93pULxVn3LS41WpXDez3AKhwpyx8x/
	 98TU9m3VjpkazFVbeijlooEII/ADjBHnghRoFXzvD7mWFYNPf93rCH5J5zPS2StMLK
	 0xHvQV882RL2DG0JL5bemyQUyCc8J14ZZPkuIPxwXCqGZwnGX4c/DEG/o6jpEG4psE
	 cHHsT4XAyVD5okR2zeH9AKMvYeAQ4GIt4SRcZMkb92x+MMolNUTBQf6bSgt1BDgwc2
	 7HFTpOUiWNjDGcxGIB9u/2e+nqojb2mqSEjAvDc8VSuCYhQjm/OXVRA2a2q/kT9d3u
	 8+x6DH1BWkMYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF6D380A965;
	Wed,  8 Jan 2025 16:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add new VID/PID 13d3/3610 for MT7922
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173635263574.697160.13448726939811072198.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 16:10:35 +0000
References: <20241224-tx55e-bluetooth-v1-1-e83ebc81507a@gmail.com>
In-Reply-To: <20241224-tx55e-bluetooth-v1-1-e83ebc81507a@gmail.com>
To: Andrew Halaney <ajhalaney@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 24 Dec 2024 14:42:11 -0600 you wrote:
> A new machine has a Archer AX3000 / TX55e in it,
> and out the box reported issues resetting hci0. It looks like
> this is a MT7922 from the lspci output, so treat it as a MediaTek
> device and use the proper callbacks. With that in place an xbox
> controller can be used without issue as seen below:
> 
>     [    7.047388] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20241106163512
>     [    9.583883] Bluetooth: hci0: Device setup in 2582842 usecs
>     [    9.583895] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
>     [    9.644780] Bluetooth: hci0: AOSP extensions version v1.00
>     [    9.644784] Bluetooth: hci0: AOSP quality report is supported
>     [  876.379876] input: Xbox Wireless Controller as /devices/virtual/misc/uhid/0005:045E:0B13.0006/input/input27
>     [  876.380215] hid-generic 0005:045E:0B13.0006: input,hidraw3: BLUETOOTH HID v5.15 Gamepad [Xbox Wireless Controller] on c0:bf:be:27:de:f7
>     [  876.429368] input: Xbox Wireless Controller as /devices/virtual/misc/uhid/0005:045E:0B13.0006/input/input28
>     [  876.429423] microsoft 0005:045E:0B13.0006: input,hidraw3: BLUETOOTH HID v5.15 Gamepad [Xbox Wireless Controller] on c0:bf:be:27:de:f7
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add new VID/PID 13d3/3610 for MT7922
    https://git.kernel.org/bluetooth/bluetooth-next/c/0ea7223c40b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


