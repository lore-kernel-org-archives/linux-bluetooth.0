Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1784A31
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jul 2025 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753281588; cv=none; b=CNVjwAZ+bCAHMdkk6nMJDfGtbtvKEwRadYLwN6jpiD2kPT2pZuUngzE9oQdgLcbg5dHR/jkQ3JoWbOjPbLiizVPqq0cFhU5fcHF70vXdQdg81kzoY/jmL1WKyzFEUWeOyDRzBqqnHRX8LCWdD+4TGJL6uA4xhoemmSBHLfDlSiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753281588; c=relaxed/simple;
	bh=TcNd/2N7Sf5OY+GbUuXoUSkNkg/kX9OR0g4PROQxAw4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m0aPdBS2GGSTyCpbyTe/f++If9dZYad6cGhM14ipBdoD2v1vhAERdMFndRWOhwzmoJh+iC9KegtHCBBDU0ZwwiHOb7v0aWzKZ8PC1+EAtqD9+GuU48QC2iCOK+j8KRKr3BWG0nyJWoqb/7wH4shxMFoITbQDG00QHsWyMENXtFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdRgEW9j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdRgEW9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A6A9C4CEE7;
	Wed, 23 Jul 2025 14:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753281587;
	bh=TcNd/2N7Sf5OY+GbUuXoUSkNkg/kX9OR0g4PROQxAw4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hdRgEW9jPKSA4Bz5VTFLw/jwo9oa1dhyNzXua2KfLcyXZtL0/5aSYJR/qD/YhRl7y
	 N+HJsqhOpEp4flQ8wAOuOzMV+3icrZOhjNyrxpetq0dfuYWmUNOssaTx9GYhY+MpX1
	 H5MXAvABi7KPh3JtMWixoShvmyAbIupuxXQeMsUNjzhHm0rZlVzTjHCYafUH6EI4Fx
	 cd3BIey7W6bhEX/gmr3L1Z1AcX0OEi2x9xWDoSNAMutWvm6RLM9o8GB28TNYLq47Bv
	 kg6//hKsyYxa20qf6JGuJe73oSpgEH6jCQJjG5iVToSy1oh5yQpEV6L4QO6Bn3PHt3
	 u3v8o6qt83lLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF89383BF4E;
	Wed, 23 Jul 2025 14:40:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/3] transport: Add write support to Metadata
 property
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175328160550.1590822.3737623052583059981.git-patchwork-notify@kernel.org>
Date: Wed, 23 Jul 2025 14:40:05 +0000
References: <20250722203508.1311750-1-luiz.dentz@gmail.com>
In-Reply-To: <20250722203508.1311750-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 22 Jul 2025 16:35:06 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds initial support from writing to Metadata property.
> ---
>  profiles/audio/transport.c | 45 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 44 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v1,1/3] transport: Add write support to Metadata property
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4549772bb228
  - [BlueZ,v1,2/3] transport: Fix not updating MediaTransport.Metadata
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=75628226ff83
  - [BlueZ,v1,3/3] client: Add transport.metadata command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3c0693c5d226

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


