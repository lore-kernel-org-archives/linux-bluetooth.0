Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E1423AB9D
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Feb 2026 20:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771014012; cv=none; b=Gp0MvXXlkcN3XiXbrJmHnWlJM0PJy1DkdV6w+/0qK8uZIfGwdk6Rvb4EmhNGxNIUV3re2/XFxhcP1OtxZOkvwyIuAwiHUnkOng41wVDFvYJC6WwfE6uEHUGrqh7kOoyubOKruV7D+g0Lxf4h7hlHkG1jT4paM1UPjexd9wjfQ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771014012; c=relaxed/simple;
	bh=OpHMH9CSCYRGzArdnY45xd8Cy9x8Gwk98XWz68SpU5A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qk6E4jQAbWxWZ5AZ04Jg+EUm9An0+F5WxkXa8QGLBzeD12NHiVAW50tWxSbY3iWD5xK4aGNoV7hPSv9xAQWctLyYfR01WYqqH4MsT5lIigVk257v34lMZAQOJyUDVcdI6o4kbT/lB5IG3pozoZSFXVIeS4pJ+OFGNphXQtd71x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=urn8fms+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="urn8fms+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43477C116C6;
	Fri, 13 Feb 2026 20:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771014012;
	bh=OpHMH9CSCYRGzArdnY45xd8Cy9x8Gwk98XWz68SpU5A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=urn8fms+UVQDKobKyS8cVBkO1twLVYto/zGpFCH4Z4jT3dVbhyQkExajvJ3Iz7PjD
	 OafjQdsjDlA/9qeNm83VdoYhpBpaUbEf3KiePEJhh343pfz8K7fxydncaQ0AgUe/CC
	 wrrJ/7Iz0wDXow77wyQANM6uJlDMN5vHV8fT9NBGKrMrUYzJVxqU/W0QIk24Schlfu
	 PrSe1c1Aclyd+60UPWB/9pFKtkV/+UE0hOmXGFFq9AlkO/K7iWQ9PRERUUqMxEaMJI
	 M3yzsREbjeCDc3lmjMT88TfAD85dS3AVChVnBUoWecGzu+ieqIaNrd8IXtNhoRUwt5
	 nNvLMlvKqBebg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 482483811A44;
	Fri, 13 Feb 2026 20:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] bass: Fix crash if setup is freed before
 bass_bcode_req response
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177101400582.2543989.11102095288331910222.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 20:20:05 +0000
References: <20260212205710.1690782-1-luiz.dentz@gmail.com>
In-Reply-To: <20260212205710.1690782-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 12 Feb 2026 15:57:10 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If a the stream is set to idle (e.g. because the endpoint is
> unregistered) the bass_bcode_req would be left with a dangling
> pointer possibly leading to a crash if the remote peer respond or
> the request times out.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] bass: Fix crash if setup is freed before bass_bcode_req response
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fe0501126ba5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


