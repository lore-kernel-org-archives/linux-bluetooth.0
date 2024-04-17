Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF23262A3
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713388827; cv=none; b=aQitajtaiJO9rGX+v1N8JZnetKRTL94+YwWZKaNoFIfwimSa2LwazaAmv4pzHfc2V/1KHo5pYQWV01UGozBAD/Cox3O3KpTEEwtna4rA0B103xfmC7b6xUDTvyhY1YaJ1nlCn6BVZVIjZrKw70NB6OZJuvIpOpb0/uxkjdSElSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713388827; c=relaxed/simple;
	bh=CASH/Chnbbu4nFc4a6x+kj6MaB8aN10/YlLyaGSbfYY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bgAQ+aYbvuzsm0OYRjuwEdrSZTOpD17I1KImx3n13WLD3GsB7EC4g7K9vrnFna6IZzy5JLyGuOWZrGUb5zkVuXQ9Jt/3vC24iHsko/0CkGyxQw1q2WIg1HbIxPF5vox271Wmll8EzyY7FcgXZsAlt1ghqiChdDrZVoZpUB7vKgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aJTaA2n8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJTaA2n8"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9DCC4C2BD11;
	Wed, 17 Apr 2024 21:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713388827;
	bh=CASH/Chnbbu4nFc4a6x+kj6MaB8aN10/YlLyaGSbfYY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aJTaA2n8Fc0EGkcDd/Qw0mwMzCd9pujTJe7b4Xzszvb2qNc/eZtF8NBHrC+b4/owb
	 TAK37y7OPq3+f/KdDxLjxezfi9Q1lkxdWMzgKXbz566tOeE9OuBsTnlDc8ELJU33+R
	 HxUAwvIjEbsDOV91aDo8Wn3goEj73+MUa1rI1+T37hw2po5OQ/dsOkV1ag0+fr1p9h
	 qUsDQwXT1+rODVdBapdQTA+qyHBoaj32A7XnvqAPrGLy0ufXfkKDbOpmYE0LvcqNhq
	 YJxQ70Ns1pZSaONBnDpE6sVtPDcvNWhmTaa9s9pVlRePgYL4v90mVvNSAI1RJfiE3F
	 Ds0AOGrPF0dSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9015FC43618;
	Wed, 17 Apr 2024 21:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: MGMT: Fix failing to
 MGMT_OP_ADD_UUID/MGMT_OP_REMOVE_UUID
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171338882758.26503.5214643010438854659.git-patchwork-notify@kernel.org>
Date: Wed, 17 Apr 2024 21:20:27 +0000
References: <20240416195407.1153243-1-luiz.dentz@gmail.com>
In-Reply-To: <20240416195407.1153243-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 16 Apr 2024 15:54:07 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> These commands don't require the adapter to be up and running so don't
> use hci_cmd_sync_queue which would check that flag, instead use
> hci_cmd_sync_submit which would ensure mgmt_class_complete is set
> properly regardless if any command was actually run or not.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: MGMT: Fix failing to MGMT_OP_ADD_UUID/MGMT_OP_REMOVE_UUID
    https://git.kernel.org/bluetooth/bluetooth-next/c/0b4bd88b3b94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


