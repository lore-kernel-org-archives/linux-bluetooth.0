Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF7E50AC17;
	Thu,  3 Sep 2026 20:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788465684; cv=none; b=dSZbQY5/5SjYWzkjCm6NegmrQlSURhSQ138cvutyLgNM2aMkbO5VteKAOF6VGXJttFRUgiwKQtgkg3gDnWEY5c3m/bw5hm7zoQeAtGDS2c0bBpcmUFW6JwtN+qe//CmJjB24DXejDIp/z/8FWBQJqn+t3YIJOu9aEmqpzWWu6aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788465684; c=relaxed/simple;
	bh=aGNwq7Kvviw/cc3TCW+eX4DZyWL+IFSJfzi1cy5ikNU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WplF8CG0QeSED0jqd5Yw/0xDfyF0j+G+AZqubDo40YuujYGE7rYLiR1+U67/u04O5GQftJOe2Lb/XhUj0wY5n0x1uLqrNNivAjbRxLLDgEkuKvg+2i1rVzDXotMeYueZGjyVuVahDSWYAazZEs+oeOmVYCNSC2Jx5LaAgU4fODc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IM6pQQIw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IM6pQQIw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4161F00A3E;
	Thu,  3 Sep 2026 20:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788465668;
	bh=anb5ZX51IgRknK9+AQ+wqEgjShFooV2aevCkP7Q7Fqw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IM6pQQIwRVmsOViEt366I4QMI4Q6TDyEqmh+KZXdDfBozSmmp3FF3cjCsVZyxZmY5
	 PrFehNzkbD0s7VG98hWUtgrFnhMgplmIV91AaqzVzkdYmvDzCWZAaroneViH4QBHbG
	 IcRBJU0dsHdSPby6hMYog55FOtog90wkq8iKgULxfP/RSl0B5nIZW2QAhM6CSj83uB
	 JWtBwLAxCCnnCRie0spIraGGA/vffFcxHxslBjTxUh87ZN7cqaXIjKFKR83FJiom1K
	 ndTiI8ElxvYK0zzTOAm8zY9tkuM6++L9U8C+79/RxPIjP8YWpuvOQ81xEw7lE4ZlI6
	 bGs7vUZpgSEVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1967E38119DE;
	Thu,  3 Sep 2026 20:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add USB ID 13d3:3556 for RTL8821CE
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178846560963.3994681.5380639365119413064.git-patchwork-notify@kernel.org>
Date: Thu, 03 Sep 2026 20:00:09 +0000
References: <20260903170322.47004-1-aritra.rohit2003@gmail.com>
In-Reply-To: <20260903170322.47004-1-aritra.rohit2003@gmail.com>
To: Aritra Das <aritra.rohit2003@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  3 Sep 2026 10:03:22 -0700 you wrote:
> The onboard Realtek RTL8821CE combo card on the ASUS PRIME B550-PLUS
> AC-HES presents its Bluetooth function as USB ID 13d3:3556. This ID is
> missing from quirks_table, so btusb matches the device only through the
> generic Bluetooth class entry in btusb_table and driver_info stays zero.
> BTUSB_REALTEK is therefore never set, btrtl never runs, and the
> controller keeps executing its on-chip ROM firmware instead of loading
> rtl_bt/rtl8821c_fw.bin and rtl_bt/rtl8821c_config.bin.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add USB ID 13d3:3556 for RTL8821CE
    https://git.kernel.org/bluetooth/bluetooth-next/c/88a6bc5607e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


