Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBAD3E9C0D;
	Wed,  7 Oct 2026 17:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394211; cv=none; b=eO7T08fYzJCDl6p/mmvGVITBEtPQfU0wVkr4cI61ZNAnm3Rl2hwaY0uo/THA3l5f83j6NJIidpwosmK2qLTYCzJ+nznUnF4QhdwD3Vg5ChdX/A+eihAsTl/jPkQTsnTfF9xDqYdr1nRq0VIIbE2KHTpUTM+/IiBWfc1twVs4+Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394211; c=relaxed/simple;
	bh=HGvvoLJP10gnNnOOSDxghRi1TMp0exg4SbmrbKrQLHw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h47byal3MnviB8dnWLyD0tg5pmcML5yY7tzUY5y/HKqyxWkg6SegmE+owN8CIx8umnZ8y+0kdCkWQme2AS45DjiRDK6fEsuWF0JPn+kcsPg1Ca706urvLcXZQxsEWyt3YPr5Ft+WB+Eb1qV6sOKl7QKvTHyh1RvWrdV0xIRIZHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rz9Wj1LS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rz9Wj1LS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 459BB1F00893;
	Wed,  7 Oct 2026 17:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791394209;
	bh=H4U181XWY95js4QOgkmsJvJ2CGlpF7bU7HPOqz3meVc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Rz9Wj1LSgZxN1V1MakSZVpiLdoOfhEfqdiSLu6jaZygtNr/0g7XKrPjMy5Lf45sJ4
	 NOKshmDnyEyUcTc7QEmV8n4cGx4tkZ5TN1Mh0/NZJgXdF3zVnELgGTZ2w071owKBpE
	 RwDl+3xXBEfkJcdtOya9FwE0JgGzHnwe71e0WKA/MVe7nOS0IxFEZG6+rKbeNd/bww
	 u0r4zzeP1VuztYht0MBRRit88R6p1tNFMIoDstNM9wv+qXaVZSIig5lKQ5z7o3XsCE
	 QAGkGazSdI/i5smPDWbOTRh8GETwg2nzUcr9ZOvhbWi/0+gaQQVS0B94uNR009S5E0
	 fDtuUdYpKSyzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3063808209;
	Wed,  7 Oct 2026 17:30:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: MGMT: Reject quality report requests during
 unregister
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179139420777.3628206.6252425087306372679.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 17:30:07 +0000
References: 
 <pm-bluetooth-objects-candidate-0186-v1-e03b4f1d5ba49b962cec@gmail.com>
In-Reply-To: 
 <pm-bluetooth-objects-candidate-0186-v1-e03b4f1d5ba49b962cec@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, jjzuming@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  6 Oct 2026 15:24:31 +0800 you wrote:
> A quality report request must not call a driver callback after its
> module text has been released. hci_mgmt_cmd() holds an hci_dev reference
> through set_exp_feature(), but that reference only preserves the device
> allocation. set_quality_report_func() takes req_lock and invokes
> hdev->set_quality_report without checking HCI_UNREGISTER.
> 
> This is unsafe when a SET_EXP_FEATURE request for an Intel controller
> would change HCI_QUALITY_REPORT and is delayed before taking req_lock
> while the controller is removed. With btintel_pcie and btintel built as
> modules and no other btintel dependents, the following order is
> possible:
> 
> [...]

Here is the summary with links:
  - Bluetooth: MGMT: Reject quality report requests during unregister
    https://git.kernel.org/bluetooth/bluetooth-next/c/ba9fb67965c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


