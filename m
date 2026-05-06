Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E2F302756
	for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2026 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074263; cv=none; b=rGFusuJgLG7Y5SfC29UCmEd9K31Ki03Epqlu+4S32pO/O8r4VWHB8Fg8kSzSMAH/vGV3TpVqbeReF3L9wjl3XIsppBCIxzStJjbgl43xkbpxaR5fuLccvbR8cTs986nBO4VW7802pQC3epm7BPNaHo0Hoh+caIpju6T+U4BHO18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074263; c=relaxed/simple;
	bh=ldIPVri/YJuXYjDHMw7l2qX6SDUd1Y11x1J6W0baD7M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dcnBLw1JqZeD1aXuk2+fyZLT4Hr9jB1zCHin/1aXnTmpehEEAwMQAI845UnsSBVlt4x9GOfmnXaY/gs6orFRx4DLavsrKGxFt25+91Ep5+IuG+MIeKkJB2btLlYI9jG/QEtoQ9tZ57hdyHECMHFQjQqnLhqdGLT02Ecd1StyCGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCJyuZn9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCJyuZn9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D161C2BCB8;
	Wed,  6 May 2026 13:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778074263;
	bh=ldIPVri/YJuXYjDHMw7l2qX6SDUd1Y11x1J6W0baD7M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hCJyuZn9fYSKYqfCDzueBncDIVFvwHXNC2f69m10QRIARHb+p4hPBloKQzEFUSdFH
	 1VxkjqTRXfPoBolrLyxi90sGDKR+A/sUfzRM0S0sOEho60Rq+kA44MgOl7B7t2flFK
	 niIWLAU34FkT+kKNnh4q5hkwFpjU0GchWeCGeocGqlR4LVjTmrUNZ/5w/4U6hzMtPq
	 owuWWUwjSuhaf/r3GRzSr3xKHTjkHyUnpbAA6oHleQuXoP1SW7XS+OQodufC5/EXmc
	 u1tV1n5BtB2F3c4G6ZB3Jfc+sP1Bh/h/y/Mz9HMOKHxJ7OnrUXrzrybjkTmYfPYg7E
	 DZ8FHlQpzucHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FBAD39307BD;
	Wed,  6 May 2026 13:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] hciemu: Fix crash if hciemu_client_new return
 NULL
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177807421279.2587487.345427828196481374.git-patchwork-notify@kernel.org>
Date: Wed, 06 May 2026 13:30:12 +0000
References: <20260505201548.1328953-1-luiz.dentz@gmail.com>
In-Reply-To: <20260505201548.1328953-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  5 May 2026 16:15:48 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The following crahs can be observed if hciemu_client_new fails:
> 
>  Invalid read of size 8
>    at 0x12DA79: queue_get_entries (queue.c:356)
>    by 0x118434: hciemu_get_client (hciemu.c:277)
>    by 0x1184A3: hciemu_client_get_host (hciemu.c:301)
>    by 0x11536B: setup_powered_common (l2cap-tester.c:1452)
>    by 0x11568E: setup_powered_client (l2cap-tester.c:1491)
>    by 0x1324C6: setup_callback (tester.c:500)
>    by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
>    by 0x48A33FF: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
>    by 0x48A36F2: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
>    by 0x133868: mainloop_run (mainloop-glib.c:65)
>    by 0x133C9F: mainloop_run_with_signal (mainloop-notify.c:196)
>    by 0x13325F: tester_run (tester.c:1085)
>   Address 0x4c1e388 is 8 bytes inside a block of size 32 free'd
>    at 0x483CA3F: free (in /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so)
>    by 0x1187BF: hciemu_new_num (hciemu.c:437)
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] hciemu: Fix crash if hciemu_client_new return NULL
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6aa7f5b4e022

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


