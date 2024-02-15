Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C5113B78A
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708031429; cv=none; b=IE4xgRg2H4bQFpqLV4h4MuZ7HMszV8N5Xad2CI4g0WCnAEMQWmzIkB1O/W1zeUyly/yy6KTtWspPDf8gBOswXaUwehLkoe2EoZchssKCaQ2U4ky4VK4G9HbtbKBYqj7Be0Z/mEsPLeolBb+GuNIOlZANzB6NUVOFiMVkzi4KLl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708031429; c=relaxed/simple;
	bh=nbrPb88prNgh20ZA/fZSeDmG8f/8q0rbi53fMkTqssY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Tu8t/Rq/hlaQs8Z402Q/L4YfL3iIceJw1WO4deDCVNjnryRI2/DaD/TxF7hdXH+1TMR+UgRJY48/j9Rcfka9LVX8qRr2+dOnt2fj1NrXgvZEXepx20D5ATSSusVORXJDcPIhQpeyYaW+cRSnUgOdBjWrGEh4un8Fdu2jhYdHK4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PquFjZFF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PquFjZFF"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5F6BCC433C7;
	Thu, 15 Feb 2024 21:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708031429;
	bh=nbrPb88prNgh20ZA/fZSeDmG8f/8q0rbi53fMkTqssY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PquFjZFFvxad5eoVAXsQVT+TorvZW9mYDEJQs6xgRLtp6ouWA7Bogoq9WeT8TQEIa
	 yZ7nh7WxENWeSNJTDMtN0DlCE9f+4+TX1s7u2RwFGpdqZEK4XMKBp8SkL+I6aYMhG1
	 VDqXVehgIsQEhfWiKQs4a5pMTAid3k0ClPficMPZBk2Up+UbT8eEtFCMYU7rdUclaj
	 Db1mdMSQIkKC0C488MR93Ws7Rr5HRXNxDaBtEeIGK+E0pAayXCr/vGeHrIDgl4sWng
	 7MUqEbrbtZR424OSTfisFAuduHugWSKbEaMdR9GSNOxyD20t259cItQ2T1uO1h2+/0
	 1Nxx682a5b9oQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 477BFD8C96A;
	Thu, 15 Feb 2024 21:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] shared/bap: Fix wrong value used when extracting
 LTVs
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170803142928.29324.1386351163543978548.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 21:10:29 +0000
References: <20240212162538.32207-1-silviu.barbulescu@nxp.com>
In-Reply-To: <20240212162538.32207-1-silviu.barbulescu@nxp.com>
To: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, mihai-octavian.urzica@nxp.com,
 vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
 iulia.tanasescu@nxp.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 12 Feb 2024 18:25:37 +0200 you wrote:
> Fix wrong value used when extracting LTVs when generating BASE
> 
> Silviu Florian Barbulescu (1):
>   shared/bap: Fix wrong value used when extracting LTVs
> 
>  src/shared/bap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] shared/bap: Fix wrong value used when extracting LTVs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=055a83c84761

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


