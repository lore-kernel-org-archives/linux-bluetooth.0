Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124013E121D;
	Thu, 28 May 2026 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978005; cv=none; b=UAreH43xxAwsedWWsglB7HtiM/fBGVNrTWM3C5MxeSd0Vyxeumj40ZIDd2yzZ2wlBGK4iqmDG7Mmltt4fiVguo+ewRWbuNo8PmPxfGrehjWLY7SYc24fAtxTeZDeVQEx80psKAWShPRsPVzPJkZlrjVxLhp81N/f/yczMFzTjP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978005; c=relaxed/simple;
	bh=PcAef1HAzPtCNgtVUyorn2LlADyII8gOnsIw9fnscqM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FZ5Ltxx6XFhOhQx/rJGxhSP/38w/hYdQpLBEePsvXLrjcxBFUqhkxNfaTjmAxoaX9cmvDhXlfxCLEdDYuj+jEd/hcxDOMgy9Larb7qdgdvy9azfa0j8u6CXaPT51QKR3vFGEZpFYadOnX2JDkNz5Qz9lvg37S1xbgIIReuVKNmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmIfqyMJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmIfqyMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D67CF1F000E9;
	Thu, 28 May 2026 14:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779978003;
	bh=qOpIKxNrfle+BopHxltRI67wgUyQPQqBoH2jDdHFY1Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JmIfqyMJzwrCi/KU1EM2DJqXR7gKoZNxCBk+Ye0omXuqahU/KQaZGg6Gc3SXVNBuA
	 +tXwrN3MGakaz2Utl72PbCAon5R6KlnGOga5075iMNWu+BBabOB6cFtm5Eh/UtNjeL
	 T7z61YKtTSUjeR7yMO1I5EiJyyIuU2cdABELbEvPg+rmzf/S9n2ssI0v0JMX7eeflz
	 kSg+VqARAVIXDSiqOFG30ZrNbQfWarqOudPKX66TRa76LbYgRZ8/8IooorA4R11UeF
	 V97BT5ZwIrHv1/8q3gcMA9DZf8R2fM8FbmvF7N3IPdgq+89P+a3IxEMz7dwBy8PhhX
	 LrAfpfJjcpDUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A7F381195D;
	Thu, 28 May 2026 14:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: MGMT: validate advertising TLV before type
 checks
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177997800814.948024.12179449818838522156.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 14:20:08 +0000
References: <20260528094506.3699804-1-rollkingzzc@gmail.com>
In-Reply-To: <20260528094506.3699804-1-rollkingzzc@gmail.com>
To: Cen Zhang <rollkingzzc@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 pmenzel@molgen.mpg.de, zerocling0077@gmail.com, 2045gemini@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 28 May 2026 17:45:06 +0800 you wrote:
> tlv_data_is_valid() reads each advertising data field length from
> data[i], then inspects data[i + 1] for managed EIR types before
> checking that the current field still fits inside the supplied buffer.
> 
> A malformed field whose length byte is the last byte of the buffer can
> therefore make the parser read one byte past the advertising data.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: MGMT: validate advertising TLV before type checks
    https://git.kernel.org/bluetooth/bluetooth-next/c/899a200a7648

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


