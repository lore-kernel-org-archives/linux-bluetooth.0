Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA3253387
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Mar 2024 20:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709326231; cv=none; b=KesfoXqa5l6EzF1QIgKw2J2D0EjC+psP5ahif6xirNEZ0QTM2di9LSOlUlH4xFLiYAwGVBu4jak3RUwD2AMObtswvZHbIEZJGEcZjtRKeD6cYF0Z7hLeewgvhoEsvFa4/aPVmU1rvVcXw4Xn9DGfH+CvlWDn/9UsExOk8zdNlhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709326231; c=relaxed/simple;
	bh=vMHvvjIGNjRXSpoBJE90jxtUemciKmETEpBUUhXeKZQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=er6rfPp8oefSg3ECpsJ7kzqWhOzf8miOdQNqI1Z+c1X6NXiDf70w/+5wGcNvCsI5Pj9c4iIoTViYyaUgWnH+2Z2e3AcqlK8aDZJ4t9SBDrNqNCtox4Ukn3rLbYGZ8a2Xi8tiRj1XaIIoQ3/kS75zOKPU9fM3k4nV37h0n74h0/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRf0sYRl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRf0sYRl"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4412EC433F1;
	Fri,  1 Mar 2024 20:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709326231;
	bh=vMHvvjIGNjRXSpoBJE90jxtUemciKmETEpBUUhXeKZQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vRf0sYRlX8WeoxYwdy09kMHQ9CnfPFvDgSEwF6LdX7E87hWcSl3xzodcf3DI+mUp4
	 QU4cm8nOecCco9nThuzwol0qMh6w+ja6qeGsu0daExotpqMQiaU4qEMNGRK5JHcyJY
	 Ae1ycQEwMd+gNy7pxhuPh7NikS1DnJbw4vyxyx7qoXVyX8NHr4LO1DNP/C3CeMOezV
	 3kC85EcXw5fo1q5nu7fae24yHkRis6IwIzy7zaKlOpy5gBn5ly5TKW4R9f7SwSh3Xc
	 dSXVhnCv/ZPFo2fbNrBgsewseLAQphNm8bKgLAZT08LotS3iAbmWuyzPtX9CAq/uze
	 1bUSKkRLwkUJQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27464C595C4;
	Fri,  1 Mar 2024 20:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v5 0/6] Update Sink BASE management
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170932623115.13774.13135467294587042748.git-patchwork-notify@kernel.org>
Date: Fri, 01 Mar 2024 20:50:31 +0000
References: <20240301150029.14386-1-andrei.istodorescu@nxp.com>
In-Reply-To: <20240301150029.14386-1-andrei.istodorescu@nxp.com>
To: Andrei Istodorescu <andrei.istodorescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
 vlad.pruteanu@nxp.com, iulia.tanasescu@nxp.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  1 Mar 2024 17:00:23 +0200 you wrote:
> This patch refactors the flow for the BAP Broadcast Sink.
> After discovering a new Broadcast Source a short PA Sync will be tried.
> Depending on the BASE information present in the PA and the local PACS
> capabilities of the Sink, one remote media endpoint will be created for
> each compatible BIS.
> Configuring one of these endpoints results in creating a stream and a
> media transport for the corresponding BIS.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v5,1/6] shared/util: Add push LTV utilitary function
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3f7d81e906e0
  - [BlueZ,v5,2/6] shared/bap: Allow reading endpoint metadata and data
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7ec9a0f77c6e
  - [BlueZ,v5,3/6] shared/bap: Update local PACS for broadcast sink also
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=98aba4aaef7a
  - [BlueZ,v5,4/6] shared/bap: Do stream configuration in bap_bcast_config
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2ec513fc37d7
  - [BlueZ,v5,5/6] shared/bap: Add API to add an observed BIS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d2fa46e08c3b
  - [BlueZ,v5,6/6] bap: Do PA Sync for each BAP Broadcast source discovered
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=29fe7bd07fbd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


