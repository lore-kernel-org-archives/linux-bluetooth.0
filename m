Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7517520DC8
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985830; cv=none; b=atZw0r52A+z7wTKJJYUV5OOpNAqiI6Fe9Hv/wRg097eLBRg4O8QM0J2UJ2CysFs3IS8v/RSaudM2uZ2oS3B96ygHr+5VCdHn7Lh/5w5ep4OoX+s8uwY2P9YNNp2hzQW1xYJsfPaj/3efLC/Q6lYa/DbXY6DDonnSrD387sA4zBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985830; c=relaxed/simple;
	bh=bxML+fmVIPm+KfuR6ItCoSyNCtz6kNSh+YiE/Gkzi7g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rlZSzOaI7sXZkdCszP6dLfy2dnHebfSq2ebgZzScEh4mlvg2+V8giTx9Nr7CkeJDVschHE3JcB/RsxABhHEDym+UyhZhfuEuZRt3IIEgRLNpYzmvlO0M5gPujViHfKhRig6Ez+o7yGSmD8zUmyUkl67y/dtOOv+k2uObVr1okxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CO43Y8Lp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CO43Y8Lp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2AEDBC3277B;
	Wed, 24 Apr 2024 19:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713985830;
	bh=bxML+fmVIPm+KfuR6ItCoSyNCtz6kNSh+YiE/Gkzi7g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CO43Y8LpUZMRrpHJa/TSq9njrI79odNeJnBhyzHWQEGw6gex+8mOf2XqVNPViD7Ps
	 3waQKm7s3/S/VHFlrwPHls3Vz25Xi/qSA2zjD8l9cr5x0nMxv+DdJK9ttLC1vArxyQ
	 /7UYeVVRAm2kzKvwdlMKYKAHZk+xUNcWZS/tzl6fN6SeeD+6V570m9sOyPDQXc2evE
	 SX5uJxHRNpYL9ehc2dKlWSv22C/oUH/d8j86Ka9rMa52ih8PSN1K6Sr4/WvP7N1Pkj
	 AYM2BwmcOWpJQ6g05N6g4O85vRvOmFUnh/AXvuDZG+BjI36UDDtMQTkUdsROR93fhh
	 l5GByIbWCnaOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1490BCF21C0;
	Wed, 24 Apr 2024 19:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/4] bap: Replace the global bcast_pa_requests with a
 per adapter queue
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171398583008.8080.1953821019197747810.git-patchwork-notify@kernel.org>
Date: Wed, 24 Apr 2024 19:10:30 +0000
References: <20240424140741.73899-1-vlad.pruteanu@nxp.com>
In-Reply-To: <20240424140741.73899-1-vlad.pruteanu@nxp.com>
To: Vlad Pruteanu <vlad.pruteanu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
 iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 24 Apr 2024 17:07:37 +0300 you wrote:
> This replaces the current implementation that uses a global
> bcast_pa_requestsqueue with one that runs on a per adapter basis. In order
> to implement this the btd_adapter field of bap_data has been replaced by a
> new struct, bap_adapter, which includes btd_adapter, bcast_pa_req queue
> and pa_timer_id.
> 
> Vlad Pruteanu (4):
>   bap: Initialize bap_data for scanned device in bap_bcast_probe
>   bap: Replace adapter in bap_data with bap_adapter
>   bap: Improve handling of pa_req timer
>   bap: Remove deleted devices from pa_req queue
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/4] bap: Initialize bap_data for scanned device in bap_bcast_probe
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=638774f603c2
  - [BlueZ,v2,2/4] bap: Replace adapter in bap_data with bap_adapter
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=aa7f3574f275
  - [BlueZ,v2,3/4] bap: Improve handling of pa_req timer
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=48a69222581c
  - [BlueZ,v2,4/4] bap: Remove deleted devices from pa_req queue
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c7071911d57a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


