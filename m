Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705D532B99F
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776360637; cv=none; b=hwrVvdz0btTkw2Sk5IaGlcBjZX8X8oVSBr+pbrSycm7zm0WIIbDCHtdXN/xCmbMIMecJdMeWa56uJ1hHh7bAMXweWHpnrByPFnr7Jow6+sDt4fR0y3/kc5aHA+bhUC+YEmKcNyQhVaw6wnwqRjNh6eKqIotQmv5ctZT1a7Is5HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776360637; c=relaxed/simple;
	bh=Mc2oxyIKpd2+CMWStoqnHd7CX9PASkftf0qVGuN6LFk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lKhMSsxU1K5ugjTUOULZ9JKQC3TC72xcLsPpwslvTsGV2KOk0lNJgEDx97NnjIxG9Uw8AuBLKnTLXeCdNm06uMRWJIjEU1YcOPV1YGzo2K89CKg+i4QgQcnspD96wELN987BYYsN9KGgO5ZDfp5/6wPaI1dAaLCqcBu4srbNORo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOR+AN4K; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOR+AN4K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177E2C2BCAF;
	Thu, 16 Apr 2026 17:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776360637;
	bh=Mc2oxyIKpd2+CMWStoqnHd7CX9PASkftf0qVGuN6LFk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fOR+AN4KMxN8xDddd2A3nqTKV1k+EvzafsEahyK0aA+JHnMnBOguVuI3tjseqG5E1
	 5YKydCAvtByEgFA2+DvnqiG6052Kp2EaoL8IFGxL18z5P7Yb3oo4gTw9yTNkOsKxHn
	 U6z7Rfq8OgJEn/qdTDCiIPOEcSyrc6jynHAQcDaWcUu1XoJ+gZf0+8hU3bY04DZWkP
	 9KAmAkQRaDHBmLL5bDjouHMcY8xZO0WEC3Cb0S9H98P+/LHa8v9IEO+oOkypll3Wb+
	 rFW8PqppmrwtWqv+s+tfcAogI2hzKgtE+i1qTG4p0PDviakqFtb+rQTNgRpI+uNzT2
	 YBTKj6lh5RN1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E1C380AA67;
	Thu, 16 Apr 2026 17:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/3] github: Add YAML issue template and
 btsnoop-analyzer workflow
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177636060555.3324412.4472228454911439331.git-patchwork-notify@kernel.org>
Date: Thu, 16 Apr 2026 17:30:05 +0000
References: <20260415182210.514686-1-luiz.dentz@gmail.com>
In-Reply-To: <20260415182210.514686-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 Apr 2026 14:22:07 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Replace the markdown issue template with a structured YAML form that
> includes fields for description, reproduction steps, btmon trace upload,
> analysis focus area selection, and privacy consent checkboxes.
> 
> Add a btsnoop-analyzer workflow that automatically analyzes btsnoop
> traces attached to new issues using Vudentz/btsnoop-analyzer action,
> posting results as issue comments.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/3] github: Add YAML issue template and btsnoop-analyzer workflow
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b73ba12b0bd6
  - [BlueZ,v1,2/3] github: Make result posting robust against action failures
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ec6940c1a284
  - [BlueZ,v1,3/3] github: Add btsnoop-analyzer slash command workflow
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ce07e906e499

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


