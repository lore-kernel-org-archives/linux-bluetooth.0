Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793991008;
	b=K/vfnxJHpVLBA++dD7SoHBk6veshHJ/kofpvTVmUEspkaQNI9734lJPaIAXP23YvQLSO
	 fYMJT2STT5biBYEHHKfmwVlPkaglvpasfSYK1vJYUYLCxjsd+fjG/WpbbV6Z+6Iv0S0GJ
	 AFl4phdBOXBYqnu3fdQzxoWcOmJ/bpVF3qnjdddLOc/SBSjSCV/U0YgL6/zDsHTTl7ezA
	 yFAHoPhHRUXxxxbgMDj9bCjFl5afhOhRjDsmYuLlq8sYvgfWb9ISMD9dXgOoQW+TwmAla
	 B+bf9jlvBWp5d8E+wfODCTkfnelKVcsZMlFHXx2fcWxfLEO1pELXW9aItIgDKLyyRhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991008;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=OrfRYCBlbmflIvhtxvG/f3svmEmtBxYlNU2+D3tCqpw=;
	b=QMe7OikJPVOJTqyWwimUG4wOR/ZtTMO1bM4Z+1YPlrnH1u42JAh/SRWSvrHieo2z+5ip
	 YxqwPi1fuBH8yVggIpGND76tBrBiOjXd8C4GOnfrSAkShXqo9JeRaehx6n/Xz6ljLL5fS
	 9+KZebwKEpoz+0wt9CQBuRr7H/Iz0vC665e6AvQLWec6XiQYDjNyBriGYS8dyX34OxuNE
	 gsacm+jXrrd4enIKcUKwjCDS/IOpHCCirBLKay3lb18+XYO0y88idB+46Sv5+PXlzBYuG
	 RIHa8zFIBOWRifrzBbIzUm5S1V8A2rbLRgXP/6ZcjcJS3RXnVF2+GJeUuFBNkfMDsyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aWgfY8Lw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F32F606A326
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aWgfY8Lw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4411F008A1;
	Fri,  6 Nov 2026 18:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793991008;
	bh=OrfRYCBlbmflIvhtxvG/f3svmEmtBxYlNU2+D3tCqpw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=aWgfY8LwbfXBMmA8lIe8zSWVOP4ltVtxxagYN1AAY75EILJnq907KKEbqKlk8Vvtg
	 eydn/uRecsxgo6RyHcPwaE5gvEMRHm6PWwbtHzrdF+ZFDBFq7UL3u5eGjh58+SiXAL
	 hN3gDcXoQBu/gk58O2Tq/+w4r3wmZFg7BGAQ480Qk92r8fgqGPgtZ4Aq7f0SIqF/Q3
	 RmCVN9PvEDPV6auGduMwf6P8EV+yALebAFdTKXppXUXQYSarZjzNNS0tVU11ai5ZXg
	 pxeInmGuK2YqlF21nozmImbDBQa0y85iFyP3oPB3tT/fSq8fd4rQ+Eq1ZTr4268kTg
	 m8DmBVuxnB42g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E01B3A41021;
	Fri,  6 Nov 2026 18:50:08 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v1] avrcp: Fix GetTotalNumberOfItems command
 encoding
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179399100691.811161.16790714216807073653.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 18:50:06 +0000
References: <20261105221620.2332170-1-luiz.dentz@gmail.com>
In-Reply-To: <20261105221620.2332170-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  5 Nov 2026 17:16:20 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> GetTotalNumberOfItems only takes the Scope as parameter, but the command
> declared 11 parameter bytes and sent 7, which targets such as iPhones
> drop, stalling following browsing requests until BROWSING_TIMEOUT.
> 
> Also return FALSE on every response error path since the callback is a
> gboolean and negative errno values would keep the request pending.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] avrcp: Fix GetTotalNumberOfItems command encoding
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a8067198717b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


