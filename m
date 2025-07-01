Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E305F1E515
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 13:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751377782; cv=none; b=u96zhw7fESNXLNVLrTEBPa58ipIfN55qq8CS5Fz8NeLKv+8DhgA2DbGK4DKPKBLSZO98yGeavtT1I0szhVKlH2vI/8Z95Yb6H0YOGa9FaBIAB//goQ8GYXMFS+jKsP3NxG2ipHNW7RbTqe1rrywUiZDBMdYQL8zcbGyh33NNMhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751377782; c=relaxed/simple;
	bh=Z5nQs/DJcgrmQLIKhs7NYeuvpTep80aDufFqN25mhvk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GnMij7IUVTBHmurXo/Q422fRrk4egpNnrMVV/R9wMASacP3GqIesoj1HDOmYMx80USfRaBsQC5iWgvvpEl+LVGZ/m+Zy3j63gJzX58xWl27QXRe8qfWnHDBpqcVRy/Rr6x6rjiOfF/wPIrQM01STsHxAG661N9NUbxBafy9fthc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rk4fGf8V; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rk4fGf8V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0667C4CEEB;
	Tue,  1 Jul 2025 13:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751377781;
	bh=Z5nQs/DJcgrmQLIKhs7NYeuvpTep80aDufFqN25mhvk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rk4fGf8V970akLtkP5eAoBP0rgW0EWOMFABfklMhWBF8hyBHtRo9S+3LbVf8PkzZt
	 fab3j20niV77/jXv8WjAg401GG87fy3K0bxPUT+1WSla8Ise8OqmZgo7eX2w44MqWL
	 fnRzW3e5sHTJeenE5v9YPLcRBgxWql0J4lbu5Jn9CjmpmZRITqa6QIfG8BjnuJiPv2
	 qpv0j6hbGBnOfQH7OKm4IRxrAczSm6pp/ZT+QKKfM+pvFY8UZnC5GQmqd/EhRqX9Jq
	 3r5ZQGbeyK8Lg3ISM6WDlPTWIxqoi74I+V8DoHF12/DfDMiLgwLUR2+HMUobf4iJMo
	 BhTxWRy1tCS1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD9D383B26C;
	Tue,  1 Jul 2025 13:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_core: Remove check of BDADDR_ANY in
 hci_conn_hash_lookup_big_state
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175137780676.4174555.1041451443191492984.git-patchwork-notify@kernel.org>
Date: Tue, 01 Jul 2025 13:50:06 +0000
References: <20250630193934.987691-1-luiz.dentz@gmail.com>
In-Reply-To: <20250630193934.987691-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 30 Jun 2025 15:39:34 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The check for destination to be BDADDR_ANY is no longer necessary with
> the introduction of BIS_LINK.
> 
> Fixes: 23205562ffc8 ("Bluetooth: separate CIS_LINK and BIS_LINK link types")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_core: Remove check of BDADDR_ANY in hci_conn_hash_lookup_big_state
    https://git.kernel.org/bluetooth/bluetooth-next/c/5cba85346eaf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


