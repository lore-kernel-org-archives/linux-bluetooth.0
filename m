Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110DE1DDC13
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Dec 2024 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935814; cv=none; b=BQhy4UzrAfUvNSx4v2sxt8xIUjVDgjV0opqxE5k4fUlvTW/Colpr+MkIJW1CjUaLwgvLo9PrenCop6brka+cRcqIux+xLeSmo07MYNszHxMCNOMDHyOv8awZhWucevO4/r+xaE8WCUOrD81N0yc8kJCmg7QO28ECYByi6iHGi6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935814; c=relaxed/simple;
	bh=WFrPWlxF+/EIGDHasOqkUN+DJ0go95DwDfEIupggg2U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VkgUaa8wjZf4D9EKfD1y9smY3VHLlj/GMBW1D6cARqpw7pE2Is6OgBWe9raXT4lexDHlQJb/d1LVBLNmDe5RBK7Cyr6OhcoFh0paIi4SivHK/cAbd9gU5F4nESmxRD6G1pStQF9tapgGkvntsblCD1yKmJYbgLY2ZMVbR5UVww0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoTKshw9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoTKshw9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F1CAC4CED2;
	Wed, 11 Dec 2024 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733935813;
	bh=WFrPWlxF+/EIGDHasOqkUN+DJ0go95DwDfEIupggg2U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IoTKshw9/obxW7JuSIR4Tka0xQNCztrSWuOsM74mZgejXk/seCdSRyyMGd8ppXzI+
	 CLSEnNpKp196FY2bQPqEo+s6rWYpEjI50bsuSJz2V70kdUOt4wGYbpJTgqLkS1AMW0
	 yvTGbNsrHIORjkZPPd2esA1VyK6rTfsnf5W/S3ss+qLPdrpUs5Ut7/WoAP7UDkVZs3
	 Vmp9tHvdHJrbQ14CKXQxW6q7BBOC3p+iEdtJ1qkF4Qu8iw2fdL9MipOYc2sNUyVTK1
	 3E+480sOPw5m3j+RBeMY0jvCwn5OVoPUk2+Ya4pqRf/V9Q6dMZ6zqaPSqCoKenCwoU
	 g7XV8/GZT90Jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0DAA380A962;
	Wed, 11 Dec 2024 16:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] Bluetooth: iso: Fix circular lock warnings
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173393582977.1641618.7929367338783966663.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 16:50:29 +0000
References: <20241209094218.4939-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20241209094218.4939-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com,
 luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  9 Dec 2024 11:42:16 +0200 you wrote:
> This patch fixes the circular locking dependency warnings in iso.c,
> caused by A->B/B->A type lock ordering with sk and hdev.
> 
> The first commit fixes the warning caused by iso_listen_bis, by
> releasing sk lock before entering the function and acquiring hdev
> lock.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: iso: Fix circular lock in iso_listen_bis
    https://git.kernel.org/bluetooth/bluetooth-next/c/c9f33b7cbdb3
  - [v2,2/2] Bluetooth: iso: Fix circular lock in iso_conn_big_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/ea4f8778d364

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


