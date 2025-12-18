Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A6D32E694
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766069601; cv=none; b=tIZ6H2fratKRPXy65F2qIXMcVjWViA5mCbVQfGpuPMwOvF3GKVPBPwiNH2XxqIzxPXizMIKnkHkHk6HaSemIWoII+qnZdUD7DxRJ9q2CXFhMhlANxSt+MF3+w84QYDXIYKuOsn604RxGYEnqkNhgnuV4g0QOUmU8ejqzw8iVOt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766069601; c=relaxed/simple;
	bh=NTrPY0/ta9FgX8qdEyiFVHyNIsPClkxvnZXM6JFZyNI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W8rZqWe46ylS9o/74qoNNJMGpoB56u50K7cCZ9ruNb5ACbOZYuSeQxKcjMs4oM6/eP6RmZyBq/rnF/6wH4OM1XhDNY8nChw9B0Mhiu/q92vMHBPgji75RIyWNO3lC5CjptRZ83ZU7+8auIwnOfTYrLPMxdLfsFHFc27ogx0Hex4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxoWKU9P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxoWKU9P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57473C4CEFB;
	Thu, 18 Dec 2025 14:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766069601;
	bh=NTrPY0/ta9FgX8qdEyiFVHyNIsPClkxvnZXM6JFZyNI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YxoWKU9P7Nvf8uJHSGVExDom3G3ZWMKymaPrrG4fa8vL897kY4W1L1alJButNX0ce
	 CfIpzjcO8GI9idVOKHRP7VZ9YQKkPHAFFbgCe2uLNwcTffvEfKvpf7+7RJ4JO56JHV
	 QE6zqieUCoUHBSe6/KxOFSd2Qwan7oWGsYrxxJm0xmbc7Tiek9uw8+TjzkzDrMKKPs
	 Vv/EGWHFbFdO7IEKnT/yK9/kC7lTiH6BSbelb1vMGbfssntTaCJ5MgXCv+fFsvzw7n
	 EsbNU7ESU/qZPaxyf3lPuVHR/ua/AsrgeGVrsp3iXANd/R7punHCjzrI59aW6bOyeb
	 FeZQs6YzPdqRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F290D380A963;
	Thu, 18 Dec 2025 14:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/4] Decode system parameters and add BR/EDR idle
 timeout
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176606941077.2993846.15118876184815425617.git-patchwork-notify@kernel.org>
Date: Thu, 18 Dec 2025 14:50:10 +0000
References: <20251217160256.441737-1-ssorensen@roku.com>
In-Reply-To: <20251217160256.441737-1-ssorensen@roku.com>
To: =?utf-8?q?Stefan_S=C3=B8rensen_=3Cssorensen=40roku=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 17 Dec 2025 17:02:52 +0100 you wrote:
> This series adds support for setting the BR/EDR system default
> connection idle timeout, documents some previously added default
> system configuration parameters and adds decoding of read/set default
> system parameters.
> 
> Stefan Sørensen (4):
>   doc: Sync default system parameter list with kernel
>   adapter: Do not send empty default system parameter list
>   monitor: Decode MGMT read/set default system parameters
>   main: Add BR.IdleTimeout option
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/4] doc: Sync default system parameter list with kernel
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=063db049ba29
  - [BlueZ,2/4] adapter: Do not send empty default system parameter list
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5e5b46c5c0cc
  - [BlueZ,3/4] monitor: Decode MGMT read/set default system parameters
    (no matching commit)
  - [BlueZ,4/4] main: Add BR.IdleTimeout option
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2edcad4c4312

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


