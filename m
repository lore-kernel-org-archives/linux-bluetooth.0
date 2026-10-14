Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29013E44E7;
	Wed, 14 Oct 2026 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791998414; cv=none; b=G0vtJG+3sH9bVlIKm7DSlNJXXkrTCbLUC5LIFEVvNHy3MTXgnZPquOStEcFg5iFqkUEKrhP8JQsZZ3N9mFiOL6QrJ8U3Gm+qCnQsBydb8mPJMYNlLdUUdrYj5qMSGiAhUoJznPCLkTnMg8Z3MlvpQaxcVAUxb1dERNbEE35BcoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791998414; c=relaxed/simple;
	bh=Qx//gIheFl9xYCQ2sUQ1FmGfcu3hJjuWV+8FVxrMbA4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MtSEfr8rXPURt1MAQWaaDJn6WU4Q/hv0UBDu4ytI88nUa+pFjo7phDJ5VwiLOparqbuRnfEPZvUYPzxxf8SriqxDstzBuqAcDufegm34b8zaOvHGzVgnNhmERsNTV8+IJCfNn5BsqQ3eLtcSTT6THYvAAm0hiSX4MqvJMQIn2JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCAtB/Qo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCAtB/Qo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0711F1F000C4;
	Wed, 14 Oct 2026 17:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791998408;
	bh=NaCVaYjHT1jed1KnUfnrqOnhyHJdLH7mpTpDt0GpCY8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YCAtB/Qo8Ju+TAx8lnMULepsKWXzw9nU+6Mo/b2DJuSuM6FWdU/85I+y2RmrsvVvP
	 iHnltg4iImUnsUUPESg2sh3EBiIyHX88K/P9pUoHWqFzGT0RDggRbywqSxMynTjh3P
	 Fu9e44jArO4ddBnRsjMlK+7tbitd2sIT8BHS7swQj+u/o0qGlBLEvaP6AvWFBNCNy1
	 IoERu2dxFIYp/80vCTDGJ3w8O6zytNdKWPdkjdBZb7EDE9hhG+3+rYYYmH5mDJvJ2s
	 3yhrfhohhCvJeIGx0kYrqpL2vAqdsi/mTBveV4PHv0B9lnvshB8pfiJrp48CI/RZna
	 pG2IsfYrlGDcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F14AA39FD335;
	Wed, 14 Oct 2026 17:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_event: Fix LE link drop on remote features
 command status
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179199840677.2868755.4119305743244539802.git-patchwork-notify@kernel.org>
Date: Wed, 14 Oct 2026 17:20:06 +0000
References: <20261013071615.76382-1-kdewald@itba.edu.ar>
In-Reply-To: <20261013071615.76382-1-kdewald@itba.edu.ar>
To: Kevin Dewald <kevin@californiaopensource.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org, kevin@simpleble.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 13 Oct 2026 00:16:15 -0700 you wrote:
> From: Kevin Dewald <kevin@simpleble.org>
> 
> When the local controller supports peripheral-initiated features
> exchange, the LE Read Remote Features procedure also runs for incoming
> connections, and it fails with Unsupported Remote Feature (0x1a) if the
> central does not support that feature. hci_le_remote_feat_complete_evt()
> and hci_le_read_all_remote_features_evt() handle this and let the
> connection transition into connected state.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_event: Fix LE link drop on remote features command status
    https://git.kernel.org/bluetooth/bluetooth-next/c/586e33a9a94e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


