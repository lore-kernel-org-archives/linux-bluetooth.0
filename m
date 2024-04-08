Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600B4847B
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 19:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712604628; cv=none; b=q8zaDH3HKq9xivcTUzaAuPsklnWtMTSbir/O6UzPfypxMjJ3g7Agj2W6zySp6Gj9rv2hb78Duup+YPQmznSEo/0bDILMtPMcNkRmSJ/5AJu6HNPqmEEcqrOq2SksVV/7f9gaTGm1em8rTEQxmnGWPzluMsBw5U4AVutdg09mCm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712604628; c=relaxed/simple;
	bh=h5Jb8UYfqCbs1WRN1tOaNYWYaGzHrKHRX1L5LNs2LrE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k5mb+A239clsbyDuCQ+Br6CEUQi17lBnAyzhY2p/DKFo01TTux+KvCknaCMzXF/JMnOKHV6Gtq7haABNGjs2S4VshQj7MNsP4xbrvfdtzyvWX5+aTRiiUquKigcI0TV5qCM2Fo3LP/ltWvSsEJnmyraYyjwAozQRpWjicsN/N2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dG6KHfle; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dG6KHfle"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 180D7C43390;
	Mon,  8 Apr 2024 19:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712604628;
	bh=h5Jb8UYfqCbs1WRN1tOaNYWYaGzHrKHRX1L5LNs2LrE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dG6KHfleEg457njt/mc/GgKEMRVUD8P3/tMf5vlj2tWuQ2bUvYAMuDGRGiSqmVu3P
	 qWQeBju+mgD94fJHCzHf6gtKd+Lu+5+csB+pXOD4TQ91N/lNLlmm7U0ImbcDmgf7VK
	 pKDHINskRHi1QdZtq6/Z2Qu4puEtacXzyIZimG2ThRY9/3+g2cwGNSiH09qL8mtjrb
	 HY76Y4W2oTdokE3X4JnWsOFY7cQQz3tThPj7WMtIwuYIqRK7h75WZKp4hvjX34PNn1
	 QCDeYHT1wrCSVzzzQST1HmmLJd+z3A5JvWwZFOl/sMRUHdc4k7QymQWmvmgOjkhaB7
	 mT8X5ZuuWZPZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0A34EC54BD4;
	Mon,  8 Apr 2024 19:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/gatt-db: Fix
 gatt_db_service_insert_characteristic
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171260462803.8265.15629236234845441470.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 19:30:28 +0000
References: <20240408155949.3622429-1-luiz.dentz@gmail.com>
In-Reply-To: <20240408155949.3622429-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  8 Apr 2024 11:59:49 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> gatt_db_service_insert_characteristic shall not attempt to insert the
> characteristic attribute handle on the next available index as there
> could be descriptors in between so this changes the way
> get_attribute_index calculates the index based on the given handle to
> properly skip indexes used by descriptors.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] shared/gatt-db: Fix gatt_db_service_insert_characteristic
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7604a577c9d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


