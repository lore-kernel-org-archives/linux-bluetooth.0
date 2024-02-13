Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DBC612F8
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707857429; cv=none; b=HRVlh8Qz0P62yni18rnltpdetaU9fxDoqhjKtFPmRnYy5xUclbJvz+B2b/W2L0s1KPwnsj8lKxtRTUPUm9cpixj6sn1e8B/Jdl65EiLrl1v9POFXUHHZGWHbd+hHY6amakCDf6ZODdNmweJJEhIvhCr7lRgFhaRh+nUqlpxwc48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707857429; c=relaxed/simple;
	bh=IB6UruIZbpHl5sV9Aay7eC8UT1Ny9eKzTq/Vu32cqsg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DNUfp6eSyXIgv+UrSn0fBgsZF+flv49rZ92IonZn0AAhggLyx+/YQsLfggmzOQJsKqJ9Zfxr/Z3Wd4gDNUPYA0fK5zwuSNnlJCX+oKeQ39iibtKKk7A8lRpb+Xx7gg6o7sgLKhT6XWx5fdBqB8Sv4qi68JXTZ0C1Cw5b1TLyWn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qCs3zU+a; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qCs3zU+a"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EFBF4C433C7;
	Tue, 13 Feb 2024 20:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707857429;
	bh=IB6UruIZbpHl5sV9Aay7eC8UT1Ny9eKzTq/Vu32cqsg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qCs3zU+ahinVqMnZCZ/MVB1L/Owh7MUc7N41OWl2wq42z4GjGV/Xo1CXbs7EZRa/1
	 mQ/sIhuknd0UCvHHCJFRIJWnAjfuq9ILdhv+KiCff9fRD67HjjpGtNuy16PQ6xFCxX
	 ymwquzzgzawZoIyA9IhurdcuIRJfrKIJCm/b7dW0X4Y9VKySm5SOPe/+0/6R2vIumB
	 9xMKpufIbOcxIvxP1R/EN1LOHtLSU/QtNpnJT6J+6avvzu51+LEbUqZ8s7xpazyBMG
	 fXVHQ5E6ia+nMUbqFjwpWzct+es04wNMusSovwrd7ZypJpV2/Sv4x/3rXLCmXcyYwh
	 dwa7Z7icGJy6g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5EC1D84BCE;
	Tue, 13 Feb 2024 20:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/3] lib/uuid: Add support to compare 16bit uuids
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170785742886.22526.9290908426741803933.git-patchwork-notify@kernel.org>
Date: Tue, 13 Feb 2024 20:50:28 +0000
References: <20240213215703.21507-4-ajay.k.v@intel.com>
In-Reply-To: <20240213215703.21507-4-ajay.k.v@intel.com>
To: Ajay KV <ajay.k.v@intel.com>
Cc: linux-bluetooth@vger.kernel.org, kiran.k@intel.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 13 Feb 2024 23:57:01 +0200 you wrote:
> ---
>  lib/uuid.c | 9 +++++++++
>  lib/uuid.h | 1 +
>  2 files changed, 10 insertions(+)

Here is the summary with links:
  - [v2,1/3] lib/uuid: Add support to compare 16bit uuids
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=93d88ecd0714

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


