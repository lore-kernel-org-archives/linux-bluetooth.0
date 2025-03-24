Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C04D263F44
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742836199; cv=none; b=gc8CaC8Kg1hl3ZxIUX+3p2t7E9oXiGXsbnVrWWkv1niubkc67OzrkIWzuxbSJ6WTQCdn1h4Ximvw2QposY4mZvnvaz1lyO5C8ItrNDwTvh2i8Aj9wRXaNtit6da0pOw5+brqf+upyUdNUkCNEI339OGDOKNolHVXIEeY9LEYYiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742836199; c=relaxed/simple;
	bh=zndSX8Ij5UVJbY3BvhviZQI6bvdxmHPGaspilkG8qxU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CEarjWX43DQq6db5b+cc/maOGTOaOF+wz40jzXdexIyGDR3biDC2aeKDkHqadABhZHQ1DyJrWU1z3VLW7HxPvYLB2BIF10+u08Y/nTYdL21KSuOI+xvwVD5FJt3ptwOrjnFQmuBrjJ/iPR7b63KYkiy5WIltwqL4NERPYa6vVtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3993VFX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3993VFX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE95C4CEEA;
	Mon, 24 Mar 2025 17:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742836198;
	bh=zndSX8Ij5UVJbY3BvhviZQI6bvdxmHPGaspilkG8qxU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k3993VFXaRZaX7vJVM7NlzEB548UlXXBPrvYNMHuk0rNRD+WvpRcjXP9Vb13zf4Qj
	 EYu4hW4B01LyR+AvFxoGU/9eOXNG337xK3pKV32G1SRTMPuCZFAXdYOrzO26ExdOeH
	 8vgBRIJGR6uWqgUI+R95Bh8VjqJMR0QHPbj/ifGs4tcs+cLQE77iEJx3MkvyA1TV2v
	 +ROlFtM2igtsa6WWtSR3YaV3zxcJSxzm5emxUHha8q9NA3s6jpw+j4dLqK21jvamxb
	 cSFFIeOTeiQ+rnIdEE51FcnjpVAwVIekYHhCCwjCtDac9JTZGwbGA5Z9CDev33u5eb
	 b1gFtR5RreE/g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ED392380664D;
	Mon, 24 Mar 2025 17:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: MGMT: Add LL Privacy Setting
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174283623478.4100869.2431559901673277247.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 17:10:34 +0000
References: <20250321194627.1729246-1-luiz.dentz@gmail.com>
In-Reply-To: <20250321194627.1729246-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 21 Mar 2025 15:46:27 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds LL Privacy (bit 22) to Read Controller Information so the likes
> of bluetoothd(1) can detect when the controller supports it or not.
> 
> Fixes: e209e5ccc5ac ("Bluetooth: MGMT: Mark LL Privacy as stable")
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: MGMT: Add LL Privacy Setting
    https://git.kernel.org/bluetooth/bluetooth-next/c/402f42938757

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


