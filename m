Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD5C4BC033
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 17:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781200698; cv=none; b=I61EZU2ocJ7xq5L1gOo4Uho+be2386gPbvJf2vcGq9BbIVGGxHljPkhL73U1XKrMUwRZBaqEHpdu8gvwcLv9sCD4P9rBEJiNDRKIsLVAGFWfazadQz7dY73H2nm7qHHkRqgPIr+CIyvjBvLJQ6rLwwdfcaxIJ/T0c1E9ZzmjEac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781200698; c=relaxed/simple;
	bh=d+saMQVKK+C8TsL3rXGIYyn3sZCusX3uyJX5obSA2lI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mBRcI8KkcWI2idwqjW5q1jKqCeUegLRqk+dWJSFkkpna91yNI4E253WVaPRnNCUPOr3hS83ezy8X/ciJHSfprpPtn86dPP86vARTCyhZnye8XlJlLrEoJ6CHUVWbwOzG+1Z6wLv16ZsS82zNUfpuOPUtxtGcwDM6Pf6GSNbUIB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UenW3Ekr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UenW3Ekr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF811F00893;
	Thu, 11 Jun 2026 17:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781200697;
	bh=5tSAgxntTbuakR5pGlfhIxXhPDikd4OvRkO5nEGeVDA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UenW3Ekr+PELciOlDeRF4FElBbJfnnIRThFLRMugOVW6q+yg1Z+1LB5trz94ZEuUK
	 ERmJMZaktRkHVzsNBwl43Pa+hKR7D9W7CiQ/FL1l2dK0QeMrNu1eex9X7wh/t0RqF1
	 /5a5yzT/rxBC6jaKmaVoV1AgDvVDy38eR5ZUC5mLfFK+9xu0HbFj2iEtnqLA2g4DiN
	 heNv7bjfatyFsZC0JY3KXbF7l0oORHe8Torwgcake+wWuMv+y5Cqn3iZND6Y+6glnB
	 EWCZIv4sbKyor3RGOG6WvKW25tVwp0K28dv62D+/GJcmAQFzvlYX0AGL+gwgAhPB6m
	 ajiVgMQgifboA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197763930F87;
	Thu, 11 Jun 2026 17:58:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: Separate coredump work from
 RX
 work
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178120069463.286318.3578477179823735983.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 17:58:14 +0000
References: <20260610162544.240444-1-kiran.k@intel.com>
In-Reply-To: <20260610162544.240444-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 ravindra@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 10 Jun 2026 21:55:44 +0530 you wrote:
> From: Ravindra <ravindra@intel.com>
> 
> Sharing a single workqueue between coredump processing and RX
> delays evacuation of RX events while a coredump is in progress.
> The firmware's RX buffers can overflow during that window, leading
> to dropped events. The issue was observed in HID use cases where
> HID reports arrive in bursts and quickly fill the RX path while a
> coredump is being collected.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btintel_pcie: Separate coredump work from RX work
    https://git.kernel.org/bluetooth/bluetooth-next/c/27e1ec48aeb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


