Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABCE189B8A
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Aug 2024 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724427633; cv=none; b=IIhjy7I4dlS+fVwz/RbO5jGgO81yd4CSKkctPORtXXIpVhJgdDiipB6HGyINxKRr1SHO4R09jPBlJarsHALtLqWYZInGghlhAuQtDeG8nu52gYW/Iaqb4saMREbIpTQuhvl1fwBnhLt7lVIHrf4JzPXM4ha3Kr5aiK9BLc48mW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724427633; c=relaxed/simple;
	bh=OpY5kcSHKTfShilPft8OD6FiAQ1EXicnL5uU8LGVlLw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f8BGG/nhLXay8RHIsM8C1zWNeiTXepQ7Yv9vExmih4oe6bSjxvK/haH0G+8w86ryOvDS8ZaQ2d+jwFReHXuKACiQ5trtHC3O3wjk+V83UtbuMa9R4NR80B5GK9GYvG1kvYGacAodVDiDteJtyjG12svQYiiwlhXvY/iZZHY08rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXWshDNo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXWshDNo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07DECC32786;
	Fri, 23 Aug 2024 15:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724427633;
	bh=OpY5kcSHKTfShilPft8OD6FiAQ1EXicnL5uU8LGVlLw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GXWshDNo8qSSK5iQjIXuEsWgve3ONB4/mNlhPRrCRZvvyhRZUx+qUM1bdxIST3HMX
	 7x4PtVvwHjxtocr+LYAJ6/IlV5B/SQzzv8eM3CNkz0OBv/IaeGhDYzma/dbPChUTIm
	 Tuitm3ZbKcFkc5dhaccZfJTsmE+XYd819xjpVzC4p25Rec2fdh6xvMv7NVjBbgPVKT
	 QfliwS7fJO1fchDZmpTtHjEqzRMvE6sCOGAgBRIu4hR7qrnuPLa4leUoOYGi/mpGLn
	 9J3FPuyK2Cfum5DnUMBS0o4n94dpVYrfNSYzdqeTiBA1UnukyfctepGH1tyfM6yda8
	 AlEm8vFZl1dNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1733804CB0;
	Fri, 23 Aug 2024 15:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: hci_core: Fix not handling hibernation actions
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172442763277.3003054.9950840370464327228.git-patchwork-notify@kernel.org>
Date: Fri, 23 Aug 2024 15:40:32 +0000
References: <20240821184335.386810-1-luiz.dentz@gmail.com>
In-Reply-To: <20240821184335.386810-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 21 Aug 2024 14:43:35 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes not handling hibernation actions on suspend notifier so they
> are treated in the same way as regular suspend actions.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: hci_core: Fix not handling hibernation actions
    https://git.kernel.org/bluetooth/bluetooth-next/c/4e7280557a45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


