Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60AD6166C
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857429; cv=none; b=T+2/1+L3r3PwjCNGKmeHw7bJQb/aiVQ+FJxfZI9KFwqiDWy/I8dWndac3JhWXmQSGXICFl1ViiqOX5w1IAMv//w0zUJiOsqbux6Al/unELQxpVtcylcxgvq+4JYEgAO3dk3+KrMlYFD3A/Y6EV8BXDx2h+lRByBJFhof034OiBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857429; c=relaxed/simple;
	bh=AWyCEKeD8HHzHAQtuLt12GDezweuJswgyj7aJeufyNo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LIx4wuHDNutNAN4D3508n6GRqu8yKVanWLCYJrP/o/bzFm2XC63Tzuxk1HOIVNyQYaZ+qnfN1hI7EyEa6+P6ZZNNQnNzlPJZDESYEF/VqtizZLsk9YQw2SmL+i+5AekChhqzvRbQPEYNnyUTIS38GdsusBFTM9Wk/vwkQKV+D14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+e2Qlr+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+e2Qlr+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 22C3BC43399;
	Tue, 13 Feb 2024 20:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707857429;
	bh=AWyCEKeD8HHzHAQtuLt12GDezweuJswgyj7aJeufyNo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g+e2Qlr+iQA9gBw5j3w5ACQTQ54NWz8Pkqs9dJ7YuRQExNtblGmUj1kUSeMe8fOAO
	 fEGlFkS1Cos1qzCnt8lCpeKDYQ6CFOBiJOs6QAaSzqgUuGXiCW14wi9PP5dKwOt4It
	 6MRoxC8Se1+lPYi2dBLHxP8v3UxRubN1Kz/rKpZDBPFxtSTnoyb0l9me6+SO00Vn8Q
	 QrIwliINTl7QHl9V31zNOmNsgZZChXBKXz19Nwh+nGKc/kzq3hmRiJRx4Ii6CrsC+z
	 rdiKGdkJHvKbaILZAphAffLzoFimevlN6xiDvMOS88JfE99PU3vx0kpio1CDfyC7rs
	 rMDcCMsNU7ZhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C189DC99FE;
	Tue, 13 Feb 2024 20:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] btdev: Fix set PA data array overflow
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170785742904.22526.6089462734795932052.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 20:50:29 +0000
References: <20240213155803.3159-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240213155803.3159-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 13 Feb 2024 17:58:02 +0200 you wrote:
> This fixes an array overflow that can happen if the user issues the
> LE Set Periodic Advertising Data command with data length exceeding
> 31 bytes.
> 
> This can be noticed when running the Broadcast Source/Sink scenarios
> in bluetoothctl, using emulated controllers: If the source BASE
> exceeds 31 bytes, the PA reports received by the Sink looks something
> like the following:
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] btdev: Fix set PA data array overflow
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7c49568a2758

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


