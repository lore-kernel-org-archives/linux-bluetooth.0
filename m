Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4031717BEC1
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726583429; cv=none; b=sUEK6XP1MqcogVfQb02cWByLKQPa22Dt44tZKV0mqaWcBS/XSFEac2zCocRHQpYDsg/fYx0dJ05HuimZybXRoj3/9XJ3VEQRMsX2VxnLXqQEZLohbcYPrNn/HdMDYpziN42nTpAs+hpyUOcxuwA+HveNoMPxqUc7Cv6+KGoqhUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726583429; c=relaxed/simple;
	bh=i1LqT3mF9CuKaFo3gX27GcUkcJl5ta2Dt6Ed3o2n15U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j44soQfAyTOsimwPT4rGoPQGwbD+0usf3MMj0/eMy6/FPExw0UqRVRO4IVTFP03kVxR11GqlguDozaxbznuBxhL+jsEWZDD393RvCgl+QHrDNBc+PxoweS70f0OW3009QEm3ZB9rUR7vzRZRlBq7fbiMHqYQS/moYTy2zohvL2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3PQ4/EW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3PQ4/EW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAA4C4CEC5;
	Tue, 17 Sep 2024 14:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726583428;
	bh=i1LqT3mF9CuKaFo3gX27GcUkcJl5ta2Dt6Ed3o2n15U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n3PQ4/EW4ZkJFiuUEmpJTMtyj0DVDsgupTvUzSEZ8gNJPVGWAErABJ+HleMjTj9MJ
	 NL2Zm9v+P7Y1RfttH9Yn9mZFnWWcOEeslCPKvhJHNkNNgW8Fe8rySwLn9T6FtqcBVm
	 8e0j5CbJbzndP+9PnbE5GLl0Vv5bgDyEvtdscACNOBo7cYB8GrvCfVBg/OnPEXSgsp
	 rQ5rfdNQa1xqdG1aVTPZ+tbJGbo/KebX4SKzF+3FB5FSPZoF5ySWsPf2aAIM2WiGUt
	 iL80ATeBhkY10H3UtMFk6xHJjg63DABUUnoYfx0kBrQQsTItXnzuEkWMvXErf3belX
	 bgzxKZAFg1gXg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 711003809A80;
	Tue, 17 Sep 2024 14:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ 0/3] Fix bluetoothctl hanging if daemon isn't running
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172658343027.158268.11140300702959343294.git-patchwork-notify@kernel.org>
Date: Tue, 17 Sep 2024 14:30:30 +0000
References: <20240912092253.119754-1-hadess@hadess.net>
In-Reply-To: <20240912092253.119754-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 12 Sep 2024 11:20:09 +0200 you wrote:
> Our QE folks have run into this problem multiple times. The problem seems
> to have existed since at least 5.56.
> 
> Bastien Nocera (3):
>   shared/shell: Add bt_shell_get_timeout()
>   client: Respect --timeout when bluetoothd isn't running
>   shared/shell: Exit after printing the help
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] shared/shell: Add bt_shell_get_timeout()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1428d8461e92
  - [BlueZ,2/3] client: Respect --timeout when bluetoothd isn't running
    (no matching commit)
  - [BlueZ,3/3] shared/shell: Exit after printing the help
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


