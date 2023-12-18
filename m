Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877961DA29
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Dec 2023 20:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ro2OxLIF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E808C433C8;
	Mon, 18 Dec 2023 20:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702932624;
	bh=j5DYB9/uEctRO5pJZcf3KSIXtWNXbhx8+gpknahPviM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ro2OxLIFXtf/wfJXSS3J5UHjVonxYkC1vqIebDK23LM2iR7AbkeHSMEPOitxQg2Ha
	 vzp4VAjZmrQOuo4AzwSh2AcsS8gdBW9h0XUnJ+w1s+ynHyyw5rfvctCTXPn29wpoSA
	 r5ZAjes20HLU6zAUIjb6/bRqEyNodFJ4spN55aKvMjdCyQ7R7Zp+WYw6OegV3MlwyZ
	 BEDy3/2aBJ1bj9hGqK/6s4TxTKD2bCIZJR1BfwZERXhqSxaCDUSMzXZiE7nn6USFn3
	 EI+TfoxejBKOutKtCIEIujsyRnoPCHmt5RWo40fs2q1oZCv+WhbTQDihMxQ3wGf6wM
	 yVCpgEt+FBuCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 08C0AC595D1;
	Mon, 18 Dec 2023 20:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/3] Implementation of AICS service and Unit Test
 cases
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170293262403.10818.8523452444804777040.git-patchwork-notify@kernel.org>
Date: Mon, 18 Dec 2023 20:50:24 +0000
References: <20231208114258.133709-1-mahesh.talewad@nxp.com>
In-Reply-To: <20231208114258.133709-1-mahesh.talewad@nxp.com>
To: Mahesh Talewad <mahesh.talewad@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
 devyani.godbole@nxp.com, nitin.jadhav@nxp.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  8 Dec 2023 13:42:55 +0200 you wrote:
> Hello Maintainers,
> 
> This Patch series contains following points:
> 
> - Implementation of Service - AICS.
> 	- This code covers all mandatory features of AICS.
>  	- Verification: All mandatory PTS testcases of AICS are passed.
> 	- Specification referred for implementation:
> 			AICS_v1.0.pdf
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/3] - Added AICS Characteristics UUID(s).
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c89ebba80f27
  - [BlueZ,v2,2/3] - Code Implementation related Service- AICS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=172948d0d6f6
  - [BlueZ,v2,3/3] unit/test-vcp.c: AICS unit test case implementation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=eb07ec1f6ffb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


