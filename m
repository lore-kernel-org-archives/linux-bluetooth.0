Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518661BC2A;
	Thu, 12 Jun 2025 13:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749735599; cv=none; b=frrv6bmwPSgqPbOwuJEoGJroBByJvUXryJCml+B+6lZHTJgndzEKesluLfOF88uhNXoV5XqgRaJncUrJlGDdyMQRz8tokBKUIJxNoVOIxkmRZfK5q4M1K9FQ9YxYDLJCDSjJE5hJovHGTQp6Rcm3iqsdIL1b3/yIWMoOMmRe1p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749735599; c=relaxed/simple;
	bh=PO6VS+Ipf/QNoHDKTP4/NOCSKfLw8CarcdYSUJogoYg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hU9foso79W61vplqacjnkTuZZ0oeasxwFF7JeUATIUw17VIk2V2fuZkHdLhyqapklvQ64MSKn6WkXHTVWU2hFSY3gAaIYJPp/yv1Twi2qvVHB2NY4GlngZHG22/ZSIh+jiAwhjpE//HMu1puLUo19bICdKmRfiloZ0CTs4835wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQx5mUj9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQx5mUj9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B23C4CEEA;
	Thu, 12 Jun 2025 13:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749735598;
	bh=PO6VS+Ipf/QNoHDKTP4/NOCSKfLw8CarcdYSUJogoYg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cQx5mUj9Q3oOsrcAblXewv+xLgn3PT5liMvAeKokpGN5WtW7EAicWI20EqUcQ7KaU
	 dTsldtN8eZq3MNu2Z4S0I/3c7a/p6XsOohwxsTYKgfXrifVKRdgvXqT65wVYyj+Ofw
	 07I16RZEzm7daYSKl+7UOSIgyr+STOKu88sTrkiJVK2cOv9MukD6esvbR7qNTZdeRj
	 q4ODrzueEADIYs+NVpDXtn8BJ/F1QZAkg6SetSL8moodrwU8BDJ5p+X7jNqKAa329U
	 42G+45g7cfYgnDKLZ/rTa9GLRuA3YX3GYSl7N9oDhmSYe9P3tIgtZYu1IMnvdeLjpt
	 IJVIgoGcS0Zrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE6039EFFCF;
	Thu, 12 Jun 2025 13:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add a new VID/PID 2c7c/7009 for MT7925
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174973562875.4138205.13746264820757572587.git-patchwork-notify@kernel.org>
Date: Thu, 12 Jun 2025 13:40:28 +0000
References: <20250606-btusb-mt7925-add-v1-1-9b64bfa86ea4@hexchain.org>
In-Reply-To: <20250606-btusb-mt7925-add-v1-1-9b64bfa86ea4@hexchain.org>
To: Haochen Tong <i@hexchain.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 06 Jun 2025 23:33:03 +0800 you wrote:
> From: Haochen Tong <i@hexchain.org>
> 
> Adds a new entry with VID 2c7c and PID 7009 for MediaTek MT7925
> Bluetooth chip.
> 
> The device information from /sys/kernel/debug/usb/devices is provided
> below.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add a new VID/PID 2c7c/7009 for MT7925
    https://git.kernel.org/bluetooth/bluetooth-next/c/892768493447

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


