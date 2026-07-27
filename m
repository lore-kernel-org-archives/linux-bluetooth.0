Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86381435A8D;
	Mon, 27 Jul 2026 18:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785177047; cv=none; b=lg+Gemb2qLFM6Wr3h6vPM7jNID7S2lV8D1iDetGxftXLFPE196Z/Hm2igt/ikPzbVXjhuPKTjr8GlpIvVL7sOgl1Sv3bfL8gk0KMqB/NvDxnGnEybBq+/MrNMQRS68thtn1qLOCE//P0GeAZuuY6yZ1ilPzJioSN1IUGS1I2H+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785177047; c=relaxed/simple;
	bh=ZxoePouEBeD9RexLPMqlQQxeYIZUbSaL9h2fSAsT6IA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r8vxjYQmhSUxuPYme+cVp2YNGf39L/cqgKXL8eacVPrfpX0FjgWd7KM0A72IDxXoMJ+KF8mG5+8WswgKcq9Ynrc+xJOK0PyABRcgagFGZzFc2H+u6NWuFe7gejTAXkScEX0nvtSu9lMTW3nAB+QL9eVZRbuoyz0O+xiCuIN5JB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nb/x/dnV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nb/x/dnV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BEFF1F000E9;
	Mon, 27 Jul 2026 18:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785177046;
	bh=rcDxdR4uLExBvtVbqDNHVeMSqCXQaqP4fYIrNIzWUkQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Nb/x/dnVaZ6RZS9P/wF2rIwseZin9/4gGhKLYDEc+2AeWb0O1/vMXcfs0f2vLuu64
	 Fue7IFbm0xh/fGb2SFi37gh2nehIUe/43ccG6+tToFy0hcu1M30OXjuhRAVeJuIXE8
	 H9tPyt+TB3naaRlK7dB82lsflLToHxjWH4TVjBqW1wPwQ8loBLRq36TlzqzOdA8vY+
	 ic+9pzuHjnURCbMT+Y02CId6aTQ2MRa+jVxdSp7PbEX7bwhACjx+B/J31I9Cgyqj+W
	 BDkRkX49pEmdqjGbsv+PDWiKo5r64TSb0VFU22X2ZQGr/GfkdYNNZ2AtVPuCslMp8R
	 R4zsVCMpKDmyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D088C380AA77;
	Mon, 27 Jul 2026 18:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RFC v2 0/3] Bluetooth: Add generic support for vendor HCI
 frames
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178517701144.1360613.15398586406872211407.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jul 2026 18:30:11 +0000
References: <20260722-support_vendor_hci-v2-0-132b506460a4@oss.qualcomm.com>
In-Reply-To: <20260722-support_vendor_hci-v2-0-132b506460a4@oss.qualcomm.com>
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, zijun_hu@icloud.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 22 Jul 2026 09:24:19 -0700 you wrote:
> Hi Luiz
> To address the below concerns you raised on previous
> discussion.
> 
> - Not use safer skb helper like skb_pull_data()
> - It will skip sending to the monitor, making debugging much harder
> 
> [...]

Here is the summary with links:
  - [RFC,v2,1/3] Bluetooth: btmrvl_sdio: Do not free HCI_VENDOR_PKT frame by hci_recv_frame()
    https://git.kernel.org/bluetooth/bluetooth-next/c/dcf47a799e75
  - [RFC,v2,2/3] Bluetooth: Add generic support for vendor HCI frames using HCI_VENDOR_PKT
    (no matching commit)
  - [RFC,v2,3/3] Bluetooth: Add hdev->recv_bt_vendor() to handle BT vendor frames
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


