Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A1C2D5414;
	Mon, 23 Jun 2025 19:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750705788; cv=none; b=pIrJ0fHD21bjP+/vm5IMTG6ndI5KpMNAmifMsWTwNrqI4bedi71Eu7AO9W5Jh4Pozg2+djG34Sn6h/tbKQvuwjuZJ21IjsHFRyg6WlmDEN3p3yfanibPBGi1qbxw9n35lRskAysaVwlE7OMIeguoDYMBHDlRBMVV8qB5ibxUh5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750705788; c=relaxed/simple;
	bh=7io1Bk1ow+pCs8WXL6XS0dbVOcovkBjzNtqpKURCnUw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HYYjHQdDh12HBCKDgd20dH0D92iQV9m2mpC/Wsfi1rScUd5KRXOykxu17EWSdN11zYB5ryWXxtIwNxzDfbSjcaf2inmSLobnQQmFQB5t7nnqcm6j04YC+5Iv02z8sbMIrwiwl767ddYmrs4AilcXZgir5Bs3/hWf/bkLjU8eRXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pj9LuaYN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pj9LuaYN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24EAC4CEF0;
	Mon, 23 Jun 2025 19:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750705787;
	bh=7io1Bk1ow+pCs8WXL6XS0dbVOcovkBjzNtqpKURCnUw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Pj9LuaYNbBuiGTGbF+AWmeYZYO0EAjymYGHZPA7ky4mNjVbg6sa9LB7J6WznnemHa
	 o65cIHgGTi4JZl48DpW2WEkoDn08CklBDOj5sXqBEIDGwafeXsXvyn7Bstem7/CaxK
	 4aMyhDW8ZQepM8JbAzgfdhz3aDfE1XtQbR93tVHawe+yvgD5H1y/VvISQucNzAgEea
	 EQT+OhboSbmoUqXhlwneRtnM6p8efNSo9fOuD+gGNNEVhmYsX/Ai687HFYZDGFhNcR
	 aRdoqwPLeWcWI3M0FMPp2t2zxECxIuHVQfzJah/XR4uGCU6WnWZP1ypbFVqBEzZ20Y
	 qAOm9FMJDcZRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D4439F1DF2;
	Mon, 23 Jun 2025 19:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_qca: Enable ISO data packet RX
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175070581473.3268784.6503974437725581648.git-patchwork-notify@kernel.org>
Date: Mon, 23 Jun 2025 19:10:14 +0000
References: <20250623-iso_rx-v1-1-65dd2882b670@oss.qualcomm.com>
In-Reply-To: <20250623-iso_rx-v1-1-65dd2882b670@oss.qualcomm.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 zijun.hu@oss.qualcomm.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 23 Jun 2025 19:23:48 +0800 you wrote:
> From: Zijun Hu <zijun.hu@oss.qualcomm.com>
> 
> Enable ISO data packet RX for LE audio.
> 
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_qca: Enable ISO data packet RX
    https://git.kernel.org/bluetooth/bluetooth-next/c/33fa852e8735

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


