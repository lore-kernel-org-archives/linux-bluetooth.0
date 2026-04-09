Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1948E1547C0;
	Thu,  9 Apr 2026 20:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764829; cv=none; b=hYkeh5WoTjSIThKJkmge72rl2tt5l398emuaCWg2iGbbsGoZ4To7Alvw6Y03V7ZcUUcpEoAQgo3QEIUbBg9z5b+9RAseTdRYg3z5ICQU4MP3efJdfyYf2toJuAavcbL91oYc/Uypa13oXmkuCLJSKJdoXlRkAZDZAu3vcalhwSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764829; c=relaxed/simple;
	bh=Lwy9ulmYG3Z6dikittA2zdtBi2HDVKnfYK1o2VU3h6M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RAHxSPgA2lDgF3DAq2aA0jw9nqICsLY8255MX4s7sx9jgDTgbr+bc0+uAeTxhXILha4Z7mJa67gWqfDDzZ5K0W9kX4p8em0ySaCMuynmrOzrzz1b5ETfhKnpiy/ui1UImCxX1lR8WomgOV/dIuqdWAHYU8Y5xBqylFtaDXDURA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5TK7TEg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5TK7TEg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5A8C4CEF7;
	Thu,  9 Apr 2026 20:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775764828;
	bh=Lwy9ulmYG3Z6dikittA2zdtBi2HDVKnfYK1o2VU3h6M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g5TK7TEgh2m98LuMI1lNMMMBaXviomE3xBnl0ukotdm82QTNXYgvdAKyuHoN8dmOM
	 RSgD75zpnvJ0Sn0Ui8ZI+Ia1NZsKaR/4Lcb8++YCtvVBk40Yez66qQXo0Jc3TQiZ7A
	 ajGUzQl6wUBF10pq+rO2QlGahGL1sjZ8ecnwaIsswic8jfz3qd/vDloTECb1moevin
	 /XGXwqFPyOO4B8I8aF78Jj0FELhrVMEwl1whUKl+ZQeGuA9YnHJiWqGzPjcl1+yGN4
	 I8isrl++jdq2Zn2E9fPdOpLaRrhaP/k9MqW0QdFVqKNQlHgJRl+kFhVcbLYBPLGYoJ
	 lqGSEwMdNfu9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF4839308B7;
	Thu,  9 Apr 2026 20:00:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btintel_pcie: use strscpy to copy plain
 strings
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177576480405.1716836.12754584988610094300.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 20:00:04 +0000
References: <20260401164622.752376-3-thorsten.blum@linux.dev>
In-Reply-To: <20260401164622.752376-3-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  1 Apr 2026 18:46:24 +0200 you wrote:
> Use strscpy() instead of snprintf() to copy plain strings with no format
> specifiers.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/bluetooth/btintel_pcie.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Here is the summary with links:
  - Bluetooth: btintel_pcie: use strscpy to copy plain strings
    https://git.kernel.org/bluetooth/bluetooth-next/c/c7098dc5ff6c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


