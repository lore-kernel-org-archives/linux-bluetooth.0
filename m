Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4359D3ED3A4
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jun 2026 11:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782472621; cv=none; b=mtIpOevtd9/xF6nw4I1Nvna3LKItmIjqsuJ8E1W9Wl097e0KrJsEUtPRlc8Nlu86Iya1oItfjpvYbVVF1eARy6FngV60pH1M2uJvOuuW/5+0rL5j0QUAYcSpNK6wibbih22U3gOpfk0bEvRfHmUFSJmaPt0+33axpfflSu+iZuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782472621; c=relaxed/simple;
	bh=b8gLBh91AtTCGhKSGd5UZEAzcOtFLMRnnrOWDMfcQ4Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=anPN5RYL7SuwTaW7ul+6eD/wi4/CxNINA2YF9LSc7RkjVGCnRnNUG2ZnHrF6f/+AmuKM2ujzkhtMET2nh0VWy/EkpU7/ZIL1X0ok5Zt90Q6i/t29b4xF3a8ybr460hIG2djQ+ey4rpmuZFzAZlEZ6Atz5icsMuIZ9Kb2WNNE2PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eh4UVTC2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eh4UVTC2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E767E1F000E9;
	Fri, 26 Jun 2026 11:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782472618;
	bh=KxXuneznZwGFnTaUn+H8EkpnEtFMGkj6THzOoxmPvMs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eh4UVTC2UVqa9qMZrtNPQD3GWw8jvIObxnFkTMdD8wcZl0aPcDJPKgPYFSd2Ew3ox
	 ey7WL6+QRezK2QpA2/Lb/feY/EGPtlukvi3oQ9vFbkQHrs3+cGtrsf/nvuTQK6G3oa
	 0RGpo/1b+GOqNw6nKtKQeo8jQ4Z2AQX599r+AgSDRHDCOwokwss84Wg7oUyaaDUsNs
	 7G9Dhy7+H0rrBtBoharwPf2QGiVK/tUidqb2rTOH4ymT1Q7W6fLU1ri8LitIDd9WHA
	 AdWue+gkcQtTwsDtjrYFVaTSC7Ymt2QOUEOAHtEZKZp5n0XFWhC/8n2eUc37Y53tUV
	 HaIs/RYVx6BiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1975C39389EE;
	Fri, 26 Jun 2026 11:16:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: 6lowpan: hold L2CAP conn across debugfs
 control
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178247260556.3816447.5186241718967422819.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jun 2026 11:16:45 +0000
References: <20260623161259.2175870-1-zzzccc427@gmail.com>
In-Reply-To: <20260623161259.2175870-1-zzzccc427@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, baijiaju1990@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 24 Jun 2026 00:12:59 +0800 you wrote:
> get_l2cap_conn() looks up an LE hci_conn under hdev protection, but
> then drops that protection before reading hcon->l2cap_data and before
> lowpan_control_write() later dereferences conn->hcon.  A disconnect or
> device close can tear down the same L2CAP connection in that window.
> 
> The buggy scenario involves two paths, with each column showing the order
> within that path:
> 
> [...]

Here is the summary with links:
  - Bluetooth: 6lowpan: hold L2CAP conn across debugfs control
    https://git.kernel.org/bluetooth/bluetooth-next/c/d138ff8690c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


