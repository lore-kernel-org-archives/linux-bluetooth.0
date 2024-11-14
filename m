Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC76CBE4E
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 20:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731616818; cv=none; b=PwGWRmspYPqxtUUwc09Pk+GhfeWcdhCtfndfVS5cRcyB/fSqqQcDbENwtmHM45DhZHvGrnI1viS4LvQnkkAphBB+FJymKjlGJ0q5xSVUL/E5SK5yvMzVdIYm8d1eGnctWBVZCZzl1DLEpBH0U26ge6g/Ks/b7AeLc3rZjgZtizI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731616818; c=relaxed/simple;
	bh=R8+IUNPP3zb47jk4lQA+8VxsUwawU8cxk8TcrL2qW+A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=epgcJ11pQ66qPLBFbEztRdz/y1Z6F4R2+cG1Z6nRImibmEtuBbvv8S3/czOZSvu3mzqPZ1Uq6WReQ9Oo3goAdunLrHGmwD0hkZpK48L00VOlBb9f/2SZWs+bNUylxI007QrFN+95kUKLzIzUIab8Z9+mZ7SjweNfKgpNp0C/JZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3qprrOQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3qprrOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F475C4CECD;
	Thu, 14 Nov 2024 20:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731616818;
	bh=R8+IUNPP3zb47jk4lQA+8VxsUwawU8cxk8TcrL2qW+A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g3qprrOQXPAuffYtpXZ6THr+MmR+ichkRbPCLykaPFKzakLlP/1j1okLFgpCj2QAC
	 YwEx25JNj9W9qWiMLG0J36q64go7GR67G1YydLxKeuTcWeBODdLV5PsrFeb6IwsiH4
	 I9oF0dy9+WGVcnmFgSn6cCYT1ozje5neHqzW/GVasQT1QDD2efaX2BhSrhxGiWI93m
	 K0RcxPyS58UGGPL7l4RyAHB5Adxc3yhLZeqrA/uljFnoQ9ydY1L6mjlEzpyegX3gwm
	 TosuZ5a+tLnHEVGqhB72WXPlIkyt7UO0ZAXt3NMIKsNG4WyqPRRJ+ECoEIW1TpovnO
	 697rhLpC5ecMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3427C3809A80;
	Thu, 14 Nov 2024 20:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/5] mgmt-api: Add Send HCI command and wait for
 event Command
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173161682901.2049385.11435509102865762627.git-patchwork-notify@kernel.org>
Date: Thu, 14 Nov 2024 20:40:29 +0000
References: <20241114192524.1856334-1-luiz.dentz@gmail.com>
In-Reply-To: <20241114192524.1856334-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 14 Nov 2024 14:25:20 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds Send HCI command and wait for event Command initial
> documentation.
> ---
>  doc/mgmt-api.txt | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)

Here is the summary with links:
  - [BlueZ,v2,1/5] mgmt-api: Add Send HCI command and wait for event Command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fe1296cb1156
  - [BlueZ,v2,2/5] monitor: Fix opcode for MGMT_OP_MESH_SEND_CANCEL
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2e981e1a9498
  - [BlueZ,v2,3/5] monitor: Add decoding of MGMT_OP_HCI_CMD_SYNC
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d395c6b1c7d4
  - [BlueZ,v2,4/5] lib/mgmt: Add definitions of MGMT_OP_HCI_CMD_SYNC
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0580dc4bb64f
  - [BlueZ,v2,5/5] client/mgmt: Add hci-cmd command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=95e89cd2e4f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


