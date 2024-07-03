Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA3F17DA37
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019433; cv=none; b=E3J0GmkOJeIO+tWiTfpCAg04MewICLfBkdTj5wr9Azo20ewB6C93QrhUrnasSUz1xA/CtJDL5B5mifnKAhB9Vh5uOAUuhibCaXuv4bTOOWveIhYzZiqLuuXXenwQqybGoNtBlxQmRQcFTMTVpLNWbEqKY8Mx6U0k8xm1HUvEN+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019433; c=relaxed/simple;
	bh=NDxAkPNnH/9LfW5+t+dSdt7GCy6n8xHAhRj4y7fh7ak=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bL3UpzyXiiVoMBaWWXxD8gJ0IKYPo91I/DWUH55pryJFNHyQjSUWheyR2qQ736cEU/RsSL0s5iSIstFAo11YZPWmJdQe0PM2/UeJwDekciFw2GhHq0cct5Pc6KSe84HM3R6fG1s322eikIcAY0kdETga3Li8HCIV3uIEdziAUFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAe6MPU2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAe6MPU2"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3C65FC4AF0D;
	Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720019433;
	bh=NDxAkPNnH/9LfW5+t+dSdt7GCy6n8xHAhRj4y7fh7ak=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JAe6MPU2q6cni/zN5gsSM+nnlhCOJn3TlXCqEw1wjWslsOhFBJ+wX7Y9rOvyUpZmz
	 WNhEpiWlTJ0UBmOS53jx+GYzgnvxwYzfD3bsv/k3cB/DuzLsW6NcZqOoXwqry9ToFQ
	 oMnzVBUI+ivrjFZgtwXny7LLDbTRNPmQv3t22LuRUddN7+3iViz+NKCw6OkdJEPzxM
	 5rijZW9XA6P+IDkTAkQ32oyrpKy/laqqias6KoVoUF1/Oe70EQqqULbasb8D1j9nIZ
	 6Vaj8ODjNDlbC9SoJ0L5MWUfHSicByuakMV2wDQuC0+evnJG80RHYO+Mkv+ex1lmMt
	 9aNDnJubQcCmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B97BC43446;
	Wed,  3 Jul 2024 15:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] shared/bap: prevent dereferencing of NULL pointers
 in ascs_ase_read()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172001943317.18626.7069202765408600970.git-patchwork-notify@kernel.org>
Date: Wed, 03 Jul 2024 15:10:33 +0000
References: <20240703090305.14542-1-r.smirnov@omp.ru>
In-Reply-To: <20240703090305.14542-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 3 Jul 2024 12:03:05 +0300 you wrote:
> If the user_data argument is NULL, a NULL pointer will
> be dereferenced. It is necessary to prevent this case.
> 
> Found with the SVACE static analysis tool.
> ---
>  src/shared/bap.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [BlueZ,v1] shared/bap: prevent dereferencing of NULL pointers in ascs_ase_read()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8a22c17bc996

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


