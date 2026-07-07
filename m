Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC18383C8F;
	Tue,  7 Jul 2026 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783445432; cv=none; b=aj2fAyz5h7N8LzN0hOGWqKj2O88dUuIB8SdUidMlj/qTTWIRwZ4//w05SZj5u5TkD+6fE8DwdX7JdTJN7cIFp3rOxdTVjf6RUQmszrussrrsxQvJl1LwThbhpjxAjDOC6WEkvlNAGPtzj9Zkb8XvySvbEBoe3KKuBAeQiPHUUjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783445432; c=relaxed/simple;
	bh=rGrDtGqvFE9ExnRotptipIl01RYbE/vLYZyjj3Dmi2c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b5sDpWgjK9vGc4zTVlCNc2Z4prVNugpHgEpeur0WO6WwbDrpGIaUEiRWyCIityOWJy4I0EWNYviQTuGUHTE4ZtL3qME+y/H37USPOsyjQJjWDowwgSsJqX4TB6s3n96d6+RvfbVxoyPJbemLh6QY3vG9fEa2KSplR6GriQjNWHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3+hNIOo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3+hNIOo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FE11F000E9;
	Tue,  7 Jul 2026 17:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783445430;
	bh=NBO5Uo/YYWIDD25/FgFeyCsR3ZSgKvA15Mr4DvpF9eg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=l3+hNIOoaKDn15c/ltnD/9PVfHvYXsRdUwQNwc0pOl4s+21uSUaxU4Hoaxpr80OHA
	 LOP0tfg1mVfno4/xCK7AcY5QG/IRgjyWCmxkMpZsMJCLDqyrSv08zAq7MBvA36Djrj
	 VDmVV8VCMfsC+I4fxNK5wwwfEx/UhrAB7dTnGvdwZgnaYvPlcqFEeE1AS++ANvClpm
	 UNyxEGU0deDU3SWw2QVAmV4knSynSCbwWcAKXLkhNgU7px21OAoqJ5PS0nd/r9ZRmV
	 wgXOcBMWksFr/RIrzJdwgGXgdynPe4k1Z+xg+ogyMoc+kj+oaH5jR3+KH6Qnbb9rWv
	 TSgNh/avJlS6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0CF839253FD;
	Tue,  7 Jul 2026 17:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bluetooth] Bluetooth: qca: fix NVM tag length underflow in
 TLV
 parser
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178344541038.2101608.10046636030996083737.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 17:30:10 +0000
References: <20260704231030.996390-1-xmei5@asu.edu>
In-Reply-To: <20260704231030.996390-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: brgl@kernel.org, marcel@holtmann.org, luiz.dentz@gmail.com,
 johan+linaro@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, bestswngs@gmail.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  4 Jul 2026 16:10:30 -0700 you wrote:
> In the TLV_TYPE_NVM branch of qca_tlv_check_data() the tag loop bound is
> "while (idx < length - sizeof(struct tlv_type_nvm))". "length" is a signed
> int from the firmware TLV header and sizeof(struct tlv_type_nvm) is a
> size_t (12), so "length" is converted to size_t and any firmware-supplied
> "length" < 12 makes the subtraction wrap to a huge value. The loop body
> then reads a 12-byte struct tlv_type_nvm past the end of the short
> vmalloc'd firmware buffer (and the EDL_TAG_ID_* handlers can write past it).
> 
> [...]

Here is the summary with links:
  - Bluetooth: qca: fix NVM tag length underflow in TLV parser
    https://git.kernel.org/bluetooth/bluetooth-next/c/198bd312df38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


