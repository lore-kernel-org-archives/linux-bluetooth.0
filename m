Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4448923768
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 May 2024 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716390635; cv=none; b=txvCcMgbt5hO4EEB6x9myKSF6GRg67a202kUewf+XooBEmWhgRQg6ftIPo12zz0ISnaHyXlxbaAGRcsdQh0wuQF/NhEM0BzrfTrX7ED4hrrm9MLjdN4YgFevffESbButkXH1BGRIPgTeg4wRKbe6HbQ3nhpoTELDTBq9P26uHBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716390635; c=relaxed/simple;
	bh=+W80W4elzK4Fe416eZozsMZu/ZBKMeheRnHxN/ypGMQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HX5zZN/s77d3X8wkmPbOKVQ+Odr5Dn+N9dgmkVfDciQjSIG+TYLVh3Ug7t60eEugRNQJyQX4fR11Ccjqfcvvknp58H9SRyHoV3XWWHA7WPgMfC9JG7CCQYqWWoXVudSP0Prpd5K7VnXnRZnNwcmelwMQWuBBOMwQSgX975Ahz7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfKp9MlR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfKp9MlR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABDBFC2BD11;
	Wed, 22 May 2024 15:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716390634;
	bh=+W80W4elzK4Fe416eZozsMZu/ZBKMeheRnHxN/ypGMQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WfKp9MlR7f1vvzy3aFh/ErCG6jlAtR1XGJGb84thS8loXAYDyw6jKgLfj3KHYUJXs
	 3P4AuJyhwn3DnWADtrvOW6LObzApfbCibXKN0fXATmz4g9LGW+MonmUg5k2hhYsP/Q
	 B8GglgVf/CpjGLPDp5VfZnWrIy7Mt2WFT6wzJcsn+2kBDqn/MiidDYIajnMbBuAS3K
	 mkaMIGH1UQYpI7GPck412SPLo8gTZM/IUMqqZzWuUerMPlF9tIe6GVfVCYmwMlBkBa
	 kxYvjWKY4h5v6haHz3YHdrQPsGTqrIm2TyRZq/Y0LxLjC3vboJG4gMZHWv0d0RX6o5
	 esMl/0sE048kg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 987BBC43618;
	Wed, 22 May 2024 15:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Fix rejecting
 L2CAP_CONN_PARAM_UPDATE_REQ
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171639063461.16391.13686459383800557979.git-patchwork-notify@kernel.org>
Date: Wed, 22 May 2024 15:10:34 +0000
References: <20240521143521.1568672-1-luiz.dentz@gmail.com>
In-Reply-To: <20240521143521.1568672-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 21 May 2024 10:35:21 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This removes the bogus check for max > hcon->le_conn_max_interval since
> the later is just the initial maximum conn interval not the maximum the
> stack could support which is really 3200=4000ms.
> 
> In order to pass GAP/CONN/CPUP/BV-05-C one shall probably enter values
> of the following fields in IXIT that would cause hci_check_conn_params
> to fail:
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: L2CAP: Fix rejecting L2CAP_CONN_PARAM_UPDATE_REQ
    https://git.kernel.org/bluetooth/bluetooth-next/c/a3975db95fcd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


