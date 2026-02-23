Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F993033CB
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Feb 2026 22:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771887368; cv=none; b=I6rfi7TAM9MK7EWnodIqDd46//4jruIvddFsKzDqgytpAej2zfCKMx+PRJCa67UQMJaTyPGoT29Yjw+s7Ha2kgDCzmFVmg6AzOGubVY3x+h5ynOTcDxk9xP2A3ylNWCLKXHHHhFJ6UVunGCNhYkvT3z0BH1LgO4Ylo7MxmIu6EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771887368; c=relaxed/simple;
	bh=LonW/kjxjL3Ej+j5JJgirzllYefv94fP+RyXUscdKv8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K8u+f/SgAiA++QRgqXqVyzVQELAaVMSiU2OOZmqYXvCR1rCQjL1fnzRgf9XJsqh7j8S3glMEUG4sjo90dGSbmbweVaWPw104X8dpyd+btDWL+eIW0y3cay3XqxdhnmD7E7kCzMJPcjqqxoHJcBU8Jho8cvIbiOhpQp2qXJJ5+as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILR/L+fo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILR/L+fo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EB48C116C6;
	Mon, 23 Feb 2026 22:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771887368;
	bh=LonW/kjxjL3Ej+j5JJgirzllYefv94fP+RyXUscdKv8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ILR/L+foObdSPN1PCWkTlUmOec+6BGI/1fAwsImjyYq697hpZs2auO21gCS+4XD2X
	 thYESD5wDUOp9Tjm3vszq3YH3bF3kah+oSXBE6AfSWn3PxE0u1f2qF8zldOLArVGHF
	 83vkzak2t0Kx62htFzhn4JPKPQmXi94aq3A0lqIk4v8FPmFeRkNfpgrM3WL4yc2idu
	 bt1yl5rC6K9jYWIIvu0GpDnDS+r5mBoLHU78ot08ovoumrPGzaOjIkr9E3ZKZGu3rR
	 /RjgFphNqEyrBUt/AEQOyqIuIH1q/UGpc29Oo/ygvCjGbDagTrCkhbgonvuA5Pax0L
	 eJ/KHSetQv2+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEC93808200;
	Mon, 23 Feb 2026 22:56:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: L2CAP: Fix missing key size check for
 L2CAP_LE_CONN_REQ
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177188737403.2662735.4180166757033435870.git-patchwork-notify@kernel.org>
Date: Mon, 23 Feb 2026 22:56:14 +0000
References: <20260213183333.1830534-1-luiz.dentz@gmail.com>
In-Reply-To: <20260213183333.1830534-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 13 Feb 2026 13:33:33 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds a check for encryption key size upon receiving
> L2CAP_LE_CONN_REQ which is required by L2CAP/LE/CFC/BV-15-C which
> expects L2CAP_CR_LE_BAD_KEY_SIZE.
> 
> Link: https://lore.kernel.org/linux-bluetooth/5782243.rdbgypaU67@n9w6sw14/
> Fixes: 27e2d4c8d28b ("Bluetooth: Add basic LE L2CAP connect request receiving support")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: L2CAP: Fix missing key size check for L2CAP_LE_CONN_REQ
    https://git.kernel.org/bluetooth/bluetooth-next/c/ea5263dc9312

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


