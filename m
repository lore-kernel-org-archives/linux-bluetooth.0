Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A1552F9A
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Dec 2023 18:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FxhimRtZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC635C43395;
	Mon, 11 Dec 2023 18:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702320024;
	bh=aj+iqJma6IPywb/8+/mPziaKNjYqdQWNWJF1ll7t/28=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FxhimRtZKaGtsyw5ngCLckWkHtN/wLXnL+6I+3r879xBfQ8sLQ0CmIDqTkEfCTkhI
	 e+a/uprU32vs68/tHIfDcU3uy+ryWa8dHxg+evWAkpQ+w60qB1ieByTlBGWy4/xb8C
	 r6H2mHbzJTDegTH6M4lQI8cVCsUkvigrpR8x0Uppxn1gsTWJgtGxQy2N2iZojZGMrZ
	 6pq3kPeKXJES1YsVc5fe/6VjX9RQnjR8uV8hOwM80Sz1YJ8jt50Og1Fbn1ETSocnex
	 4pqZxfUgI/I54/5Zx/Pnjxsqb2KvDq8ccuag3lybQtKzlHzjj5XZ1ElXgpPJ0liOW/
	 ieIZ9q4lQZS6A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C672EDD4F10;
	Mon, 11 Dec 2023 18:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/vcp: Fix notification endianness
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170232002480.25763.12600598782695945445.git-patchwork-notify@kernel.org>
Date: Mon, 11 Dec 2023 18:40:24 +0000
References: <20231211171135.437354-1-luiz.dentz@gmail.com>
In-Reply-To: <20231211171135.437354-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 11 Dec 2023 12:11:35 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> 4db4d5fa1c4f ("shared/vcp: Fix endianness errors") does attempt to fix
> the endianness of stored volume offset but in the process it broke the
> notification since the value is no longer stored in the Bluetooth byte
> order (Little Endian) but instead in the cpu byte order which is then
> used in the notification as is, to fix this instead of notifying using
> the stored value it now uses a dedicated variable which does use the
> value from the request itself.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] shared/vcp: Fix notification endianness
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=95838efc07d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


