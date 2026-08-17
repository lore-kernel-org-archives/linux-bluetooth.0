Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F33446D2C8;
	Mon, 17 Aug 2026 19:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786996014; cv=none; b=kuxbrqIKYgG0EvJllrJq+BOF1FMkApoMQ1AVP0468h+xrexeCQZHJz1/SNCbyB8EI9UjjdgVPp+pZ970z+PY9HVD7z93Tj/0m/XsZMxEOorK4O99ZAYsFgwWYYOId3uj6IPnkF2wT8m9cq4B8dTONbNsuBNCR/DyrHHlHr/QEC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786996014; c=relaxed/simple;
	bh=RIYBaDlh3nA1he2H5QbkiYPFBEwGEwKgZwlq7vup2AI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vGB3L46cyL1wKc9MGtzGr/k0sS/Y2/Qrp4v6sJdQdOOJgICQfKgCLxNfzR/XX+N348sGxbgN8Ape9uL3KGNEBg4sjLJ5Zn4AeOe0/X1flUhuqVsPdj+DiXOc9NlQ4Ro4kIJ3EU6hh3Ip63VSz7bbve0M2Mc7/1GYpsylZUrGSLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnRssPnM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnRssPnM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA03D1F000E9;
	Mon, 17 Aug 2026 19:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786996013;
	bh=XIge3VEzx7uZ5TQ9czkFrKfiFB7mmKfoONtGNVArVog=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HnRssPnMNl/6el9Le2suS+QqikZLQyjC7iFpxx5LwbfMUHvoDww6ibWGPFaE1WyVU
	 j/9v7l4AH8uOVlAiIZuYMpuk9XBdP7/dTjDeXhngXaWDQaKwEuvu3IlwAp7XMCfdRG
	 25ynrvMQ+/1T7tU/fDcRZLAn7WPT2D2s9PH/vaVR9oUFCQkpGg4zYzdtdfoj62GGFb
	 CCiIuXh+WaqT24VFjvGj8B8b7JxytiQigAb6n1vAtugLzNqMEpa5udtcjsa1EbMMU4
	 bV6UYm/fwCBEaylM+Lz/zLZisCGza0Bs9GcmA8/oCKXR6ShZS24FjvwCw72D8a0IHF
	 e/+7OelCaYP7w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5687A3926262;
	Mon, 17 Aug 2026 19:46:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: btnxpuart: Validate the FW dump header
 length
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178699596488.1691257.10669499183665262272.git-patchwork-notify@kernel.org>
Date: Mon, 17 Aug 2026 19:46:04 +0000
References: <20260814182849.940976-1-ali@iusegentoo.com>
In-Reply-To: <20260814182849.940976-1-ali@iusegentoo.com>
To: Ali Ahmet Memis <ali@iusegentoo.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 neeraj.sanjaykale@nxp.com, amitkumar.karwar@nxp.com, marcel@holtmann.org,
 alex.zhou@nxp.com, song.xue_1@nxp.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 14 Aug 2026 18:28:48 +0000 you wrote:
> nxp_process_fw_dump() pulls the ACL header off the frame and then reads
> seq_num and buf_len from a struct nxp_fw_dump_hdr placed at skb->data,
> without checking that the ACL payload is long enough to contain it.
> 
> h4_recv_buf() collects HCI_ACL_HDR_SIZE bytes of header followed by the
> number of payload bytes named in that header, so skb->len is 4 + dlen
> with dlen supplied by the controller and possibly smaller than the 8
> byte dump header, or zero. A short frame with connection handle 0xfff
> therefore reads both fields from beyond the received data.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: btnxpuart: Validate the FW dump header length
    https://git.kernel.org/bluetooth/bluetooth-next/c/1fcf216462ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


