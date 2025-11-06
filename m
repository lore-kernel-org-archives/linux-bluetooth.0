Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FBD2DF14D
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Nov 2025 23:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762470635; cv=none; b=SeURWFXO6VWuwbSSyJFJANBgGZ6p9nUGha+aokrpe4H0nH47zBGt9kCP6HUlcJHhcHhNrFKsHl4tzITJ9JDnw2ASvPCLrap8+PXHp4dxz6yNm4PykC82im4TY1EZ6KP2UtH4snlS5DwdWAvGbnwl9Y59Q3nR/qrMrNWX+T47J3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762470635; c=relaxed/simple;
	bh=jVOSSZKlxS90C1tZH5gkkinlCrPdeHHxkQSA/gkj/Vo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fRT0zPGNk6iSr0EogfQfNRCS9VztemWs9Tjm3EzHbnrTi/H1FGWj5Nre7aKdcQRFbWV5P50U86UeQF5kiuiA/6WyEj0+cQa3b3kSvYgBVxOOt/PH7wE8za8yOUvXWL9q/zIRd5edFse/JhUcIufREqsruZuy3lgOeO3b2X0EsvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsW638ku; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsW638ku"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98B0C4CEF7;
	Thu,  6 Nov 2025 23:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762470635;
	bh=jVOSSZKlxS90C1tZH5gkkinlCrPdeHHxkQSA/gkj/Vo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QsW638ku3oefbX3hdi0nVjOSSr/FUzg69m+Ronvk8kaN5q5TmzUWuwocVQy5fzrur
	 yA7uyzjKI2qY5sLEnV8zYRbRhnC0Mlud1qdNhe/6JqtibSZYapBQTb2J7L86x4U7ft
	 q7qUGeA2OarPDvrEZOCakxCpgAG0Yug7ipD7D3yanXZRfZ7ikmPuUGdFOV40j5RRRy
	 AMwueN276dsNE4aoUtuphEB5bxS5d6W9t8VhoI4QnUuJjByz65s2wRQRFhVjoGzuKg
	 iH0zEJcM/qTUSp/nlhqliy530dCvw22oPmk3HZUHpSEEISel48iByKLqwG9SjvSfLa
	 NXdYJa6hN/PiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE1139EF96E;
	Thu,  6 Nov 2025 23:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/3] monitor: Decode Bluetooth 6.0 version
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176247060849.383880.10203292464827207734.git-patchwork-notify@kernel.org>
Date: Thu, 06 Nov 2025 23:10:08 +0000
References: <20251104142506.12356-1-luiz.dentz@gmail.com>
In-Reply-To: <20251104142506.12356-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  4 Nov 2025 09:25:04 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This decodes 0x0e as Bluetooth 6.0.
> ---
>  monitor/packet.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [BlueZ,v2,1/3] monitor: Decode Bluetooth 6.0 version
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=070ef3d7e96e
  - [BlueZ,v2,2/3] emulator: Add support for LL Extended Feature Set
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7fe16b6dfd1f
  - [BlueZ,v2,3/3] mgmt-tester: Add tests for 5.2 and 6.0 Bluetooth version
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=69e5da687980

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


