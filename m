Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795456809;
	b=Wpw55YDbqHb4OW7mIqrCBzGrQG1IU7wYQsYeriiNHvaP5z7BA+0jrwZDh9wfuWeqxx3U
	 LDBgLXAhrKPevTIfwzmmjGTBOQ1/efJ8+8GB2YYnNPRXhGEz54RGQpTerFxUxHZyD+46P
	 qyv1YWyJW1W1J4/0yhX5RnoiCvFNPRlJrQ9MYiovK7TTfYE+L1Bj66ei2TsDvtU2bCV/t
	 FP9kJnSFo9D59dxy1uj9uLun9puPZdpL0eT4tDzAWyD0rE++4PQvp2kI8uBGxDsl5qiBS
	 QAeO9BD1NkLb+79WTKA21Gg6OdOTzlqDCMUW6IL74wuuxkXGbV3WNMvZvJsDu9F6rOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795456809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=xXw1AGJYR2o0t3hpRKJfah1obqXxBfNu12l+5BcHPq8=;
	b=J6zJNH1qaE+NB5DYazedkHyPZ4QaIItdgvBisW6lzM4g0qiFBMcMtivIqbRTV5uecmW+
	 knrejo/5VU8cDESarZsHaoAJ+HRLga9qBG9oNdZr6xl3tLC2yBGmoLA3H1PQrxw3P9i8v
	 Yb4VKb7jwg+AuXlWvzvhdaOFeT21AEKR2h1SX4USQvEKeMkQmxyvr5BQH/7VePzHNNd9p
	 y9JQ9lWdNIgy6URzX4yA5Wlz0aiTHvxqjTEDzZJ3TaGETxv5LUytAAeX5gcu5baGUWr0f
	 H/V5KLwmbWTfVDMLOaAmz8ckESMKP7Oa54nieLHDxBf9+Ve+/TUKyko31Kpt6lUZdFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=npECcR7O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F090A606A31E
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 18:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=npECcR7O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45FDC1F000C4;
	Mon, 23 Nov 2026 18:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795456808;
	bh=xXw1AGJYR2o0t3hpRKJfah1obqXxBfNu12l+5BcHPq8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=npECcR7OV0jppu/3+dCe0QO59qGr58PXczQd9kp6J434V0O3pT/fZ8XvG8tbuhCWI
	 R8ebShxzhvnbZVcxYCXegVNMsoug8P4u5HjQlAZ4Cw4yfVjUKvWahwF2+EfyUlEfVu
	 mGfVUJMKMDVkULuCwA7AJJTIyFoh2o+wV1+gcuBJ+qTrpicGEHyEUhdI+wfLOrgVbb
	 jTKelm23IlA7JVxF/NuzfoAHbctiDyx0scoLjRCBYRRyByd62ELBVWeaMxgTqwdc5m
	 ITBXXXcuGjZOhSLLaymDz7YOSX4Ai6EWXAVSCzNxAjiIlKiWI47rM7o7yONq13eymg
	 E4Tgy6XzLkAsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A38E392EE1A;
	Mon, 23 Nov 2026 18:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] advertising: Refresh only advertisements that
 depend on
 discoverable
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179545680677.3023180.5669263420904450604.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 18:00:06 +0000
References: <20261122103136.620031-1-simon.mikuda@streamunlimited.com>
In-Reply-To: <20261122103136.620031-1-simon.mikuda@streamunlimited.com>
To: Simon Mikuda <simon.mikuda@streamunlimited.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 22 Nov 2026 11:31:24 +0100 you wrote:
> A change of the discoverable setting sets every advertisement again,
> although only a peripheral one without its own Flags depends on it.
> Some controllers can disturb a running BIG when the advertising set
> of its broadcast source is restarted (an NXP one skips every third BIG
> event after it).
> 
> Steps to reproduce:
> 1. Start a broadcast source whose announcement is a registered
>    advertisement (LEAdvertisingManager1, Type "broadcast").
> 2. bluetoothctl discoverable on
> 3. The advertising set of the broadcast is disabled and enabled again
>    (btmon), under the BIG.
> 
> [...]

Here is the summary with links:
  - [BlueZ] advertising: Refresh only advertisements that depend on discoverable
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4242832ef817

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


