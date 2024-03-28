Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CC4127B66
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711636830; cv=none; b=guguBGhkyDDBDdX204+jsBSpajZrzGkn7itI/5Hl9JMfAOTqnmhY3YgyJ/RQHJFJxi8LUtPGrVk+9fPLovkhpRqJMUnKA16CZNcH97mL/yNgQ+4XmNmDPY2DhVESC8JPXkUj0jGPTUGo+DLQlYdRah5NxzTyHZ5v5OCA9xsxCSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711636830; c=relaxed/simple;
	bh=ETp2kUCngV/gRPebf/MNlnQuW3cWGkCuzBvRvH3k+Ls=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=No06PkmjPw2z/kTyqakNpG9YwNrM6jwDxPA7kVGL+jyqsiC7ya07m2zkk+x3ApdOB4vG3VOsKNwh2wFl2EIveFH14jAoxLik1e5SBqqwhUPGfOF8Al1YaI2oVsKHQAthjC9htkCJLwLxIWktiX4EGZb4uJbqpwGHw9joxqN7iqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfPd0TmP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfPd0TmP"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F8DBC433B2;
	Thu, 28 Mar 2024 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711636829;
	bh=ETp2kUCngV/gRPebf/MNlnQuW3cWGkCuzBvRvH3k+Ls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sfPd0TmPF9nDCzN7GOJ3H4J2k3sTc9Fi+OTjfSOfwJJqh/UZUQ63V09VTP1Ywjm+o
	 WR4+04P6aBG7c8LcKMzvWtjh3fG9prv/y21fQJAImGIEuKhccvoRker70fMFLn0kzF
	 vUB4Hv5JB6+rhHv7Meu4vLfyIpeNs+FpRADAS4XV/ZsLBSadmaiT1McRls1dd/H0GN
	 bxyMJopiRfWCvC3WhXOSVTzjWJaKRuelc/TXRe4vPc+913FxuviArje1PgON6us6q5
	 aZs1QLnA4LKt9iDuW35s8NM9nMXHT386L3YmCXjg+9vYUx1jeP4ZCsxbS/7BtmMjWG
	 TGYsH+bjUKdKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 84F71D8BCE9;
	Thu, 28 Mar 2024 14:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] monitor/att: Add support for decoding GATT Long
 Reads
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171163682954.3770.1408580707285106467.git-patchwork-notify@kernel.org>
Date: Thu, 28 Mar 2024 14:40:29 +0000
References: <20240327150727.1584607-1-luiz.dentz@gmail.com>
In-Reply-To: <20240327150727.1584607-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 27 Mar 2024 11:07:27 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds support for decoding GATT Long Reads:
> 
> < ACL Data TX: Handle 3585 flags 0x00 dlen 7
>       ATT: Read Request (0x0a) len 2
>         Handle: 0x0028 Type: Report Map (0x2a4b)
> > ACL Data RX: Handle 3585 flags 0x02 dlen 27
>       ATT: Read Response (0x0b) len 22
>         Value[22]: 05010902a10185020901a10095107501150025010509
>         Long Value[22]: 05010902a10185020901a10095107501150025010509
> < ACL Data TX: Handle 3585 flags 0x00 dlen 9
>       ATT: Read Blob Request (0x0c) len 4
>         Handle: 0x0028 Type: Report Map (0x2a4b)
>         Offset: 0x0016
> > ACL Data RX: Handle 3585 flags 0x02 dlen 27
>       ATT: Read Blob Response (0x0d) len 22
>         Value[22]: 19012910810205011601f826ff07750c950209300931
>         Long Value[44]: 05010902a10185020901a1009510750115002501050919
>                         012910810205011601f826ff07750c950209300931
> < ACL Data TX: Handle 3585 flags 0x00 dlen 9
>       ATT: Read Blob Request (0x0c) len 4
>         Handle: 0x0028 Type: Report Map (0x2a4b)
>         Offset: 0x002c
> > ACL Data RX: Handle 3585 flags 0x02 dlen 27
>       ATT: Read Blob Response (0x0d) len 22
>         Value[22]: 81061581257f75089501093881069501050c0a380281
>         Long Value[66]: 05010902a10185020901a1009510750115002501050919
>                         012910810205011601f826ff07750c9502093009318106
>                         1581257f75089501
> < ACL Data TX: Handle 3585 flags 0x00 dlen 9
>       ATT: Read Blob Request (0x0c) len 4
>         Handle: 0x0028 Type: Report Map (0x2a4b)
>         Offset: 0x0042
> > ACL Data RX: Handle 3585 flags 0x02 dlen 27
>       ATT: Read Blob Response (0x0d) len 22
>         Value[22]: 06c0c00643ff0a0202a101851175089513150026ff00
>         Long Value[88]: 05010902a10185020901a1009510750115002501050919
>                         012910810205011601f826ff07750c9502093009318106
>                         1581257f75089501093881069501050c0a38028106c0c0
>                         0643ff0a0202a101851175089513150026ff00
> < ACL Data TX: Handle 3585 flags 0x00 dlen 9
>       ATT: Read Blob Request (0x0c) len 4
>         Handle: 0x0028 Type: Report Map (0x2a4b)
>         Offset: 0x0058
> > ACL Data RX: Handle 3585 flags 0x02 dlen 14
>       ATT: Read Blob Response (0x0d) len 9
>         Value[9]: 0902810009029100c0
>         Handle: 0x0028 Type: Report Map (0x2a4b)
>         Value[97]: 05010902a10185020901a1009510750115002501050919
>                    012910810205011601f826ff07750c9502093009318106
>                    1581257f75089501093881069501050c0a38028106c0c0
>                    0643ff0a0202a101851175089513150026ff0009028100
>                    09029100c0
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] monitor/att: Add support for decoding GATT Long Reads
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cd22ff6a1fef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


