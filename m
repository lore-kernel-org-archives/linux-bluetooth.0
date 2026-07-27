Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73563CB577;
	Mon, 27 Jul 2026 19:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785178858; cv=none; b=M9j2FTUpoAi1nWaNN1oknP31uYWbyOoZ6XxJfCWYtURfigbx6T3Z5+UQHJXllVB+79hTqMTZDuiAIz7vnxQRlEC6CQ4oyQK4ie3No5d5BkzBzbGCvrJfbWgOUIFD32ZNY9qhmWNBTiAVxs8cKOfS58YFaL6GRnhc2IH5KoPfqlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785178858; c=relaxed/simple;
	bh=nZETC5hCkdR78Qn6Fopp+uaXTALFs5Ue/2MDcj4urFc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z9xbk7S99hfNzMT9Yo+rWtgwD663v8Nyat1nhJITEAgHpr58z4c600aL5Nobg2rv5LaVHr7VCVpu2rJ8gndzowZ484vS3yKORRGcOksoIt9bfOY7cGItPqhqGR58RHmUV9/JR/IoRrSb2gFPD2cM357AuejMCxz0nwYwnlPlNFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHdLijLs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHdLijLs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D57F1F000E9;
	Mon, 27 Jul 2026 19:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785178841;
	bh=q19HfW6Hv6Mg1BHXXdZMdqj5ishUf9OayRemURJu8OM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QHdLijLsjP+HPiMETneeani4Q8RvydqDo+3Ea5clBXY/eyJA4jSMqVC6zOVyUXV2b
	 A7xx1Mf78asTwAoqHnt2EdCZpcpZEtNe4EOhQusRfg8Fj5SxmrY6Ez9OqC392wgLHw
	 pEkOopYCRKknKoX7PwadarpJu75+FxrX9njp4KndZPl+0gIyjAggxYuSWjXrMzJZZ/
	 J0V85scUegvYOVOPh9FFdWWffvonRZ7xIrtqa6kXg0d21Ad8zDG6Yb0arqMpqglyy+
	 r8gCp2TjZ0AMFS5HKYT6IXwAwK/rYdOcYrisYk1EsVTlcyhYgyuPHXPRjvZojA2hlU
	 9I64viMb75AxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1987D380AAFE;
	Mon, 27 Jul 2026 19:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/7] Bluetooth: hci_conn: hold conn references in
 hci_sync
 tasks
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178517880663.1372023.9123649060094265539.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jul 2026 19:00:06 +0000
References: <cover.1784973264.git.pav@iki.fi>
In-Reply-To: <cover.1784973264.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, oss@fourdim.xyz, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 25 Jul 2026 12:59:16 +0300 you wrote:
> Have hci_sync tasks hold reference to hci_conn pointer they want to use
> later.
> 
> Avoids UAFs and passing potentially reused (possible even if very
> unlikely) pointers to hci_conn_valid().
> 
> hci_conn_del() dequeues running works for the same connection, but this
> has no effect if the work is already started running, which is the race
> condition here.
> 
> [...]

Here is the summary with links:
  - [v5,1/7] Bluetooth: hci_conn: hold conn reference in abort_conn_sync()
    https://git.kernel.org/bluetooth/bluetooth-next/c/3bf1394e8868
  - [v5,2/7] Bluetooth: hci_sync: hold conn in hci_connect_acl/le_sync() callbacks
    https://git.kernel.org/bluetooth/bluetooth-next/c/69a694ebe97f
  - [v5,3/7] Bluetooth: hci_sync: hold conn in hci_connect_big_sync() callback
    https://git.kernel.org/bluetooth/bluetooth-next/c/b1196afe58a9
  - [v5,4/7] Bluetooth: hci_sync: hold conn in hci_connect_pa_sync() callback
    https://git.kernel.org/bluetooth/bluetooth-next/c/cddfec3618d0
  - [v5,5/7] Bluetooth: hci_sync: hold conn in hci_past_sync() callback
    https://git.kernel.org/bluetooth/bluetooth-next/c/3c5f5c6be878
  - [v5,6/7] Bluetooth: hci_sync: fix hci_conn_del() use in hci_le_create_conn_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/423e5fc465eb
  - [v5,7/7] Bluetooth: hci_sync: remove unnecessary hci_conn_get in create_conn_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/73b6871b261f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


