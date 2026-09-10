Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421E84A68B1
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 15:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789054271; cv=none; b=Vo+KSf7UJ3WgrmJbbLNJTQ9qNHDGE0mKAdTch3fyZd3k20L/GTPlzs3VxfsmpmeY6CaOfBEubMHnIgL2FcYwu3mPpRIvth34zO2tM+xBXIn4cDZoP/EITDvjTad5Nn6eRJpb9Uao0XuhMWL20ePXh7oHWaGGwFKaxjtm9MLN4s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789054271; c=relaxed/simple;
	bh=pB98tslEN+0ij+Lg41uXi21ZWQHv4gGWpT4UHkzBE90=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NiBXEdsK31MPuVZ33SwsCSHMTc9ZDsnQZheHtrsx9YDHzRxzscAA2iETBmzbzee/HMfl8xyN9itwrm2gcLF/0Y7TJtNfavz9b8dl8a2+PibUsM2Px1Jtwqg9Oi7O3ygk5+OGdZ2tx+ktL7YC0kKAvU8H5TGTsSmzXxi0iFRCAYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZfqxZ9f; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZfqxZ9f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B071F000FF;
	Thu, 10 Sep 2026 15:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789054270;
	bh=1LI3UwxRScxjyEGMjPwmiWd+z/yYXpqbVmbIyHFIrUk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oZfqxZ9fh0x4kc4EuL8RkRfECly7CMRygEpTk9afUC1R9L5+x3/n9rd38445VtIpE
	 4jhszdRVtf1Vy2J15S3t35CHXSwDKhmy7iUVWNUgp0aZ60dBFJoX37PcmJfMNnF5/k
	 ryyNKd/xSsxXL7Sb8OyvMfxQyP82e+pehA9mmrqoQCzF+AXo+/Kp1Kdv/WBamtq9FW
	 0qAprfiYH5vARVv+1WAsQcI5RS/CoTs1Po3hKanua/f3qvD994HDK+mVgMHHvDD4Il
	 VRAsZZinx4JICW6EWeT3D4Zr1rVG8m8rXTMmDD/E1KIV9RiHZt0jrleJgs+2Rhx5qO
	 ELHypEadS7meg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09BD380CEF9;
	Thu, 10 Sep 2026 15:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] monitor: Check valid range of CE Length
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178905420738.1498636.178528734451251713.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 15:30:07 +0000
References: <20260902150951.1583184-1-luiz.dentz@gmail.com>
In-Reply-To: <20260902150951.1583184-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  2 Sep 2026 11:09:50 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The connection event length recommended in requests by a Peripheral has
> a valid range of 0x0001 to 0x7CFF (Time = N * 125 us, Time Range:
> 0.125 ms to 3.999875 s), so print values outside of it as reserved
> instead of decoding them as a time.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] monitor: Check valid range of CE Length
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b93baad72d27
  - [BlueZ,v1,2/2] emulator/btdev: Check valid range of CE Length
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9d35770cb647

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


