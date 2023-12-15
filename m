Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB6146458
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Dec 2023 20:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y94JjWoc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EABBFC433C8;
	Fri, 15 Dec 2023 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702673426;
	bh=a7i8tUMVvagOBq1tPuayHs4ucpWiPgU4IR/Rcj0qGbc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y94JjWocpbc5nj0ZlZIPz9SCOVH6Xl6fTohvqwnLORrNsbDIhSbbUIiFxPAeV75Og
	 PDREvBJ63/guS9AcyOhsMHAVw3X8OGptA3IU9TaIxLhzyBFXX18XqwBMRXHPy13xOj
	 EPBbBgmc2MD0Sy/kjJtRY3UDVCgmdMVrzwJ4dI5W+6ywWaFg8AGwT89FqguljLGgBT
	 kp7JM5XKjq3O6skmcREEvkIz7jVyYU3lw4D3dEwYXpNEjErd9Ciou5pQs/QB4oUpms
	 73LeyAqBncfl5GqfeGz6BGfw3EpNSklrZtCoByjgBE8N7+tpMhn3e2b1EqqbM1Jaav
	 cFqnmW+//1Gbw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D58F4C4166E;
	Fri, 15 Dec 2023 20:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v6 1/6] bap: Allow setup of multiple stream per endpoint
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170267342587.29572.7392825145043897455.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 20:50:25 +0000
References: <20231214205556.1320286-1-luiz.dentz@gmail.com>
In-Reply-To: <20231214205556.1320286-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 14 Dec 2023 15:55:51 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Remote endpoints actually represents PAC records of the same codec and
> their capabilities are merged together thus is should be possible to
> create multiple streams depending on the AC configuration.
> ---
>  profiles/audio/bap.c | 616 ++++++++++++++++++++++++-------------------
>  1 file changed, 345 insertions(+), 271 deletions(-)

Here is the summary with links:
  - [BlueZ,v6,1/6] bap: Allow setup of multiple stream per endpoint
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=511d58b06c63
  - [BlueZ,v6,2/6] shared/bap: Make bt_bap_select match the channel map
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e7e8b2a3d7ca
  - [BlueZ,v6,3/6] org.bluez.MediaEndpoint: Add ChannelAllocation to SelectProperties
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=07efa6d35b26
  - [BlueZ,v6,4/6] shared/bap: Make bt_bap_select select a location
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4bed5da57861
  - [BlueZ,v6,5/6] shared/bap: Fix stream IO linking
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4b5b4f0767c6
  - [BlueZ,v6,6/6] client/player: Use ChannelAllocation given on SelectProperties
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e01208dac67f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


