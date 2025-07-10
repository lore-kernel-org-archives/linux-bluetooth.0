Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564C7154BF5
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 15:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160165; cv=none; b=qamc17M3RxuqLIKR+OdS3Sh9+hxdShRHcyiR0nYSD790FFsIjN+ljRwm1byFZDSQLgfds7ilAaSN+usOi0tknHa7TYKsUn9m2BC3GzMpXktP5OsvyAFXAxNpk6evB922r5aeygGU3GHfhsZ+ssPqUFp0mV1hwV6dx/4zbtnrqXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160165; c=relaxed/simple;
	bh=ewCZenAbSDLGcaJSSDMpE9bzrZzlXxmmfWGNTHTNiZE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fUGHLda2r5GTMINwAzLy4y9EkMsHK8TAxcx3CRF/cAKvC1z3uBHvh61u/t7nbQ4iWNDvpr1RnVXNYV3zu21ym2bFlanEIVUJmHmNkY9q0Zl2lvnsuuee9MKTPQQLjwpp2kiwOTb764uwUwPoX02TyokxS+A15sx8ssCBt312OwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W4axVFoq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W4axVFoq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9FABC4CEF5;
	Thu, 10 Jul 2025 15:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752160164;
	bh=ewCZenAbSDLGcaJSSDMpE9bzrZzlXxmmfWGNTHTNiZE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W4axVFoqcrM5mcnsn5feZ/p44bGBy+03snAFMCeq1Reffyq2+j1+FcDbebC4rJbt8
	 oXw7MpllZKYWSYCotgtA+7iLX9puUVKLEkhWrKSXktLUeS2OaQTZjkloOoo9D6ZETM
	 pLzL2pWkVPouZ0M53bYfcO4lBF5lObjHuUQ9QXR5e/Tm2e6wGvAuB2vWrR9+FjvRBq
	 QJW5rES+vc9S7on/yUsvnKmgv1PsXa0tt3IdqJiHbg1BcWvfkn1MVAOI/bpxMUnNiA
	 bE6PqFxSRbWvg75mag0AyeaVdPTDVTYyu6XQRYrFbg9aSEs9n86+Ol9vClOUHVjehV
	 sNdE/nt7ARJbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7168D383B262;
	Thu, 10 Jul 2025 15:09:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] obexd: Remove --enable-threads option
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175216018699.1518208.1944595208061975112.git-patchwork-notify@kernel.org>
Date: Thu, 10 Jul 2025 15:09:46 +0000
References: <20250709143612.2115659-1-hadess@hadess.net>
In-Reply-To: <20250709143612.2115659-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  9 Jul 2025 16:36:03 +0200 you wrote:
> Threading support is always enabled in dbus since version 1.8 released
> in 2014:
> • libdbus always behaves as if dbus_threads_init_default() had been called
>   (thread-safety by default)
> so remove the obsolete option.
> 
> Note that we also require glib 2.36, which is newer than the version of
> glib with GThread support built-in:
> [Since 2.32]
> This function is no longer necessary. The GLib threading system is
> automatically initialized at the start of your program.
> 
> [...]

Here is the summary with links:
  - [BlueZ] obexd: Remove --enable-threads option
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1c6f080d7f40

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


