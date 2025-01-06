Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8361D1DF743;
	Mon,  6 Jan 2025 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736187016; cv=none; b=iGIFcOROyxNyO3G2meJ+zlQkwG1am+7CAjoi/N+pArfhDGAR+nYnyIRfGraqZcZ6hXSGd4dylt1wN0V+Yh/bb0OScdtG+KNoguXQk+/wZro+H1ocMSwF4X9itvcAY61ZuRLB8YJXVhmR1WRO1fAtqGTbL6+DHy7XVBQV4tEzaPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736187016; c=relaxed/simple;
	bh=5PlDcKtqVBuOJWOxTdj/X9bXaXtbcLWHt8gsMs9B5vg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gYOoMDv0lfnTScUzZKVlIAFdzg6hiZn3s4LJyS7uFjRVdXFVpNJhd5oVXaN2ehmysD9gUS4WigGzfa80QctpM1Slx73ynhtn4ecZrvmZxDSXzbWqRerNQM17tnZNM+RZ8ONU+e8OHSr3oLUYhztQ+XHMzXBNsAF6gUB2EnH+ckw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9gz0ceq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9gz0ceq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE6FC4CED6;
	Mon,  6 Jan 2025 18:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736187016;
	bh=5PlDcKtqVBuOJWOxTdj/X9bXaXtbcLWHt8gsMs9B5vg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s9gz0ceqd1GRk25vAFoYBmUb+V6wvbE161w4PgtxZ7wHVCLnT+tbvu8ayBC1I4p3r
	 5JloS14h1Ijt4+F2BY9C72aem6o6gvCGZUyC8ifgRKdA943L/aCiNXnN1RzrZGpBdQ
	 KNkvMJnJpAAztSb77l84L6TT7DcRSi6mRRSuplxXfzhhgr9t+lu0vUqPDbMONYerAb
	 4jW5xTowibHfSUEzl9YOV40ymri9aE60A8RgiSpSXMq3BrGgi9v6xig9VHaJN2Qntw
	 c/TbDz/QVaAHfICqfk1SkDUxuX9SQ9dG1J50euQ1gWN+kAyarAWqzlpg5fwJw3u68d
	 e/IZlAZv7HQ2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DB6380A97E;
	Mon,  6 Jan 2025 18:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btusb: add sysfs attribute to control USB alt
 setting
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173618703723.3577621.15231390426011092583.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jan 2025 18:10:37 +0000
References: <20241213120420.v2.1.Ifc708cc471a8834b344c26fce1ce2fe3e5992cad@changeid>
In-Reply-To: <20241213120420.v2.1.Ifc708cc471a8834b344c26fce1ce2fe3e5992cad@changeid>
To: Ying Hsu <yinghsu@chromium.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 chromeos-bluetooth-upstreaming@chromium.org, marcel@holtmann.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 13 Dec 2024 12:04:22 +0800 you wrote:
> When a Bluetooth raw socket is open, the HCI event related to SCO
> connection changes are not dispatched to the hci_event module, and
> the underlying Bluetooth controller's USB Interface 1 will not be
> updated accordingly.
> 
> This patch adds `isoc_alt` sysfs attribute, allowing user space
> to update the alternate setting of the USB interface alternate
> setting as needed.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btusb: add sysfs attribute to control USB alt setting
    https://git.kernel.org/bluetooth/bluetooth-next/c/e85c08c0aada

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


