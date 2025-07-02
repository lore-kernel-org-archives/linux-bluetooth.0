Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFCF253351
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Jul 2025 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751477383; cv=none; b=bZmnhnyIAQfq9ScWPMe3iVelB5lCb9w5V1UotwUxbYIyWIEm0ylFlkBCw7lL0M5ufMfbL9jqux/LYsAGNmRqJ19gdgE+GVSmsZjaEFV9xoibhHkOeqekntouTb/OPdL7nCWrzpHH31M/Fgfxma727nFl9nz0O4jgR7lsAdRA83Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751477383; c=relaxed/simple;
	bh=hD0kNLA+rvLN7bLvwoI1fN4fziz2EOuvBSmtsIKrYwM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d/VlTnRLCsLanPJYsMnK/QGBM7i9l8XWn+783WP0a4XVxHTl+pLwPylBYh/PKfqmqKmJoiPfxUw2a+V/uvsY04zoQVgCJ8tlnbLx1Pyj6+/9bCVOWrRbczCeIdvmHjabcs54lfSj1yqlBeWrl6UQTJFljXlhhU5OeWKU/9TuOZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lhIzk6zF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lhIzk6zF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEEAC4CEE7;
	Wed,  2 Jul 2025 17:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751477381;
	bh=hD0kNLA+rvLN7bLvwoI1fN4fziz2EOuvBSmtsIKrYwM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lhIzk6zFJtxn1jJDi0m5aAgbkmY6+TnPcS/VMY4rgT72ETXKUgAQq/QLx0SdQTVmp
	 YiqAj9fNRIBzFdjzEaHJPGtJj2Aa7uL1yg8/AHlgzo/9ZAaAntSebclnHd2RNAOoGT
	 K+OIKGNMNO3uPaSnDuCLBI0mixg0tQP/az/Y3QcnadP9RjWsCEGJWZhZN7vr9uoTMM
	 1zv1QdTfHsbiuDo2s/IolY6zlUXILt0Nyjml7Ui3mRdoCf9SkgONZyZ0AV8XY50TKq
	 a1/2Uk1zQkZW8dkse7ogIFUil9KUHWgJzf3hlFf+n0C57HbtbHBR/zI25+p5+rmh84
	 9fLJnOqSsgOCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD1F383B273;
	Wed,  2 Jul 2025 17:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] advertising: client_remove: use concrete type
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175147740650.803508.12915682030043617855.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 17:30:06 +0000
References: <20250701141739.19128-1-ceggers@arri.de>
In-Reply-To: <20250701141739.19128-1-ceggers@arri.de>
To: Christian Eggers <ceggers@arri.de>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 1 Jul 2025 16:17:38 +0200 you wrote:
> No need for using a void pointer here.
> ---
>  src/advertising.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [BlueZ,1/2] advertising: client_remove: use concrete type
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=90e2296ee459
  - [BlueZ,2/2] mesh: node: remove dead function declaration
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=50fb9042e1ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


