Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EAA1A01B8
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2024 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726765230; cv=none; b=lOLTFKvVIWPQnpbh4zaIhHFlwc4wNsoj+f5Z0WuEx3p1IAUF7MzuTWiJwIEPcp6Nm7kXB/776nTqmjUSLM7N98q8ftCVadCBU1EJToSSQVayPe6ktzsipmMm8COTSUY1c5o9OQ9RPA45KR2SgIYHQvMG/TUd7fe1VI0JZl1ERv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726765230; c=relaxed/simple;
	bh=5R0wxkstp8l82Q8T4fIz1ToR3MdX2USIBxpSG0zhaAY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YtxSkP2q+cVHmpG8f9JHdcBbA3e8EJ/xAOTy/4nRH6tx+gXgBOav3/ivSRJVlv5+XoSah5HYJmTxPxK5j7Sti5NSTn9Dhu9hacBumbzauFCAirxav5Z4quMmoiAGarihskMtD4gsCQsjTh4fk9RnZl08n9EFLLcmxm4vYExn9I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cIsMuYk7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cIsMuYk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2715C4CEC4;
	Thu, 19 Sep 2024 17:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726765229;
	bh=5R0wxkstp8l82Q8T4fIz1ToR3MdX2USIBxpSG0zhaAY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cIsMuYk7pcbxxw5tG5ViEXodkAYBWCgiDxQ1u2vRs9jpdtHVngHVvUNy0qkEZw6R3
	 NH2u5ac9fI2zMJEIJuHzBOOfT7c20Ztt7IIL+doZS1m/RKAQoEqSD32HC97e0+hw8e
	 J1jnmWVhy6JOeCWEUtigPJojz1fTWh1i2GP44fZ/u4nUWIFN1ptfEZpUwK7KhxmNTt
	 xVhZ9Yv4rqzzbq6bH7MFD0ihOvQmLdmb2bP4n1+6HbehUv80CoHoajlq4q7fJeKm6V
	 2r1kKHiomcspS3k4mjNyaTCCM/TaPo/O2bKnxsQdntI8uSkvSJIogDXoRn6nofjXE+
	 /wTTmkIeXSPNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB79A3809A80;
	Thu, 19 Sep 2024 17:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] doc: Remove Pygments dependency from manpage
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172676523177.1624116.8952655229047035402.git-patchwork-notify@kernel.org>
Date: Thu, 19 Sep 2024 17:00:31 +0000
References: <20240918184839.662364-1-luiz.dentz@gmail.com>
In-Reply-To: <20240918184839.662364-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 18 Sep 2024 14:48:39 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This patch removes the Pygments dependency from l2cap/rfcomm.rst file.
> When the code-block type is specified, the rst2man throws a warning
> asking for Pygments package.
> 
> Fixes: https://github.com/bluez/bluez/issues/950
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] doc: Remove Pygments dependency from manpage
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0ea4e4d52c55

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


