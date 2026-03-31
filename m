Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB5213D51C
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774967422; cv=none; b=Q2e4EbHFESdk8g/d1lo9gXLW3XBDKB3Y2AeL2AZIjo2VqnGYTiBmA3wFCpoig4eggjkNLCmzqjeSyFHpKcEbYLvV5aoPUU0OH8QGcKJgkDlhMllzwUuc66VfIRYO94Ufv3RzuhYLpNIi9C1IUw4TGUD9JwanGF3d46yGliJCV/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774967422; c=relaxed/simple;
	bh=ofY+xABuDiySag1ezZz5QbNeDmMgiBHiyFEGayiaNsE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QSNKJDd6WG7ywLf+mCTn/S3Dyke8SKnbZh984hfs1w1ueEz9SDhU5ubild2zYY7N4prp4clht81RurfbV6wc2AXcuuxrygdjSvIQ64Ki/59/KeArqeb4OUO30bPZfDE6WaLlz5IgKyQkijxo4u0CKDgPNg12JV5JGyMnG6RGV2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PY/f23n1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PY/f23n1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9833C19423;
	Tue, 31 Mar 2026 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774967421;
	bh=ofY+xABuDiySag1ezZz5QbNeDmMgiBHiyFEGayiaNsE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PY/f23n1K6oTgU6wj8u4re68z1eyKZwzIWKgkbOPBYBKVTL2NhAyuhkTjfun467SY
	 IMTKg1vGnvc9TId98WuqvO/0TG7bjqewGcS8pbJI+w1M3lfTgk+iTTNQZg1GZjjnm7
	 I/HVTCJJBzQri7/8PD0UTc9AlEA4mHg4RECPByMjqbmqwA216C1A8ddXsj8wFCV3PY
	 2thpbOELFZ7K4aOPdrIGBJSI3CuLn8Z9gksejgY05r9fQUeDZvEgA1QJMKTYRlMUWp
	 /GCJk70Nu2Ra4Hr4U5/gvEnOqcJ6vZseRP0dTtQSe6JsSSMnk0ZcJfj26bt8dLud0+
	 tklEKE/B/AMLw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9FD83809A05;
	Tue, 31 Mar 2026 14:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: hci_conn: fix potential UAF in
 set_cig_params_sync
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177496740554.2731558.2506628875970689257.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 14:30:05 +0000
References: 
 <5d61842fafed29f489f472bc6cb324e41f568083.1774787573.git.pav@iki.fi>
In-Reply-To: 
 <5d61842fafed29f489f472bc6cb324e41f568083.1774787573.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 29 Mar 2026 16:43:01 +0300 you wrote:
> hci_conn lookup and field access must be covered by hdev lock in
> set_cig_params_sync, otherwise it's possible it is freed concurrently.
> 
> Take hdev lock to prevent hci_conn from being deleted or modified
> concurrently.  Just RCU lock is not suitable here, as we also want to
> avoid "tearing" in the configuration.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: hci_conn: fix potential UAF in set_cig_params_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/e00e94a42852

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


