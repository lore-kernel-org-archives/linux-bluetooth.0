Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452644D8AF
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 18:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327436; cv=none; b=JpfBnQJ2b1f0D5UQqSi+XnR7qI3n0w+VwGpoeig2ntg4yMPIDT0FK9jiMglTSm0oJ+/Z11+nXJtyWk1jzgP/CTAo8s1cr1hxYHjKPSu39tZMy4EpJL/d3w3XQdvgMLljr/4/vaET43DyGEO4fjWFRARsSQ47KfTtxFq86/wFz8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327436; c=relaxed/simple;
	bh=k9IQHeK8VYD1/4uKlkiIaImQZP5CQ7+bcVO++ZAvcIY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=unETif0ksGsP0YBDttsWGbz2P7dwZB2xNE2xcOI6ZFuxKUFRcQ3B/njOB7PUYc29QrGGdS23zIEphc5xVE5YcP+p65MRueyyeQBNyv+T3Sdfgkt9dripmvgaRy3PmF7gVM3H0V7eWkphj4sgUH1abOK3Hu/CdBSBI+tt6vs8pDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GT9GQMIr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GT9GQMIr"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D41E6C4AF0C;
	Thu, 18 Jul 2024 18:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721327435;
	bh=k9IQHeK8VYD1/4uKlkiIaImQZP5CQ7+bcVO++ZAvcIY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GT9GQMIruCarusjrvwo1YOAP4M5xsxL509WPgkTuWEAw9lvbAw3Dlx0TBiHOhFRiC
	 ndwHVHahuQfAtv/LBry6tVqNPn4NzcvHRDCvM6HPoB4gRspHsVtDDfixVy3yqVdbno
	 1S2Z6uP9Hnefp1ZavdQIQG1dh3wpT9+au1kqrVJd6R3OJCy2Qkjc/dxBb81vYr7Irq
	 BmWFaeHgGdrRnz6hka4TVstRA33M2Fgzc6aeC60MIm977jqZg+Gn7AmMI1kPnkmK6n
	 9plWPpQqZh6YtKCmVAeIL5xFz6XSo/H1hvC+2FZIMqrpKuQomCh5rwPLqYzA+/O2Pu
	 QTP1HVBbBX40Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD73EC433E9;
	Thu, 18 Jul 2024 18:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 00/10] Initial implementation of BAP Broadcast Assistant
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172132743577.20188.15530964698289453048.git-patchwork-notify@kernel.org>
Date: Thu, 18 Jul 2024 18:30:35 +0000
References: <20240716142207.4298-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20240716142207.4298-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, vlad.pruteanu@nxp.com,
 andrei.istodorescu@nxp.com, luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 16 Jul 2024 17:21:57 +0300 you wrote:
> This patch adds an initial implementation of the BAP Broadcast Assistant
> role.
> 
> The core implementation resides in the BASS plugin (the BAP Broadcast
> Assistant is a BASS Client).
> 
> The BAP plugin implements the callback to probe Broadcast Sources and
> parse the BASE. Information about each detected stream is notified to
> the BASS plugin, which will compare stream audio capabilities with the
> capabilities supported by the peer Scan Delegator (discovered by reading
> the Sink PAC characteristic).
> 
> [...]

Here is the summary with links:
  - [BlueZ,01/10] shared/bap: Add separate API to merge caps
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=caa4202a7ee3
  - [BlueZ,02/10] shared/bap: Update bt_bap_verify_bis to receive caps
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=679349fbc9f2
  - [BlueZ,03/10] shared/bap: Remove unused param from bt_bap_verify_bis
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bbcf4891cd46
  - [BlueZ,04/10] shared/bap: Allow checking bis caps against peer caps
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=662aee4357f8
  - [BlueZ,05/10] shared/bap: Append bcast sink pacs to Sink PAC char
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2c98c478863e
  - [BlueZ,06/10] bap: Add API to get bt_bap matching device
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f16391348810
  - [BlueZ,07/10] shared/bass: Add API to get GATT client reference
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=88bf423eb525
  - [BlueZ,08/10] bass: Register MediaAssistant objects
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=77e4c0976c0d
  - [BlueZ,09/10] bap: Notify scanned BISes to BASS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=22779f0bce61
  - [BlueZ,10/10] client: Add assistant submenu
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a3f9970f7a8b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


