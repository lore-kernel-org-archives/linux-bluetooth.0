Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB3E15624B
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 14:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748962200; cv=none; b=X+waaB5SUecXXXrTaNkEMcCX2x+1dIZ8UJKfpSyhLx7ku30XLYNcRJ231YG8Jt79bhiVmxd5rqnb4h0iuvsR6hzR/tm+xq/tEfSmqR2QL7R1A6zPEKcWF8QoFLcEtH9uRr8jd01ZhLoqKYRgjFyYAA8zwodjKR8C8HNzXVXzN3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748962200; c=relaxed/simple;
	bh=6J7LVbbi6wZB8RrwO9yk+Z6eCxEZLqWh+BsnzMIlWsI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z6EkJUh856NMeHgCtxhI+0AnDoYk6oSgdmn0BqpMUVPxmFUKR3ilclSx2gE6xJ5+zMt88ahzyRl9BtTsVncFmraNgD1xsWwQ+hW9nl+lo+bPns3Z+RjgbD+twWfs/hJajAIEURWM06Yds6qI15KAskQU3jdujtu0jlEP7I8Kg+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwkbZ20c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwkbZ20c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A5AC4CEED;
	Tue,  3 Jun 2025 14:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748962200;
	bh=6J7LVbbi6wZB8RrwO9yk+Z6eCxEZLqWh+BsnzMIlWsI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gwkbZ20ctsXuHGT+FNZbv1HrM4vIZBXwqZei8QbEtE1iOTPqMyWSnAxUR9ea0zMfp
	 eC0+Yj5CuSezXoVIy8JYavXO23Rgxr2sagnQENMLak6m4eK+CL00FwkhF37zMtiEX2
	 nNngxqDWCCwwpJOed9B7JNZTVB411O/p7HJLuzq/NpyD7bvcyv4ryxyIeuGEbaGRUA
	 vnWCnPNpXod8zewZgbTfM8bOC84SgRw/H0fUboC203UTc/E0kaiaShZg6ZmNXJK2fy
	 V342WdVzmeiEDJcphH4OQ8snzqUO/3A/1B7MBB18elAAMwqyd9HO+MLIM4BLdIQUnD
	 7I1gwqOl+r1oA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC4D380DBEC;
	Tue,  3 Jun 2025 14:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/3] Bluetooth: btintel_pcie: Fix driver not posting
 maximum rx buffers
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174896223248.1544228.13563513642430079551.git-patchwork-notify@kernel.org>
Date: Tue, 03 Jun 2025 14:50:32 +0000
References: <20250603100440.600346-1-kiran.k@intel.com>
In-Reply-To: <20250603100440.600346-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com,
 vijay.satija@intel.com, aluvala.sai.teja@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  3 Jun 2025 15:34:38 +0530 you wrote:
> The driver was posting only 6 rx buffers, despite the maximum rx buffers
> being defined as 16. Having fewer RX buffers caused firmware exceptions
> in HID use cases when events arrived in bursts.
> 
> Exception seen on android 6.12 kernel.
> 
> E Bluetooth: hci0: Received hw exception interrupt
> E Bluetooth: hci0: Received gp1 mailbox interrupt
> D Bluetooth: hci0: 00000000: ff 3e 87 80 03 01 01 01 03 01 0c 0d 02 1c 10 0e
> D Bluetooth: hci0: 00000010: 01 00 05 14 66 b0 28 b0 c0 b0 28 b0 ac af 28 b0
> D Bluetooth: hci0: 00000020: 14 f1 28 b0 00 00 00 00 fa 04 00 00 00 00 40 10
> D Bluetooth: hci0: 00000030: 08 00 00 00 7a 7a 7a 7a 47 00 fb a0 10 00 00 00
> D Bluetooth: hci0: 00000000: 10 01 0a
> E Bluetooth: hci0: ---- Dump of debug registers —
> E Bluetooth: hci0: boot stage: 0xe0fb0047
> E Bluetooth: hci0: ipc status: 0x00000004
> E Bluetooth: hci0: ipc control: 0x00000000
> E Bluetooth: hci0: ipc sleep control: 0x00000000
> E Bluetooth: hci0: mbox_1: 0x00badbad
> E Bluetooth: hci0: mbox_2: 0x0000101c
> E Bluetooth: hci0: mbox_3: 0x00000008
> E Bluetooth: hci0: mbox_4: 0x7a7a7a7a
> 
> [...]

Here is the summary with links:
  - [v3,1/3] Bluetooth: btintel_pcie: Fix driver not posting maximum rx buffers
    https://git.kernel.org/bluetooth/bluetooth-next/c/31b3d39c89f9
  - [v3,2/3] Bluetooth: btintel_pcie: Increase the tx and rx descriptor count
    https://git.kernel.org/bluetooth/bluetooth-next/c/e849b59c9db0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


