Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6384443AB0;
	Tue,  5 Nov 2024 15:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730818824; cv=none; b=WaY+PvrWrrC2M3tRivPyaBdB+AkZ82y5y3vluFNy87p9krIiniyokDA/Vreqrvx/n2T95CAJOXOK+FwN2nGUowAzKKyPShnlNStaWQ3zYowFt/jBNkFfwW3pEY5JpdwCSc7QuXIi1/czz4yDyQgsro76/RMC7JUP6lu2YGnZWm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730818824; c=relaxed/simple;
	bh=hwtMV9Qj3NKD2N3GDsqgdxIXuPb/uUtnEmMIN4rXi2k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GCdu/d7JfTmVWX+tJh/yreUZXxATmXHTyqSoatfD6rpJPJbjmaZKPrXMJDL/F6m1Snko+6SXgiCFfewu9qeuMgoJ7Rrvcvjidha9nvgbhwTtZ/JkHRQ23K8/WgUrI3VF3fre0ulcpRoczh/ACDTmbboDEU0q3TQPOm7+rUkqqRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdv91sWH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdv91sWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E60B0C4CECF;
	Tue,  5 Nov 2024 15:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730818823;
	bh=hwtMV9Qj3NKD2N3GDsqgdxIXuPb/uUtnEmMIN4rXi2k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qdv91sWHFUwZk0VDjArFin6owvheOMzHKOnwxIFrw3vvJcan/FZ9GJbFp7wDe4t92
	 Bm9IwdTW1Wd3KB1kxKJOZaGB158an2xiYd2WZx9SX2ojduoHYaNyAkbeFQtMPcJthd
	 a5NBkeZKF699UHFDUkT7CdSxWpDnNBDtfyDYA8M5grMc2dUQ4a0HURSttyTK7vlIA/
	 jK8Zb3wC+8la2sQEPdvmoELTfCy7+HQVcAY/LZdbnVNBlKZtHdNOjGZoBo+UqSHvjq
	 1LERG76VYgx9OLQof0vMvV/Jvid0wOaMbn2pWz2yDX1xe3DMJLTOHg+fv3ftMY2FsS
	 wFltS6PoZUdHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADA83809A80;
	Tue,  5 Nov 2024 15:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add new HWIDs for MT7925
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173081883249.584547.18341653514811903582.git-patchwork-notify@kernel.org>
Date: Tue, 05 Nov 2024 15:00:32 +0000
References: <20241104131904.30447-1-jiande.lu@mediatek.com>
In-Reply-To: <20241104131904.30447-1-jiande.lu@mediatek.com>
To: Jiande Lu <jiande.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, chris.lu@mediatek.com, deren.Wu@mediatek.com,
 aaron.hou@mediatek.com, steve.lee@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 4 Nov 2024 21:19:04 +0800 you wrote:
> Add below HWIDs for MediaTek MT7925 USB Bluetooth chip.
> VID 0x0489, PID 0xe14f
> VID 0x0489, PID 0xe150
> VID 0x0489, PID 0xe151
> 
> Patch has been tested successfully and controller is recognized
> device pair successfully.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add new HWIDs for MT7925
    https://git.kernel.org/bluetooth/bluetooth-next/c/408ec48013da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


