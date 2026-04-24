Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74692342C9E
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777056647; cv=none; b=PgVuFfUwMIaVNMr1cflnuHlSk6WT60n/ZkZgyj2xIMVk6iILNx22EDskg7bXSie/iKajsk7QD9HxJ/PwGzF0Rk90O2hbhrhY8aaGdUz9DxnNp1qneyO/jZUeZXk5ku170ndI/4s6+GKk29IUGj/+MsJt+lKs4Kdliwc5ot8JVhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777056647; c=relaxed/simple;
	bh=Z/5vi3rFv6s5jmCTtaOkV7X+O+YWYHFtkQxJDVtu4To=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NU0GO9avY1t8dZ7J+ySkHJRZXNp9KTvjHloji1LWqGOz15THwIho1gftQINyslZgZZkNGQZZnCYWVI9YQjw2hEprU3utjTsreHcqo76BXSzvvqIVGeDye5q5W/W1aDwd+GIB93Iy3RyAgqPbhbBy9hurYp0VboTa3oyGeH47xQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiyedKbi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiyedKbi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D921AC19425;
	Fri, 24 Apr 2026 18:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777056646;
	bh=Z/5vi3rFv6s5jmCTtaOkV7X+O+YWYHFtkQxJDVtu4To=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IiyedKbip8H25q+hvW42wVxffR1QdYKSm7ZMjs7Rh0DMTOvj1UIA3VBmiL89d8lMs
	 LSl4tV5li2R9mTeTXX3BasniZFvN1mERjODAIL0DCkK8y1v8NUcfvmr1fBjCtpNXnp
	 PrhNfpWaZ8Fkdv8E0rcHBk456b3SDF2A77eU9nXH2DT45H3sSUTVhoCmW3/XhAmn82
	 Cl0R1JCktHhiHg1W7lY2++T2YOSL0Oa/BWgFteMyL6DtWTf9lMrBSXqLc42rc10Af8
	 cv1lLk8awJFhECXn8vMEVLa6mhs+6fgzoTPE2UABQCmfoYQ/kU9IVkCHSnlYiI9PFX
	 YC6hZeBtbyFZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CCFE38119C3;
	Fri, 24 Apr 2026 18:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek RTL8922AE VID/PID 0bda/d923
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177705660729.1662901.6717656117537860631.git-patchwork-notify@kernel.org>
Date: Fri, 24 Apr 2026 18:50:07 +0000
References: <20260424122522.402953-1-zhangchen200426@163.com>
In-Reply-To: <20260424122522.402953-1-zhangchen200426@163.com>
To: chen zhang <zhangchen200426@163.com>
Cc: luiz.von.dentz@intel.com, chris.lu@mediatek.com, pmenzel@molgen.mpg.de,
 floss@jetm.me, sean.wang@mediatek.com, en-wei.wu@canonical.com,
 Zijun.Hu@oss.qualcomm.com, chharry@chromium.org, ceggers@arri.de,
 johan@kernel.org, linux-bluetooth@vger.kernel.org, zhangchen01@kylinos.cn

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 24 Apr 2026 20:25:22 +0800 you wrote:
> From: Chen Zhang <zhangchen01@kylinos.cn>
> 
> Add the vendor/product ID (0x0bda, 0xd923) to usb_device_id table for
> Realtek RTL8922AE.
> 
> The device info from /sys/kernel/debug/usb/devices as below.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add Realtek RTL8922AE VID/PID 0bda/d923
    https://git.kernel.org/bluetooth/bluetooth-next/c/516a3ab44299

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


