Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A937156256
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Apr 2024 19:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713210627; cv=none; b=T9VLAB2RhssNNAfOddjIOh08jC4HqoIrDW9v7mfTdTyCJUpgdShTq2oqnDde/LFrOWbXB6x3iHbm8s6w0sTQKQkulJa07Izecaf8lp/T2kCyo5tWGvapwOnKKxsWz/Y2CLg15EPC5Cu69vO2kY/Yo+Lu2sjc0L6UyWDUYYgrmSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713210627; c=relaxed/simple;
	bh=ZqhBKaDpU1AurItmL/clZv1xvGdMlNCyHDHK4YLrOjw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Oq7aMDClxLc/CQfD2riDNybAXaCUMGNBSsArF9NGes/vDk7Zurj/4MEbUFOpzKQi/lsoxpr7ji8XsZgSAV8LU3bz1gfSIdaw5/0/HR9mogvgTJtB1MdUcqvzMITRmDGGpqKlrZnIzY1htMKR85Y6zLHZHN39qMSytelROnvG+UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Juuv5K+T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Juuv5K+T"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9A9AC32781;
	Mon, 15 Apr 2024 19:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713210626;
	bh=ZqhBKaDpU1AurItmL/clZv1xvGdMlNCyHDHK4YLrOjw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Juuv5K+TNyMoHumKJQa1kHre3VfUI+oztjhb+JKM4H6O1Tyz1tYPTkfMq9LNEXTqF
	 E/jwjN/gEwIgA982UzaW5+qD+TKLebbIrc8veFfgOGduFWZfb424mkXimsZzwwpQkR
	 RuLir58o6DPS8MKYvdan3mwDe6gHxpKbpcdtFGKThTLPVAkDRkw72Q3iahBZmjpvZZ
	 qH+k1twxs6j5r7M6Aby+aF15fHhVza60i21yxhBOXHTIP6wOsD5IFhFhb7dRfLtvQM
	 XLdzFyp5ihPj7PkAIdTtwWo1sqEahwk77t+Nh7fsUQYK3dTe1G4CdvZpiRQD9ARwDe
	 vzxzwGVUoSESA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7525C43153;
	Mon, 15 Apr 2024 19:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/uhid: Fix crash if bt_uhid_destroy free
 replay structure
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171321062687.2386.3115334938013550773.git-patchwork-notify@kernel.org>
Date: Mon, 15 Apr 2024 19:50:26 +0000
References: <20240415145444.857497-1-luiz.dentz@gmail.com>
In-Reply-To: <20240415145444.857497-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 15 Apr 2024 10:54:44 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Id replay structured has been allocated it shall be set back to NULL
> after calling uhid_replay_free otherwise it may cause the following
> crash:
> 
> Invalid read of size 1
>    at 0x1D8FC4: bt_uhid_record (uhid.c:116)
>    by 0x1D912C: uhid_read_handler (uhid.c:158)
>    by 0x201A64: watch_callback (io-glib.c:157)
>    by 0x48D4198: g_main_dispatch.lto_priv.0 (gmain.c:3344)
>    by 0x49333BE: UnknownInlinedFun (gmain.c:4152)
>    by 0x49333BE: g_main_context_iterate_unlocked.isra.0 (gmain.c:4217)
>    by 0x48D4DC6: g_main_loop_run (gmain.c:4419)
>    by 0x2020F4: mainloop_run (mainloop-glib.c:66)
>    by 0x20254B: mainloop_run_with_signal (mainloop-notify.c:188)
>    by 0x12D6D4: main (main.c:1456)
>  Address 0x53ae9c0 is 0 bytes inside a block of size 40 free'd
>    at 0x48468CF: free (vg_replace_malloc.c:985)
>    by 0x1D8E19: uhid_replay_free (uhid.c:68)
>    by 0x1D8E19: uhid_replay_free (uhid.c:59)
>    by 0x1D8E19: bt_uhid_destroy (uhid.c:509)
>    by 0x1591F5: uhid_disconnect (device.c:183)
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] shared/uhid: Fix crash if bt_uhid_destroy free replay structure
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b94f1be656f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


