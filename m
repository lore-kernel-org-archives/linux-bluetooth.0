Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3113C58497D;
	Tue,  8 Sep 2026 16:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885098; cv=none; b=H2ke9OSncJkm0IP8V+nMWzq104O1eQ2j0SHvx/whwrdua5FqiDY4WdWE/fKky4LTR7TuC5K4mRQ1NBgD1YMEbAcXTclRYdCT0aIB4WQKejz7i32YhsmNaVBuIiNEKY6Dyq4gmIOLTv3p/D9Jj1oZ97a7NzTxl/VW6IiiqCaAb2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885098; c=relaxed/simple;
	bh=aUGBD0MFgox/fEcbJdkdLK8DEYNpt9YGD7DIxDrmJTQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eqzlkTmtoYTBbSXxaLlvKyUcJ67dTzIYgqWc+e80Ah//7HeHR7clcw9c/4J9ALRUt3i30tJOjEJbmY1OWY7JFd2O5Bwj2JQjZl9LMGBgWWhboDkJM+XYeKD5xT4MHcIMK0/Yxi7f4fO9CRy4vxuz9Pr/soXzT9Y2vkL+8HYdOgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkdbsDdO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkdbsDdO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCE971F00A3D;
	Tue,  8 Sep 2026 16:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788885095;
	bh=EeidF5GniVxj91Xb2Lm+rH/55O8TE3ngvcJnz9IRqpk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jkdbsDdOLlqjSQdJYZ8fHoUTLBIo9cPjZCHuVZSzvGc4vfeyXbOj/2wcwIr8JDCK1
	 ybHFSalG4oeYH32m8Dad3wzt00tMX2BUsPHyb2xryjmiAwmscVHRSTyL4v9Hsu9jYi
	 cXK7W/rPR0HacGfKKUWZvqJ5eSXhDCt3DVuYMM7flWh7l06y7ODmjJfDfeR/UpQnN8
	 d9p+xLgC5pXb4CVR7b7BfENOkdWYj/nfzKYIQwH+Ey65uYLFJVV80A1ESTNc/m6noV
	 f1CXHjQ2w1He781f/LLMv4/txXakdhxM3At/s9K5qNTunphtCwRVw7i7tcH+EUuY3y
	 1Bm7PYY84IxNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939F239EAF6D;
	Tue,  8 Sep 2026 16:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btusb: Add device ID for MediaTek MT7925
 (13d3:3631)
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178888503412.3627954.4047194716743316404.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 16:30:34 +0000
References: <20260905195746.244134-1-samuel.alhovuori@pm.me>
In-Reply-To: <20260905195746.244134-1-samuel.alhovuori@pm.me>
To: Samuel Alhovuori <samuel.alhovuori@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, pmenzel@molgen.mpg.de,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 samuel.alhovuori@pm.me

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  5 Sep 2026 22:57:46 +0300 you wrote:
> Add the USB ID 13d3:3631 for the MediaTek MT7925 Bluetooth module
> found on AzureWave / Mercusys MA37BE PCIe Wi-Fi 7 cards.
> 
> T:  Bus=01 Lev=02 Prnt=04 Port=03 Cnt=03 Dev#=  7 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=13d3 ProdID=3631 Rev= 1.00
> S:  Manufacturer=MediaTek Inc.
> S:  Product=Wireless_Device
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btusb: Add device ID for MediaTek MT7925 (13d3:3631)
    https://git.kernel.org/bluetooth/bluetooth-next/c/9c7071e63e87

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


