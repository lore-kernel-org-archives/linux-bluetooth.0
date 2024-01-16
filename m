Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33C21D522
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jan 2024 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431739; cv=none; b=lSQF0Bgh3rJeoYdw+YJ/OCbmZf47ATO3FKT+5OKbR9Qwdl2sIuDx+I7Ul3zwVukVF6OgJTXtkNROLSx+8yNjOEaA9g2E+Tke1m7anVjLSwmV3z1LBuXb8OD3JsLM1KJwrwkrvQOsK0LGBGw5Cjl1xmIM9N5+3Hf7wSY9b37Bup4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431739; c=relaxed/simple;
	bh=ARw361aWVy5/1AOG4qcz60hojpq7CMLbTWtasD9qQR4=;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=krAkpjr4sc2HjrunXCuCTDpygg9XLaQ10yc4WwhFmuN0ZOj9r7w96poERJYOtJaqmD0bFnjI7deWZHrG4SUW6Amu1Z23Q96Ig/NZe2VXNkB4tCVtMrH6jRtAkkGWeYjc7Xc5Fskkmw38AZi9ikqjd+0ZnOKMSeBRVYcSWUf8+ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCZHBmMx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCZHBmMx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9677DC433C7;
	Tue, 16 Jan 2024 19:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705431739;
	bh=ARw361aWVy5/1AOG4qcz60hojpq7CMLbTWtasD9qQR4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kCZHBmMxpIUjZTaeQJBReQFyYOzXF7BC3hPFWFV31vXkWJxOENNe2ZJLeiNHFqh5W
	 +eMyeB+KGXFXImc3luegov71x+RM0Xzkp19PKANDINtN2NQlg9X7MfJQbay+OWgPtT
	 czY6wTmqY3Tzyp80ljmFrCOHIb+7uNlUG9UqFWGBE7u+Vjw0oGJAf512RlWNZSCqhS
	 yeTn9Lc+k8g2ucLxlJS3ud8ZIaNxk7BCagHHhMGFXkW3xShSnO5+S5gqbcMD88PYuM
	 iFk0Fxx6CuXUHmbxERsI7lPHUQtk+9ZWhMyH21k43c6FIDnQodxsP0gZw94o8F23L4
	 fs9TYOTYYAC2A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81DE8D8C987;
	Tue, 16 Jan 2024 19:02:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 00/10] Autotools papercuts, linker GC, symlink
 dbus-org.bluez.obex.service
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170543173952.30188.12996299112617772130.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jan 2024 19:02:19 +0000
References: <20240116-autofoo-v1-0-626f6b54bd06@gmail.com>
In-Reply-To: <20240116-autofoo-v1-0-626f6b54bd06@gmail.com>
To: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, emil.velikov@collabora.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 16 Jan 2024 13:51:54 +0000 you wrote:
> Hello everyone,
> 
> While looking at our bluez package for the SteamDeck a handful of
> paper cuts stood out. Here we tackle the build related ones - a couple
> more series will be incoming shortly.
> 
> In a gist we have the following:
>  - remove manual tracking of .services.in, DEPENDENCIES
>  - remove unused variables
>  - polish PKG_CHECK_MODULES handling
>  - enable linker garbage collection
>  - create a symlink to dbus-org.bluez.obex.service
> 
> [...]

Here is the summary with links:
  - [BlueZ,01/10] build: remove unused AM_CONDITIONAL
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6d6294036c39
  - [BlueZ,02/10] build: tweak PKG_CHECK_MODULES calls
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c07fb1fcddad
  - [BlueZ,03/10] build: require libudev 196, circa 2012
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3f490a69cb55
  - [BlueZ,04/10] build: remove dummy {conf,state}{dir,_DATA}
    (no matching commit)
  - [BlueZ,05/10] build: remove unused variable builtin_nodist
    (no matching commit)
  - [BlueZ,06/10] build: remove .service files from DEPENDENCIES lists
    (no matching commit)
  - [BlueZ,07/10] build: remove explicit DEPENDENCIES handling
    (no matching commit)
  - [BlueZ,08/10] build: manage .service.in files via configure.ac
    (no matching commit)
  - [BlueZ,09/10] build: enable gc/dead code removal
    (no matching commit)
  - [BlueZ,10/10] build: install dbus-org.bluez.obex.service symlink
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


