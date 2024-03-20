Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F0C381AC
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710928228; cv=none; b=Ftk91Qw70kQVTODNVV2MuSgy5SL3YgtEvxDHC24XNi58PpB6J8iZUE5gEwQ5Bm+Xdt4wtm1AmRm+9VMvUxg3WzAKR+lDyGW+PkcbdurEP9r8+mowBfvXt3NZC609g7czFZdxqgiIfY8nhpSjNMspMGFzjoBcSRHrKNQb735UoAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710928228; c=relaxed/simple;
	bh=/F1De09lm92+az2h3xGc+/3MBx5jRnUSrGkhYK5ejNs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j7WpTMzA2sZ89GN5mIa0QrshlRtQdL8FGsT1qfnf5Mz0wbIbmFqno5fTi3ckZ1dx8v2WwrsoLi5LkB6ec9NUL0TxeZB+WkIMudb5kddWWyi33oIv6TTe8KNyEP58H+RQAKfZBvohyCiiAqMJq4DC5PQdIz+UHdit5QEOqDDYwC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvAx2hLA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvAx2hLA"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 42757C43394;
	Wed, 20 Mar 2024 09:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710928228;
	bh=/F1De09lm92+az2h3xGc+/3MBx5jRnUSrGkhYK5ejNs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PvAx2hLA6rScmCS5j4+fypnxBG6Dhkx9ssCss+2gpI4r5c9bhUjEzPX/au5AflqiN
	 GfmZyxJS+63kUaoBKFKtbUm0DhveR9nbvq99zOha+lf/TGcQtEbW3OZ5jHv8DqbcNR
	 Fr6spkAnQKJVN6QlaT9eutCqV5MvIkeEdNw0ciUt3puqYO42oBv2zIRs+WLmrQP0H1
	 kULSixFFudlwplHGjb5Y0klDOXfE2Ho3YoXxi8T1gkU/N4xpAQLEzkenhvf+qQEE1Z
	 lLANIrreE9ZG6Dvubv8dIMxkQafmnDVE1ICfUkttl4pxKxCDRLe0PNUn+RPVZ2+NsE
	 6nCPBlC5FRRew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C9BAD95060;
	Wed, 20 Mar 2024 09:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: ISO: Don't reject BT_ISO_QOS if parameters are
 unset
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171092822817.2097.12889449652955308605.git-patchwork-notify@kernel.org>
Date: Wed, 20 Mar 2024 09:50:28 +0000
References: <20240313194318.1397153-1-luiz.dentz@gmail.com>
In-Reply-To: <20240313194318.1397153-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 13 Mar 2024 15:43:18 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Consider certain values (0x00) as unset and load proper default if
> an application has not set them properly.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: ISO: Don't reject BT_ISO_QOS if parameters are unset
    https://git.kernel.org/bluetooth/bluetooth-next/c/60482ab92867

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


