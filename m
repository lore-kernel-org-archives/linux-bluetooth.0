Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C5E47A56
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 22:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUBiV3NW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A394EC433C9;
	Wed, 29 Nov 2023 22:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701297625;
	bh=nsrnDNdh2wp/aULsATclzMbHDH3CWZ4maGPkbShzoPE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BUBiV3NWkFeMTTmMuY1Fxz6pPQ4dHKdRJm0FYVIcsP9Mt0GSYvfXQUxIfaguhtopM
	 KpEP/9Q4mJYhvvwzSzOod1Jpr5SrbSRG5JyVP1aB+IcHOQRNFMhxlSlUqwO/dtgN6E
	 d/i2uqQ4Ol87xALFZDnU2AIRYTAzy/ynv84UTEfONfv3FeoZfCFOtx2teoo0W0MA/6
	 H1TVpapsTy8qoNlE6qpbDOsbyWi6bvHpg+SwY2pJTO8toVhB636O0QKIdLF+2ofF0n
	 GpCMxRUgwv0pKcG1zvtvsuacS1+9N41Lok7EUKYc/RV0uK5ByRiZ0JGx6e8/F/iLbY
	 MMKWIixMyLrbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 83DFFDFAA86;
	Wed, 29 Nov 2023 22:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] test-micp: Fix endianess error
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170129762553.11308.10417535236170396199.git-patchwork-notify@kernel.org>
Date: Wed, 29 Nov 2023 22:40:25 +0000
References: <20231129163041.2075184-1-luiz.dentz@gmail.com>
In-Reply-To: <20231129163041.2075184-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 29 Nov 2023 11:30:39 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> On big endian the followin error can be observed:
> 
> MICP/CL/CGGIT/SER/BV-01-C - init
> MICP/CL/CGGIT/SER/BV-01-C - setup
> MICP/CL/CGGIT/SER/BV-01-C - setup complete
> MICP/CL/CGGIT/SER/BV-01-C - run
> micp_write_value handle: 3
> **
> ERROR:src/shared/tester.c:954:test_io_recv: assertion failed:
> (memcmp(buf, iov->iov_base, len) == 0)
> Bail out! ERROR:src/shared/tester.c:954:test_io_recv: assertion failed:
> (memcmp(buf, iov->iov_base, len) == 0)
> Aborted
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] test-micp: Fix endianess error
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3a2d3b31a3b5
  - [BlueZ,v1,2/2] shared/vcp: Fix endianess errors
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4db4d5fa1c4f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


