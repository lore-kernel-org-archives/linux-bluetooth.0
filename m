Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420503793CA
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jul 2026 15:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611039; cv=none; b=EGAv8Q+BfjLzGtlpRjRIA/+RSyBqvnTokyMWjyCiANvZGz9I+//XzFN0I/2oRHhv7yxWhi4vEnEQh0bGZfQcXj6vNYxb9UcqoT+sWjdAxUtPXn3MKXOd8VmgGyWY0PZesLDGNgFQBbKKezVvWl35K08PZLld2iYdEXTky+gKwtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611039; c=relaxed/simple;
	bh=u4OBDBehHFgM2XU8NWT/nzKMFWfULuiFN+7uUuCFr08=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TuUF/8T2RIsgX1LJEXMjqzbI/3FccHbn00Ac5mVoAJnXPhaMblxjchEnLj3PS13pu1VJ1IskOx6CQ6agT+rF+5yhbZ5D3j1tbUEinRKVSjCfeoNmZs6f+hhfXdTWMrr5xvnp/tdgQ/4t63UtPLa+Wx5UnzmsOqBKkm5IteA/QpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ld20gQIf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ld20gQIf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594C61F00A3D;
	Thu,  9 Jul 2026 15:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783611036;
	bh=QvVwuIWqPF50c6Y7vPPDL+/Nuw08gEu06t0cUaAASSw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ld20gQIfWEDIr/k9NuPhnz6upgggnwIXGatW1z+o9Zj+2Wmn59zX9rUrDpAHzJsnI
	 MzIvd9crrSdrFeoTlMrkTzjKmXNvZtpAVMz+G95sjl49yd75jlgR+AOqGAYN6ngN0i
	 VFGtyL2BwTuOvZKzgDv3qtxTo1tN85DS2xHFJNIQoWX8T3InMoTJg8a/4z5ShrDhTq
	 /ss+7Bhz9KtwlsFhjy4FBXvuIQKisT5JtBR8KvXUhzCzZ4OFWKOSzhcmmBKOvjTP2K
	 fL+doKox+FKvFIo87AoFFlafvjnKifd+zhSO8BAEgc61FeL8wejzcihFHcdn++vXaY
	 XKJfAZeeZ0Gnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198FD39250E0;
	Thu,  9 Jul 2026 15:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/bap: Use util_ltv_foreach to process
 metadata
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178361101463.3546291.10810412259359588342.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 15:30:14 +0000
References: <20260707183944.1215551-1-luiz.dentz@gmail.com>
In-Reply-To: <20260707183944.1215551-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  7 Jul 2026 14:39:44 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes use of util_ltv_foreach to process the metadata entries
> instead of attempting to iterate over the entries manually which
> probably only works with the exact same order as used by PTS.
> ---
>  src/shared/bap.c | 88 +++++++++++++++++++++++++++++++++---------------
>  1 file changed, 61 insertions(+), 27 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] shared/bap: Use util_ltv_foreach to process metadata
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=13b14db95089

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


