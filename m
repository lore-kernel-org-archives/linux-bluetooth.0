Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BADD219EAD
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 18:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737744014; cv=none; b=V23XlkJz6VknqG8y/1jvKlrxu1fsIIgE2FmPACjmrHBI8X0SdD4O71x0eduadea1IEtMArhvSsy6+06wmGwAfKShf40NyZWDNmL2kde4A2W6UlZmQjIj3aoAhCV4Op3xfCDKXq4xk1pjOeFzHRWn2kzE/QwFL171mk/E3XRiH98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737744014; c=relaxed/simple;
	bh=jUNkiBE7EPO6KP7+7/HBL7PIEmK4YMYTZYYhG91W0fg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EOoOjVCoQ27SurSGUuL2VeKOV+Sc+Gnj0VRxxM8izyGCEFYvNZ2Bil/I8C/+fVUHQxuYgpqR8N64quztsztQL8ZmVLh43t9jaaaE7TSsxPhsstX07Vp2zqZbRWuvtZaG1oUb9xlmkpcRi5A0Xd+zbtWzC8tWASSb09jEcTTJ5To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeS6A1ZS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeS6A1ZS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F4CC4CED2;
	Fri, 24 Jan 2025 18:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737744013;
	bh=jUNkiBE7EPO6KP7+7/HBL7PIEmK4YMYTZYYhG91W0fg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VeS6A1ZSuAT0VkCD26frJhAK61OHgSz30W99guJ1AcbnAaiHJEpiQmsH4YvlZp0kp
	 zsza9WiJnFiQ/PTq+xvQaUv3t7VDWgdLifUznKmyxjnFipfaOT3WE+KYrlTKeCfdIf
	 micH7bD4Qu6qQhQi+CH5qx3STzDOCZB2xpVnCRAkhxKkheLltJeVxVb30goXhI5rc6
	 cZHdBt+9Wrz6WgZL0O37y6TOrVBqxGacZWJHaHSY4O/lCo9zSiIFqGoaApgkKqUlo8
	 zgptRdlc7dcKKAqMPOjeaVKt0QewMEVJ7WdvonBmLG6TrKHi2h8jrJupLC9uazn10x
	 8mjj6ZiS9tGEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0B7380AA79;
	Fri, 24 Jan 2025 18:40:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] org.bluez.MediaTransport: Allow Volume property
 to follow profile range
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173774403824.2131600.5693404094007308977.git-patchwork-notify@kernel.org>
Date: Fri, 24 Jan 2025 18:40:38 +0000
References: <20250123205411.369041-1-luiz.dentz@gmail.com>
In-Reply-To: <20250123205411.369041-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 23 Jan 2025 15:54:10 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes the Volume property to follow the profile defined range.
> ---
>  doc/org.bluez.MediaTransport.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ,v2,1/2] org.bluez.MediaTransport: Allow Volume property to follow profile range
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9daadc32e807
  - [BlueZ,v2,2/2] vcp: Fix using scaled values for volume
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0aac6883b3a3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


