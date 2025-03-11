Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F50725E805
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Mar 2025 15:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741708200; cv=none; b=WkCNgrDis0KqCJLYEFwkLSRnZ6gizt0enKiltQYjjolZK+GOFE7+ndnu1LUASjqLP+gI/WEyvGTHBXZZLbDKLJCPwFGDne5414nD1K3IeS6bxQ8VRd1FyOdZg7A2xMbZW8NqFcIVFVsXxi+BSnPigGTA70GOjT8jwTD2BMnZXOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741708200; c=relaxed/simple;
	bh=1h9G5j+wY/kpgxuxcwgk3BwavkFQs3d27KhiiiHyPAY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MsTghBPVkAlidFAmtptxInBsOREKcq6ZpnaXiOd43azYH2E117moT9BN+ZdzpxJlBDQzWWgvmpJCkf6xvNw0rEb3A1w4q/LrEzVdZ4MvUgLcrXQu1dLygqwunidj4QdUx+GGpZ/1po7Ec5s1xdmUXiJyHZsEcAJUtNLS67B0HOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iu+jPZqp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iu+jPZqp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A859C4CEF3;
	Tue, 11 Mar 2025 15:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741708200;
	bh=1h9G5j+wY/kpgxuxcwgk3BwavkFQs3d27KhiiiHyPAY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Iu+jPZqpncH2Fmpepj2x0aTuSXFcSrByrzKPcNR8cRi7DuWVzG8Jf/MXWL/jkpqJj
	 NdAmrCdWA1sZUsF+2FAmjCDvaD7kJK7bjjuJTdIrzMZyXjUEvzsLFad9JAWlg/u8iZ
	 qo0jylP2vCb4kUAHtf+YEL/ZfzUpQ4J+hmlMCUwDSLE3INSWictypncQeEQlVn9L1m
	 6yXkvHi/zVe9KZVzeNAbE8ah1Jq8QTWUJOYflpXCpnGG2OQB9n93bGB7vegjrfthCN
	 vPT9Ss6aWIE2tlaKdHieCauUU4X8usz5dzW+UrBYD3c7uWFvlF5Bk+2q+GroHWSvrm
	 /Gd5ngLMs6xxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DA2380AC1C;
	Tue, 11 Mar 2025 15:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/6] btdev: Add support for Sync Flow Control
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174170823425.132061.7780763071835633975.git-patchwork-notify@kernel.org>
Date: Tue, 11 Mar 2025 15:50:34 +0000
References: <747adb1a5f2a6b7b25e823bf22f8795f4c7c6322.1741370367.git.pav@iki.fi>
In-Reply-To: <747adb1a5f2a6b7b25e823bf22f8795f4c7c6322.1741370367.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  7 Mar 2025 20:00:54 +0200 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds support for Sync Flow Control by supporting command
> Write Sync Flow Control Enable:
> 
> < HCI Command: Write Sync Fl.. (0x03|0x002f) plen 1
>         Flow control: Enabled (0x01)
> > HCI Event: Command Complete (0x0e) plen 4
>         Write Sync Flow Control Enable (0x03|0x002f) ncmd 1
>         Status: Success (0x00)
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/6] btdev: Add support for Sync Flow Control
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=86d6b74ff002
  - [BlueZ,v3,2/6] btdev: send SCO setup events to bthost
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b7ef134eb978
  - [BlueZ,v3,3/6] bthost: add hooks receiving SCO connections and data
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ce1abc32b3fc
  - [BlueZ,v3,4/6] sco-tester: check sent SCO data is received at bthost
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=87d4f95dc312
  - [BlueZ,v3,5/6] btdev: support disabling commands
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7da93164f483
  - [BlueZ,v3,6/6] sco-tester: add tests for different SCO flow control modes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=95055def8cd2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


