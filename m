Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BED23DFC68;
	Thu,  2 Apr 2026 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151624; cv=none; b=kkF4+JBmXEGoI4ZBjgHbrUKg1OAlKqDxe66OxdkM1KiN4pATDcH+fVs5aHOVF411j5bodYKCvT1la+5ymwTDxPZo+y3jNi8L50KCsHWexB3zSAbYtsrBK36k3W4WYo+oxGxIDWg4A2rEKnI+wciCE6FIwx8KKx22pzwsBul5NQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151624; c=relaxed/simple;
	bh=fGdBxCeYoQg0+JCY6XySW6cdd0lEGy6WkQFaOOyHW6A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dwsBehvTABhG+01Fa64S7FKedVHxcCMLcOPsskrvRtQM/GCSvMeF/igBMjOaIfzKihV3fq+9G9vIpubPvR/CzLpoDC8cs+pWLmFlJsOLf8qOZEzSAAdbfXk5ZoSehEOjPkgompFpbAj06ynUEnhCF3xeIqRFXzSKWD2w6p103uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QZkpqbZw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QZkpqbZw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35C68C19424;
	Thu,  2 Apr 2026 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775151624;
	bh=fGdBxCeYoQg0+JCY6XySW6cdd0lEGy6WkQFaOOyHW6A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QZkpqbZw/PUptuzvY4l+4Zmv4ula3jcu0Wz2nxtI0ejzURQYuujloadJFQikIklje
	 VYxl7oL3FL6ZJ+0i268YcWr7PHHD+LTE2Hd5U9qM6zXJg6YzE9j+S+37HAOhVSMDhm
	 t6VzLftNXK0EHwqj5edgHfrfRJrr69iv72ZUoygc928oLdrvGD5ugA2+dmDB2sxMyA
	 CU0/ypQPpINx4M3F6nNBBcBR6PXp3dv8hgdxdhCD8GVGKFssKPjqu2kOhqc22SISug
	 sa5u2RyoXqz08wR2bl2aM/ays2hMvjXLDReDoMio7qUzB3CQB5J1L+yHnCwqjc6n5G
	 B3+vgWLE25rDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E3E3809A08;
	Thu,  2 Apr 2026 17:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btusb: MediaTek MT7922: Add VID 0489 & PID
 e11d
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177515160653.548768.855726341352896143.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 17:40:06 +0000
References: <20260331175301.6946-1-nercone@nercone.dev>
In-Reply-To: <20260331175301.6946-1-nercone@nercone.dev>
To: Kamiyama Chiaki <nercone@nercone.dev>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcel@holtmann.org, luiz.dentz@gmail.com, pmenzel@molgen.mpg.de

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  1 Apr 2026 02:53:01 +0900 you wrote:
> Add VID 0489 & PID e11d for MediaTek MT7922 USB Bluetooth chip.
> Found in Dynabook GA/ZY (W6GAZY5RCL).
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below.
> 
> T:  Bus=03 Lev=01 Prnt=01 Port=03 Cnt=02 Dev#=  3 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=0489 ProdID=e11d Rev= 1.00
> S:  Manufacturer=MediaTek Inc.
> S:  Product=Wireless_Device
> S:  SerialNumber=000000000
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btusb: MediaTek MT7922: Add VID 0489 & PID e11d
    https://git.kernel.org/bluetooth/bluetooth-next/c/3966e67cdd70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


