Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B552050128F
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791576009; cv=none; b=I7WghgEsJg1qbzEtLzxtvyKs2OOEjkduzuUf24hn5VNC5JxZ37hEmiOzuhnBSSrFIlRL5vH+VljoC5euz47lmU4XPpJy4nnGeKuRzfmhLo/UkRWr4Eu1BgMAiROdGYjt83cCpyDNw63ugN7eFPjyARUpIJfYhVABrmWtnxfo8G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791576009; c=relaxed/simple;
	bh=+Dkofh4SL7GucuoRbBHT6Tfz3ekFpOQrbEb2P8ev6nQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ujMSkn0K15lvJXNYQwVWLQzRRpJuTy4VI7RjGzFr42ZPhBcf/kZ2EAgZg9QJr5AuAnzHSUy8Zjn0hUIw5uk3vtnRs1+ry/5osVdh+xVkYQlixbLFLMqBNf4ayFFNguA4DvtlemFKRrVCIvYCck0pn7HBaX33La+9aYW1OH9YAfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxB49mq8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxB49mq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465341F00893;
	Fri,  9 Oct 2026 20:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791576007;
	bh=MWPHNcqFE3c8s+F1x0i2fljFUC6gOKu14kigYqgSv88=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VxB49mq8vTu1KiwZRvnZbSar4hZcdDgkrIXYkBeRYU7tBmcRGDyx3vZQX1nqWutP/
	 7SU1IZ852gjd8NNZPffcgL3gyvMCYJM08/6fAgD6YobfnVagWb6fGIvEEViXhxgMcE
	 HseFJSA20Otz9RIZJ/pbpYCJgE4I/C1CDvp9bEvDH+YMgAj5m4q1fZXuQoo1Tv2TYG
	 1YqtClCoEEOIwTbVE+6oc1kqujbT6ErqRVMGDstWPmgq2XExpTvy2zeaZkrmtNIFKn
	 h8xVUtmsBOgdYXp+g0BiEtB4dB42t5PvfA4Fe16fJghS0p3v1BuoxdoyB9VVlGCHAh
	 EvI6HdMGby0+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A220392627A;
	Fri,  9 Oct 2026 20:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 1/2] Bluetooth: btintel: Zero version data before
 parsing
 TLVs
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179157600603.981840.12084970276342453886.git-patchwork-notify@kernel.org>
Date: Fri, 09 Oct 2026 20:00:06 +0000
References: <20261008140602.2623464-1-kiran.k@intel.com>
In-Reply-To: <20261008140602.2623464-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, chethan.tumkur.narayan@intel.com,
 chandrashekar.devegowda@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  8 Oct 2026 19:36:01 +0530 you wrote:
> Firmware may omit optional TLVs, leaving their corresponding fields
> unset in the caller-supplied struct intel_version_tlv. Since the
> structure is typically stack-allocated and not cleared beforehand,
> fields for which no TLV is received retain uninitialized stack
> memory. This stale data can be logged via btintel_version_info_tlv()
> and copied back to the caller, leaking kernel stack contents.
> 
> [...]

Here is the summary with links:
  - [v4,1/2] Bluetooth: btintel: Zero version data before parsing TLVs
    (no matching commit)
  - [v4,2/2] Bluetooth: btintel: load unlocker.sfi to allow unsigned firmware
    https://git.kernel.org/bluetooth/bluetooth-next/c/964430c03896

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


