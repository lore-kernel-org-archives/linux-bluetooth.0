Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72981F37CB
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jan 2025 15:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262618; cv=none; b=uoS1tPNEhi9WAAIYl6PV/BQDx3QOP4zunldKq0WnK1GDPClDKEm++twaVBlAsavUCRSCCjAL/867Idt4B/0Qft64OPf1gWMtIupk09JmMuTcOBnv3Zm7Xm+eK3GiLslCwxHVJl7W9NVjLRZy5/g3QxoQbgvhp7dnA0pMYsRiEc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262618; c=relaxed/simple;
	bh=u0lqT+OuAiJNTFLGR6BA+Pud03LaE7Ak0ygBRhbyN30=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VSkkRzca2LJEr+HMjiaHkcABaYrTczDu/njeuz+z+n7aoI7nPgmCHIZlMxbQvnHZUOIppxB23ouj/fAyP/0Ii64OaQBq2fBj8/4dyLFtR+qJGVmWyALeSr9d/Q6UHqrxRK0L/BSF397CeUmceOi3RoPNXQ9bsBZaSJNlpDOJKhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1kaveKh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A1kaveKh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6849AC4CED6;
	Tue,  7 Jan 2025 15:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736262618;
	bh=u0lqT+OuAiJNTFLGR6BA+Pud03LaE7Ak0ygBRhbyN30=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A1kaveKhW7F4LBRKCjvldoDlMf9Mx2Ney6SKvezj4WtIfGhdjfTi9LYqg+rxiEJ0v
	 OEpG200CUrLv/0bM1tLZxJers91f6Y+LpMySadcwHlsSnrohbfkMwNPhWutt9T7cj+
	 zwl75aEGYEnnMqm7A21tRxMsq0qjySLW+8/SOViJkQFUuUR3tvoczx+NLTD6Eb/FgX
	 c3dIN2ZAn/8ZnELjy+2Ftr8SS38uHjX6PS4qX6Xj0VnHJNNXMe2r3gQEZUVH9ue5jZ
	 E9/BdPPPQooDnC56/5xzzdQwWFVc+rcipWswWNZPxwrlsXbDFbTo3DX/5/Y0YIcBku
	 M0Lit7/6QFDHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB57D380A97E;
	Tue,  7 Jan 2025 15:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] plugin: Order plugin init by priority
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173626263948.4189790.7178400814253985411.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jan 2025 15:10:39 +0000
References: <20250103125833.58396-1-BlaiseD@GMail.com>
In-Reply-To: <20250103125833.58396-1-BlaiseD@GMail.com>
To: Blaise Duszynski <blaised@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, BlaiseD@GMail.com

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  3 Jan 2025 06:55:32 -0600 you wrote:
> The init order matters for some plugins, e.g. wiimote
> Add them to a sorted list before calling add_plugin
> ---
> Cast has been removed and add_plugin is adjusted for g_slist_foreach
> 
>  src/plugin.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)

Here is the summary with links:
  - [BlueZ,v2] plugin: Order plugin init by priority
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=79900d49ac68

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


