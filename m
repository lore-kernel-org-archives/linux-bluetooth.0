Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE07028EF
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Dec 2023 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+h7SFoh"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 50F85C433CD;
	Fri,  8 Dec 2023 15:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702047630;
	bh=CKvaHHF3Lu25ZEhaxMjitt8S3IIIUezHWY63c4iU7yw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y+h7SFohBG10CXSK56VqLakjt3Q75RS+E3jIw74/3M0nZGzR4EPsCJnmw9CBXXTbb
	 oZEnMztRcPn3Ymi2CzedZjN9P4Ejzi1yCfQmRRlnABx5pwEeT+ryfg4B5vmbDDw6wj
	 Rd5K0BhStxCVOTy8Wla9Q0W+Ibr7PRdoj6pAk0u2N7UdnP1cQJhkprc/quFjH+xiT9
	 6QsWy5fTA8wr/34oKZJsfl7N1EGvXuIinaGinfrABrF4e069XQcQrP6Ff+4XdQVQEA
	 np2IRr2ZryNQw9k7aODAyeq3RCS2/9GwrmXYXuef1Lu/clJw04n7u6SxDFxmrpbCht
	 fY7h7aUm8o6iw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3D04CC595CE;
	Fri,  8 Dec 2023 15:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] Pattern match on service- and manufacturer data
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170204763024.28520.6907170827783234804.git-patchwork-notify@kernel.org>
Date: Fri, 08 Dec 2023 15:00:30 +0000
References: <20231207090902.884270-1-sebastif@axis.com>
In-Reply-To: <20231207090902.884270-1-sebastif@axis.com>
To: Sebastian Forslund <sebastif@axis.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 7 Dec 2023 10:09:02 +0100 you wrote:
> When advertisement monitoring, manufacturer data and service data was
> not being matched against. This made it so that advertisement monitoring
> with or_patterns did not work that type of data.
> 
> We must start matching against the data in the manufacturer_data and
> service_data queues. Run a different match-function depending on the
> type of monitor that is being matched against.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] Pattern match on service- and manufacturer data
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b0656c2cf14d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


