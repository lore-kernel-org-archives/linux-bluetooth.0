Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EB63232
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Nov 2023 00:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f1N5PGIZ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 992BBC433C9;
	Wed, 15 Nov 2023 00:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700008223;
	bh=JQoqQPv4wsFbx9yVWrYKApXuD5SaGD+ZSR0cG1fLv+k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f1N5PGIZuwCzzp4uHESmhcu1Nt7fF3PZ6LOvE2ro3QP4Bdm9kvBRZYe72kZ7itmYV
	 EeJd39bn7wrHgRrfB+Cvpo0aEbLVtNA5bfK/kAU9imBjsAZ8Bb2ARr3aImPcWoRE31
	 4b3c8LosLR/fKz0nZ/0PxNEqVnx8+UDZ0VKo8zBcthKZIKj86xCM0PsgnvpU/7ebDf
	 NAXLt6kGd/L544GnwAuB9snt0tWhR2+vR8+8/WuZb8agNMSxPV7ve3NXLqVWqeaMi+
	 Uh0pRuMwRsZFk1nKblu4CgEtc/I2Ja/hTsljtGvhX8zwMuarE7LsYJXgbevRRl90aW
	 VqUn3YD9iRpWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7344CE1F67B;
	Wed, 15 Nov 2023 00:30:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] bap: handle state transitions with old_state ==
 new_state
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170000822346.23786.1390579434951329167.git-patchwork-notify@kernel.org>
Date: Wed, 15 Nov 2023 00:30:23 +0000
References: <e8a45a4796f024825318996d68d1b92ebcc9b04a.1699652713.git.pav@iki.fi>
In-Reply-To: <e8a45a4796f024825318996d68d1b92ebcc9b04a.1699652713.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 10 Nov 2023 23:48:19 +0200 you wrote:
> ASCS allows transitions from Codec/QoS Configured back to the same
> state.
> 
> E.g. NRF5340_AUDIO devkit starts in the config(1) state, which is
> allowed (only Config QoS, Release, Enable, Receiver Stop Ready
> transition are client-only). In this case, as client, we do Config Codec
> ourselves and end up with config(1)->config(1) transition.  We currently
> ignore that event, so QoS won't be setup and transports won't be
> created.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] bap: handle state transitions with old_state == new_state
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8b035b70f379

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


