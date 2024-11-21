Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55FE19C555
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Nov 2024 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732208425; cv=none; b=S5cZbzXd/lP9+FkOaPgmJEk/S0IE3xg/vmz+Vu8wrICL8iODN/P/LkDGl9wOF11ak4i4NhkgUdV8Voyp6U9pnR4a5qca3/AOem9tuQRGcFrS9DOir1EsmOqyHw03yLA0E8yLjH/32RktAX1VWpnP/37UQ7KphXXa37y8WSTJMJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732208425; c=relaxed/simple;
	bh=WabpNNgjO0gH77c61IzM8sgPIvxF+LgGJZFVpPnRAk8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GBnGbYBVr/edMGXGq2wGLGm47VvXUzy9n52um1rJrXycx2LdThBsMOfPW9H/VSYaCw4BHTEBGRPu/dkWoXsOfCeVs12ngGgTEz0v3kLcIEpISM0MjoZyuY0tfNHgvVC2r0WSF+SAjdGS/sdQwTZwrQ38ic8nSNFaaqlbgZwFKGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJRPZU+m; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJRPZU+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C261FC4CECC;
	Thu, 21 Nov 2024 17:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732208424;
	bh=WabpNNgjO0gH77c61IzM8sgPIvxF+LgGJZFVpPnRAk8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NJRPZU+mmZ9YDoWxGGZdE2g8TwLlLt/v/8MoEW1dePAe7+3UrJMOcOcDAu+ZnTsnF
	 QAUuldaZzPCkig99Tq2mxoYuTJfG4VvZ6q3i4wjlAOrckRfObk3N0+OE11ThGe/EIN
	 Z8vyig+XPJ1swUY4cMjb5PoZuWEw/RZ3hoI8JTeNKxg7N8qmXZLwGnjqXwXnzDl6iN
	 TpeJskSufvdHDzKr8+RjgRHYwcrq8/IdDGgIqFA2Tm4GUly9HHD+Zve4OlVVEZfv/x
	 I2/rH3E6PTFwGJv8QYycIc7q4RRaI/9wFRxV2FtVdnQ43cbA3e3jmV/ag2LVdZYnug
	 EsGPSUuc1jdGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACA33809A00;
	Thu, 21 Nov 2024 17:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] Fix for broadcast mode,
 not to add any AD flags in advertise Data
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173220843649.2009966.5299635694613469576.git-patchwork-notify@kernel.org>
Date: Thu, 21 Nov 2024 17:00:36 +0000
References: <20241120154755.1951-1-quic_prathm@quicinc.com>
In-Reply-To: <20241120154755.1951-1-quic_prathm@quicinc.com>
To: Prathibha Madugonde <quic_prathm@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org, quic_mohamull@quicinc.com,
 quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 20 Nov 2024 21:17:55 +0530 you wrote:
> From: Prathibha Madugonde <quic_prathm@quicinc.com>
> 
> src/advertising.c
> Include check for broadcast mode:
> AD flags shall never be set for broadcast
> 
> Test steps:
> From DUT, bluetoothctl go to menu advertise
> advertise.secondary 1M/2M
> advertise.name on
> advertise broadcast
> 
> [...]

Here is the summary with links:
  - [BlueZ] Fix for broadcast mode, not to add any AD flags in advertise Data
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=385f0f357d98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


