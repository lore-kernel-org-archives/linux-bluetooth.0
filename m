Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851435;
	b=MdDenf+wf+fwE6fuZqOjqQowT/0cDC8/B2ajeOWDNcjbRM340H5FRmPoN5//h0vbkR/m
	 LQoSlnpKkeaM8zH77NwUVVMgPpdGauwrPGoixJbdfq8tjemG/sIbHgK7LMtnjaHKRBSUK
	 vdJj4Dq1+/IGxkwRI1+rba5iuTagKwvmfNhvzFD2oDA1i2ykcDFRETJKhsUX2tV+QQPup
	 NoOUpZEB1ag1q6FTjTlLU37NnH6HjXdl5+2XGodyt/rVAQIwSTQ5D3LwOnYJV8nyWY3Is
	 7DUs7g9o5BJQtBEfAtzxupBozOhAyY9Di1Wm7o55XPqVNnAfhPvZh1k96bpWgFrpuug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851435;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=/XwVU02/e7Q6qdTihRigHGzkTg2OHgkkOjowv3ImClM=;
	b=ES5Ah4q5kJ4mAPm+vHhd8MRo3bDN/+nfr4PtWuOme08Hdo95WLdgCgaQzirbxzvB1DaI
	 uaWPwAjYh9IlaKcz1FS47s1Gvh+qXv2X0+3aqmT0+pU019ye7yMwNo8rNOi0MM0tYxjyO
	 HuSBGWokeVDf7mjul2m+9kEnBc+HfHQRrZ6Mclx4L3+13UZ8NSYjPU2ukDVFdATGHVb/W
	 sRQGqQ0MrsrjGY1QktG+tsUqlCrunvLJr9Gs90OtsZC3BkXIAZ42+BBaSec8/a95ogGQ4
	 x20Hf64e6MkNpjd9oawtG4zCBSsO2hmn0yJvBstDZD9LzxScvpu89D6xTBkDRmmht+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AjshHWAb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297C7606A33B
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2026 17:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AjshHWAb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080EB1F000C4;
	Mon, 16 Nov 2026 17:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851435;
	bh=/XwVU02/e7Q6qdTihRigHGzkTg2OHgkkOjowv3ImClM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AjshHWAbBz61AAmk2gwP2IuphN11S4LrWZ/Uglix6KQ3o61X/xZULzhlOzrPRKoNG
	 ns0RZvFdPulX40U7+gmU3C4SfejtbH6x/JTVAbGy9QSvESl+cGJLY06fj0vQukNN/j
	 cPmcraeIQ7X9umZtjWvHOUudoQc3x9e3+VvsoiheGUh/m8sk1++jBV7akzloObzdVm
	 aZ+sxiQgEuKe7JeJ857jDb/OLKemZdoqVsdNinIhNmgEVj6LeL7UJtrT/owT7co4FA
	 +qVnTO26fjbtHR0kV5Hl2dlsw65hgeDiQ1AK2oTY3KRW88FaO/PEVyGjWGiPxjhv1V
	 wPvwRGbif4teA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1449391AFAF;
	Mon, 16 Nov 2026 17:50:34 +0000 (UTC)
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
Subject: Re: [PATCH BlueZ v3 3/8] transport: Clear the owner of desynchronized
 links when removing it
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179485143352.3796096.5519401065518488398.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 17:50:33 +0000
References: 
 <b6c8409cc2aee6fdc413f2e4f4ef617297b8f97e.1794428234.git.luiz.von.dentz@intel.com>
In-Reply-To: 
 <b6c8409cc2aee6fdc413f2e4f4ef617297b8f97e.1794428234.git.luiz.von.dentz@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Nov 2026 15:37:37 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The links of a transport are given its owner when it is acquired while
> synchronized, but removing the owner only cleared them if the transport
> was still synchronized. Setting Desynchronized in between left the links
> with a pointer to the owner that was freed, which is used when the link
> is freed in turn:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,3/8] transport: Clear the owner of desynchronized links when removing it
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=25a3e73a2197

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


