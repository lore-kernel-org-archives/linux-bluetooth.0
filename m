Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9CF39AD33;
	Thu,  4 Jun 2026 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588354; cv=none; b=Ote8bNMDkNgMqcAftVxzqh6E8GX7YqUWh9g8fsIrYKqAenKvzriS7148DT6sWFP1N97GYM3Bo+gVD1L+dkx8KhJ2hqAJ+4yFNVr9/3QGX6rN/P4zAoK6As+wGIuc86nrt/5dA4XRb7vF0MGV/wR7jBb+Ci6x+T4FjW7gsCu4SJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588354; c=relaxed/simple;
	bh=R1MAf31K77eibanSnHp4s/29jNjZP6IY5GwY6SN2DFo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KksaLU9947MmwMTAFSdY+LwSDJavTsOumFIi+Gc7BAtzDF/sG+yAW89jdTyUXjjVced1BUKOGQVhNeFH+dNUeizzZO0pv5G7CJMnyphZgqRCK9rwwqZ9ZZYw5dM7nhUaylaO8oBCW0wGIIX7YC7yBWC0ye2YvX8EZzZ0v4kgFbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ktmt+kOL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ktmt+kOL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7522D1F00899;
	Thu,  4 Jun 2026 15:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780588346;
	bh=sJ3u5+2C6nQ10msRag8svsA6Ur7/VTXXPCCsJLg0+Cc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ktmt+kOLMS83vb+k1rzoeg2+DVWKRgVVFpiRmYoURQzOOjkyNNMpX88WkiT3n8gnk
	 umaMVZmxlvw+iG5+95z0cMAp56Rko/nFDVK1tOR5kw+KNrATdq/yHWuMQg6utQcgzI
	 OBSA+OmW+G83DtBKkk5dIyR8ci5S7eILDAQ7sQTDyi0m5qI13Jk2qI5g9LlLt5DlXv
	 ABNffOBBqCZI+o6yzfFzU3/GJbnBR/AwwiVv2k4xNax+NY0DkLHI75yNdEDBjcVTcm
	 v0LanvWUzZ+cGeoGZ8k4YyvG4JnXi+wcA0edaHsHcr6iOKzfzCTvgMi98eGHcJsfy2
	 +DXcfL73/ayUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A4239309B7;
	Thu,  4 Jun 2026 15:52:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btmtk: fix URB leak in alloc_mtk_intr_urb
 error
 path
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178058834713.2488052.11227407768144149827.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 15:52:27 +0000
References: <tencent_DDA5BDF30EAC58E68647B4C37D20A3C7A505@qq.com>
In-Reply-To: <tencent_DDA5BDF30EAC58E68647B4C37D20A3C7A505@qq.com>
To: Zhao Dongdong <winter91@foxmail.com>
Cc: matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 zhaodongdong@kylinos.cn

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  4 Jun 2026 19:46:40 +0800 you wrote:
> From: Zhao Dongdong <zhaodongdong@kylinos.cn>
> 
> When btmtk_isopkt_pad() fails, the previously allocated URB is not freed,
> leaking the urb structure. Add usb_free_urb() before returning the error.
> 
> Fixes: ceac1cb0259d ("Bluetooth: btusb: mediatek: add ISO data transmission functions")
> Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>
> 
> [...]

Here is the summary with links:
  - Bluetooth: btmtk: fix URB leak in alloc_mtk_intr_urb error path
    https://git.kernel.org/bluetooth/bluetooth-next/c/c583e1de7ede

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


