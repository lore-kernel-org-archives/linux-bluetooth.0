Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCE6321A5
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Nov 2023 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sc+KH9Vq"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 498E3C433C8;
	Mon, 27 Nov 2023 15:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701098427;
	bh=0gWqcm6z1IXNEH2fbAVucVlU9bGngv9nn40qZ548Q68=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sc+KH9VqTOdAr3tTbSy9R4OaJXz2oOghPdQltsuTYR6JqrcolXh58oubliAYkIP0J
	 bfYZ9CYpjW51NSfoaCdYDsU/b1KezV3Ry4K6UOzgbZemwL8Lz9Oz3yMstgNhw0lekl
	 rlKPL8aqXFzpPZlrLEsK2UW8D+MtnTDatauRymndWTo7sE+/TDwiYXdtKj/1YnDrLT
	 SifyQnPLU9/CJTUqdFXwuIV/cYoHbr18bw7D13ATyEivA6e6fSuJ3WxIS1YygGYaNc
	 yOWW7IuvGsOQOJMRKePKNHisk7kFr29rWulOY6ZSBQuY+8Hesb5DIN1ZCtNicY4JVq
	 dEZ6KHxnF7vpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 377D9C395DC;
	Mon, 27 Nov 2023 15:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/5] shared/util: Add GMAP related UUIDs
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170109842722.13376.16287175682652212549.git-patchwork-notify@kernel.org>
Date: Mon, 27 Nov 2023 15:20:27 +0000
References: <20231122210727.893872-1-luiz.dentz@gmail.com>
In-Reply-To: <20231122210727.893872-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 22 Nov 2023 16:07:23 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds GMAP 1.0[1] UUIDs following the assigned numbers[2].
> 
> [1] https://www.bluetooth.org/DocMan/handlers/DownloadDoc.ashx?doc_id=576496
> [2] https://www.bluetooth.com/wp-content/uploads/Files/Specification/Assigned_Numbers.pdf?id=3
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/5] shared/util: Add GMAP related UUIDs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e94853608c80
  - [BlueZ,v3,2/5] monitor/att: Add GMAS attribute decoders
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6af3b7290a3a
  - [BlueZ,v3,3/5] iso-tester: Add presets from GMAP
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c9b48a6f84a8
  - [BlueZ,v3,4/5] isotest: Add presets from GMAP
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=506413dba872
  - [BlueZ,v3,5/5] client/player: Add presets from GMAP
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=813e1ce11993

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


