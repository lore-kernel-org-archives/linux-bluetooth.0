Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC28193476
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720621835; cv=none; b=sgc3MHRc+AjG7C6//rvLrQNwngwzA7Xu3h2Iz1ZsdJBPfz4AamJf/sMaWewHfdznUy+G68f7kPLDBRDklg64pwnzR6t1NxoR3zJbN7FF2+VTAIJYks51VEPulU+DhpesZkLn0AP9ATtM5ltjweCddVarFaCbBwLobNx0IyZn8NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720621835; c=relaxed/simple;
	bh=s+BeRa4zAO+cKGSWl2x0/8l3ACg2deOz0BqgQWF6ut8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PgbTu7aAmiwfjGRj7QwgDy5NZ32NdMTZZW/ejvmrVI35FHntE7JzuaAj4anOZJ3C5mW8M7+Am3wedDj7ryT2fzdjpIGuQZVgdrIhS3YOuKKnS4HOxQ6Z6JzNa80UfYq7AT/p1OfrM4xbWmomdKwX/1STmRl+teWW/UXACwdmYaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWBRH1Un; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWBRH1Un"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 77B00C4AF10;
	Wed, 10 Jul 2024 14:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720621835;
	bh=s+BeRa4zAO+cKGSWl2x0/8l3ACg2deOz0BqgQWF6ut8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iWBRH1UnSUrfhNB9EhglLmpoo6VjtO9ILgxHV65LwDpcNk5oqsKGKLjWCM0C34DYJ
	 PIyxqLPeLvCX5EzFke7aOX/Wi8Z3a8F6pzakgtXiHLz7xuch24vqlExtYwrwI72a1B
	 kWnK7Y0c5LtrDD2WNbE3jc7xoeXDELcO2dmy6eqguepDAE/CyvcPOT1NXJ6jDxBepn
	 sZzXb8ggW6mo4rqJDwsHOUw4NVddfHIpIdvkdpCGvD3Fssvi/a5Zl72OxJdkIJg0mT
	 hTB+AFylo4wD30Bwwk5mMRvsSEchpL/fcTWPaq7nMEfRDfPWgVQvRCp4GjEfxKRF+Q
	 czM4UpcZ9h2qg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E031DAE95C;
	Wed, 10 Jul 2024 14:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/vcp: add NULL checks to
 foreach_aics_service()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172062183544.19459.6937149384364957020.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jul 2024 14:30:35 +0000
References: <20240702085508.30513-1-r.smirnov@omp.ru>
In-Reply-To: <20240702085508.30513-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 2 Jul 2024 11:55:08 +0300 you wrote:
> Make foreach_aics_service() safe for passing NULL pointers.
> 
> Found with the SVACE static analysis tool.
> ---
>  src/shared/vcp.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [BlueZ,v1] shared/vcp: add NULL checks to foreach_aics_service()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ba70a116d971

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


