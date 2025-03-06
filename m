Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2F12139CD
	for <linux-bluetooth@vger.kernel.org>; Thu,  6 Mar 2025 18:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284599; cv=none; b=eMikt92me+gRe/56aMA3qAxNOqgqZXkxP5jejf5EIzF7iKrtTVXd0c6wyhKmlXo48b0QRtVdyzYx2DX8ak0KH/KwZWfx2ci5XBuWvTg6/LIJJYIQ97lB4R8YPHvx3XT30OptzS2ABFxW7E2+4S0+k0JO4on+NFlmN4+GYwrB7ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284599; c=relaxed/simple;
	bh=nPZkVErmSJWKJQg3XwDmUuOESSEEgZvJrPe3W2uazaY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FCTrEQqEO7A7C93i3PlT4R/g9zbP931fg1KNLUppwdoeRjWCDFUFqZc4F/3IYGZ5F9xYKeEgTgtbxzeLfsSKp9eGN66IJ5S3Pt83u2pZpfGz+8GZVBmC340uIGbzEb50lMigBneAg1De+o9mpOl0GUoU8fXuTjKcWcppxbet65c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUhEfqTv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUhEfqTv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D48C4CEE8;
	Thu,  6 Mar 2025 18:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741284598;
	bh=nPZkVErmSJWKJQg3XwDmUuOESSEEgZvJrPe3W2uazaY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oUhEfqTv/PJLczWUtv/8FFEeWN505L6HJZCSexrJsAu0QplUW/NB25ml65Fwf7y0d
	 1n7UD3q/p3LEE+3iliue2JslTFwLcylt1gtUCyirFKsD8V08Ht7aoM3kyny/dEXXnB
	 EV61AiLoED1tkee7bJpMEJXwz7jwwk6Xx3SWrMTnFpdA/5xi3AfezXdYAyjV2K9t2v
	 esPQqj1U3mjQwojiTjA5aHKCa/kFzk+dqhQfpmjAyZ+F8KEVzVQM/G0Ln73TFSkqhv
	 SiKb7H7P6+V5CaIJz8xElpB7lHn5kjYvFDDcLthPoUi6smpe3jEJz/HCw90IxZUe/y
	 I9KOTXJeR/i4g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C9A380CEE6;
	Thu,  6 Mar 2025 18:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 1/4] org.bluez.Device: Introduced PreferredBearer
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174128463201.1694595.18290187114283313427.git-patchwork-notify@kernel.org>
Date: Thu, 06 Mar 2025 18:10:32 +0000
References: <20250226181129.2958079-1-luiz.dentz@gmail.com>
In-Reply-To: <20250226181129.2958079-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 26 Feb 2025 13:11:26 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This introduces PreferredBearer property which can be used to indicate
> what bearer shall be connected first rather than just using last seen
> bearer which may not work always since it seems some devices sometimes
> advertises on LE bearer but expects connections over BR/EDR e.g:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/4] org.bluez.Device: Introduced PreferredBearer
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a22935f9baf5
  - [BlueZ,v3,2/4] device: Add implementation of PreferredBearer
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=03240630b39b
  - [BlueZ,v3,3/4] client: Add support get/set PreferredBearer
    (no matching commit)
  - [BlueZ,v3,4/4] storage: Add support for storing PreferredBearer
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4d3c721ee037

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


