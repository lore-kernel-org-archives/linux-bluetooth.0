Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795552815;
	b=qJM0EaJeOyXJEAcxDCEWuRWi6ECV/ay+o/D+XeyIzGWvhGAYSLvnJ/IdT3GJgjvUZGAW
	 A7EpluCl308LH+MX/drQVBxnrJhQUZtFz80SEOBcUe6OJFE5en70uH1GWdo7y6OdBcAcr
	 /WXPZ7yEpWhqRP2ka7ppFSOybT3YlhkveZmu5gcpvFKePdp2y7hfc8rtl17L+r5TRw5Mz
	 /BKOmwDQ62hDAd5wVNg/O0TNu/Gu6RGcVn0wr0hcj0Jv1/p1G9hI4PtdsaK2NYsFfj7RX
	 M0V8uH8dAZDSJQqqfhzjwYZ7J2lvKYRVKvHtKH/l0gX1CgHOsuxoKxCUtcv7KGHtLVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795552815;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=4ELjI+cAY2NSE5U9WcDYrVEC2ENA1Vuy494EgwRIc7Q=;
	b=3Orv8Z73XuB3g3JZrH+Tw/4kl5YTWqocmhRZz/Ijz0OJIRw08SPsK6FO8pAxRtL41JYp
	 mouvcN8nWWPaMLN8hmj+g9oRJSIQKhXvtXyUjYM/K5CTQx8DHUgGErmCZuyxKtfRlYEWA
	 bs9voprvL+YppQrE6EkqPku5HgQU0Halydr7xIodY+xqdx+J/x53APAfFVBLXdCpddOPH
	 g62arpDznjD1MLFo7ByHq2d3mrMmGoIICpAR7ODV/3KfnjEegAFT8e5FjzeCYFTtgv7rh
	 axKXeg9A5JzIHuMmZjtkTMKOZLfZbfTTP3XQzQNVRHNlr2bjNZByip2q41nnMFrtm1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zy8ylaiC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D4A606A33D
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2026 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zy8ylaiC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D8B1F0089E;
	Tue, 24 Nov 2026 20:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795552815;
	bh=4ELjI+cAY2NSE5U9WcDYrVEC2ENA1Vuy494EgwRIc7Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Zy8ylaiCQhPvbr7WSc2cNz/JdIY3MYkWiWZl+9qQKSQOo34YfJ9OTFVzj4IeszOxB
	 8N4OLzc4oC0q6ZWizuWBG9TqzXZTh4+ZsMd+1lZnkjCpWupI2uCldszGhO0ZPbKX7O
	 inI69kDrTJ6LzyGB133ykfjaV35LCk2hneET5RjPkvnAOQ0rsmay+ZmJNr4I39pRFp
	 oSiR1IstNVHh7O8gg3I6ulnHmWEjIkes7deMeY7MFIN72oA9Rok1/LJlCIKVS0r6s3
	 FZX0glZUrUlBxJVlIjJ/s0p0NgkvjoYpKZ3aLNFnQH41TrisJNrXAVBFXk8fi/8g8V
	 CEq0oXNC+7sew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15F03808209;
	Tue, 24 Nov 2026 20:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] Bluetooth: request LE data length for MT7922
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179555281351.41195.13261911767623406964.git-patchwork-notify@kernel.org>
Date: Tue, 24 Nov 2026 20:40:13 +0000
References: <20261124140325.3092381-1-cochcoder@proton.me>
In-Reply-To: <20261124140325.3092381-1-cochcoder@proton.me>
To: cochcoder <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 24 Nov 2026 14:03:39 +0000 you wrote:
> MT7922 USB firmware can accept maximum LE suggested default data lengths
> without negotiating a larger transmit data length on a new connection.
> On an ASUS G614PR with USB ID 0489:e0f6 and firmware 20260724143815,
> ASHA playback remains choppy until an explicit LE Set Data Length request.
> A request on the same Cochlear Nucleus 8 connection raises delivery from
> 21.5 to 50 audio SDUs/s and reduces peak outstanding packets from 32 to 3.
> 
> [...]

Here is the summary with links:
  - [v4] Bluetooth: request LE data length for MT7922
    https://git.kernel.org/bluetooth/bluetooth-next/c/f57f78086ab5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


