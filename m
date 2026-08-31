Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E824A8FD5;
	Mon, 31 Aug 2026 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196872; cv=none; b=ApM4ClesD1SfdIOlv8IeewNx0FQKpMWp2AD4kuPcujJgXvFinX0q/3HIu5V9R+pQx53avIBlHQZOHVWzj15tuzmiRgHDIW/azgH7rVkwh7KV+No17PZ6tt8M8+wjX/TN4CZlM2T5NLHPJ6Axkf1iLHqt84gd1NSSxC+BAqYtets=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196872; c=relaxed/simple;
	bh=wZXZ5tyz4+iqVA+E5VAZx32f8VLfUHUDkbezeZSr4F4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o1qtX/Y5CKYu6/m8Cji1vtuJ0kVU/TRAN4n5GuXmf0Vjsi8GljQzRINuCtvrrZfXOTVCVrIiSZ0mgLPer7hzO43gu0XLzPdp5Ueu8vfYRWAXYps0nDVvxKhnRYAPpUtTZkAnbEmAuibQGQmfy/pMtmD4tCjCz16lJ0MLY18qFtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWm4rMQK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWm4rMQK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9AAF1F00A3D;
	Mon, 31 Aug 2026 17:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788196870;
	bh=uQMG6tqpS3eUFyH0Z2UMLCZ02wO+PQDSMxz+lvNFvxc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oWm4rMQK5SrwTeKKk6U5OA9klhaGjVmVNrDq5fjgJ9NUCjmoMsZlAez0lxtWjbSxx
	 tXblPQeFnzekMeKTeao7hUvqEUdR7fWLI5t1YBpGMqiOskpcXXGue0rnfC+0QsXC6i
	 7yWvFojl14qXJk4ofowYIh5g3M+rrYXSQmDPH2X45Bdh0DsVNyl981AptnnuiQhBhc
	 /nt4Pyir7qKrTBOig1Arqe38K4NtI7S7AU5lmY+uVw5QImpXwY2x10lr05U+NzYTjg
	 W7UgYuWTuqV5w5F3m/fvRNJaKk6FlYsps3VDd5tFU3tsYRhetSC+ZLlu4Kj15jIJk0
	 781uiJAnE+MLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1972F3924458;
	Mon, 31 Aug 2026 17:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/3] Bluetooth: btintel: harden version TLV parsing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178819681363.671757.16024867125795377604.git-patchwork-notify@kernel.org>
Date: Mon, 31 Aug 2026 17:20:13 +0000
References: <20260831095923.18830-1-acharyalaxman8848@gmail.com>
In-Reply-To: <20260831095923.18830-1-acharyalaxman8848@gmail.com>
To: Laxman Acharya Padhya <acharyalaxman8848@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org, ali@iusegentoo.com,
 kiraank@gmail.com, kiran.k@intel.com, ravishankar.srivatsa@intel.com,
 amit.k.bag@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 31 Aug 2026 15:44:20 +0545 you wrote:
> Malformed Intel version TLVs can make btintel_parse_version_tlv() read
> beyond the received response. Validate the minimum value length for each
> known fixed-size TLV and bound the firmware ID conversion by the TLV's
> advertised length. Propagate parser failures to the setup path in a
> separate patch.
> 
> The two bounds fixes are kept separate because they were introduced by
> different commits and apply to different stable trees. The parser error
> propagation is also separate because it changes setup behavior.
> 
> [...]

Here is the summary with links:
  - [v3,1/3] Bluetooth: btintel: validate version TLV value lengths
    https://git.kernel.org/bluetooth/bluetooth-next/c/eb656c5bb754
  - [v3,2/3] Bluetooth: btintel: bound firmware ID by TLV length
    https://git.kernel.org/bluetooth/bluetooth-next/c/58c6f5ec1d22
  - [v3,3/3] Bluetooth: btintel: propagate version TLV parsing errors
    https://git.kernel.org/bluetooth/bluetooth-next/c/f8c8fa407aa0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


