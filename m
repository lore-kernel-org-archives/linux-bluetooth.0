Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78FD46D08C;
	Tue, 21 Jul 2026 19:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784662861; cv=none; b=FRNXYhqaKKvEgilDPstUQkWCNSaefr5AUohITbLsVlbXyioV4HcjNNKQ5q9icewzFrTUVV+9TXVVeuwosqL1+ZQPFElRCyf2LRY7AiX0X3CB8fBEgdWXdAlT3AFoWKFe2z3PhFImHmZqSS3WO9fNUOGaCiJsYYDx9uB0wlYuBkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784662861; c=relaxed/simple;
	bh=gjP4bnG2YQZQPKZTTo5Hz7xFkIjeFaphZEzB7hy1Iw4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uVNPFYdg8j0ZlyrP9FzonPzKE92HuItc9B5/eYe619GVnrT7hTgN/xj798X53WRU3mx2LFlGSzdS6E5zsyhgvuz5UVoW2TlUa2tWpQ0ssV09nA9Mt4fDQ8Ad4f6UEEwdCzxS5XJlQfEyIHfoVo1DoLkZoOMRLgDYqM03StVhtUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VuKRS/XQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VuKRS/XQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD3E1F00A3A;
	Tue, 21 Jul 2026 19:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784662860;
	bh=Uy4cyYANPIzUSwH1pt5fbNqzYiqyj9XdQXJqHeoKuDU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VuKRS/XQKWvCSWURKFRfjSEJq6dzyAIMeC2fMt+F8dCybOYfxWNz3VbJRUZaXqymB
	 kNcoqNowwsb0yYhUAFHXhVfq7vKd3vhRAjbhwRr+O/SlSTi3dY7oilAEL2OQE0zCqS
	 M2HYSdxJvhdgYn+eELOO8h7aa/C0ltBQEvs1OgB6wdey9xUDRFD9/rJJLF4hXBjkt5
	 87vMTW3u3kPUe1sdTBL0tJ/BoNOW9WX8zFl9sDFD7sEY0hgxJ2LhmptfR5tcznc0j5
	 Nil+8JryHH1X2uPZRj3BnX1NdZ0axvrZ1U24BuUeqXb926JtHiKiGlcBvVD47n9k4P
	 TBSy/G5GXHBTw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A6E39253FD;
	Tue, 21 Jul 2026 19:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] Bluetooth: Replace HCI_VENDOR_PKT usages with
 HCI_EV_VENDOR
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178466282990.1001510.1612644464371121953.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 19:40:29 +0000
References: <20260721-fix_vendor-v2-0-1977a8c39708@oss.qualcomm.com>
In-Reply-To: <20260721-fix_vendor-v2-0-1977a8c39708@oss.qualcomm.com>
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: brgl@kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com,
 zijun_hu@icloud.com, linux-arm-msm@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 bartosz.golaszewski@oss.qualcomm.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 21 Jul 2026 03:14:39 -0700 you wrote:
> The macros below have different meanings even though they share the
> same value 0xff:
> 
>  HCI_VENDOR_PKT: HCI packet indicator or type
>  HCI_EV_VENDOR:  event code of a VSE
> 
> several usage of HCI_VENDOR_PKT is wrongly checking an event code.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] Bluetooth: hci_qca: Replace HCI_VENDOR_PKT usage with HCI_EV_VENDOR
    https://git.kernel.org/bluetooth/bluetooth-next/c/235a0cffba9b
  - [v2,2/3] Bluetooth: btusb: QCA: Replace HCI_VENDOR_PKT usages with HCI_EV_VENDOR
    https://git.kernel.org/bluetooth/bluetooth-next/c/90ae39404c94
  - [v2,3/3] Bluetooth: btusb: Realtek: Replace HCI_VENDOR_PKT usage with HCI_EV_VENDOR
    https://git.kernel.org/bluetooth/bluetooth-next/c/6f55ad8fb0ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


