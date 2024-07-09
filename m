Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ED915F3E7
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jul 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536632; cv=none; b=DvGvdsTWlShzvoMZ+T34oUsQZLds8yQ95w6P8OFftS11cFoZAs1r7mA6uN8kZSv2NYNdS4W/mLVldI+/QTj4wy2srjTWoYMireYE1G8bGe74CRSgt8IEXilRIdeMWWrf4tgo4hpmGhQ0T3e7BUINVWBZ7nxzN9UPNgQw2cI9crc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536632; c=relaxed/simple;
	bh=vnZtWfmdXMcu1xxFU7aDqmlkL27+FVz5EZFo7LqoRAU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bm13NgxAdVP5dMHJhLqPVDr0CqVdcyIxZrv15Q7oOxHVqfuj1uGP/JmvIZB483vRmj391+Nq/O/gnopkgFBvmgbsmbGt9y3yqu9TsFVTN+Fy498/oET2L1hElsM7rvTH7vN/lXjW4mC1k5W5DaIgnZ/pyJRAF/YaHcQKqC+lZFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jlfy9F/D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jlfy9F/D"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1803C4AF07;
	Tue,  9 Jul 2024 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720536631;
	bh=vnZtWfmdXMcu1xxFU7aDqmlkL27+FVz5EZFo7LqoRAU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Jlfy9F/D00m1xnYzWRG3DS+Gaeha22rAxvWQCuvkp1TByIFiW7zf2+rQjXhqV+FGT
	 YuK/hlmLDjjB40uI8UlP6o0vdar1O+mZYzihJliLwNOm32uhEzAI2Ojhz5jcK5qIfP
	 MqrU/frAEsK8NCCrnhZ6So9pPT92VjKgwywcpwHFKFRkW0EEchDAsH2CDHia9awxy1
	 oTpeKTAUkdmdSdcfQ+YtY9EzJlqSiN3Uiyn8dLHEa5/MzNZU0IuoTkG9GcuA8UVdO6
	 Bfddo/eBRpmvGdRwsu65ET8PkoS9bm8KYLgiYZnCQrQ/6mdffbHdfGXRQ/Ie+5pLS9
	 H/0MPnR4vdeFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A32A4C4333C;
	Tue,  9 Jul 2024 14:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] tools/btmgmt: Fix --index option for non-interactive
 mode
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172053663166.10405.6998663440385214638.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jul 2024 14:50:31 +0000
References: <20240709115541.66118-1-arjan@opmeer.net>
In-Reply-To: <20240709115541.66118-1-arjan@opmeer.net>
To: Arjan Opmeer <arjan.opmeer@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, arjan@opmeer.net

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  9 Jul 2024 13:55:41 +0200 you wrote:
> In non-interactive mode the --index option does not work because the
> call to mgmt_set_index() is made after bt_shell_attach().
> See also https://github.com/bluez/bluez/issues/893
> 
> ---
>  tools/btmgmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] tools/btmgmt: Fix --index option for non-interactive mode
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f00d5546c9e9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


