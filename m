Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D969F3A4519
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Mar 2026 15:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772809806; cv=none; b=bVcp7GTFBVP7tn4aM0C2ryVpsL8z555+1xivAPmguaHBOH9X3fjU+Vxzzu4ap8LV1Xb7w+FZJGAS2fSIa/3V3y81sHiBKkWBkJcaD8RroUoS8a1ap5Bl9nZtMQWZn7SMTp0rxgQ57clUpnW0hEid/iJBOGDsNJdcViTEXP6Lp48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772809806; c=relaxed/simple;
	bh=s13SbSnL6pi72yBoVi41y8V+92OUkGYVKlXnNfmzSxs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TNMPGHL8XnGYH1X2jZh+hSTloOxZrIql6OcHqwXga8mM+ccNnrKgnmOyD3waGumO8OO8T3zzR5HQ5Vx6nWO9lL54NRuwVLR8UhyRisxT3SrDCSBSOV4vxqi+w4Z/DeM25f0Epbx1bfK7nXHPudb20QXmId9oujvlu4GrpriblgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tID2KumI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tID2KumI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FFE7C4CEF7;
	Fri,  6 Mar 2026 15:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772809805;
	bh=s13SbSnL6pi72yBoVi41y8V+92OUkGYVKlXnNfmzSxs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tID2KumIAfp2UJK1GvoJVqpWmAqqQAdspbCemO6lD5zB2xvLE062GejaEu1tPdyaw
	 TbYQNDJ8j1lOyTAS4gNL4+4sHRgpUrYWxVq4shzwHEEeym2KHQdqgbMqfsljbAF+pD
	 MSjQh6HvZR5vJ+o6z2VKesouqKBmj5pa0hVegOv5U1DDukwJiyQp9auMyeFD8vCJSv
	 nkNGrQjQyb99bSX2p1tpysELXbbu4tW7xx05WdQdO94EV8i7TcRiOmr68aS8OQSbiC
	 s3AHEe0Jv/bc2qay6JAxH+UVgqaRrc8rqrDQ9J4ZhIit+I8ZmHHPh0VZJ5/BpqqgW8
	 yhBgxxW4dcB2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FA43808200;
	Fri,  6 Mar 2026 15:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3] client/btpclient: Add GATT support to get Device
 name
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177280980455.3708258.3926582645716607139.git-patchwork-notify@kernel.org>
Date: Fri, 06 Mar 2026 15:10:04 +0000
References: <20260218085206.498756-1-frederic.danis@collabora.com>
In-Reply-To: <20260218085206.498756-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 18 Feb 2026 09:52:06 +0100 you wrote:
> Add GATT support to btpclient so the it can read the "Device Name"
> characteristic (UUID 0x2A00) from the DBus interface resolved during
> device connection.
> 
> The device connected event is postponed until ServicesResolved property
> is set to true to ensure that the services, characteristics and
> descriptors lists has been fully populated.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3] client/btpclient: Add GATT support to get Device name
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8d82d3e1e539

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


