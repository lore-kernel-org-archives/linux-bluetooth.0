Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F09F7490
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715956834; cv=none; b=ijaiWxHUSznWGVD6Lvc67AEHwJUgdM1xvStID4nskPI1saTgrVOqjGkrttAUxDHrq2PSW0+P5UkVSrXYPkBsHmwFQiy7vPjx3HMrWOKf1//2jbfsrw6UG/9RuHKZOESGf7wu1IRYIEHWVYAsj1boGw8U2UDnZL4MUFwzSu7WQgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715956834; c=relaxed/simple;
	bh=Tfs1UUMJVl+YTeHyXE2w8iO72kIdxlkDIh7LVKiIi7A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ranibsKvPzvR/VdrrAPY4UfPPdAkdELmn9eEXLE88Iw/1y7l0A7wmy32Cu+kUyLWdsolpE4C4BsezLmIrheTOzgR3b9fhFJXB93Y7NfqKIRfNxJYvKgTHNEJAED/GTlNMhbu18Fkh1uc1S57+1M7Adz2dDAOuTdEOWVTI5dn3e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBV0XYzA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBV0XYzA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5A8EC2BD10;
	Fri, 17 May 2024 14:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715956833;
	bh=Tfs1UUMJVl+YTeHyXE2w8iO72kIdxlkDIh7LVKiIi7A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cBV0XYzAzJZcauEu47DKDRg5dgG2oN64FvUotTPtq+NblnJbULiYUllRNPpUEzjkg
	 IlZBD+mXPUAWKxEh1Z7c3nZ6z7hGkx4imkrCmVhXxnvuHsIlZZpw3iP6QD/ikAhIlI
	 3mPIw466XdeqKxp33fZKYmjdkiYxCqT/BNx4WYMlwkhRnVoBKyDBq3I7ZwhnmDhAIy
	 cF9/ze4pCSg74GL34Gmaz5q1CDd1mE/F253n+sBNocJXRx6a+uzKEau5OaaWNSfVrg
	 54O/U/y/AZ1NiB4yKHtitykIwqygTK8AmLiiQJpa1xFmt1ITNrRNaKAAodRjSAsK5H
	 Xx6f2c/cwv94Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6B4AC43339;
	Fri, 17 May 2024 14:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btintel: Refactor btintel_set_ppag()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171595683374.30517.4844115361621676420.git-patchwork-notify@kernel.org>
Date: Fri, 17 May 2024 14:40:33 +0000
References: <20240516122436.880999-1-kiran.k@intel.com>
In-Reply-To: <20240516122436.880999-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, vijay.satija@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 16 May 2024 17:54:36 +0530 you wrote:
> Current flow iterates the ACPI table associated with Bluetooth
> controller looking for PPAG method. Method name can be directly passed
> to acpi_evaluate_object function instead of iterating the table.
> 
> Fixes: c585a92b2f9c ("Bluetooth: btintel: Set Per Platform Antenna Gain(PPAG)")
> Signed-off-by: Kiran K <kiran.k@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btintel: Refactor btintel_set_ppag()
    https://git.kernel.org/bluetooth/bluetooth-next/c/287da9035b2e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


