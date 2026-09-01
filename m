Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D9549F13E;
	Tue,  1 Sep 2026 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788289868; cv=none; b=IJFd+hUYD4hjaPCS61KjvavKzLta6NISF9tjBWtzrX4KGpMWOgtda70eMpDwvSu7BlaZnFi2N7zF1/lYcRFMK3CJwk4qK+gLAxPxsdkLcCWAdhMuSpiOtAh4psZw7FYSsX3VmtsoCDtqouUsv9Xk8n+DYzaGpDLGdKfJVO1Of0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788289868; c=relaxed/simple;
	bh=rs0jCfJXyjnPvhTklQ/4yWYYNyY4EwZ8N29mEDVsO5I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DpKnlwwEr0XluB0xLzo6aUrAY1lp7IaRVM3uzs81uPogUdTIqEOhJabu+VHRq+vP7F2OOrRrYDAUa3Mp+SdC2O1jqFou+Njan9hInvcSUnLcuPAf9NQCiiuVwKveMg8+RCyMJdVoVy4uNwpGjAqggTeJ4YuHknS9Poueb4uJf0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6NpF66X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6NpF66X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5B7C1F000E9;
	Tue,  1 Sep 2026 19:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788289866;
	bh=VaVNWr+zO2+Vhz9h17a5NMUgtZKXJ7bOKDal6FUnz1k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=e6NpF66Xr2BqZK/XcDuxd327L0dDvovUhBtJ1rqLfXVOJmXPhHoIr7DnYPQ5qA34y
	 KsRhvaF416qKBQG8AXCtGjZiRi+P4iaKe32al5LAbDfRCeNm8YscZZhhfg0bknTM+b
	 Mmhbz/dM+vgQ6qkhv9Z0GytCJ5qFt5d2APqHdbx/EHSCVMSE05pPsaGNxblpjYQDY/
	 fxSO5+y/+MybsYl9ykoPta8FKtnNS1XxP8+rcn5FE++yPz1EDSndBNXkA7OTESFosW
	 U0K7dveg782aaPt+ZFy72y1fHRXNwwEbN3GJHYmjIJ6wZA7Ec9GwlzdqAgIJzsj4Dl
	 7NgdxM3wDfKuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9392B39253E6;
	Tue,  1 Sep 2026 19:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 00/16] Bluetooth: L2CAP: fix and annotate
 l2cap_conn::chan_l
 locking
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178828980914.1804078.16309494402667039315.git-patchwork-notify@kernel.org>
Date: Tue, 01 Sep 2026 19:10:09 +0000
References: <cover.1788013041.git.pav@iki.fi>
In-Reply-To: <cover.1788013041.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, oss@fourdim.xyz, error27@gmail.com, elver@google.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 29 Aug 2026 17:19:55 +0300 you wrote:
> The intent in current code is that:
> 
> - l2cap_conn::chan_l read/write is guarded by l2cap_conn::lock
> 
> - l2cap_chan_del called with held l2cap_chan::lock (l2cap_sock.c uses
>   this)
> 
> [...]

Here is the summary with links:
  - [01/16] Bluetooth: L2CAP: take chan->lock for l2cap_chan_add/ready/del
    https://git.kernel.org/bluetooth/bluetooth-next/c/ca52f4764c87
  - [02/16] Bluetooth: L2CAP: add l2cap_chan_close_unlocked() and locking helpers
    https://git.kernel.org/bluetooth/bluetooth-next/c/368dc7fcaced
  - [03/16] Bluetooth: L2CAP: fix race condition in l2cap_sock_shutdown()
    https://git.kernel.org/bluetooth/bluetooth-next/c/86b377359826
  - [04/16] Bluetooth: 6lowpan: use l2cap_chan_close_unlocked()
    https://git.kernel.org/bluetooth/bluetooth-next/c/4e64bd587b64
  - [05/16] Bluetooth: L2CAP: remove unused l2cap_chan_close()
    https://git.kernel.org/bluetooth/bluetooth-next/c/c5123fddfef1
  - [06/16] Bluetooth: 6lowpan: avoid concurrent peer_del() in bt_6lowpan_disconnect
    https://git.kernel.org/bluetooth/bluetooth-next/c/02122fd80029
  - [07/16] Bluetooth: L2CAP: hold conn->lock for __l2cap_ecred_conn_rsp_defer
    https://git.kernel.org/bluetooth/bluetooth-next/c/62df59925278
  - [08/16] Bluetooth: L2CAP: hold l2cap_conn::lock in l2cap_connect_cfm()
    https://git.kernel.org/bluetooth/bluetooth-next/c/604e2f6d1e95
  - [09/16] Bluetooth: L2CAP: add annotations for l2cap_chan list locking
    https://git.kernel.org/bluetooth/bluetooth-next/c/886931f0c7e6
  - [10/16] Bluetooth: L2CAP: take lock for l2cap_chan_del in l2cap_ecred_rsp_defer
    (no matching commit)
  - [11/16] Bluetooth: L2CAP: hold chan in l2cap_ecred_conn_rsp()
    https://git.kernel.org/bluetooth/bluetooth-next/c/26836086682a
  - [12/16] Bluetooth: L2CAP: annotate locking for l2cap_chan_del()
    (no matching commit)
  - [13/16] Bluetooth: L2CAP: annotate locking for l2cap_ops callbacks
    (no matching commit)
  - [14/16] Bluetooth: L2CAP: make concurrent l2cap_set_timer() refcounting safe
    https://git.kernel.org/bluetooth/bluetooth-next/c/761224d13f8a
  - [15/16] Bluetooth: L2CAP: remove conditional locking from l2cap_connect()
    https://git.kernel.org/bluetooth/bluetooth-next/c/2c127ee79a0b
  - [16/16] Bluetooth: L2CAP: refuse __l2cap_chan_add if chan already has conn
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


