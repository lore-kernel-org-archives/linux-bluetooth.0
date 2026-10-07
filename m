Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB02C4C7525;
	Wed,  7 Oct 2026 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394213; cv=none; b=t3wRJKuKIpg6M+MFHVKtzVpd9gSX111cWeVe9CLprgvo1S4d9Iql1jftAUKQlTC69SIKx/tHr0S8NYTKUr1jwYkpX+yTv6gsQ8G1X4iQWPGQOO6PFgIHexBfI4YyPUtDuT5zai50yUqE9DOePKIsy1G08QALCXcjSNH2mjVoezQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394213; c=relaxed/simple;
	bh=GWVLGRxTAAkykQcJL70LWPC57b5ewCC4HbDgnox4Idc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pTWAh3WMljLcRjmuQvfpCqym/MSugHV8jsBqg9ILmkK6OofJugRTO+bwUyRBfM5VWartbr8bQ/C546C8UhlYEx28jWdZWmWnf2tu7oXyxRJUL7emUkLr5l9dFfNC8FhTcyn9YxMz6Tq7KXO1dXbs6w/+yjp6YJ5n2x1lkpYCNLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rt9U5T2A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rt9U5T2A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA161F000FF;
	Wed,  7 Oct 2026 17:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791394207;
	bh=JPxrYKtTJO509C0BCMi9HW+VM0RBq9UfJBLmILQqu0o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Rt9U5T2AQ2jquMKV0jXaiXpzQaFsuiJUis9tbQ6SqfYjkf9r71YaxHkcMiuAiaQqG
	 mNs+HuJxT/2AHUEDM/o14xUfm9sXykuTcYSY6RWsaFUuFtjLeygIVkO30TtJeZk2Yl
	 B61N1BwNzZ0R2/Zmd7dUF8ZPAk7Urj3rAnYVIFlVIK76uSXet1ILn3YZtbnCg9I8ZP
	 Ag1wh78/fIymmfH0OdGcPTUeA8KvALr/vtFok5rfRmEXaQtkuEtRTCiuUnW+Kkj84C
	 XABydSnrXhX+vopVLPMQTj9IyPkblkBB8lrzM3Kqb0DagpIsxKiOepJoyP69OmauaV
	 KkqCek4UPTT/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44843808209;
	Wed,  7 Oct 2026 17:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: 6LoWPAN: Use RCU-safe device list removal
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179139420653.3628206.2096536706982565327.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 17:30:06 +0000
References: 
 <pm-bluetooth-objects-candidate-0231-v5-32295fa35099b0d50b92@gmail.com>
In-Reply-To: 
 <pm-bluetooth-objects-candidate-0231-v5-32295fa35099b0d50b92@gmail.com>
To: Cen Zhang <zzzccc427@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, jjzuming@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  6 Oct 2026 15:35:23 +0800 you wrote:
> RCU readers of bt_6lowpan_devices must be able to follow an adapter's
> forward link until their read-side critical section ends. The entries
> are published with list_add_rcu(), but device_event() removes an entry
> on NETDEV_UNREGISTER with list_del(), poisoning that link.
> 
> When an adapter is being unregistered and 6LoWPAN is enabled, a
> 6lowpan_control debugfs write with an existing LE L2CAP connection can
> enter lookup_peer() after unregister's first synchronize_net(). If the
> connection has no peer on that adapter, the reader must advance to the
> next list entry. Neither RTNL nor devices_lock excludes this RCU reader.
> 
> [...]

Here is the summary with links:
  - Bluetooth: 6LoWPAN: Use RCU-safe device list removal
    https://git.kernel.org/bluetooth/bluetooth-next/c/fabf38c7e07f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


