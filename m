Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68C81547C0
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764834; cv=none; b=OXWCrFNnADFthfJvDD9zfsjyvo4BOeDQ6aH0XTvHiEJOquaz+iL9lrCn088H/8O83OUcaa/5UGMPbQhaXPK5i4Sq+dkLYNpitMKgteOYRxv6QudWk0dtw62OECWZS44jkiL1MmwaZwBA6Si5NKuGdlzxE/KvJIb/53rEtu2bmVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764834; c=relaxed/simple;
	bh=XLxJ0dfSPcpOXGm+qla0a+UwwrqritiIzMGcU0CQSYo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aJ9LddwdxDSKaG1Xn1uiZ/3iceFu5UgOco4M5VbKmB6ifj6jOXwGOy5tN3Eymk/yHf3lqdAk7PudAZBt6IKygKBKdqGujtLOFWRcHYip+UDrWYc7rB2tOMZqm0EDpbHR/YfEugYwPiEQ2IItgNODucrlO09MVBknhrCrD0O2iD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tC0wHs6u; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tC0wHs6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E382C4CEF7;
	Thu,  9 Apr 2026 20:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775764834;
	bh=XLxJ0dfSPcpOXGm+qla0a+UwwrqritiIzMGcU0CQSYo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tC0wHs6ugy8qegwG24+eRhtdY/oAfofxMARyq12YD+uM9Jj1Zgpy9ZBat3ZQfgHi4
	 zNK5vwymSPbWCNh3vq5x1pH9iKDDnNX66wyVFOj7v9U1Et2U4a9dtR9zeK8mJmsZrA
	 zq0qUFBXyOog3dcmx1UZ1I0oryF+xJadKSgrOL3Zpfa3+Bz9oExdRVEKd9s9kxizFP
	 bpOk3meDCTb+eellHWGzXBhPEPF1xMKXNqUbnleNwhOMMgXFp8C6KtCmjGQUAHzpAK
	 3rKzOgiuexU2eUU8lGFW1r/sMwW6OX7pctFWh3sku0neJQ+cx4PE8m3ImeosBtYLHK
	 ewvUr6YzZ6BWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C3339308B7;
	Thu,  9 Apr 2026 20:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] shared/gatt-server: Add
 bt_gatt_server_set_permissions
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177576480953.1716836.5463745317091281451.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 20:00:09 +0000
References: <20260408201415.488511-1-luiz.dentz@gmail.com>
In-Reply-To: <20260408201415.488511-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  8 Apr 2026 16:14:14 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds bt_gatt_server_set_permissions which can be used to
> enabled/disable permission checking before operations which can be
> useful on testing only environment where encryption/pairing is not
> desirable/needed.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] shared/gatt-server: Add bt_gatt_server_set_permissions
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=950853f32861
  - [BlueZ,v2,2/2] main.conf: Add GATT.Security option
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=516099a9d405

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


