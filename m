Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7BD1FA8FD;
	Tue, 14 Jan 2025 17:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736875218; cv=none; b=nCXrGq77maS2upGqwIMf98TCJi6m6Jve9JdYvX8GollXjCv7anzKBGti1lXqozbpdUBCAEem5my+GAH3/P1Op/Y6zabTYS/XdlaPaUpqvBs+qPpC6DDGErMdR0xe26/N19fRohoSZaU8ncoLc/8QA0vcqc8yGVxdYl8tmW4MxOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736875218; c=relaxed/simple;
	bh=6MF0dlcJddwJ2j8LDnKkAPEmE1AocvfGYy4073HYR0g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E78YLyOaPpXkeNLvcidBvL3w1r9YbdZhF96ESjNUH1UOyp+Gaa9VIT6lPmlSt7ayYSQG75qJ8U9/PggY7FHSWkcXzpY2N5GjBQrNlz3pV5nXxqWilsKTWa+w0DnyEYK3Tug/oBEYxiioE414j/z5gvdP/Yj5sdM9hO2DURr5Eno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dorQIg8H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dorQIg8H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41565C4CEE5;
	Tue, 14 Jan 2025 17:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736875218;
	bh=6MF0dlcJddwJ2j8LDnKkAPEmE1AocvfGYy4073HYR0g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dorQIg8H8KLDz3WrEN/YIAyfm0I4vUlZIBQgo+JjIbRIXdXmnvq0QAmq+BeadKx+x
	 DHtgdsVEVruk60i0ZUXuDXFJbRYYgH71Yh6Ie9BWFPJvALVy8qP1PoGO93XRi4gYKY
	 /xGS5b44rZf4SbJ0ehoH+Hk5rzqRmV8xrqq55XdfETZiasVcR71sTLvFoI/LMZCoGD
	 E5uwXxKu8TXqQP+hK2BWvAcqv8U7fEvb0KV29aXpSjjQeRzhl8ZtH9HI50+Mucwxez
	 r/lEVWAT8WcmysWIDPIxUaPny8/J5yi3JI3t+p97YGRrYSFpG9Q94ByltvDPaLoNKi
	 xZkw7BCdsRPpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FD6380AA5F;
	Tue, 14 Jan 2025 17:20:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btmtk: Remove resetting mt7921 before downloading
 the fw
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173687524073.62266.12024494240760693746.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 17:20:40 +0000
References: <20250110095548.12761-1-hao.qin@mediatek.com>
In-Reply-To: <20250110095548.12761-1-hao.qin@mediatek.com>
To: Hao Qin <hao.qin@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, deren.Wu@mediatek.com, aaron.hou@mediatek.com,
 chris.lu@mediatek.com, steve.lee@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 10 Jan 2025 17:55:48 +0800 you wrote:
> Remove resetting mt7921 before downloading the fw, as it may cause
> command timeout when performing the reset.
> 
> Signed-off-by: Hao Qin <hao.qin@mediatek.com>
> ---
>  drivers/bluetooth/btmtk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - Bluetooth: btmtk: Remove resetting mt7921 before downloading the fw
    https://git.kernel.org/bluetooth/bluetooth-next/c/c8d46ea46991

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


