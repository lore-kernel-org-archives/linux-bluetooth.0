Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1192510A24
	for <linux-bluetooth@vger.kernel.org>; Mon,  4 Mar 2024 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709586029; cv=none; b=EWBYxCrsLZ0lvrC+DCq7EhsWdkrze5PrP2IagutZBuvDebpGooojAJBPy7vTaQfKRHb/va6HihDcuLjVpBg1kiVVp2ncNuf20XzPOOBAdjeT9ohs8HmtKSmx0TJ/y+4PZYxIVybJlUWPzE+GpoF3UKRukyVMeirUZx6PVAxpTjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709586029; c=relaxed/simple;
	bh=FLEK6DWvxOcyqKPbWl7WNYQYSUpyZ6XN+c7lNeUELx4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TmR84CBwD/PmBSbVUxcl096CdG2/vt/ca0q1AZsxidofoccht/u49inaR99KC65jp7mVII0Rl4YoX4fLs4KzuIFjEmTthG5SY/Xj3/17CTHdsvX8EqdYxrX5PNmT3gMsL+7e9KXQ5JJH3UoU7QBexYwrV/EIp8kJNqZEt13TyaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAXg0ZNW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAXg0ZNW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id E546BC43399;
	Mon,  4 Mar 2024 21:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709586028;
	bh=FLEK6DWvxOcyqKPbWl7WNYQYSUpyZ6XN+c7lNeUELx4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZAXg0ZNW7T0i5CxkNkfKLg4uxzoksDFjG1sXTkMu/rn5VFDGruYHBA2Kq1AK2dtm7
	 QHzuTnqxaDaNsErmTXg7OVG9a2bTvoMyVtRDu9SVbQtdQvqo9iTo0bluRfH3HXHkTn
	 MyKc10oDGI78qRzb7vb3LMu2nAOHnUniGDig3TzzKbDFxrLt2YkMSsJuu93GFZwZwk
	 koyYn8PmLLEytJWJwrd0hV4F8P7fHOz4giAIq1NUz3dBdvhMCAv9d3BH6+xPn2YS2V
	 6iuP7hZavNuTwZ0a9Kzlwr5WUr6c9wg/HXZhd3fNC/TVbTxSg58l5vpVZ0J9UU8bFz
	 VB0lAa510VkfA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA874D9A4BB;
	Mon,  4 Mar 2024 21:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] Don't install conf and state dir on systemd
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170958602882.11728.8847999337738114915.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 21:00:28 +0000
References: <20240304142200.69968-1-mg@max.gautier.name>
In-Reply-To: <20240304142200.69968-1-mg@max.gautier.name>
To: Max Gautier <mg@max.gautier.name>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  4 Mar 2024 15:21:57 +0100 you wrote:
> The bluetooth.service file already specify the State and Configuration
> directories with the correct modes, which guarantee they will be
> available (with proper permissions) when bluetoohd starts.
> 
> Not installing those helps implementing the "Hermetic /usr" pattern
> (TL;DR: '/usr' contains everything necessary to boostrap a working
> system)
> 
> [...]

Here is the summary with links:
  - [BlueZ] Don't install conf and state dir on systemd
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7665fb5d943c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


