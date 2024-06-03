Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4397D210E6
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jun 2024 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717446630; cv=none; b=pjdvUm29oSY6v5T+VTgVC2NN1FsXamxtSLBo6HMMwsHQnAuHpeVrd+Vrb947xMPWlLw4D5a/N5dPcl1GrjkI8ruLgxTJ5F4nJTdIlNJZN30nhVZSllqwL8VEErcSCfe6mb7j90PON4vLZJfTdNg508SyDMHKOPZVZYr3MCdQce4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717446630; c=relaxed/simple;
	bh=D1ZiGfoS1+IQj93pvs39Nd6lYtXAPYUfhA9tF+Mrtew=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tbUvS4WFZi6VsoBJ1AIKVu48bOpHBPEr+cGtvrgp3j765lh6BIgz3Y+XMByZXSw2++XNhOY2uRzeFrB1bSI5Wuf/DI4uTO9h7kx9XodKkZVcwtHgqvkVZO5nLG46m/JUP+ZLA5TgHW2TBPMPpJQlmnaWpQhnujWe6XhEcYmYIEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXXLU/d+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXXLU/d+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC474C32782;
	Mon,  3 Jun 2024 20:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717446629;
	bh=D1ZiGfoS1+IQj93pvs39Nd6lYtXAPYUfhA9tF+Mrtew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kXXLU/d+yIqW806v5+pbBhXf4g2LIuT03Wdl7lCiv9CgDCHLcS11iTXuCgq7fOOFk
	 D+XuUj065YL3Pn2r0zSVF7pTbrkOtQu1xKjjfpreen4lvo5aWLzKz2NDI/6R9QI1p5
	 2XwC2VWSewQn48BfNSiqQpAFK1RsEA7BekgCPlBavB5KK8JZVII02iVnlQF3Ahl+q+
	 +rDXYNU3DbxNi+04sJ7jcOA1Sih7eFNqGg2r27vVAzVEyj4tEM4rr9PqLMsAVqAjC+
	 vqSCmVlFekwa64cTOFUkG6v6cjSNPwoGADJ7oxRfKk3clHtHq0rOSe8P4GQ65s5J+Y
	 OBYXvYtWfh95A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A99CDC43617;
	Mon,  3 Jun 2024 20:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/3] shared/csip: Fix memory leak
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171744662968.24186.1383093484486236770.git-patchwork-notify@kernel.org>
Date: Mon, 03 Jun 2024 20:30:29 +0000
References: <20240603185312.162337-1-luiz.dentz@gmail.com>
In-Reply-To: <20240603185312.162337-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  3 Jun 2024 14:53:10 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following leak:
> 
> 102 bytes in 6 blocks are definitely lost in loss record 660 of 909
>    at 0x484282F: malloc (vg_replace_malloc.c:446)
>    by 0x5A078B: util_malloc (util.c:46)
>    by 0x649162: read_sirk (csip.c:485)
>    by 0x5C74FA: read_cb (gatt-client.c:2713)
>    by 0x5C4137: handle_rsp (att.c:880)
>    by 0x5C4137: can_read_data (att.c:1072)
>    by 0x65DDA4: watch_callback (io-glib.c:157)
>    by 0x49656AB: ??? (in /usr/lib64/libglib-2.0.so.0.8000.2)
>    by 0x49C6707: ??? (in /usr/lib64/libglib-2.0.so.0.8000.2)
>    by 0x496B666: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.8000.2)
>    by 0x65FE3D: mainloop_run (mainloop-glib.c:66)
>    by 0x6605A3: mainloop_run_with_signal (mainloop-notify.c:188)
>    by 0x31DEFA: main (main.c:1468)
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/3] shared/csip: Fix memory leak
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=09e39a7d6dca
  - [BlueZ,v2,2/3] shared/gatt-db: Introduce gatt_db_clone
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7e9816dd8c21
  - [BlueZ,v2,3/3] set: Attempt to use existing set gatt-db
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cbe4144dea6f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


