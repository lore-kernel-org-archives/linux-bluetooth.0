Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724D91308E3
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Feb 2024 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706901029; cv=none; b=ceGnnWlkPhUMZSM/w2q5akR17gIRyU+AKB09Z++Q8ZcSfod8Rqlpa2+CzOXgqAYJ1uFKWRUiYHFTKifhI4xUjCT46+PgLNeTiBQBpTa6UbMCiejHpVb9QpNIzR21NYf9ef+BgjpB61t7EhTrG0ppUkwsxOep2x07QyNTrqdoHV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706901029; c=relaxed/simple;
	bh=x14vz/gDKEwpWPSLJxg5Y2m+T2SU4dMDbJpg4TP+0oM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZHkiqAdnj+uoeqXzqhj1oVlAMMi6ulyszbYwthwjbX+un+Uk1GgcBI7LupAr1LHqFl6bSkanEIDJFsiF67dN+t+OcSe8/gFhnfDMEmuBaIHGsUZhSrHNuumeyyfU8zPaVQsJx6hg6wVgVI9KSSLKcPmI1yKZZd/2G/fP6t2S06Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VS4NETlI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VS4NETlI"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB43AC43394;
	Fri,  2 Feb 2024 19:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706901029;
	bh=x14vz/gDKEwpWPSLJxg5Y2m+T2SU4dMDbJpg4TP+0oM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VS4NETlIGi69F//hjbuQMBJbco7Xo/UK9qT0BEcN/JeCfVRffwvRyo1+TecOtw2ql
	 XBYGAzNCYO7g7gwFn6yxQB/75qmrkpbQuqRD0GEHICYdqENth6eV7ml+Ytux956i+L
	 s+MQtq/+78xT7AA15KNLlJ9eOm3JovT0pm/lrKeNtFKx7cNK5hCTZNJsDxEhwBL8O9
	 HLst6soRxqVYxq3YO9H2WpBz+RboAyagZoiH1ilwwBJldHd93fsBLUFDdpcQQhGqEy
	 b64nZ5oqMUcJSziCzke9ehBKsV6G+ISWHdk1T3ZYRhIkU0ypy37DdlM89Pe2B/zqcl
	 EHA2S4opIA8RA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6D19C04E27;
	Fri,  2 Feb 2024 19:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: qca: Fix triggering coredump implementation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170690102887.13805.17815962162279958410.git-patchwork-notify@kernel.org>
Date: Fri, 02 Feb 2024 19:10:28 +0000
References: <1706259624-12518-1-git-send-email-quic_zijuhu@quicinc.com>
In-Reply-To: <1706259624-12518-1-git-send-email-quic_zijuhu@quicinc.com>
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, johan.hedberg@gmail.com,
 mmandlik@google.com, quic_saluvala@quicinc.com,
 linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 26 Jan 2024 17:00:24 +0800 you wrote:
> hci_coredump_qca() uses __hci_cmd_sync() to send a vendor-specific command
> to trigger firmware coredump, but the command does not have any event as
> its sync response, so it is not suitable to use __hci_cmd_sync(), fixed by
> using __hci_cmd_send().
> 
> Fixes: 06d3fdfcdf5c ("Bluetooth: hci_qca: Add qcom devcoredump support")
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: qca: Fix triggering coredump implementation
    https://git.kernel.org/bluetooth/bluetooth-next/c/5e35f82bf3f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


