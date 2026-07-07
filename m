Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC2B37C932;
	Tue,  7 Jul 2026 17:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783445430; cv=none; b=WBkzRC+XB5FX2RhD3d6gX+Gsdnv6qzIqZ6/Mn29UicuLpv2IOOSUaiGd1xxfm3K0zUDw+yyJVnUFHTURRvAbLYll3O3NphgiTOXuvA3VVyi8mj+ewkBqzpXmPB2gkBX+JoLzpDkGi0hJTFMWXMQ/gDZD9TZXEJBSGuEsmbQviiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783445430; c=relaxed/simple;
	bh=7ZlU2Qj02hyRo5e57kk/88bJCH8FaVr3ClifRh1OGAE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DUZyfONS6Rb136q487Jg68WZBeBPjX9YqIXkSsFhLEONiu2UTfiSRxgjKeHO2BzwzVx3jzE0mohv7ZU7PavUNokfGwFElw6srArbF4zsW97Y5qstc40R6iZNHE2G98bAWEOY601huYPAFYXr8Mah2da/Xi6+iXrcWCathq3eaJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GABSEKWs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GABSEKWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C4071F000E9;
	Tue,  7 Jul 2026 17:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783445429;
	bh=ka7ggRzfied3qfhHIe/OjukC+ZwbUroAiFebZNNQmXw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GABSEKWsJ60J9Hh4QxL6c+GrCX/vdS8l+Pa6WwLgOFnAonHKYEh1KfOHQQROrKCr9
	 INU08J1q7WqT29lw1kRnRTO2xl5wppPGGJLZGpSeJA3MQl01fkFe0Q3x0amcBxQyJc
	 MJTf5nu85lpKkt6/WIZ5qIfa86WWA+nuZa+5SHG/jFLq1iIL+deRQ8ES2vkC+TuQ04
	 UuoKehK0+6tp9nanrJgWya+93KcLpa/ufHdKPSGyGMFOe5QKGXfWoIgP9xcPrh5bRm
	 koEDKp0H7xJ05HfpLhw7FkQga5AP7uftpU55sl/8XaPtqTttYGmR+fx1mlr0d3xUN5
	 iuTKiEzq59e5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568C739253FD;
	Tue,  7 Jul 2026 17:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_nokia: validate firmware packet bounds
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178344540888.2101608.9319054193030015302.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 17:30:08 +0000
References: <20260706091701.77562-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260706091701.77562-1-pengpeng@iscas.ac.cn>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  6 Jul 2026 17:17:01 +0800 you wrote:
> nokia_setup_fw() walks a length-prefixed firmware stream and
> decodes HCI command packets from each record.
> 
> Check that each record fits in the remaining firmware image, that command
> records contain the HCI command header, and that the payload length is
> covered before submitting the command.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_nokia: validate firmware packet bounds
    https://git.kernel.org/bluetooth/bluetooth-next/c/a392bd47c5e0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


