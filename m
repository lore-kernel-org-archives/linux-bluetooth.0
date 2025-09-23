Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6C014A0BC
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Sep 2025 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758635410; cv=none; b=BTW31FYxCSkDt55WDCb8BWr9iI3xRiX+hglBCVuR0tvQwZA4CMlPxe4U95JEuNWTrFcKUJPgu7PDA7sH7motkojEP/PTjRXmDWbqI9iRDS5TQcIA+rYJIcInWXzxwYLCpdCFUkJArDvQlYJVW1zkOhd/fLZiKbntb2CJeUxzwsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758635410; c=relaxed/simple;
	bh=1eHNRqhT9Wqzr44Kux32T66NGlJbBvHmRQxiMhhTLWI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZUrLxN4wDlze8fFWlCzfyBYRE1gzp6c60+NIIqw4ttmUO4yZtr3I2nUr+C3XgKADfmJ3Zj5qYjaRPrByZgwaC8xfm81D6404jC5nIawskm7OvzXGMTTTRqnahGnrxqyzOHwjDbasFlD2cdEGAmvyIsPb0iT09tyRnmnDMJvzRjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwVu12l8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwVu12l8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D13B3C4CEF5;
	Tue, 23 Sep 2025 13:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758635409;
	bh=1eHNRqhT9Wqzr44Kux32T66NGlJbBvHmRQxiMhhTLWI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TwVu12l8w3Uh/EWmGDk8JGDDp5U8MGscOZXQd7L9HBn6md3g75GHfdx8WJbcn9+Xo
	 xSI4omsM5DFfyk6cgkGcMBy9jn1995QEIJgaCpY0vH1pM43Smabihc/MNx+Pw6LsJx
	 6xQ4Gay46WS+mD6eDm0BoHlXEhkECLLSCk1C2A0merU1bURx11GyqXtFA5+3Ur5X8o
	 r7S3ETx/4DnyIvhb07zOpPDmSGEZlqSqkzYW9gjVbVi79wR2mm1Gk+coXjEE1o+kuR
	 3qUpuGpfX/RUrA43xr6NLkyQbw1cLjUWtFJWDo3A1jHllCLg7uf02+rJ58OfuUOX8/
	 V2wr6SCJq3E/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CFE39D0C20;
	Tue, 23 Sep 2025 13:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC PATCH 00/24] Bluetooth: add locks to hci_conn accesses
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175863540699.1433266.16158218631524864208.git-patchwork-notify@kernel.org>
Date: Tue, 23 Sep 2025 13:50:06 +0000
References: <cover.1758481869.git.pav@iki.fi>
In-Reply-To: <cover.1758481869.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 21 Sep 2025 22:14:15 +0300 you wrote:
> (RFC since this needs to be tested much better.)
> 
> Each hdev has two ordered workqueues that run in parallel, in addition
> to user tasks and some timers in global workqueues.
> 
> Both workqueues may delete hci_conn* and modify their state. The current
> situation is there are races and UAF due to this.  In older kernels, it
> used to be much of the work was done from a single ordered
> hdev->workqueue, so one could be more lax with locking.  I don't think
> what used to be safe earlier is necessarily so now, so some simple rules
> are probably needed.
> 
> [...]

Here is the summary with links:
  - [RFC,01/24] Bluetooth: ISO: free rx_skb if not consumed
    https://git.kernel.org/bluetooth/bluetooth-next/c/b18365fe359a
  - [RFC,02/24] Bluetooth: ISO: don't leak skb in ISO_CONT RX
    https://git.kernel.org/bluetooth/bluetooth-next/c/f7db34762ae5
  - [RFC,03/24] Bluetooth: hci_sync: make hci_cmd_sync_run* indicate if item was added
    (no matching commit)
  - [RFC,04/24] Bluetooth: hci_sync: hci_cmd_sync_queue_once() return -EEXIST if exists
    (no matching commit)
  - [RFC,05/24] Bluetooth: hci_conn: avoid ABA error in abort_conn_sync
    (no matching commit)
  - [RFC,06/24] Bluetooth: hci_sync: avoid ABA/UAF in hci_sync callbacks
    (no matching commit)
  - [RFC,07/24] Bluetooth: hci_event: extend conn_hash lookup RCU critical sections
    (no matching commit)
  - [RFC,08/24] Bluetooth: hci_sync: extend conn_hash lookup RCU critical sections
    (no matching commit)
  - [RFC,09/24] Bluetooth: mgmt: extend conn_hash lookup RCU critical sections
    (no matching commit)
  - [RFC,10/24] Bluetooth: hci_conn: extend conn_hash lookup RCU critical sections
    (no matching commit)
  - [RFC,11/24] Bluetooth: hci_core: add lockdep check to hci_conn_hash lookups
    (no matching commit)
  - [RFC,12/24] Bluetooth: hci_core: add lockdep check to hci_conn_valid()
    (no matching commit)
  - [RFC,13/24] Bluetooth: hci_sync: fix hdev locking in hci_le_create_conn_sync
    (no matching commit)
  - [RFC,14/24] Bluetooth: hci_core: hold hdev lock in packet TX scheduler
    (no matching commit)
  - [RFC,15/24] Bluetooth: lookup hci_conn on RX path on protocol side
    (no matching commit)
  - [RFC,16/24] Bluetooth: L2CAP: fix hci_conn_valid() usage
    (no matching commit)
  - [RFC,17/24] Bluetooth: hci_sync: add helper for hdev locking across waits
    (no matching commit)
  - [RFC,18/24] Bluetooth: hci_sync: hold lock in hci_acl_create_conn_sync
    (no matching commit)
  - [RFC,19/24] Bluetooth: hci_sync: hold lock in hci_le_create_conn_sync
    (no matching commit)
  - [RFC,20/24] Bluetooth: hci_sync: add hdev lock lockdep asserts in subroutines
    (no matching commit)
  - [RFC,21/24] Bluetooth: fix locking for hci_abort_conn_sync()
    (no matching commit)
  - [RFC,22/24] Bluetooth: hci_sync: lock properly in hci_le_pa/big_create_sync
    (no matching commit)
  - [RFC,23/24] Bluetooth: hci_sync: fix locking in hci_disconnect_sync
    (no matching commit)
  - [RFC,24/24] Bluetooth: hci_conn: fix ABA and locking in hci_enhanced_setup_sync
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


