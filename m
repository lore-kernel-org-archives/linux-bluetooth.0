Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752031922E6
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946632; cv=none; b=idFuiIfEIdbEzOI+JG+LZWGsAQmcjZ59UXDUxqddynz2vqsjDoYy9YOJirQNF9yx+Cx/apwmTb7/ysvfLXiaA6fFKrork3R4FnC63OdcDk1CB4rm82qs42cKY6voxtY96wUo+yAMx+xKegaPHzvulekwsfeITktpFM0u8bXX+2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946632; c=relaxed/simple;
	bh=zk0luG91QpfOT60+Mf2bS8vLRAOPhqJW2JAZ1kFqIa4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jIo0gdVLeYpRgnIhl9P57wu/IXoXPp1QVwpQm1uRzTWAr2PwUV74BvA65xAR4XdapTjXqXH1gCqv/+Zl7Q7aIJHEnmeE8unvslWOHAVsfgowunzq7r7F9AcG53TJopEfqnwThriQyOAojYPCFQe0iER/1WxhmzMgyRDhh1RRrnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOrbMIiY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOrbMIiY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9F1C4CEC8;
	Thu, 29 Aug 2024 15:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724946631;
	bh=zk0luG91QpfOT60+Mf2bS8vLRAOPhqJW2JAZ1kFqIa4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bOrbMIiYdEbegClp5CVihpNCEzud4t6HQlmsIShxEFXQ2bCN5qfNBJXfsEkaApjvC
	 JQkowOQwxaKgSwhGOKrbA/nD49ADAtSkiq73Yf/3ckAuvzfuCuSk5xqXCVdaiitoIT
	 mEgJqribQVSAYp+0mQWx9eHSXvpoJVlLH0EM1xK62ShgxAvAwCJncuVYJmZ7pWu5TW
	 xo+IPPyh55BcepkWfzotsWosSq3Wn4ISD10+M642EzD9VOhCiI1h00NKRMj9vlDG2Y
	 G5vg+WDtnZiaA8TkCSmxtve6A8yVlWjlPZKPoeHN8D9cqVbmNMRG9xlRZroLsUXUES
	 dqF8FQjfRZkWw==
Received: from ip-10-30-226-235.us-west-2.compute.internal (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8A0D93822D6B;
	Thu, 29 Aug 2024 15:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] shared/uhid: Fix unregistering UHID_START on
 bt_uhid_unregister_all
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172494663256.2000498.1962141469898200231.git-patchwork-notify@kernel.org>
Date: Thu, 29 Aug 2024 15:50:32 +0000
References: <20240828202949.924451-1-luiz.dentz@gmail.com>
In-Reply-To: <20240828202949.924451-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 28 Aug 2024 16:29:49 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> uhid->start_id shall not be unregistered in case of
> bt_uhid_unregister_all as that is considerer a internal notification
> not under controller of the users.
> ---
>  src/shared/uhid.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v2] shared/uhid: Fix unregistering UHID_START on bt_uhid_unregister_all
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2daddeada069

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


