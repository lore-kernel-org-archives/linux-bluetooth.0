Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B5421A07
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Nov 2023 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAOujbis"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4506DC433C9;
	Mon, 13 Nov 2023 19:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699903337;
	bh=3MFlsJd533eyasRSxxb1MFgO7ddZ8PMX2zHsXK4Ygi0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bAOujbis60biHh3OrDfsdHWzcvHSB3MbQTlIQshCmqfPyWdC0NC4fS1MDzafhIj19
	 9UVxfoW081fZlE6EmnnfqmDIwyFnZdidnp1JwIwPCe2wDCcxZ8qDt229nz1DRdZGlM
	 0QvX2qBTW3Mrw0TMXwu8ujIpJzKMSc+ZahzSfV5cbVBD30+xC9BHbY1Q8k8fczXIAC
	 YInIZd1w4I+pxvNB1NLje1R0AOK5VShJPzLXIffGGTZOqzoHygA/H3QmTvbrFCDZ2M
	 aCnv/YvHZjSd2SqhlaUw92ZT7xIuu1Bl3b1T5FY9C592na2lwF7jxiVRvyIZia1x1E
	 eurVHRyBtWKOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2BA80C04DD9;
	Mon, 13 Nov 2023 19:22:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/4] Fix an allocation oversight in SDP parsing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <169990333717.26848.2520772808995215197.git-patchwork-notify@kernel.org>
Date: Mon, 13 Nov 2023 19:22:17 +0000
References: <20231103182150.60088-1-verdre@v0yd.nl>
In-Reply-To: <20231103182150.60088-1-verdre@v0yd.nl>
To: =?utf-8?q?Jonas_Dre=C3=9Fler_=3Cverdre=40v0yd=2Enl=3E?=@ci.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org, zbrown@gnome.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  3 Nov 2023 19:21:46 +0100 you wrote:
> There's fairly old oversight in the SDP parsing code where it was forgotten to
> add a NULL termination byte to strings that are later handled using strlen().
> 
> This series fixes that oversight, with a few commits to better follow best
> practices on top.
> 
> Found by running with address sanitizer.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/4] lib/sdp: Allocate strings in sdp_data_t with NULL termination
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fdb5ba2cbff3
  - [BlueZ,2/4] lib/sdp: Don't assume uint8_t has size 1
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cfcc6346a96a
  - [BlueZ,3/4] lib/sdp: Use correct string length in sdp_copy_seq()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5afa25c95e6a
  - [BlueZ,4/4] lib/sdp: Pass size_t to sdp_get_string_attr()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


