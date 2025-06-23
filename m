Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB7926D4D9
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Jun 2025 17:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750699179; cv=none; b=YIcU46jchuufftCgWXQlb+MCMtf3dqO9OctDdpEmS4YaDRJv2mlCiwVZBcLGo7YPao/dFp0GCPIvJQa8NwfLLxpctJSWH305mTI28JZA3w1glUxTlCgsEuAG847HCezvl1W593XCjqAcZ3OFOtdF6ncsQQWg9OsK8jVQkjZ0ftk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750699179; c=relaxed/simple;
	bh=qBSlE/KHmi+JCzg5NwJsHBl1bLC4dHNfTnyuJyW8muc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W3ckM61Punv8EM0PuTTClKeEUVRPYy8sv2FbuhhoYWqlNdMmk3ZfFj1EbOAJj8JkUCTt2ihiSCwysLworZPVWCueGKM7//iFI3pncrF4EldVZg4Xw/I0FH1sgj6ZxZ5LEY/b9mE6H7HMRSDAXjByhlodqTSlz9IMtfH8LsFbxY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Leuq2fNx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Leuq2fNx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25828C4CEEA;
	Mon, 23 Jun 2025 17:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750699178;
	bh=qBSlE/KHmi+JCzg5NwJsHBl1bLC4dHNfTnyuJyW8muc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Leuq2fNxgRT/CcC1OjktLT3TZR3q71XcPWKtr7o+ST/6ceN70TKMTq+fS9WWOQxXK
	 bdaM2ukDSOdl9Alq5AkQSUMX7OOkZwtCRR0RG54QqduTnjmRlsqUI335AfxrozljAZ
	 vE1QqCI1CFfQ6GT4e1PJef8YK6VB2dn8/zkXYnYCBusvaHkDagFQobyw8ldGfNVIpO
	 rHs5rNdPeiT4xLMGPNytH8OWk50R9Y0xuMkehUleYbwW3VV3W2TjcecViiYySYZMki
	 ZN7osGWxxye9xanwvYBlXia0AvDiFMtJK8jlwkoX+tClvoXwXAR8JZXB7Ws8MvVQxb
	 Rj46LZ7NZ7UEg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FCB38111DD;
	Mon, 23 Jun 2025 17:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/bap: handle inverted order of stop ready and
 disabling->qos
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175069920525.3239463.10574050638683479754.git-patchwork-notify@kernel.org>
Date: Mon, 23 Jun 2025 17:20:05 +0000
References: 
 <c98a6f523b122b47aaffb3ff6b59ccb236d76749.1750592769.git.pav@iki.fi>
In-Reply-To: 
 <c98a6f523b122b47aaffb3ff6b59ccb236d76749.1750592769.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 22 Jun 2025 14:48:02 +0300 you wrote:
> DISABLING->QOS transition and Receiver Stop Ready reply may arrive in
> any order.  BAP v1.0.2 (Sec. 5.6.5.1): CIS may be terminated by either
> side after Receiver Stop Ready has successfully completed.  However,
> when we get the reply, the stream may be in either state.
> 
> Instead of client detaching the IO on stop ready reply, rely on
> detaching IO on entering QOS, where Receiver Stop Ready has then
> necessarily completed. On DISABLING, mark stream io as not connecting,
> so that it gets detached even if CIS was not yet established.
> 
> [...]

Here is the summary with links:
  - [BlueZ] shared/bap: handle inverted order of stop ready and disabling->qos
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ae1b7f6ba805

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


