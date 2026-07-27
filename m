Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518A743553B;
	Mon, 27 Jul 2026 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785177046; cv=none; b=tZDzzhlZqe1EPkPt4HoFL9tZLY6fwcfAr9vX5FGi2SjtqZb5rK9DwC1gyBCiZFEPI9/y8VK14U0yJAzP5e0N67+sZV60er68H00aXAKYZc3QC3TDQRpn/ZGFAuRT1IMHHBPniEsWpXm0Foo8anKyIR4HnPKZY8ViQfcrCOTIm5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785177046; c=relaxed/simple;
	bh=Qyh/pYDyhknDi6TTURciiSVIXqBvTHjZAEOB+33zGUA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=M7M1E5Mgg49dupx8Imt0jcD7AgxKt4QSsaTafEUx3dsxg6YgEmsFrCmkT18i9ZXanKp2+Boibate3i9pxqp7uBHND7eNxMHlgfzgNcJcKVMT7Vdy6ddRL87vOQ1EY5HIhvfvIcAjZrP580SHHIY2p94BRd6T21f+FVwOZizh6t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ee0WbiWC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ee0WbiWC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58A61F00A3F;
	Mon, 27 Jul 2026 18:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785177044;
	bh=uZmjA23YMkUskVbRP1raIK4/zr0p6TGUqvHc1unA+x8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Ee0WbiWCNHjZUe5lWJUfAiNcTQmc4vf+M08sdoce25n3/YpE8xH8h6UVtGtM8PFPT
	 bx5NucJIQqhJBn6FEmX2RyDO+KOo85FFlcnCafFlxaU8odXDtFXns3ekA3AEOHZ1ml
	 zHIQmFeAlKo8k2ntKOlnbxuPHKTPOhPh02tCWGRUDFqJ0bRB+91bCISnNPxx/dfCHU
	 ktzOEwxplCkJefTipmq/1cqmsM/PboMYMAIGZusAYFKjQsudTvPXUF5XDDXeptYoeX
	 Purn0e6a+qCL+GGDFJH3u2gfiQjd27Ct7RgmhmiTbkaH/kkpGA+l2L+y6TJDqjfKGF
	 00KKyL/FTYvJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 65818380AA77;
	Mon, 27 Jul 2026 18:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/5] Bluetooth: btusb: Preparation for upcoming
 Qualcomm
 QCC2072 support
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178517701013.1360613.13814217148431362861.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jul 2026 18:30:10 +0000
References: <20260713-btusb_prep_qcc2072-v2-0-bbcb651285f2@oss.qualcomm.com>
In-Reply-To: <20260713-btusb_prep_qcc2072-v2-0-bbcb651285f2@oss.qualcomm.com>
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, zijun_hu@icloud.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 13 Jul 2026 05:01:10 -0700 you wrote:
> This series collects the btusb and devcoredump changes required by the
> upcoming Qualcomm QCC2072 support.
> 
> Posting them as a standalone series because the QCC2072 driver itself is
> larger and will take longer to review. These prerequisites are small and
> self-contained, so they can hopefully be reviewed and merged on their own
> in the meantime.
> 
> [...]

Here is the summary with links:
  - [v2,1/5] Bluetooth: coredump: Introduce and apply hci_devcd_state_name()
    https://git.kernel.org/bluetooth/bluetooth-next/c/6ec4edf6a898
  - [v2,2/5] Bluetooth: coredump: Allow drivers to pad dump header to fixed size
    (no matching commit)
  - [v2,3/5] Bluetooth: btusb: Add an indirect recv_intr() hook to btusb_data
    (no matching commit)
  - [v2,4/5] Bluetooth: btusb: Make btusb_recv_{event,acl}() take struct hci_dev *
    https://git.kernel.org/bluetooth/bluetooth-next/c/77cb572c7be0
  - [v2,5/5] Bluetooth: btusb: Add a simple static btusb_prepare_reset()
    https://git.kernel.org/bluetooth/bluetooth-next/c/d08d8b62e7df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


