Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FB86EB5A
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jan 2024 15:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfdF/4Ob"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D313C43390;
	Fri, 12 Jan 2024 15:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705074027;
	bh=uT2SKceFEZXw102OGEx3qwATlX8+2N/Mvrl9+lQaHKo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DfdF/4ObIVGNB64yNSt85KFT/AIFElEjlb9cwYktJtw6eFxv4KVVH8BjVpVghkdCJ
	 lTt6wa2W/Hze70pC6595hKUwiQemeL9k19gy57Wq5jpkUz1UVd90GQUkzNGWA4h+ck
	 g827Kci10epiBTqPZ3ypfsoCNub66aCTZabCW+pUyhZ7EmzUGIQfi8QDuO9TITU21t
	 zH7iEJ0vJRROWBHzwBxrXsgEV4CIYG/iW/d1HY485WFhsiSVqWcaYQNCj0Fn51YyKT
	 VTzYN8b1sTbxy2Q9984P1QkzJXwgKbL/QBBhUgNPRqEWyXHG3D30sKKlUdH/kF/VPc
	 BXsD8cDQD++EQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 15EACDFC697;
	Fri, 12 Jan 2024 15:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/2] Fix gatt-db munmap_chunk invalid pointer
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170507402708.14704.12096474828165311874.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 15:40:27 +0000
References: <20240111133955.65686-1-frederic.danis@collabora.com>
In-Reply-To: <20240111133955.65686-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@ci.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 11 Jan 2024 14:39:53 +0100 you wrote:
> PTS test GATT/CL/GAD/BV-03-C published a service starting at handle 0xfffd
> and ending at 0xffff.
> This resets the next_handle to 0 in gatt_db_insert_service() instead of
> setting it to 0x10000. Other services are added later.
> This could end-up by a crash in db_hash_update() if not enough space has
> been allocated for hash.iov and some entries are overwritten.
> 
> [...]

Here is the summary with links:
  - [v4,1/2] shared/gatt-db: Fix munmap_chunk invalid pointer
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dacc69373263
  - [v4,2/2] unit/test-gatt: Add unordered setup db test
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


