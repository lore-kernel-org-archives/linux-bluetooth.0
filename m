Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBF720FA9B
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Feb 2025 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618214; cv=none; b=VUKN4YoEejHVH0SPuClLJrsVP6QO9AghuNnS5DhSZ/KsP9DsWRcYAS63VegDVoSsVnaY6Yz2xgwKu4Ihix67bMuopEnk2uir3ki0vgd84SOjOBogEC7KDtjt6jwamKLhXCwWED7mF/vzywEH/J7jLJT8U+Xk4F3e1UZasYfxO3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618214; c=relaxed/simple;
	bh=uF/4nclLYW5Y2FRuRrbeyETeQjo3puAhDaoaq/EYwl0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vu46DtDgbCdJCqlCKS97MOi9ow+CKlB2UdFr0hj8HrwRoD//w3jo2m7rnTPCnSA6jiA5nNtsSf4DJcGc/h0YEngQP6TpQseA0nmvVWBRlKC3NTAu1fBQmpGbCbDBtE4NFdtB71FHN0g4nny6l60jHff7BU8o8XS630PLzV5m9bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BctgxsYU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BctgxsYU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C53FC4CED2;
	Mon,  3 Feb 2025 21:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738618214;
	bh=uF/4nclLYW5Y2FRuRrbeyETeQjo3puAhDaoaq/EYwl0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BctgxsYUvudUqzN84OW0/CniPasPkFL4rs5jOYMRI0hyoH01KZ/QFjIwmoV1hFMGy
	 RjdxMYdWSOlSWEjyMSfbTtQAbNU+Gi+DsQXfNtWHmNwCjZaQa2a8OtWpc0NK6rmHxm
	 yOt2B+OO4E4ZqmAaBo/XYa3mykNxN1bYUs3GA8Z17QkbNhOwh7VzlZWE3h66Xy+eW8
	 S//8CjsAlVfFHVca40BiNaFHV9xH3amArq4I8PmGpP+M+d/bi9HLWT5dXr4gvLpn8g
	 iJDRN6jhxrzQMyv5yjjNztK/IOiHORHLt0lMCAp0huSF5ia+3ZwoW3wCnJTO/mSwAE
	 9waN9X/mMVQFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE90380AA67;
	Mon,  3 Feb 2025 21:30:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3] shared/vcp: have only one volume change in flight at
 a time
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173861824125.3505817.6758716965895366004.git-patchwork-notify@kernel.org>
Date: Mon, 03 Feb 2025 21:30:41 +0000
References: <06e82df8d3cdd52cdaf4417059638382d7443efd.1738422702.git.pav@iki.fi>
In-Reply-To: <06e82df8d3cdd52cdaf4417059638382d7443efd.1738422702.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  1 Feb 2025 17:12:09 +0200 you wrote:
> If bt_vcp_set_volume() is called again before the previous operation has
> completed, the requests get the same change counter, and all except the
> first one fail.
> 
> Fix by waiting until the current request completes, and if volume was
> set again during waiting, send a new request with the latest pending
> volume value. In this definition, bt_vcp_set_volume() will skip over
> intermediate volume updates if they are done too rapidly.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3] shared/vcp: have only one volume change in flight at a time
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e77884accdb2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


