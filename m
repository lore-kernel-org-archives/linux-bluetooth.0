Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4952E473C60;
	Fri,  7 Aug 2026 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786120257; cv=none; b=BYRVa1sw+RGYKYWVh6Sh7q5hNSbCfIag22xCGxfyP5bk4RKZmXQjbnpTMlQ3lOKPd575apIxy6ky3AbnkSk0PGbT7COTzvFST8XvBE4ruzSWHa7Ffxkimauj/ixmPr5QgKzKtVt21QRy58eMLnU/EnunYJ/mmcYJhYofFGTmC/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786120257; c=relaxed/simple;
	bh=60aUnkEjjD++SBvJBFtUZBMJ8gV0hfIhXrBhUhhmXyE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=p4cyVQY72aSkH8rAhTySGfs3ZPMO96szJQYmfJDnnwjMn7gDSS3B/U+cgkGSeFdr0d+9/fxmgrjSkvM80lFADJqYsTMnyGvumLCaIYhwHKlTOy2DkME4p6u6ZpaORH9d8DxBX8GMwwA1emWJU0TZICmGY/HUMhyXjcuxgWgEFhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMdQXt8j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMdQXt8j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320031F000E9;
	Fri,  7 Aug 2026 16:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786120256;
	bh=w2TaZaVTyeHbQqU4tR3bZKRSqwuTFJUlZMxeHFX3Rhs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XMdQXt8jtb5ITBid/27lVgnzAXKof/zOmca9fhJqn2w8qh8AGzOrYdYZ81yk31VQv
	 0kLPYKCz0oodwJqZ4tyfRzi6KelokhhfuviTIVI0ik6/Tt6v/sspZSFyCVhqYcXRNw
	 93ETVP11hJs3B1yOXTQ5YaIqjZNlILhS4oW7lpgmEH+tCHyNyivpGJma7r9rorF5of
	 vMU+Ed59I8Igi9E6P3ZXz5jeNb8FRPuAL+pGE8yf5FXenVLbvbDUULO2M459+wlHkQ
	 AZCHb+C5Q/awWZRXFKo3i3k5SYJpzEtZAt/9hv1Z2M1U/To6igutwuiytHGgXE1/j9
	 V6z8U6eKBJwPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19861380CEE3;
	Fri,  7 Aug 2026 16:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: MSFT: validate evt_prefix_len against the
 response
 length
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178612021463.1887768.11222059650731715459.git-patchwork-notify@kernel.org>
Date: Fri, 07 Aug 2026 16:30:14 +0000
References: <20260807012555.97482-1-ali@iusegentoo.com>
In-Reply-To: <20260807012555.97482-1-ali@iusegentoo.com>
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  7 Aug 2026 01:25:54 +0000 you wrote:
> read_supported_features() only checks that the response covers the fixed
> part of struct msft_rp_read_supported_features, which is 11 bytes:
> 
> 	if (skb->len < sizeof(*rp)) {
> 		bt_dev_err(hdev, "MSFT supported features length mismatch");
> 		goto failed;
> 	}
> 
> [...]

Here is the summary with links:
  - Bluetooth: MSFT: validate evt_prefix_len against the response length
    https://git.kernel.org/bluetooth/bluetooth-next/c/78cdc6f14ab3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


