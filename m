Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EB5317162
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 May 2026 19:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778613663; cv=none; b=AiU1PE6pjtL5GJX6namSG3t0MYpqRW2k+UEzey9SIP3e8J3H3/7dOFwmNlMMEyajtZ3p+gPk7uRwgaid+5SbEBdFJ8EZ8q+ieolGgK0MmF9wFo1OyraWyfM5j5tdG4UNTmLEgiF2Ftv7urkCFJAV2S8z2BaWbxGynh3063DT8bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778613663; c=relaxed/simple;
	bh=28hphx8IuY4LbdK5p6cM7TmkzpO2ULuEEAmOR2xtOEo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C49lWXtwz/CBdmeHILQmZrGs2d9vr/UHakSm5abJxODGjtyLJCwJv/Zl4C3fUhiJV4wK0J9TTUvvWHj1vaL9qc7xC+6h+A2Ph/aW1z7fBReDBDzqbniqry8zqVnduD/6lzO8ap4EiDODsgtgGiOuSkFUQ14/1fBbEeqXK/X5Fhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2+Sm1I1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2+Sm1I1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B408DC2BCB0;
	Tue, 12 May 2026 19:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778613662;
	bh=28hphx8IuY4LbdK5p6cM7TmkzpO2ULuEEAmOR2xtOEo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n2+Sm1I1N8dB5QSm/EPCUpnVLW7/cZnGTO0DUt6LrT2thourcuUXluP7EIf55o8LY
	 b9dms2S61nt8BJ5M9aJsT098hfcPhkUvFZrGnt1UcXgzKB7+wHOuEtKPPy3n/4Bp8O
	 3lSRhN8UyGNMGdLKBmklAjT8iwMOIlbSDBW34vZZVfPRDOTLUr/jPZUqmYIuyP/BsM
	 pUyemN66+aUHK5MhgOeTmgMRmV7RCpxKkJxT2m86TSTUbMQCeemXH7XaHYrY1mM6la
	 ErmDzalumngS1zNTUZ0QiUYFBmFNkW1y6cuDIutpjlFfXNsCeptYRe4cR8z2L+/+1N
	 8uemtCLcxWmxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D8F3811A59;
	Tue, 12 May 2026 19:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] adapter: add BCAA UUID also when seen device is not
 discoverable
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177861360880.3045511.5201092313121444491.git-patchwork-notify@kernel.org>
Date: Tue, 12 May 2026 19:20:08 +0000
References: 
 <a03d5b481c87d86d2bd2bdb376729ea6c4f992a9.1778535912.git.pav@iki.fi>
In-Reply-To: 
 <a03d5b481c87d86d2bd2bdb376729ea6c4f992a9.1778535912.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 12 May 2026 00:54:47 +0300 you wrote:
> BAP v1.0.2 Sec 6.4 specifies Broadcast discovery uses observation
> procedure (Core Vol 3 Part C Sec 9.1.2) which makes no reference to
> device discoverability state.
> 
> However, if remote device does:
> 
> 1. Send Advertising Data for some other UUID with General Discoverable
> 2. Send Advertising Data for BCAA UUID with no flags
> 
> [...]

Here is the summary with links:
  - [BlueZ] adapter: add BCAA UUID also when seen device is not discoverable
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ec223f0782ef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


