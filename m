Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EA52D739C;
	Wed,  2 Sep 2026 21:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384672; cv=none; b=XfrdNw9fQ8Egt/chRTwWVIar25WLGRwSV4zIvhgN1F3f0ESkwNsB8cB41r8sjFtJwnhWLhPJGiyz8p3JXuUSPW2W1AiWcYNW2cVEcBSwMrQFWJMkpRMENsWBEar8G2Bs3jS3A90VjqyurTxGDGkD9hkxJ88nVLueeVsqfwJhBQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384672; c=relaxed/simple;
	bh=Kj3bxi0flrkSvFaicvTf9BYfe+jbliuQQR/jhW2MpJY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jYWb6/FITpOXwX8naX+xwckqCVQk0aHaZRG5st2xSaEuPaTNMXpUjAZNn4cBI9WiN6y3tPfk/jbXOmiFhJ+Yp33BwxhbeHd+eD4ugZMx5XJSiJIm4FPVXe6PF6mYV/ON6cYp/vOWiYvg7/FA1nXXvdxljNJkNdVjtPnknowN5SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnAXhnO+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnAXhnO+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D591F000E9;
	Wed,  2 Sep 2026 21:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788384665;
	bh=+p+BmNLmT1SKv1gqG4ZuXT/+T0FkUScI040XPAxNxHg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZnAXhnO+O5ihgOaWvXRLsTByLrSjybFUgjLhioqn6eDWZ8pbelL3hlE4SqKTWIWXc
	 WP3d7Dg4HUCQNjnAhLH6I98TMxookj2jcGmzfOdRKVDcmltfJPZOOAL95B/a4ODVJ6
	 G4Xgady+xcoa6rC/dZ49C/fOXNFnftPZnO1hLvQpUQEVOE5xXCWMGxDFJbOyCyVjpq
	 lfi6PaVgZap5MlIvWT3t/ptTAhXUlsxim6ahVLVAzZpnSrfvMNuOaFC6Zgd89IcJA4
	 +8RGIBmLIf4zgDLsH5eoVvg+yv2pisQafeZF5qf3ExTxjiLVwwusNwYz6Jf9T15ymQ
	 HrrLrOwn9qRew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B4E3927045;
	Wed,  2 Sep 2026 21:30:08 +0000 (UTC)
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
 <178838460764.2957558.9167588069983760163.git-patchwork-notify@kernel.org>
Date: Wed, 02 Sep 2026 21:30:07 +0000
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
    (no matching commit)
  - [02/16] Bluetooth: L2CAP: add l2cap_chan_close_unlocked() and locking helpers
    (no matching commit)
  - [03/16] Bluetooth: L2CAP: fix race condition in l2cap_sock_shutdown()
    (no matching commit)
  - [04/16] Bluetooth: 6lowpan: use l2cap_chan_close_unlocked()
    (no matching commit)
  - [05/16] Bluetooth: L2CAP: remove unused l2cap_chan_close()
    (no matching commit)
  - [06/16] Bluetooth: 6lowpan: avoid concurrent peer_del() in bt_6lowpan_disconnect
    (no matching commit)
  - [07/16] Bluetooth: L2CAP: hold conn->lock for __l2cap_ecred_conn_rsp_defer
    (no matching commit)
  - [08/16] Bluetooth: L2CAP: hold l2cap_conn::lock in l2cap_connect_cfm()
    (no matching commit)
  - [09/16] Bluetooth: L2CAP: add annotations for l2cap_chan list locking
    (no matching commit)
  - [10/16] Bluetooth: L2CAP: take lock for l2cap_chan_del in l2cap_ecred_rsp_defer
    (no matching commit)
  - [11/16] Bluetooth: L2CAP: hold chan in l2cap_ecred_conn_rsp()
    (no matching commit)
  - [12/16] Bluetooth: L2CAP: annotate locking for l2cap_chan_del()
    https://git.kernel.org/bluetooth/bluetooth-next/c/6873eb51dcdd
  - [13/16] Bluetooth: L2CAP: annotate locking for l2cap_ops callbacks
    https://git.kernel.org/bluetooth/bluetooth-next/c/4149ba2a806c
  - [14/16] Bluetooth: L2CAP: make concurrent l2cap_set_timer() refcounting safe
    (no matching commit)
  - [15/16] Bluetooth: L2CAP: remove conditional locking from l2cap_connect()
    (no matching commit)
  - [16/16] Bluetooth: L2CAP: refuse __l2cap_chan_add if chan already has conn
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


