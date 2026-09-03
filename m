Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFF250C29A
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Sep 2026 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788465689; cv=none; b=lVl/fJUCaSi6N8OYjQT8Mb5F7CcHeX37WZsF9+sYXQCrkRZ6kLkVmNaKxpj8VNSavJYecxujNBwzFsLBQk0TjHrK3q+9ceIX6MHHgxDaQsH6OVSiq8iOiEehEBRFkdah7tqJ52BbP+eiMEba9DMIWzcOxja0Kl3UteYuOb37ESk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788465689; c=relaxed/simple;
	bh=4/0HotX/iqVspGOz3riN0bEMXYwXdvSPeTgDl9H7QEw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iIFuswAunMy5fC+BQLy7/x/ANT2W89cxpiukrzt9VylVDUbbwGt0DJkIN9UF/SH5E3lHXXYLM365fw47pABywZRutt8v94fMzUAmFzXBTxtqQq9NlX6ALW5K3oLuxZLinLZfC9ledWAcxZ3FNJmo9OdmAYPePvLbccvFI2a1IXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHYinE0R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHYinE0R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CAD71F00ACA;
	Thu,  3 Sep 2026 20:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788465674;
	bh=hWL37N5fY/AlUUY7j/ddgz3hi/swagglgdGxperbNsE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WHYinE0RiEgaXmqAFeE8kArdCbdVRiffARM0t8e6+ainiL2eCDFvzG9FaKy4sv8hD
	 P6bD0cat0j5p5rII4jYKxeDfSGvQVU1NtlUeLqSfr+AddCcrMxPUcvh/tKYWLZwpUX
	 Ut0WM96hiC6mX+AE7996fx/VMa1wm1HHtBR0K1dR5mwHBcEUBXMYMVKjvNIGgLzY0C
	 fbLZzs9dWVyU3lqD0P1bNsDqcVgBxi287vYr65p2JTyFCANKdFcWsEv3uoZvgAleo8
	 FgNMjcLckHIiop7dLPLz04iSwg0szMytQ94o16t3vBjF1BmMZYsBObIpJVV5/ML3VU
	 1wT88hgjT19EA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1970E38119DE;
	Thu,  3 Sep 2026 20:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/2] Bluetooth: Move H:4 reassembly into the Bluetooth
 core
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178846561564.3994681.10545850539691056483.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 20:00:15 +0000
References: <20260831164112.778064-2-luiz.dentz@gmail.com>
In-Reply-To: <20260831164112.778064-2-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 31 Aug 2026 12:41:10 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> h4_recv_buf() is currently implemented in hci_h4.c which is only built as
> part of the hci_uart module, and only when CONFIG_BT_HCIUART_H4 is
> enabled. That makes the H:4 reassembly logic unusable by drivers which do
> not depend on hci_uart, e.g. btusb which needs it to implement Bulk
> Serialization Mode.
> 
> [...]

Here is the summary with links:
  - [v3,1/2] Bluetooth: Move H:4 reassembly into the Bluetooth core
    https://git.kernel.org/bluetooth/bluetooth-next/c/37521ec2f55f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


