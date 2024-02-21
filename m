Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE627C097
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Feb 2024 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708533630; cv=none; b=YJCImKE880X5S3gLjE6L8xYRcBBEwSxZvhoLsh+QyJEyLw1cjoyMqDibyUzma5nkUBY8S6eMZsM1gh2cHbIkDLUwT4OCJ8/YPakyilKvHdkAW5F00WJiYVccpGzLJc6Qk6UqOrVKV5AWzNKXWvcdT0AE0MM6fetl7HOEn4BCmVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708533630; c=relaxed/simple;
	bh=gjLwyceByQpNNK2Kc8whViaCLfQCF0IybO2DALJFaQk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kNS6CO+nPZtayRvFPURvnz5NIHNoSluDr2Xd+AyL2D8Se/c9A9NojtuOINjOryDPicJia9nQaG4DiEkhOghv6e41kNnBl4Hm070xtT1Fa7h0tr0djBDXwYCCimI1dui+i7OjShFDVgYLQ9dT5JrHnk5gbno2Sv+U+4VTj6OJnbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tMGWopHg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMGWopHg"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B453DC43330;
	Wed, 21 Feb 2024 16:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708533629;
	bh=gjLwyceByQpNNK2Kc8whViaCLfQCF0IybO2DALJFaQk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tMGWopHgCTJgua6f52evBiCP9RRU7pCIziW7B7J4AeqSuPZvOF7eEGKqbCm1jKA57
	 lsySQXS3m/ZxJ9lz0hn5Ajqpu0W4HMFnXat4JfxlqgSpHYZVtBlFNgfvjhvnUjOYyF
	 0soKWAdJJMuzMnLK6WT7AhodNTK2qU7tBnJCFGrIEEB2/2AjqeXCC9d2+PcGO9TZxa
	 +WEktESZPKAu/rfOcBnQ7PaN13xwmBpJRiFsUXIOxpS9QiLVdf7aR/ceNemdxOfNna
	 B1FWvk3NAmYcZSPUCZZgZi4JphsKAy0/VrmGg3optqYgJt2U5/BK8ESxZDVpad+MFY
	 36WvKSkrfCZQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 990E8C00446;
	Wed, 21 Feb 2024 16:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btintel: Print Firmware Sequencer information
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170853362962.13387.8484041172965236687.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 16:40:29 +0000
References: <20240221133346.3295639-1-kiran.k@intel.com>
In-Reply-To: <20240221133346.3295639-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 21 Feb 2024 19:03:46 +0530 you wrote:
> Firmware sequencer (FSEQ) is a common code shared across Bluetooth
> and Wifi. Printing FSEQ will help to debug if there is any mismatch
> between Bluetooth and Wifi FSEQ.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 114 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 114 insertions(+)
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btintel: Print Firmware Sequencer information
    https://git.kernel.org/bluetooth/bluetooth-next/c/452481b004a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


