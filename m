Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCC63172E
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jan 2024 21:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705613792; cv=none; b=imN9j2huBCaqrq9oCFftMOOKtMDynPKJbe2rDGCcjXKaJYIt3NFJZ8gfKNzFQwmL5nSWXaHTuFPBDDI+2vFOC1PyPD9wTVe9RHm0VOSlGOaifpwUKJ+8hE1C0OSlfjwpHPWthPFj01fOC8c8KMxfwqK4b1jKdmexTHTwsxZB0Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705613792; c=relaxed/simple;
	bh=bMEqRWuD7urM3WHeW0G+LaEFG9byxNr0+Ryh9CXghYM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oDrRTf0vTjpGTf0ZOHNpBYDcELh6NNLNerHk8rVo0BU9gan3Gq/bV0VEtjV3PXbA907FnM8ksF5zdko3Vc0mIl+jTB4K4g4cA+/48bPr77PR5RI8QA5GLwuAGV6FJkvfIwXbnsweJYzh+Wp9ATX/gauzxgDyVfNIX2z0+luLF5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CIDh1vxb; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CIDh1vxb"
Received: from github.com (hubbernetes-node-ad4181a.va3-iad.github.net [10.48.147.33])
	by smtp.github.com (Postfix) with ESMTPA id 0DACF8C1112
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jan 2024 13:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1705613790;
	bh=09rfP5zY5UHHH1DpVUHGH1QocYP+V/aEB1D5+hc6XvQ=;
	h=Date:From:To:Subject:From;
	b=CIDh1vxbKZn3jaMpx3zjlPGbnqC//CyJ+n2ScbKAkU13rE6hbGMVXXMXapzlhEDoR
	 idoJAI6llgb0FBwEP4VkJJ6w+guBwu5Th3y5PuLXOoi3EdBGmo0Fq5S7pBF0WBqY/Y
	 B+Y7miWSgNgL6Ivo9t5JoTZVo9sMqUGnc6/mjEio=
Date: Thu, 18 Jan 2024 13:36:30 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/3f490a-e108c7@github.com>
Subject: [bluez/bluez] 62cf4a: client/player: Add support for printing A2DP
 codec...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 62cf4a2ab52ef829ec50c68b5fb9438ecb383dbd
      https://github.com/bluez/bluez/commit/62cf4a2ab52ef829ec50c68b5fb9438ecb383dbd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-01-17 (Wed, 17 Jan 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add support for printing A2DP codec details

This adds support for printing Capabilities and Configuration of A2DP
endpoints and transports:

bluetoothctl> endpoint.show /org/bluez/hci0/dev_94_DB_56_F7_F2_88/sep1
Endpoint /org/bluez/hci0/dev_94_DB_56_F7_F2_88/sep1
	UUID: 0000110b-0000-1000-8000-00805f9b34fb
	Codec: 0x00 (0)
	Media Codec: SBC
	Channel Modes: Mono DualChannel Stereo JointStereo
	Frequencies: 44.1Khz 48Khz
	Subbands: 4 8
	Blocks: 4 8 12 16
	Bitpool Range: 2-53
	...

bluetoothctl> transport.show /org/bluez/hci0/dev_94_DB_56_F7_F2_88/sep1/fd7
Transport /org/bluez/hci0/dev_94_DB_56_F7_F2_88/sep1/fd7
	UUID: 0000110a-0000-1000-8000-00805f9b34fb
	Codec: 0x00 (0)
	Media Codec: SBC
	Channel Modes: JointStereo
	Frequencies: 48Khz
	Subbands: 8
	Blocks: 16
	Bitpool Range: 2-53


  Commit: e108c744fa8dfa1c4f54257532f3433a47179869
      https://github.com/bluez/bluez/commit/e108c744fa8dfa1c4f54257532f3433a47179869
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-01-17 (Wed, 17 Jan 2024)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Print owner information when it exit or release

This prints the owner name when it exits/quits/crash or releases a
transport.


Compare: https://github.com/bluez/bluez/compare/3f490a69cb55...e108c744fa8d
