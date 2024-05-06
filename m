Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B301C13D287
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 May 2024 14:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005231; cv=none; b=X6L8kqDc5RVRgH1bILPE+dl5wvbe+9NC/tANSZg9ClZ/tcYo+ug2pm4mqZm9UgRiBy+buhHtzgGBHIJoK0GJYFs7NG9bJIz4Kw+H8jPr+pB2lTSg9ngfztSb7YWk+Mk9+GA5Ruz2hA1C/65ibntduy4LlSDfmi3KKqGgx10rFWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005231; c=relaxed/simple;
	bh=V4xhdQI5sAARadNJlL+eYVImcjhZL5+wLS4SYRtr1t0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tsR/PjWmxTmHXOe7PDa9PoaMx2e1XZFkHIgwJNJQeExQzSHczgbVIXUFllyaRT6/ZoPcL58U+NrCGzsXAHToJav7XdpVZHQw/OiOXelgrnsuIrrpOt5PIm/CgIqtVPfrGZ6i/QO4lfuZUxfaOmJOztGdZTcNRb0ifAtWov4PmUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOOTg80x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOOTg80x"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4C14BC4AF65;
	Mon,  6 May 2024 14:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715005230;
	bh=V4xhdQI5sAARadNJlL+eYVImcjhZL5+wLS4SYRtr1t0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IOOTg80xEPxXQ7j0E3SfAIa1txiTpCMOb5xIP3lBlexfr8OBcQ9viQTXH6a7gqJRE
	 CWgIVWAGv+BSFvu66j4GBqobuFSJRI7nzfqlwO9OmyDxa75FwummY51FnMpRf6cvwX
	 x9cF1FAlsOmnn0ESgJhw+OLYt2hg9OLA8lOEQNt/LNhMdgEKbECQNoeyg9dxCHfT9j
	 2Ih/LHWmhYfWroanWLkR+7LcX/ZNEyJQsTKbLlguOA4b7IPoGdEcJTFYSBGG8qEYsX
	 jYn4KCB37Fy1kBSKK9htD5Ob0/kMxgnwghYZ0N7eiwDfng4TlK349H3NJPzcmoSDp+
	 pu46LX0mSa2RA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3DB90C54BAA;
	Mon,  6 May 2024 14:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] gatt-database: Fix error registering characteristic
 with Handle 0x0000
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171500523024.10901.14204794447186694132.git-patchwork-notify@kernel.org>
Date: Mon, 06 May 2024 14:20:30 +0000
References: <20240503145238.3771921-1-luiz.dentz@gmail.com>
In-Reply-To: <20240503145238.3771921-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  3 May 2024 10:52:38 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Registering a characteristic with handle 0x0000 means that the
> application wants a handles to be auto allocated but requires to be
> informed of what values they end up in the database.
> 
> Fixes: https://github.com/bluez/bluez/issues/821
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] gatt-database: Fix error registering characteristic with Handle 0x0000
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f34cc1da5081

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


