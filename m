Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB0C264A71
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911788; cv=none; b=lBG7AWG41bmm0f1ffGhAHAZFJYWHe8HNFpvvYDti/VVAlDyKG5JgJ/+unUVA89S+zLlqPoLBZ3bHHHm3sWBuEwe/l4/9gWQVEEG/k34hgd28+qfCIc2ouVvoF1OfMlyvhS0cfUCHLftGEi0RAWwlC0wP498rTvTgah6ZG2Gfb7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911788; c=relaxed/simple;
	bh=YjjFULAODu1pKIPp0ihS8j+YG2WFi0jp2iA+gytdWLo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=itOYVo3O3XxzwPDOGu7q51zboKtx09QoqlmB0EO62HO5R4FkCASIZBkMsgB284K0ZhtLmwGv16MQrZDdc2ntULgYzOWsyJSmD/TMrpFzMDloq7NpzLkoPfKHJVTNZAzPZsMle84IRBL7MNMeiTfK5G/Z7h/wskyUN3WBfUtkEk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dA+MJrP6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dA+MJrP6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EAFC4CEE3;
	Mon,  7 Jul 2025 18:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751911788;
	bh=YjjFULAODu1pKIPp0ihS8j+YG2WFi0jp2iA+gytdWLo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dA+MJrP6oM/FZ7OYShELnqZgQzMRuF6DV6ViP1jAej3VN2OQn/H3yJJNfboSuEzz2
	 wqiuczg0RKO55xsQ9K210FciWVrQFdAv4uoHF70LN/i86VBjpGnGI5i4ifRqIsu2cX
	 +Cea2FQKDL6aYs5MmTTPYEZvBeMSZCzjNN84O46t/Nb69gKlFSr9AMHCZvsG+s2x21
	 jwTtXblp4f7PUGIJ7YNYRM00RyLuv3ePvSKbPgc24cUrupLUpTHsPJmoxPr+4Piity
	 h+Fgdb6IAZjy3LUrpXpe6DMXgndJBjvkJsB4imONo0Liy3Z0PxMWopJ0f1TwvDS4Vm
	 otGb3oX2/kFhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE323383BA25;
	Mon,  7 Jul 2025 18:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] Fix double free in obexd/client.
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175191181124.3378325.4493638428859276505.git-patchwork-notify@kernel.org>
Date: Mon, 07 Jul 2025 18:10:11 +0000
References: <20250707145242.2356210-1-i.iskakov@omp.ru>
In-Reply-To: <20250707145242.2356210-1-i.iskakov@omp.ru>
To: Ismagil Iskakov <i.iskakov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 7 Jul 2025 17:52:41 +0300 you wrote:
> This patch fixes double free that could have happened
> when 'contents' in obc_transfer_get_contents could not
> be read. The second free then would've occured in
> image_properties_complete_cb at the end.
> 
> Ismagil Iskakov (1):
>   obexd/client: prevent double freeing
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] obexd/client: prevent double freeing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=be8c031baaa8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


