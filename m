Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B72DC76A
	for <linux-bluetooth@vger.kernel.org>; Mon, 10 Nov 2025 20:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762806037; cv=none; b=jrArlnLlWKkNPIbAejUUeeJ6+bLGEoF4T1F2LXlK00NSOq7Vq/qU1LAFYSF6Qph2EHm7q5Et69AoCS7YDlhYI9HruwQLwDWyAMW+WzpUrCAoZp+rj/fKKtxPMVFY+xjjG0Rxt1TSpjKFguasmi5CVurd4J83HuQ+oG7glQdSVhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762806037; c=relaxed/simple;
	bh=ibjgQr36ZryTETJzVnOwQdCjazJd4MVcC7CvWlRRFD4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C42Q0N3g18ISRtIGUo3Or6IaKdQKrFURE0RuXcqmaRT9iJkKj22P9Hlpou8VEmI6PGHWgfB7QS9p1+ZzsGBUolxdIJ95Cv0HkIIwr+fZBEwEKfNe9R84SMS/9dlWLMZO7LSqlAtIEeblAPBoJ5tvjhyOVACNf1WTcuBaVIkJ6Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipWr1ZlW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipWr1ZlW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DF7C19423;
	Mon, 10 Nov 2025 20:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762806037;
	bh=ibjgQr36ZryTETJzVnOwQdCjazJd4MVcC7CvWlRRFD4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ipWr1ZlWe2hK/b3LCvCTbzSDd/Q5hUXhhipOrlO9XSfK1H8/a5AJq9fG85f/N1fGj
	 kfWJCSxhfqSPYrggZGSgFGpcdCWFIPX4h+t68nPnymoZyFGl8jvKDTAAzdplSAFHmL
	 /Wlo1Di0UMUn/n9Quy5EmJaxNGopZ3ZKLbNj/mO33RTMOiD7/UkyI1tGUDjVi2ejTV
	 CMbkv0gVbMs6H6MTcqtmYlHFj5HA734uIEjiDIk2mPrlGW+jTGnECGxslbvLx9XV6V
	 JWyQ49042BNiThfca64SbnTOob7utVJQBD0Zc+K0oIP2AMgsrsKpMYDEDzq8/8JPm0
	 Owwa5KcSwod1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB11B380CEF8;
	Mon, 10 Nov 2025 20:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] shared/hfp: Add Enhanced Call Status support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176280600775.2762084.9118739314924188427.git-patchwork-notify@kernel.org>
Date: Mon, 10 Nov 2025 20:20:07 +0000
References: <20251110073804.49651-1-frederic.danis@collabora.com>
In-Reply-To: <20251110073804.49651-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 10 Nov 2025 08:38:03 +0100 you wrote:
> In case remote device supports the Enhanced Call Status the calls are
> created, updated or removed based on results of AT+CLCC commands.
> This implies to send an AT+CLCC command on reception of +CIEV events
> for <call>, <callsetup> or <callheld> indicators instead of managing
> calls directly.
> 
> This updates the tests using FULL_SLC_SESSION:
> - /HFP/HF/ENO/BV-01-C
> - /HFP/HF/ICA/BV-01-C
> - /HFP/HF/ICA/BV-02-C
> - /HFP/HF/ICA/BV-03-C
> - /HFP/HF/ICA/BV-04-C-full
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] shared/hfp: Add Enhanced Call Status support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d33b9b7c9e7e
  - [BlueZ,2/2] unit/test-hfp: Add Enhanced Call Status tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=173e9963df4b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


