Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C7F1D5CCC
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798198; cv=none; b=h6v1grrgzw7Q+7+RrhK7j+9B9xDEkSxlCMMkI2IAp5ERrwJk+BlpX7ymK1oZCRb15bUF4pHxb1u5pY0pTlxDlgG2BOmHnTMUW5LA6ZGyyDh5CBFMAzVXcD8X96teJUK22OvPY19sFL/aCikQIQN0f8aRQmAtANHnaTu9qINWUCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798198; c=relaxed/simple;
	bh=Uq1/ZLOQP2cvBg8RBCHkrJ1VYboGGDmPsLVOMjE860k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rsK8EI73rZopIoo++LtZlC+q5Bh6u9oyIObPJqwz0lKlLxKLtp5C1YNXmuFa4+jsCgsFSQtoWBoHOLyzEd5TPNgFRCdZ5JjBBz2DnEUmJ3hJEE1hFifxuZBKTO9dSNfUrwXvRXnKbDsVFu0qMJ5ck6Nreh5memuzuxCTOunmqh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BSBsc9Yq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BSBsc9Yq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFDAC4CEDD;
	Wed, 12 Mar 2025 16:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741798198;
	bh=Uq1/ZLOQP2cvBg8RBCHkrJ1VYboGGDmPsLVOMjE860k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BSBsc9Yq1LbnL6OgG9+KDs3jYSfXw3Z6WGyv6HkH6X7napG1a6tfrIE9Vd3h8+IMN
	 1LaHGkLmqZCC4rKKRZxV9gSaEXC/CE1kI7RuUFbPmeby8gmmxURBb7z9PN7gzl2gX9
	 vMDjw7SwpKqRqRnq+kodY6zqL7rZpyQY2CyYMgHCEAlBU4s0fl6v4uMA3G+rrPLXeG
	 eTJ8fA0NooQOH1aRz4Fo2/+E5eagWTAoHA4D2/8LF5lWPB70Yu1WikK39ZCwbaTsQc
	 P7fwj+x4L5tIPRP2PkyXOpARrKtiU3K21AWhLuyeyZYZL8hzGwS85et9os5YDXnyR4
	 6KSo+jicwurPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD0B380DBDF;
	Wed, 12 Mar 2025 16:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] Fix typo: s/registery/registry/
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174179823253.864475.18361388046278369281.git-patchwork-notify@kernel.org>
Date: Wed, 12 Mar 2025 16:50:32 +0000
References: <20250310105218.4127627-1-kernel.org@pileofstuff.org>
In-Reply-To: <20250310105218.4127627-1-kernel.org@pileofstuff.org>
To: Andrew Sayers <kernel.org@pileofstuff.org>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 10 Mar 2025 10:52:18 +0000 you wrote:
> ---
>  obexd/plugins/phonebook-ebook.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] Fix typo: s/registery/registry/
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8fba2cd3b712

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


