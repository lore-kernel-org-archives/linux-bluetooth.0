Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB233B8406
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065680; cv=none; b=UZ3VTmeGNAxi6QggY8RIGJsdAMDkUj3l+dVUUekAVz5N0KGzz7OK/xHDfoukY9wfIiyeBCOf7ocd7HxgKlYf/4OSs2R53tqPDcdymsjDUBLyHrBXOBGmPd+d8pmQpQoUTc0uEaz+fgIsvH2QXtageWmRR1VJAjpKlYzI/hINpVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065680; c=relaxed/simple;
	bh=H4VL6ZZrfh4xq3yU57AlLePamNzZNW1at89Bmzq6Fok=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DLYyTv4pDayJ1PHGfL7cSmZm8ZpZ0MMF9DiLXKJGIcLISj188ALjc97mFyJ6pgryo7B6v+/P7Gco8DW+QhFSoH2beomVQkvSmrJarKsaugcrLVPL3qBhQV223Slg5dY+aDXWqypGzI7BxRgrIHliU0b30l0L23jZPoXCXp7FF/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TCdQcej3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TCdQcej3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7697D1F00899;
	Thu, 10 Sep 2026 18:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789065673;
	bh=8xJ2gc2hfRZ7FfV0HKBVUowYOLgDFM6eiejOPrNFM5k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TCdQcej3GbZvScUWOfW/A5guGZlsgCeGbWr2EyYghH8T+46+BihERQR9GHWmiEY8o
	 atNVn5Vhtfjvkgp0vuaE9HSsrkjsKGH9MQRNPb7ycApo833D2zh55nV2BTp/eXJr/+
	 DHyUJkIUbhiCSm8WP1XWhT0Ig50xthn0aQTxKacbsFBrFPrXde7mfkpJ86IOJ3PZY6
	 IbDvLFoVXyDAuropWKhD368d3SzkGYCbf/EofmyQPSsjSYbhLdXzMiUbYnBy/tcQkv
	 1QkI19WKIH8/z8YROxLiY3I0GbHbnYgoSUVgQZDjRrZof0FHLow9rUSV//rivwd2FH
	 jDwM27HqjgdYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A0C380CEC6;
	Thu, 10 Sep 2026 18:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ] bluetooth.service: Fix ConfigurationDirectory warning
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178906561062.2027917.11205750738338201649.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 18:40:10 +0000
References: <20260820094503.1779779-1-hadess@hadess.net>
In-Reply-To: <20260820094503.1779779-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 20 Aug 2026 11:44:46 +0200 you wrote:
> When running "systemctl start bluetooth.service" on some systems, this
> error would appear:
> systemd[8067]: ConfigurationDirectory 'bluetooth' already exists but the mode is different. (File system: 755 ConfigurationDirectoryMode: 555)
> 
> ConfigurationDirectoryMode was mistakenly thought to help sandbox the
> daemon, but the service configuration already sets ProtectSystem=strict
> but "If [ProtectSystem is] set to "strict" the entire file system
> hierarchy is mounted read-only", so bluetoothd can't write to
> /etc/bluetooth anyway.
> 
> [...]

Here is the summary with links:
  - [BlueZ] bluetooth.service: Fix ConfigurationDirectory warning
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a79a955d4a8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


