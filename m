Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96236174EE7
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Aug 2024 20:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722976142; cv=none; b=tVqsFhXVrD6ZPGyQ71XSyiS4E4CNFLon6Iqg7cS55Zuf3EaR18PUnKiD5ETkZNYLeH5AzsyuxkVnMM08WpXvt7jMo/Rka3o1iWGAm6kh/jW0kG6YrYos0JOb44192FcigfN9M1gnsIwr092Wspy2ULxVO7HyNpy3S8q3x468UQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722976142; c=relaxed/simple;
	bh=7iw5nNHcRN+n8S1Gpq1EAC64OcsSC+IVyGHEsZaVB94=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ArtufEvZ86A954qIkus2v5nm4d9FRqiE8U97wFlySqf3eA4iU2qGdk5F4e8iIvRtvL5seeQIDByPKSLmWYpbR5FS+0F3K+iLKYmIjqSGFk6/efBLK2ueM6BZsQem3bA1oNebDB+hKr+6x33H+OU0e290tyZFuGcyK2Nv5fDNPHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GbjRSsea; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbjRSsea"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35248C32786;
	Tue,  6 Aug 2024 20:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722976142;
	bh=7iw5nNHcRN+n8S1Gpq1EAC64OcsSC+IVyGHEsZaVB94=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GbjRSseaB1LXeaE21LIf6PEpqbrJ1fyRNyQGwWmkInnoLbTq9HMpzL3Jtqfk167P6
	 CwJ8exhn9Uc42i+g8lGsEx/fcUaTGyO6/1i19Ob2307pJJUMwirJW3mh58chOBun1y
	 SdiuCHPt/Fz87jJUNkvalCwaqBQyJ7sHgT4hwImifrFAnxlGA4na7Pc4JpRg6bLnrT
	 G2K+U15Rb8EC0HLoDNoxmt+eB2lgoU4SGmvTqIlYGFihRWD3X7SvxU2Rv1c2aufiPh
	 lj799FC2QeZXwyOX6sHPanT8X4Gu0Otug0hZamN13H+enbM5VzPUkOdHwTIlMA+7Z1
	 f3wkjplTrfHSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3438539EF640;
	Tue,  6 Aug 2024 20:29:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/3] Bluetooth: Add a helper function to extract iso header
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172297614078.1692635.10181296255875324484.git-patchwork-notify@kernel.org>
Date: Tue, 06 Aug 2024 20:29:00 +0000
References: <20240726104326.459668-1-kiran.k@intel.com>
In-Reply-To: <20240726104326.459668-1-kiran.k@intel.com>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 26 Jul 2024 16:13:24 +0530 you wrote:
> Add a helper function hci_iso_hdr() to extract iso header from skb.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  include/net/bluetooth/hci.h | 5 +++++
>  1 file changed, 5 insertions(+)

Here is the summary with links:
  - [v1,1/3] Bluetooth: Add a helper function to extract iso header
    https://git.kernel.org/bluetooth/bluetooth-next/c/54aca0cc489f
  - [v1,2/3] Bluetooth: Add tx/rx counters to track iso packets
    (no matching commit)
  - [v1,3/3] Bluetooth: btintel_pcie: Add support for ISO data
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


