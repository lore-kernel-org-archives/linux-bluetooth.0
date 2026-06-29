Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0B8395AD0;
	Mon, 29 Jun 2026 18:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782759101; cv=none; b=oyOHfV6T7qeWJGulOatOBClzksDTmxyMUPo6Ivun86AIZbcRQ8I//ISQT6aAXRgz++z8zv0eyi8FARWMwsR7fj2ecsvvJsgxY+27tDatRWyFCrPNVc8zdYdDty2LQ83QoC5EWCkACJbtcNvqPPw/rGyGmGg4+VCNhMD39w3mvNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782759101; c=relaxed/simple;
	bh=8SQmdna1omD3izGkmc/PeLA/dr4wvD+czfDMl31NYIM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=cvlCh4Yx+2FYg0peeT5dYX8eu18tRBrBubxQwYlNygNurr6W8CbjQPl3Dyug59g0vm3jWc9h3QeDyVSWlNnlbK+WJQ38M9uHd56DqMw7PZ5hsgXykfAN4qH9tLw1GV3TTySDh4LajYc11IpZmq5C8+UMXhly+669zdYxe1rMrCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hF7on8x4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hF7on8x4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A5A1F000E9;
	Mon, 29 Jun 2026 18:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782759098;
	bh=8SQmdna1omD3izGkmc/PeLA/dr4wvD+czfDMl31NYIM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hF7on8x4o0N1vx4yy0nENiFK+a0zUQ04fNEY8J3bfnL68dLuk17Kt/HJaSKBuP2fd
	 Sdho1zyVrw6dMgjrI7eOOkJmU/U6BzY83igaBYytRz6cErfKbOj88f1YGmNUUSF9zJ
	 0hVNx++qz9IFGjHSE+HgS8uNM11YVHNNBQ7cQoOPG4Bou8EULz4B3z5rfBY0fLCJj7
	 vv46BfTWP8sBrOu2jmdgfyUADFFH2Y8Q1xvneJRoWA5qSixAReGME07kPL9NdnsRdQ
	 WU+N3TlEzNm1/3p6WLRUv7j7BsjS/c+dqKtKHGdN/5O7m1HBxGgSvejR0gckYwOtpL
	 envwDQO0EkbkA==
Date: Mon, 29 Jun 2026 08:51:37 -1000
Message-ID: <1793c0326127168c468d0e363723f55e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Sanan Hasanov <sanan.hasanou@gmail.com>, jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Cc: syzkaller@googlegroups.com, contact@pgazz.com, Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org
Subject: Re: WARNING in delayed_work_timer_fn
In-Reply-To: <6a3eeec7.ade5411d.badf0.e138@mx.google.com>
References: <6a3eeec7.ade5411d.badf0.e138@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

Hello,

> workqueue: cannot queue hci_conn_timeout on wq hci4
> WARNING: kernel/workqueue.c:2271 at __queue_work+0xd2b/0xff0

conn->disc_work (hci_conn_timeout) is a delayed work item queued on
hdev->workqueue. Its timer expires after the workqueue has started being
torn down, so __queue_work() refuses to queue it and warns.

Arguably this is a shortcoming in workqueue, but as it stands a delayed work
item has to be canceled explicitly before the workqueue it's queued on is
destroyed. disc_work needs to be canceled on the Bluetooth side before
hdev->workqueue is torn down.

Thanks.

--
tejun
