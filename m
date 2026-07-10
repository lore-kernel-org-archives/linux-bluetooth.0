Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AFA3939BC;
	Fri, 10 Jul 2026 20:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783714232; cv=none; b=jLgc6p2RIaEPoSEKjxlHKNMWNAdH833x2Y+Cm3elBycilKlGg/nO1Hmfd1THR3VdcIAVR8OYpFr+uEDX/384UI0VrUayx7TcBqv9y+g8B3bZgBjG6Vn4oLliN6HC292hRrN/b5ENhUnecaJxIxzG65jx9sI7VZnlk8IlRuC8Z04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783714232; c=relaxed/simple;
	bh=dDXm/ofaoENrc7MvDxOj342/lUcz2UUHeC26Le76S6M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FyoiU53rjrLaErVLTX7s0zlq5tthe/BrdrGyfOlYsR3WHGm9bRTPbOfiQPJF1k5QKA+VCIAuAqUqZ8UeqZ+SOLgUW95Y/FVJDdPMEzL5DB7G9rZcZbJjFgc6dehrmbTwo4tB9/fMTdU/IWGdKuCMcydQBwGRHRc9W33145LfsD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDzRgaoi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDzRgaoi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E371F000E9;
	Fri, 10 Jul 2026 20:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783714231;
	bh=g8KDt2YzQwZZPhN1w6z/dKux60P4OKTDTc/G0Yyvm9E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BDzRgaoi6oW1IM/W9ZOlo4YQFdr23acV5TsZf3G9xovlR6jiy9ndhxhmKOYWwnLRV
	 ZvA7w3NRYgO1aVyGcyDFHXVETDzqPzDivwfaghGwXeoErgckHe4gk2LUt46JWJVrHt
	 V5doxYgShwlDtOYtqNSDnhBL16zKm21cbD+IXtnKscBMScKP8jUecoxUOZZ/0AXuco
	 pdglkTw9UeTvOoIHofjtl4vJMtklzJgKErDUzdSx50lKEf1Oh7Ke54ZZEI3layqDBN
	 05gAiP00M4yo9AL5PApXGuSVlmNei+QmX8zU0cgQ2WuHLJBCrzk7pnV9zNinUwDdt5
	 3/K9z5T43aBHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BB039246C0;
	Fri, 10 Jul 2026 20:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_qca: Clear memdump state on invalid dump
 size
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178371420839.843459.16141138658537164977.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jul 2026 20:10:08 +0000
References: <20260709062250.4166128-1-ruoyuw560@gmail.com>
In-Reply-To: <20260709062250.4166128-1-ruoyuw560@gmail.com>
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  9 Jul 2026 14:22:50 +0800 you wrote:
> qca_controller_memdump() allocates qca->qca_memdump before processing
> the first dump packet. For a sequence-zero packet it then disables IBS,
> marks memdump collection active, and reads the advertised dump size.
> 
> If the controller reports a zero dump size, the error path frees the
> local qca_memdump object and returns without clearing qca->qca_memdump
> or undoing the collection state. A later memdump work item initializes
> its local pointer from qca->qca_memdump and skips allocation when that
> pointer is non-NULL, so it can operate on freed memory. The stale
> collection and IBS-disabled flags can also leave waiters or later
> transmit handling blocked behind an aborted dump.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_qca: Clear memdump state on invalid dump size
    https://git.kernel.org/bluetooth/bluetooth-next/c/fd694aebe414

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


