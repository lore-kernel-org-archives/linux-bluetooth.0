Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FBB13A245
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jun 2024 15:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500465; cv=none; b=nd0XTjlzY7GFF343qAVN9hoX2LZyOfRMBs8WpAMME1eSdem3Vu9rVcjipJC5ztrzQZui2YZY7S/a7xemGCESXs5yoZTns6CWcKwkeMa8rFGlgiiE9NnHPdDba8f4NH2MFRTtK6TMkek+I4WI/SubipQP0246evOOauCekMsPOxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500465; c=relaxed/simple;
	bh=3CNgI0bgIOge8e2f/YyT2+HAcngQHwCXOA6VvLDxDzE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KAO0yh6Jq6H2QSz7NRge4/RuBI6KADPBuqsD/RNje4e4rExsWLHzIg4JqAQGqy8gbWzdHYPJMbHAwmqDuC+AOACY6R3nSP+uJSajA/K1mQbJUYrlLwVB8NV20GwhfsRXnEHCr4cERAdGqR4+OgkotVu7kv8xVfPS2Rr0PWVmnFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIBFNCP5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIBFNCP5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0F6E2C4AF0C;
	Thu, 27 Jun 2024 15:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719500465;
	bh=3CNgI0bgIOge8e2f/YyT2+HAcngQHwCXOA6VvLDxDzE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SIBFNCP5CtMtQdaInPqKxzH2qLLF8q3/9mkkyYZ7trg7z/un9oQzQYW54MrC1n99k
	 syS0VqoWYuQUsMz/buy4nFIabWs9Osb7PqMdnXStb5U1eKxqOQG0eEaZC9mI5puLA+
	 FDoY7DWhrso/us3/zcTUIaKdBtx6Bc0PJbMkgg95wAZIr6OD5nlBx/+4irHjUQZl8y
	 e3nb9vz0bN4B6TQgN7OERf5TOUgRKywc9XJif/kwhXu/NJhcHpRpH7BOP+wYf/Bpi2
	 3zv2XEX8nFKivVzDzDznA4NgZg1B8xpgxHXTk9u80K6V/dxd61UWrBkPcmkErBGzur
	 MGcrwf51C1PMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 052EEC43443;
	Thu, 27 Jun 2024 15:01:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btintel: Fix the sfi name for BlazarU
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171950046501.29698.11686044297550018903.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 15:01:05 +0000
References: <20240627130639.2744811-1-kiran.k@intel.com>
In-Reply-To: <20240627130639.2744811-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com, Tsigan@ci.codeaurora.org,
	vladislav.tsigan@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 27 Jun 2024 18:36:39 +0530 you wrote:
> Use INTEL_HW_VARIANT() instead of CNVi Id to decide to load Intermediate
> Loader (IML) image. Fix the driver loading incorrect firmware for
> BlazarU product.
> 
> dmesg:
> .....
> [146.111834] Bluetooth: hci0: Minimum firmware build 1 week 10 2014
> [146.111839] Bluetooth: hci0: Bootloader timestamp 2022.18 buildtype 1 build 16362
> [146.111848] Bluetooth: hci0: No support for _PRR ACPI method
> [146.112204] Bluetooth: hci0: Failed to load Intel firmware file intel/ibt-0291-0291-iml.sfi (-2)
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btintel: Fix the sfi name for BlazarU
    https://git.kernel.org/bluetooth/bluetooth-next/c/c341bd6acce9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


