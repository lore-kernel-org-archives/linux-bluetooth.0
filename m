Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4902175A8F
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Mar 2026 20:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773259809; cv=none; b=JBRdZZPn1rZhTAuQhjZ1WuitqBseNH6AP0rIzBkwVWW+XzchI6Dlim66PgqGKYV/XjELISqi3pl90sY2ftGTRGz44WX41ucNQ+HQOQYVYiZ0JAmO9N+xlEC+FwFVy9/X9nBndnz96ledtGrqmGnv1KotYhGnHDZvr+evq+arN2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773259809; c=relaxed/simple;
	bh=SKc579dLlu4kCkOFcNgq5Al3fwUVGbOdnPPGoV1jbQk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C4XzH6dMU1H4KK5BPfCJ0pGMLvBupX9R5oPYxkVU3zOYdHKqli4KUqDOGCFqBuMBIvJtkQCvBynrQOohP5DiiTsBXsdaHbXOS046+tZOklQCBuD+cV/OGsha+we6UP7kGKX002SelpjQJ3Zrros36v0237wUasbWKeKFNLPxCbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVpTKJbj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVpTKJbj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FAC4C4CEF7;
	Wed, 11 Mar 2026 20:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773259808;
	bh=SKc579dLlu4kCkOFcNgq5Al3fwUVGbOdnPPGoV1jbQk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pVpTKJbjOFU7Dn4fqVCAw5aszyMMG2ecl9VClFRmmqsj13VHurVHjb/c4EpmE5R1N
	 8bYVb0OjnloQSwhTJ6uvhmtlg0x++dkpB486s5mztEX9TuisZ4gLevyKgwgk04/oDf
	 AIXSXLRUM3dhWVBQJKTC50q07ZKA9VMnVp4vHhpj457vvvVBFtmHcDl+SXReMMw6m/
	 77RptB2Vm22ksIsR8xaltjSZ/Iby3fYNJCb/xKSpy3w3tw89QSnGRxJtUhsoqVMGvU
	 DkDRLnpo9d0t92mTXIQnwVAgoP/bMSt3T0uHdNoueiX2s5WoKzgwd/AnnkHiXD2qcu
	 AJlLgCONjttrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA2643808200;
	Wed, 11 Mar 2026 20:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: L2CAP: Fix accepting multiple
 L2CAP_ECRED_CONN_REQ
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177325980455.3817440.16082168650744075592.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 20:10:04 +0000
References: <20260310214037.732139-1-luiz.dentz@gmail.com>
In-Reply-To: <20260310214037.732139-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Mar 2026 17:40:37 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Currently the code attempts to accept requests regardless of the
> command identifier which may cause multiple requests to be marked
> as pending (FLAG_DEFER_SETUP) which can cause more than
> L2CAP_ECRED_MAX_CID(5) to be allocated in l2cap_ecred_rsp_defer
> causing an overflow.
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ
    https://git.kernel.org/bluetooth/bluetooth-next/c/19ba9c64840d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


