Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C5E299A8A
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jan 2026 19:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767641608; cv=none; b=aF/Zu3da51sa7gnwHIylQjEEUSJeCC3iqo2uPWXqlLpbfsohHijrKnNkMI3vzPeZjHQbvXFhDahyr/+ebi9PfhP53wa+ldyZxL2dS4Tr4We5R2E55fcHTCjMkkJRLKzIQgljdrDJszG/bm/UjPcip7kOc3LtlsqZM9H1JzaSo/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767641608; c=relaxed/simple;
	bh=8XX70FBM5uLfO9vbDjZCo34RrtUmVlYyvBj+bwHHTPs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LMmhnwnespJfvdgzDG2sXOEkb8Api571CxazKQBYVjQa9ISijdq5d+4oPNPBsikyyKwmHhHCF0yMG0HS2gRluW+E3t8L0izbKIqs6EJI934/fizNzw4JnHebaOse8hZ1+gjDpvmGYWfCKZDKVzzJx5Rmlv/2hAPYDAGL1d3Aru4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktPYCjge; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktPYCjge"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2C2C116D0;
	Mon,  5 Jan 2026 19:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767641608;
	bh=8XX70FBM5uLfO9vbDjZCo34RrtUmVlYyvBj+bwHHTPs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ktPYCjgendrFbHybB0EcrvcNW9KzShDubptL4IYG03DSAwy+EvBppFbPEWUaFdDiy
	 YZAccTlNQd8kgv+FZDbcN2A1tGwfNdI9EEGp5XhrUza26UB1TG2Q2ZvGuknu572FSz
	 auwRWMlKrvitl6FBQb9AjtrC7naNd2tzxleDj7iiKrseprL9A0mmWNlx9aVURmSzXU
	 1In1+8qpg61qNemMfi4FjcNU1i1SMWtzTGTh9CsrrXbijo0qXMgsLxNvh4d7GbDEdT
	 fqwbTYXGXHyoGWYJ86jyQ6sa8Avq+wmUrjo7uZP2B3PYfHVA5fybbMPYJxftAhH008
	 Z61qRdSZY5bBw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78873380A963;
	Mon,  5 Jan 2026 19:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] bap: remove setup from bcast_snks when freed
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176764140604.1271388.3053360374766258099.git-patchwork-notify@kernel.org>
Date: Mon, 05 Jan 2026 19:30:06 +0000
References: 
 <968496f3bffd44598c7dde7460a4aaa38a7916ff.1767092564.git.pav@iki.fi>
In-Reply-To: 
 <968496f3bffd44598c7dde7460a4aaa38a7916ff.1767092564.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 30 Dec 2025 13:06:09 +0200 you wrote:
> create_stream_for_bis() adds setups to data->bcast_snks, but they are
> not removed from there in setup_free() which may cause double free in
> bap_data_free().
> 
> Fix by removing setups from data->bcast_snks when freed.
> ---
>  profiles/audio/bap.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] bap: remove setup from bcast_snks when freed
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c8fb53f49cc6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


