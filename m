Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D78A1386C9;
	Thu, 31 Oct 2024 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392228; cv=none; b=aYQtr/NMP68OHWip+cyEXEQOwRv4IVqAfgxO3LZ+ouC6CN8elZSxcrhrhJChNxcB++cGHhG6rT/gA7zdoWCjm6fqGro8/NbWumfjM2+MTz8GYfx+n/2WJnzSet6pQsny3o8Irz3F2sK9qh3xiqfpzF+dkdfTEpe4d/ELGYxuUBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392228; c=relaxed/simple;
	bh=+IzlIjqFPuhGJb0L7uRmVbeC8XXMUyldZTLzoEfuut8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QS58KIhfQd3IuCv6UgNxEVxfdXdRqEkfFiQPMaqcFQCfxbakbDDbxqLQqQofWwuZkFjG2kEDh8JOs5MyiCk5bvrAcWHCggcVnqDEFtPMTk3J1KYQddug7WQAql9zYjt02D4TRkpN6mbR0sdNFomFPimBHtpC7XjSKk/XNnXtj+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZSZ9RuQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZSZ9RuQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935F1C4FE8E;
	Thu, 31 Oct 2024 16:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730392227;
	bh=+IzlIjqFPuhGJb0L7uRmVbeC8XXMUyldZTLzoEfuut8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BZSZ9RuQe9JW/AENoCTfdSrt5QBvLcX3+3AmnSC6Pyw2yh8mXVmx/b0SGkflpBe4h
	 UG5/24FlsV3FVfSHRbnqkqgHlEIN0e9gLEOFHliR0KvO7pD7PPAu8J4nXXNN3KGLYB
	 oa944AgQH8OA1sKXEQslawjnMIiegpahHWCnURAGg+scxmz22rE8/Ljin12mX5Bgyq
	 chbu1NzYm9W3V9T/teGauRvqm0jIiv+HAk6VxpItYagy2h3NDJ4hyr90fGWka4zsqE
	 8SubDe9aUBdILOQAT0URFUMTO9oT4n2sp4459sN0CT53iQj981LtuSfXsls7F+e1c7
	 XEFModjHGPkZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEE2380AC0A;
	Thu, 31 Oct 2024 16:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btbcm: fix missing of_node_put() in
 btbcm_get_board_name()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173039223552.2016510.7048692457778826183.git-patchwork-notify@kernel.org>
Date: Thu, 31 Oct 2024 16:30:35 +0000
References: <20241031-bluetooth-btbcm-node-cleanup-v2-1-482d52910bfa@gmail.com>
In-Reply-To: <20241031-bluetooth-btbcm-node-cleanup-v2-1-482d52910bfa@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linus.walleij@linaro.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 31 Oct 2024 13:11:23 +0100 you wrote:
> of_find_node_by_path() returns a pointer to a device_node with its
> refcount incremented, and a call to of_node_put() is required to
> decrement the refcount again and avoid leaking the resource.
> 
> If 'of_property_read_string_index(root, "compatible", 0, &tmp)' fails,
> the function returns without calling of_node_put(root) before doing so.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btbcm: fix missing of_node_put() in btbcm_get_board_name()
    https://git.kernel.org/bluetooth/bluetooth-next/c/6ef8bb9d0bd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


