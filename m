Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C024502F
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 15:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338430; cv=none; b=dWeijjdqmqrsGZnNpvieyV8rgYQ3cfQZolM6Zna5X+IgZoy/ct7FB5JJDj8/fdRa0DDkhzeQS45KPt/x6GkA8WQU6h6YSJs9Q7Zktxd1XOZkOkDYgJsZBZiK12eVwhvH6TISp0Lzo+otcZNz1xvJLK+bF27i79tdTIXwTSuC6eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338430; c=relaxed/simple;
	bh=SeZ8FzSIHZLRQZRabzq1EPxa5z60j6PeOIcax0JOb44=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pfvVwaiLpGuo0vCJjgEmQLu7odlbgLaLfAweRi9lK/Mfxs9jGq+knjluX2jTh0umN4ngbkF7rdmCcd1neno88Kew7Apz3paULMIay1fy2XZwQYrPQDpH5N/EJjDsQ/fZt0g0BETdRUPCfFP59JjLNEy+FHOMRaAh5j/pTxoH9j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0/VIlP8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0/VIlP8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1C5C4CED5;
	Mon, 11 Nov 2024 15:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731338430;
	bh=SeZ8FzSIHZLRQZRabzq1EPxa5z60j6PeOIcax0JOb44=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=o0/VIlP871QMXxUKZsFDir0YT6Uysn/NepJKkld805DekngI0AYjJWoUfx+Sm4ah3
	 T025kRcRSoAiXvQBBgi/Vnh6+CdDHSmiq6H0Di/qCaRMOy68wRRuylc22EsiI1El4h
	 Mf1Np8QYZOtpp8bGgTLMaQ8Sb5EyCyi/qSK6y/go8bmSvYRg3V5f7OhpbhVepvahEs
	 b6xZBj54wUGZlmqxB7fx9UCe4qj0VwfCV8gkzqAtm6AwLxrsHdmsBOjA6GWkpeiIOE
	 gvfPZy0bgKwi8FKNURPl8UfEkk4TO2Jb52+2uaMP0vAMIC5Q4YtObgk3H1wPHRkfWt
	 2VLXCIdnXJskg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF053809A80;
	Mon, 11 Nov 2024 15:20:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] obex: Update the FTP version to 1.3 in SDP record
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173133844024.4067431.12524237535576529318.git-patchwork-notify@kernel.org>
Date: Mon, 11 Nov 2024 15:20:40 +0000
References: <20241111132238.2162878-1-quic_amisjain@quicinc.com>
In-Reply-To: <20241111132238.2162878-1-quic_amisjain@quicinc.com>
To: Amisha Jain <quic_amisjain@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com,
 quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 11 Nov 2024 18:52:38 +0530 you wrote:
> This change is required in below PTS testcase:
> 1. FTP/SR/SGSIT/ATTR/BV-02-C
> Attribute GSIT - Bluetooth Profile Descriptor List
> 
> Current FTP version 1.2 is being deprecated and withdrawn
> from BT Sig, so it is mandatory to update the version to 1.3.
> 
> [...]

Here is the summary with links:
  - [v1] obex: Update the FTP version to 1.3 in SDP record
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f0302d90a1db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


