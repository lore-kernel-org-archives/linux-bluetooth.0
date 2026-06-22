Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABA333A9C4
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Jun 2026 17:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782147633; cv=none; b=tM68GfLEfjLhj8TEfUcPi/C72dk8Mp2BVf1v7U7X2ehJycRxzhK94rIUGMP0oadrUvm1IAOxXt9YP3zWB+0Y9s3Xuc0SGut75YY+Fxfo3wIOxf2/hADNl13Dn/oyldTYJvN33Bhys440oEkQ53m1Ap3N9+ueBBupcy4CCD2XG7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782147633; c=relaxed/simple;
	bh=YdRjjHfOENnd+d6G9mjHO77s5xPgRzNbGpHtE/Uw/BQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G/9X0uimx+KKfg+Xf9zYUfY+2cm9+0AyHRmjAPaBPxw7fBr57zGfIa9xG8eDODlH8AibLjxw5e006mg9WX8ysCMWpxf77mozz2ADSwcPyjbxYqdBMMIziubDTV9YrAz8vsaO7MJdg6+Sh0RWfUaOhccw0XL/Bl+8G6tPpWTpZoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mY2eo39z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mY2eo39z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D84B1F000E9;
	Mon, 22 Jun 2026 17:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782147632;
	bh=etCCl++m4W+RNV9ScSXKHzXpaXbUT9TcgmQYdF7qp2Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mY2eo39zny7IaOOjmlbsWG3ULPC416d1cvpDC/W3OfNV+78Qm0R4ZtOKgJl0pYmVR
	 cVgNqAg5l9biCJ3/cZNdFuXBov0luU+IITqbWqy62IMWYjdvI5ZonaVsrK+NpcFPyy
	 178H71t8t7xgFU6cWSYGfEybkSf1dJQu7ihaXY9ayKG3tTqI2pw/fSjKevDFf9B81+
	 KeV7hkuSqcSrDa2QnlQsHK/vtnGdSZqDK96Z3VbVL+fmG+36+Tl90YZBAuLwGqTNxe
	 Fb/an+pYsXXwYGfzixxZNhMcxA+eOwOT6XHQPLoCHaegIsCF8d6/D1iQiWSov8QDXI
	 gpBEkK7sye1qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09E83930917;
	Mon, 22 Jun 2026 17:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: simplify force_no_mitm_write() with
 kstrtobool_from_user()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178214762225.1322955.16888557488603170773.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jun 2026 17:00:22 +0000
References: <20260617153019.981515-1-dmantipov@yandex.ru>
In-Reply-To: <20260617153019.981515-1-dmantipov@yandex.ru>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 17 Jun 2026 18:30:19 +0300 you wrote:
> Simplify 'force_no_mitm_write()' by using the convenient
> 'kstrtobool_from_user()'.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  net/bluetooth/hci_debugfs.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)

Here is the summary with links:
  - Bluetooth: simplify force_no_mitm_write() with kstrtobool_from_user()
    https://git.kernel.org/bluetooth/bluetooth-next/c/f529eaa118a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


