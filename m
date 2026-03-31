Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1C53FB7F6
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967426; cv=none; b=EhcWWNmuebEi8ANd6wGBXdFFJjAGJcfOjaEFbXEwTFPIZxfJVbivuynPYgInZmagwX6kB3X78ccDZkvAmL8spk7mQB+tvxjr5ZAELjtqmxh4mwKB6jbjeF0YafbUdhPGekRG78wvTXGqq++o4JhqDLDMV6TR+cz7cSbr/ppnQA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967426; c=relaxed/simple;
	bh=uffDqo6wzxHl6riEfG3Jmly81N/VUXSDdw/2HpmnZAQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SYjYJPcEIZ1kxloEglEpFyoiPbeRF/gH2qH/MrJLLIQhOPmkN5zUMfTYMe15wodL8JG5rwdY13gqwOj1E2KFjkjxzBJH7adeoBLa5sd3s99nnDKmXH8sk63/eGpAK/PezhL2yndevXTokWvQmXOINNmtKDlZR5CJnNxswjS5OII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzaPoJw3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzaPoJw3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337D1C19424;
	Tue, 31 Mar 2026 14:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774967426;
	bh=uffDqo6wzxHl6riEfG3Jmly81N/VUXSDdw/2HpmnZAQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RzaPoJw3Bxv+UANHEfA7JVSGIE4bTxizMW1xucFO3/EOQDwHcaKZ+o95AlVPUEVaO
	 qwJ5+j+OppGOWIYIr2jZ7OIDhnj/IxXauv5+H6Ykuh66CakM9EdgrJNdv76FjQ/CYV
	 OmnJD0UjEETcAXKNCy+NLEEW+er3Zrr5N/bd8JDaiZ8COobHoWuP7kba2gtmb+lmSv
	 8glc0+9ZcZJJeIr4fNHO/0CR+VvQyigoi50Fe9fsngjTGpkrkpL/Bl04zsj5IvbW4z
	 iQG4wo2b7ptzxuqcwGGkyNA0tSI+/C/cRpa9C+N1YC+kbLAqhFrIRnVoM6Cvud7rzW
	 WhbZtIDfyefYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C373809A05;
	Tue, 31 Mar 2026 14:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: fix locking in hci_conn_request_evt() with
 HCI_PROTO_DEFER
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177496740953.2731558.12495255644281555301.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 14:30:09 +0000
References: 
 <089f435fb4668921bb416a3d60fa0f232456e054.1774791296.git.pav@iki.fi>
In-Reply-To: 
 <089f435fb4668921bb416a3d60fa0f232456e054.1774791296.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 29 Mar 2026 16:42:59 +0300 you wrote:
> When protocol sets HCI_PROTO_DEFER, hci_conn_request_evt() calls
> hci_connect_cfm(conn) without hdev->lock. Generally hci_connect_cfm()
> assumes it is held, and if conn is deleted concurrently -> UAF.
> 
> Only SCO and ISO set HCI_PROTO_DEFER and only for defer setup listen,
> and HCI_EV_CONN_REQUEST is not generated for ISO.  In the non-deferred
> listening socket code paths, hci_connect_cfm(conn) is called with
> hdev->lock held.
> 
> [...]

Here is the summary with links:
  - Bluetooth: fix locking in hci_conn_request_evt() with HCI_PROTO_DEFER
    https://git.kernel.org/bluetooth/bluetooth-next/c/31798ffc35a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


