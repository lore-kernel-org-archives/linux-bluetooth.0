Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73296364038;
	Thu, 30 Apr 2026 17:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777571790; cv=none; b=NswuVPDsGxTPMW4NETJrFQ4dGL+LY5x8SBfKvKkEkySxmUTXoE2PnlzuyphwinsfXjfn4mnfbPQgsPIfp1+achrP6kLioAVbw83u5POA9AqKrIJVlU0mg7pJmhIIaNx03wujYTfDHJTCQYKNhaMtvQtFqVhhBLjBAaC7UcLIjCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777571790; c=relaxed/simple;
	bh=mu8CyJbzk6oFEHDvzyPeBWPQN5MDIdG5XefzZtnwwtI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C10ST1hahSlEnjsbLqSpdDM22r6b+BiLgj3IENGdaiAo1M7rSgF45UBcohONA+7V71nS85DFYLs2ZJ9fXGpDiPvdNz4lYp2tfuuDQwXxYW0yxiQPL2YsizJzwMRXOONVvGlABkaY0hzmC8SVN6nQjGgdOoRISZucgnuAaAQ4ChA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/Lc+e1P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/Lc+e1P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FF5C2BCB8;
	Thu, 30 Apr 2026 17:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777571790;
	bh=mu8CyJbzk6oFEHDvzyPeBWPQN5MDIdG5XefzZtnwwtI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=q/Lc+e1PmVXZR66JcLglsxedi/KjuBpOyEUd08Gi5sHbNS686f1oeLxhchgB4vpJK
	 R/3hvG9b+7yYgC5YcqsFJzTU0E7WOkA1AAZnfRvvvztDVYmmlTWi1lRV75/Ck/m7o4
	 nKrti6asvEsyoXDee8Rg039zQJzAUZCE65OB7N7eHV/192REFW78H2QmCwBHpFdgmM
	 pDr09ssaZmlZMBLMPFdvENHIGT8STuv1A1tadA0krD+Fmehto9XlvH4Lj2bkftBZxO
	 sZNACpRiPdodRgtM5YWeT5Fcvb0i6vySGcZCt0PzQa2h2xrECCj8i1vxqkaLsQ2e7L
	 MijkzzGrJTIJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E54380AA62;
	Thu, 30 Apr 2026 17:55:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-deletions] net: remove ISDN subsystem and Bluetooth
 CMTP
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177757174432.3109994.10971496392017658764.git-patchwork-notify@kernel.org>
Date: Thu, 30 Apr 2026 17:55:44 +0000
References: <20260421022108.1299678-1-kuba@kernel.org>
In-Reply-To: <20260421022108.1299678-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, marcel@holtmann.org, luiz.dentz@gmail.com,
 mchehab+huawei@kernel.org, jani.nikula@intel.com, gregkh@linuxfoundation.org,
 demarchi@kernel.org, rdunlap@infradead.org, justonli@chromium.org,
 ivecera@redhat.com, jonathan.cameron@huawei.com, kees@kernel.org,
 marco.crivellari@suse.com, ferr.lambarginio@gmail.com, nihaal@cse.iitm.ac.in,
 mingo@kernel.org, tglx@kernel.org, linmq006@gmail.com,
 linux-doc@vger.kernel.org, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 20 Apr 2026 19:21:07 -0700 you wrote:
> Remove the ISDN (mISDN, CAPI) subsystem and Bluetooth CMTP protocol
> from the kernel tree.
> 
> ISDN is a pretty old technology and it's unclear whether anyone still
> uses it. I went over the last few years of git history and all the
> commits are either tree-wide conversions or syzbot/static analyzer
> fixes.
> 
> [...]

Here is the summary with links:
  - [net-deletions] net: remove ISDN subsystem and Bluetooth CMTP
    https://git.kernel.org/bluetooth/bluetooth-next/c/4f10f1dfb235

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


