Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FFA44E67A;
	Fri, 24 Jul 2026 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784919667; cv=none; b=KyHqCfsz885iaWiPH9aFNqfeRNsehEQ1NN64S2HKLXesMQECoYvPh9CStabVbjgRrvhpmV1Z8HF6KrYElfKTeIrIRf+5vFDEoht5RJ76g8c2FrFN6Hjx5GCwIv2K2vgGQzGpIvhddM+fAgOHMStcaFCn+81buq61prcgq7OUfQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784919667; c=relaxed/simple;
	bh=8ozcQlvPvv9FqaJ62OT949SjjJpmU8LxqGovtyI/Gh8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RdK9F/Y3/QDWx7jJwx8lVDMLdBRgxMXfjTi7AGmVK5DUUMBznKSBizqwonHkFSZNzpteUFcBmHpD+kiNz2sCtcCJml4oLu/RKTBoRvo8KD+9ZJvH6uUa/OyZQpIrnq3XXYkndMdVGawLsvwNSSqnI35CgVRwTGy45UztxGnnSA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZ20iafS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZ20iafS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C6F61F00ACA;
	Fri, 24 Jul 2026 19:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784919643;
	bh=vKdhoG/tlNXG52VdD/M3dFrMOStKH57F4PpR8quaq9g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KZ20iafShSIZYxZVS6ci6WkP4F2J/eMFK6Ql/V1pLXoB2Fp5UellHYa0CZLtdy4i9
	 m4NSDr3UU8BwG6rX1Pi26z3/Dwlz6hs1o5dx3FpkWnngNk8qfpJSuzl1gvliQYV9Na
	 wPQ4MiCSXhdRQQf5mlFXcqeFoCCcU/gMFQHmWSZLMHZeCvo43xlpP8Wr1gVU9zOoez
	 sMsazfY57u8fmK584K6qa1dkYL31/gjUZlTdJMJIRR9WMUa2bYCrHvdjzkHZ/kmocs
	 L+1Ex7IstdrQTG7SPduUsjBjx4qhwdW+8UPuSvO0BTmDC6u6lUp7s1UdcGL4pLzmSx
	 cD1xx5+PH81Ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AF1380CEF6;
	Fri, 24 Jul 2026 19:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: RFCOMM: validate skb length in
 rfcomm_recv_frame
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178491961039.3273549.4096598946894620170.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jul 2026 19:00:10 +0000
References: <20260722092616.1122797-1-yaojiale02@163.com>
In-Reply-To: <20260722092616.1122797-1-yaojiale02@163.com>
To: Jiale Yao <yaojiale02@163.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, kees@kernel.org,
 kuba@kernel.org, hadess@hadess.net, suunj1331@gmail.com,
 pengpeng@iscas.ac.cn, tim.bird@sony.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 22 Jul 2026 17:26:14 +0800 you wrote:
> rfcomm_recv_frame() casts skb->data to struct rfcomm_hdr and dereferences
> hdr->addr and hdr->ctrl without validating skb->len first. A truncated
> frame with skb->len less than the minimum header size causes an
> out-of-bounds read of uninitialized memory. Additionally, a zero-length
> frame causes skb->len-- to underflow to UINT_MAX, making
> skb_tail_pointer() read far past the buffer.
> 
> [...]

Here is the summary with links:
  - Bluetooth: RFCOMM: validate skb length in rfcomm_recv_frame
    https://git.kernel.org/bluetooth/bluetooth-next/c/4c7de7083a9a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


