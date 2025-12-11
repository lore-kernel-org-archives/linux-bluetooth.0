Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424503161A5
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 17:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765475592; cv=none; b=cpgdhRRPsqDpmciogjrUjnL8CD7NvAC7XD9hIZNFMAA7Ubbb5/Jwmw688j5VIcJ5M3GDwc0WbhqHsj9vRyfKXvBSEPhDCoa5ITBFohSBMlLc0cDgAqSE9PqgL1addPY0dckayRTSSxQpexqVdjHhSyIQQ1vFK/+up91S3jN3QVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765475592; c=relaxed/simple;
	bh=jJi0Hkg0kULgDi7hbxv6+NGw18W96hosmngWaDyQ8Xc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NDosSDFn4KmOicb3e/urMUTVJSbk6ob+cAIvVa19x/e2rgiu9QA4oIvH27Wnzs7mPcnJaxC5locDLjjfXXSsmiKyJZGQX/0FixHNiOu+XVzZOkDZLJdkQPADXdnevP5UDHEF3Dgh3Fe3rE9T8XnUH6ZkRQ4eeuGaV/0ZO3zxCpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROqmj791; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROqmj791"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B8EC4CEF7;
	Thu, 11 Dec 2025 17:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765475591;
	bh=jJi0Hkg0kULgDi7hbxv6+NGw18W96hosmngWaDyQ8Xc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ROqmj791obriyl1AkLsknEXuju6nOgzod/iwPrTIsB3Gz9evKl9uV0QAOsT0mwvEE
	 0DlJr+S+55vOFUuH4Few0AgE55PHakzUpilyWXpLreVocJ7ZImJOhxIl/eteGTAKf1
	 ZhgYms1NQR0fJ6nxyEkuTq9aB55i/qgVePi12Mc6IhCvieHCtTNm54+PplTrVyCwFP
	 DmnD6909u7MuEY3+XN50z31VVKfl7rNxR/Q+DU3ZnuynhmEcske2sAb7+krcsh/AHk
	 Xo1ocXLD82bzoLJ8RF2svBZ9734zS1v67DxKI3OLJFD1vyWWWhEBrxcplujd3l0bJy
	 Ceu9qQioL+yLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B66E63809A86;
	Thu, 11 Dec 2025 17:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] l2cap-test: Add tests for BT_PHY
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176547540555.1466170.10377853339223036402.git-patchwork-notify@kernel.org>
Date: Thu, 11 Dec 2025 17:50:05 +0000
References: <20251210204952.153725-1-luiz.dentz@gmail.com>
In-Reply-To: <20251210204952.153725-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 10 Dec 2025 15:49:52 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds the following tests that uses BT_PHY to retrieve the ACL/LE
> connection supported PHYs:
> 
> L2CAP BR/EDR Client - PHY
> L2CAP BR/EDR Server - PHY
> L2CAP LE Client - PHY
> L2CAP LE Server - PHY
> L2CAP Ext-Flowctl Client - PHY
> L2CAP Ext-Flowctl Server - PHY
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] l2cap-test: Add tests for BT_PHY
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e83c6cf125cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


