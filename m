Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32EB54BDB
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jan 2024 18:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfsDvNIg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75454C433C7;
	Mon,  8 Jan 2024 18:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704736824;
	bh=lXFczle222oReBxrnFWl76XTuyq6q9IJR/m9rPKmqEE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RfsDvNIgXGtDdmIgMUk5BOrtYlZ6Y0zt5O8MWlXy113GVGYB9UukAjd1M2/27XzpM
	 HTdW9YGUPD6F5SjTVPJGUHomh7b+/tuH0oTRcJH0cFahke/lRkYanpphWFRFNXc9yl
	 zxMYDoE9x03daZzcIMSZnodcSn3Y6jXWL3Kieq+ACjzEJHktNRZLci7f95Ebv4wn7j
	 4Fc2dpoPklyL6EouA5lgXt3LoysfUzckSBsftIpWxrde37f77c3/rhTVAzPMTc7jR0
	 DS5bLWjchxMLYSiKA/5qRKqcrFRq6kmtYSR4/f+NoYsp9MabDIZ8cbQvHYfS1lBYmT
	 XL9AP0yNvYNAQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 544EEDFC690;
	Mon,  8 Jan 2024 18:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix accept_list when attempting to
 suspend
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170473682434.30343.4706210275241538867.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jan 2024 18:00:24 +0000
References: <20240105161042.4179775-1-luiz.dentz@gmail.com>
In-Reply-To: <20240105161042.4179775-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  5 Jan 2024 11:10:42 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> During suspend, only wakeable devices can be in acceptlist, so if the
> device was previously added it needs to be removed otherwise the can end
> up waking up the system prematurely.
> 
> Fixes: 3b42055388c3 ("Bluetooth: hci_sync: Fix attempting to suspend with unfiltered passive scan")
> Signed-off-by: Clancy Shang <clancy.shang@quectel.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_sync: Fix accept_list when attempting to suspend
    https://git.kernel.org/bluetooth/bluetooth-next/c/0bcd317e8b31

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


