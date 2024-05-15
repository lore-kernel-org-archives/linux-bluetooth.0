Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E1F1591EC
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 May 2024 19:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715799633; cv=none; b=CtwQ1a0KsQ8000H12DUmXF5T6/7lKVMd4x/HsbB9HWGASIeFTErnW1ODXaSZCrM7uJ8Pa0yh5XTXTBBlrLgvKK5y81mGy9TJiYK7Hp9LeSVT+1uspgeWXxNcqFSOPnj7Ixch+6nF9JCvgVdT9A/uaf1/A5p3I1olo7OfLPgEYss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715799633; c=relaxed/simple;
	bh=qVsPuHA+dgxRwjiIzR5D9Z/oAm233OOh6YewpkwDS0M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q0bxU4eRDoyKnV95piMs4vDANpqrrkK57MSkgiY9aUDv/Nsh+kq/r5UU1i48t31ItBVDms7zwAsss4Ao1BHTR5oenkz2/Ju1FmxbIB9KofZh8IBe1i97ka/S7gays6+UgsAm7CY09j9mCEyiy36jXcwx33hrmR9806y7KMcabkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJ9KfAwL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJ9KfAwL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B353C4AF08;
	Wed, 15 May 2024 19:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715799633;
	bh=qVsPuHA+dgxRwjiIzR5D9Z/oAm233OOh6YewpkwDS0M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EJ9KfAwLiemi1T1oU/LMUvN+sg9nhM4iol/eBCCao4DmdKcIirMxig/Kg8PwMooYj
	 NFVH1RWQj/6TJSDskzXFd1IOTrP8KNkD9zBDFe3zBHCUjIir+8GKXQF0Z0rQ909alt
	 NoM1vHkY+svvb/unbt5q7M/M4bNT/qY6AAVssf0MHhWH6ivXZHBE2dFWCkK73Fx3Zu
	 fY+E7/GtlSmSdrQkJfU6W2DzZxs26NEWYx1oNNSjTArhdpoddTiZUIO5QDKzALCpBA
	 lFaIjgOXIoZMU/YMiz6Rf2vlFZfZf96OCKSVunZJJ12UFitqzR9BUXdEY4UwNgmuMQ
	 8uQR75riOMIbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E633ACF21E3;
	Wed, 15 May 2024 19:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC v5] Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update
 existing connection
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171579963293.26824.1464577417921275624.git-patchwork-notify@kernel.org>
Date: Wed, 15 May 2024 19:00:32 +0000
References: <20240514175149.752522-1-luiz.dentz@gmail.com>
In-Reply-To: <20240514175149.752522-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 14 May 2024 13:51:49 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes MGMT_OP_LOAD_CONN_PARAM update existing connection by
> dectecting the request is just for one connection, parameters already
> exists and there is a connection.
> 
> Since this is a new behavior the revision is also updated to enable
> userspace to detect it.
> 
> [...]

Here is the summary with links:
  - [RFC,v5] Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update existing connection
    https://git.kernel.org/bluetooth/bluetooth-next/c/831be422f3bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


