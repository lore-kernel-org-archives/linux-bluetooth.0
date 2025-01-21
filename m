Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C515D1F4725;
	Tue, 21 Jan 2025 16:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737477611; cv=none; b=KWqag49xJt7ci2jXlK0fiGqSUEKuhXnuutRcGFbrOJam55SH1+13g08VyQ3Ae3oAkslnun5YHiIKJTV0OA8Uj8GnCl1vVC2VA7+5JZc99yErOSAPq3RbU9i3YsIRCZ9J50e5+kjdumQ/ZPzep7WI6iCfiZqiq2d5j6OGaOyK6y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737477611; c=relaxed/simple;
	bh=U6W6gWHksIKS/JOeP2vqnvlwLWqT1XvuJC2uq/dXEf4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sU2zK9lRI1TkrITpp5bFVlzperYs+TVsKQcTbjx4z25Kn+AT4IDVLB0nMzZ6sE9b1WGw1FMEdbNc2ANK/fE/lhq9gIHwVSko+FkYRheGk4Yoe464qAtXy2qclYeGXG1gmwTksRmxcZkDshgrwU8gUgXcAA/89FqhNb5S9YJQC+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMJB1DKl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMJB1DKl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C900C4CEE0;
	Tue, 21 Jan 2025 16:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737477611;
	bh=U6W6gWHksIKS/JOeP2vqnvlwLWqT1XvuJC2uq/dXEf4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cMJB1DKlxXJCBejrEsWXKO0shnAJR2xB/x9g3Xl+gwadDPPQTPcvWqgJlReJxul4V
	 +webTwXhjTE2BM0b+SGXD0mixrm2YNtCBp+8DAOCRSZlVFV5140ftfJr70Fq5cAp8J
	 LNhVp0nYzWOUYU70Cl4f67HBTu6c7eDurB4QPQmd4LacvVkzmCsuGI96UyhoP2Efc3
	 bZ1h23BLzsS6egQXjwabU4GToKobyOf4zKHHim08hqo2JnNuvG05MTgy1JUKKYt+xV
	 GKdgyviAr8Y+vvFL/cDgu15URGdM7d4SkHwu6s9NshZNv+oascPP22ZI94lJp6dfgL
	 bbRo3422fWyAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE226380AA75;
	Tue, 21 Jan 2025 16:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: Add ABI doc for sysfs reset
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173747763549.49514.1118957944197537637.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jan 2025 16:40:35 +0000
References: <20250120164732.v2.1.I2524c9a7d322be04b38b29bde3d7d1e578229cca@changeid>
In-Reply-To: <20250120164732.v2.1.I2524c9a7d322be04b38b29bde3d7d1e578229cca@changeid>
To: Hsin-chen Chuang <chharry@google.com>
Cc: linux-bluetooth@vger.kernel.org, pmenzel@molgen.mpg.de,
 luiz.dentz@gmail.com, chromeos-bluetooth-upstreaming@chromium.org,
 chharry@chromium.org, johan.hedberg@gmail.com, marcel@holtmann.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 20 Jan 2025 16:47:36 +0800 you wrote:
> From: Hsin-chen Chuang <chharry@chromium.org>
> 
> The functionality was implemented in commit 0f8a00137411 ("Bluetooth:
> Allow reset via sysfs")
> 
> Fixes: 0f8a00137411 ("Bluetooth: Allow reset via sysfs")
> Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: Add ABI doc for sysfs reset
    https://git.kernel.org/bluetooth/bluetooth-next/c/07b6216dfc34

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


