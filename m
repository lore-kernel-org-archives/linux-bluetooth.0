Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A4B207E18
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Mar 2025 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100400; cv=none; b=FMHxWVDe42yeqDcv6PPHVYJx+fPxjDAA9Ik+P2D1cwPioTtn1JLPgSGMonxxpeXEkXas0NXWrDgNwC9vdFbDRF3i7ymprjpG+YArOLmfiP6K5QiSJElWaqzQuaDJ+YzpNcx/MZcpeONFuj8l2ZyMDEaMwImBlvZkPOHKWIELOj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100400; c=relaxed/simple;
	bh=BF+OS5BO2scyUHxQ1QSfqLG5roXqlNfCxO66a1dBN7c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=og1kYtSdDrkOl+xyZqxtp5JkIkFW32fzeee4mrdxJQvgY+QF4jzIUFS78eMNSXegvANidxbZM4WeboMiL9Bm2/dukh+ovBZr9vw43Iloytg28zEvTXgKHxQBZ3MTIlZ6P2JqAdKS8UbH7riZm0SMSjzp5q5+Uirf1CSW2GdA4Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zn1EGbSS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zn1EGbSS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15424C4CEE5;
	Tue,  4 Mar 2025 15:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741100400;
	bh=BF+OS5BO2scyUHxQ1QSfqLG5roXqlNfCxO66a1dBN7c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zn1EGbSSO9fkT7DKvuLaP0EABBC5y0K653rqhqhcvTpWn8O/yzBUpRLiPzw/D6YV+
	 xsUJaEiufmrPdVSCErWerfkllMGzsNJV7yIUhL08Y7cOrJHVPep2oP2hDtVxA0Jgg/
	 V0zmSiIOtRScc4tXbA2dln1PEqfUslV9gtEgbM2zh1F9Sruitdj388QUxFSKsT0uyB
	 Ii+67U6lysXXSwb55ytq7N5pXScU8o0InnBXw4HKln/HkVmkTNxBv5c9rh46UP9ndZ
	 eczmegyAEAkbcijtPWE0E3bujfgXXXKX3NNTNHbw1FxKhXiZMAwm77uqZNdIofqHTe
	 djOEaY9+4aB7g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BF2380AA7F;
	Tue,  4 Mar 2025 15:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: Add support for device coredump
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174110043274.174904.13541424061943104239.git-patchwork-notify@kernel.org>
Date: Tue, 04 Mar 2025 15:00:32 +0000
References: <20250303164527.218458-1-kiran.k@intel.com>
In-Reply-To: <20250303164527.218458-1-kiran.k@intel.com>
To: K@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Kiran <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 vijay.satija@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  3 Mar 2025 22:15:27 +0530 you wrote:
> 1. Driver registers device coredump callback
> 2. Dumps firmware traces as part of coredump
> 
> Co-developed-by: Vijay Satija <vijay.satija@intel.com>
> Signed-off-by: Vijay Satija <vijay.satija@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btintel_pcie: Add support for device coredump
    https://git.kernel.org/bluetooth/bluetooth-next/c/aaa9cc6993d3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


