Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2086A03B
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Feb 2024 15:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441231; cv=none; b=ZUcLCN63A4WwFrW9hJJHTbaNxvgP0XsFt93RWhltR7t9XoVTtNR6EHNN5sl79q/SeupVdyZEhOuZFGxSXLngsEux8UqWG0i3OxQFWSkgQ1gV+RNy6N5ia7Edq5wnyA73XIYnNYDLkqbP2Njybdl7pDOsoNdYnx/U6qUWbI273tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441231; c=relaxed/simple;
	bh=G053u50YzhV7Qjvam1HBZdCtYOzOOe0jtpezWzHgd/o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ttqC9/dctIxQnH8Gm881Mumjr5POyyQLD5prVO5Jz6aap1YddBjScpAoaJHo3DrlcGv7MrKD2ookGsDsvMfQYjfXNx6Ms7sGx6ZCkC9ZnK6cRDz497+ojWpZTNVz2Q8OlG5/fomvr/AxKH4mO2W6dtUTcAdOl3350PLD0TdcPFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T4cauCRI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T4cauCRI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57A69C433F1;
	Tue, 20 Feb 2024 15:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708441231;
	bh=G053u50YzhV7Qjvam1HBZdCtYOzOOe0jtpezWzHgd/o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=T4cauCRIxaQPERHR8+cWOdJkwch6Cu1vfL6M01q8jzhkDjgV2uoC58k4g32D5qo/p
	 L2csy/6AxfONJj1p8tW6+2WDWtFcqKoYsH8pVYzzJUboIj/k7qxdRl/dKGw2ycyV51
	 BeSaJ/dFwL9HShHyapxLQ/32zZ1DswooyfJd9oVyjhmAwhLUWd+WdD9ZlaajkFmIPs
	 L3Z9lAJ7W0mmuA/+8pVtMrDbxpAY1py1Fdh8mOSg3FSQYgeS2xIyXzBV8JoKngqptr
	 ldXKzVi+SDNKLhabkFJf+33dSxrk+j47D1bHlosBY3kzisKHLjYPFpGIvl6hAKTWRk
	 b7eKyepqa5afw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3CC3ED84BBB;
	Tue, 20 Feb 2024 15:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 00/10] Handful of build fixes and cleanups
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170844123124.11924.8847424394060331888.git-patchwork-notify@kernel.org>
Date: Tue, 20 Feb 2024 15:00:31 +0000
References: <20240216-hook-fixup-v2-0-a6b192d1a6ad@gmail.com>
In-Reply-To: <20240216-hook-fixup-v2-0-a6b192d1a6ad@gmail.com>
To: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, Joakim.Tjernlund@infinera.com,
 emil.l.velikov@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 16 Feb 2024 23:11:04 +0000 you wrote:
> Hello list,
> 
> Here are bunch of regression fixes caused by yours truly - mea culpa.
> 
> Changes in v2:
>  - rework first (install-data-hooks) to per-target hooks
>  - add renamed files to gitignore (rules patch)
>  - introduced six extra patches
>    - fix the @@ substitution in the service.in files
>    - drop erroneous -fPIC
>    - add org.bluez.obex.service to gitignore
>    - drop duplicate -I include in obexd
>    - adds all manpages to gitignore
>    - moves libbluetooth public header to sub-folder
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,01/10] build: rework {install-data,uninstall}-hook
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9fe4ccb79ffa
  - [BlueZ,v2,02/10] build: install obexd (dbus,systemd} services as needed
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c2b9f357d522
  - [BlueZ,v2,03/10] build: handle relative libexecdir instances
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=71d8fda25b21
  - [BlueZ,v2,04/10] build: drop %.rules make rule
    (no matching commit)
  - [BlueZ,v2,05/10] build: simplify coverage handling
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=344cf10cb60c
  - [BlueZ,v2,06/10] build: drop explicit -fPIC from obexd CFLAGS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bade07f43fed
  - [BlueZ,v2,07/10] gitignore: add org.bluez.obex.service
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=071ababfe6e3
  - [BlueZ,v2,08/10] build: obexd: remove duplicate include -I$(builddir)/lib
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4d3605e472ed
  - [BlueZ,v2,09/10] gitignore: ignore all manual pages
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e6acec4770bb
  - [BlueZ,v2,10/10] build: move public headers to sub-folder
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


