Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0541214212
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 18:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075003; cv=none; b=FGo12RCVcUv/IO6Qbt/VuYIHu8Raoej+KIxpQ/IqscJJbJDZ5UlIFWYm5xA4W0HY8zAf057j5k3E/j2Q2eriLInicucU0Ebuj7fql+Gbrtake1ylqvJNRLTVXJigNctmmDIQEfw6IQCq8V8M/8Flk4SQFMs5otSQ1jgiHRzSt7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075003; c=relaxed/simple;
	bh=QYrvcNwIiZeTxZ1PN/FrPHWyzXaNRPX3LYhyWPdQ6ko=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PZpHG82xkKg/s/FeU8lCYM9XZfTOdvyLjxmLSVnJYwp/aNYd/UqDAbeGSKprYUuH45AsHSQzSAhZYJFzAcpzpsxQ4uAgU1f4QTg+doXsNFhBgamghfzpL/CrxhaGjDABGZ2IB0N/osIhuPe4TmuhgcVg6Q9nbq+94Gc1uQMIc2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYer5ZHp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYer5ZHp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40D5DC4CED1;
	Thu, 20 Feb 2025 18:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740075003;
	bh=QYrvcNwIiZeTxZ1PN/FrPHWyzXaNRPX3LYhyWPdQ6ko=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YYer5ZHpdpufbTgqSJwHBF2aiVDbdA8rdQVfIuQrSMnZ+lzxdEgzNFfuF9EKU8mK2
	 BIi8YMEgQ30vVA0/h+U2hnVg+3vOSapih0fwn0hUSxv54xVwQz+vW84iN6yHa2jo0M
	 pSiwJ/pUlZgEvRYaV+uyPqv+4R8AjhmPVVvMY5HDnlOqNuROn/gICDLT+1/j9Cyf5P
	 /oGSj+P9mcGWGNiXokdLq8trJOtkmwydyqAde6URGQh+WTOl4gLEmhgxb/ITri1Cp2
	 MICcpvQlswXuDGFFV3iQSyZqKMfEumxlorxjrZRLz4FDskRI3xgI8GeeZoOH18BlVc
	 rlDjmWPhBkN/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34767380CEE2;
	Thu, 20 Feb 2025 18:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: L2CAP: Fix L2CAP_ECRED_CONN_RSP response
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174007503404.1411319.16129942979347735146.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 18:10:34 +0000
References: <20250218222801.1526620-1-luiz.dentz@gmail.com>
In-Reply-To: <20250218222801.1526620-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 18 Feb 2025 17:28:01 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> L2CAP_ECRED_CONN_RSP needs to respond DCID in the same order received as
> SCID but the order is reversed due to use of list_add which actually
> prepend channels to the list so the response is reversed:
> 
> > ACL Data RX: Handle 16 flags 0x02 dlen 26
>       LE L2CAP: Enhanced Credit Connection Request (0x17) ident 2 len 18
>         PSM: 39 (0x0027)
>         MTU: 256
>         MPS: 251
>         Credits: 65535
>         Source CID: 116
>         Source CID: 117
>         Source CID: 118
>         Source CID: 119
>         Source CID: 120
> < ACL Data TX: Handle 16 flags 0x00 dlen 26
>       LE L2CAP: Enhanced Credit Connection Response (0x18) ident 2 len 18
>         MTU: 517
>         MPS: 247
>         Credits: 3
>         Result: Connection successful (0x0000)
>         Destination CID: 68
>         Destination CID: 67
>         Destination CID: 66
>         Destination CID: 65
>         Destination CID: 64
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: L2CAP: Fix L2CAP_ECRED_CONN_RSP response
    https://git.kernel.org/bluetooth/bluetooth-next/c/aa6629540b87

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


