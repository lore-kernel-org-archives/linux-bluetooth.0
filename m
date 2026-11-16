Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794859207;
	b=bQmve8gWESvmrz/4SQmkNezKuA5MCDO0b7nVEY5CBQl/DEs+GBubO3hwt8KMEUMd/aKg
	 EqSWK+mMqRAEqz0Lzkf88Kh9dzkznm6L56+pli4/NbLL/OkJJag9zVd+ezhbLuGP2Db6o
	 kC4hFGjghPsp8cv98vb3WNlRgaePck6o4bWaWrCkbfmU0Cwm3zFb85mnOvh7MMAjNMcuq
	 WGdmH3SMlx2FOE7cnetCgOaWfIv0z5ndEAoHeC5ZF28b+QpKCnQm2O6CghqKQqkLnwsFk
	 efLLhrzwJKLnQiW28A5vZ14cI1ZjG1FXyZybw7n0TEnn6GIRCxXE8RSvfdq/5hP/HPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=hdX8D8utICM5MVykEAtCmjUBq0GSVHdDwkH/F+Bl/jo=;
	b=LWVrJnBpY/+L9CtiCaben0ZByUd3wOnNX7apzCXWx7YmyJLxwWHNIH94fab/POXLLYrE
	 YBpbzuquijSBO91GlShrI/mJRJu+OhXKvDsJ3J5Q0IaJ716evvNX9fJqNZjYaqQ7aFvrZ
	 GAT0Q958u/RZdyyZ8H7fTGDNDt2u4WsnzRGtyv6kVwMybGYsBUivwcLWv71jG7O5OiMO7
	 T4gc6yi7iELZEGaSS4g0PxG9/utM6SaaPj9sFeYRydPm7+wnUDFF2ZMdjf1wpThf7yKT+
	 yWis/dKF+Y8EPpOzH21Wqahh/ueE1u8eXY9mUYS3TBiFfKt7agMrOugTsZgkLj8vMrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OPDSm2Cj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F13606A322
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OPDSm2Cj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 813361F000C5;
	Mon, 16 Nov 2026 20:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794859207;
	bh=hdX8D8utICM5MVykEAtCmjUBq0GSVHdDwkH/F+Bl/jo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OPDSm2CjuKGMCx841tFCapUmcqVedmxpnC+fpMT5RPIvZAfh6fgU0XHWZi6oZ6Y5k
	 lBDjIGMGTL4wTJxbKuKrCg+VNlTXxlcIqV1dT3ezSdMT6yzXVdd0x58aYdYfv2SrBH
	 zthUN9zHHRjk5K0xqxoVR/1WPhz4JdvF2ywktr2vbvMBAjE8DapN+XvTLeJub9pSX8
	 PmvAyq2oBsP+7UOA5Uor48q9izJV1WjtWLW00Hl440U3UEkVJIdB5g9do72BAxIHvT
	 OQQm65UpVOFoCch3+WZcQwpKtj97eqYndYCaNPJa4qLriv/DfLQ8LcTuspxmVGVjQ9
	 RQ4LzUbQvlYbA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77411391AFCC;
	Mon, 16 Nov 2026 20:00:07 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ 0/2] Single advertising set in the emulator and
 mgmt-tester
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179485920627.3860040.3796894125726226871.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 20:00:06 +0000
References: <20261112023858.892176-1-weihong.guan@gmail.com>
In-Reply-To: <20261112023858.892176-1-weihong.guan@gmail.com>
To: Weihong Guan <weihong.guan@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 12 Nov 2026 02:38:56 +0000 you wrote:
> A controller may report a single advertising set (LE Read Number of
> Supported Advertising Sets returns 0x01 to 0xF0). The kernel then gives
> advertising instance 1 handle 0x00, the handle Global Advertising uses
> too, and several places took the instance number for the handle. Those
> were fixed in bluetooth-next by commits daf949c968d4, e7e877bf658a,
> 8b1eff978e66 and 4dce35adafb5, but the emulator always reports three
> sets, so mgmt-tester couldn't see them.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] emulator: Set the number of advertising sets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=58e111cc9904
  - [BlueZ,2/2] mgmt-tester: Add single advertising set tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=923d95d0c2fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


