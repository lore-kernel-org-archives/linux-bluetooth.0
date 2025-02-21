Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CE11FFC73
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Feb 2025 16:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740156603; cv=none; b=d2FaQsOWbv43I+N5NTYsUI8LZH/uYib4rMOTRE54XSGXRZUwQUCIiQ4vGRwthjwQlsiZ+pterY8eVTzjYdHMSkHbnzJXrlaCZp4VprTSopseUbs4ODByjYigchEqcqZFDneOW3F7IcUpT+Tq7ZWTSv8GSs6nt0P4FZlQQPE5yvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740156603; c=relaxed/simple;
	bh=NO7Jkm7Mz+409bZm48WxnUOvRHFLQKZeuHNw0H+NCA0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dJxqJmMCXl2A9GuE26YQPQfOgSeXpGbraVZJS+wki4t7gbM9ta6p2m2J0vog+qlVl/UbHjOs6dX32YjDd0Z3yvvTx8CLoW8FnhH2ZUgWdPzCLV0dHzoiYp4Gkp7j/4MZRvyYDDmlWZ2bJVg4gUhBqp1D8dwZRqFZycL9YDzTRqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFdVnKix; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFdVnKix"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A05AC4CED6;
	Fri, 21 Feb 2025 16:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740156603;
	bh=NO7Jkm7Mz+409bZm48WxnUOvRHFLQKZeuHNw0H+NCA0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lFdVnKixdW3SfNrZ8xXY68HDQSy4Ub2MhMaZzQ4eSDXZRo+QeAvhgO+lE70yYqxni
	 B77zHj3fwGLNlZqZBUJQIPKbWEZEvLZc1cdB6XwGqonc9adT3PR3u3yy3LdB/W7K7y
	 iojm8i8yQ3M9BobGIHAQ7KmwNTzj/V3NOBvdtXNnUe3zNvTw7hgp+WFc2J4PTfEqZO
	 CKHPC21yFvIp8kXxbh35D1+PmNYyIAl2cHCMxCpeDGUEFdOuf31JERiIuw+y/Xqvtt
	 z2yherQ+dRcd0zMmxmyv28YZ8v5sxBJmUdVE37eWBxk8EH8PiG8OQmFXStnEpZmGyw
	 6htvYx2tn7HfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7169A380CEEE;
	Fri, 21 Feb 2025 16:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/3] bap: Update bt_bap user data handling
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174015663404.2112364.8241467118640071521.git-patchwork-notify@kernel.org>
Date: Fri, 21 Feb 2025 16:50:34 +0000
References: <20250220085811.5033-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20250220085811.5033-1-iulia.tanasescu@nxp.com>
To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc: linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
 mihai-octavian.urzica@nxp.com, andrei.istodorescu@nxp.com,
 luiz.dentz@gmail.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 20 Feb 2025 10:58:08 +0200 you wrote:
> For the BAP Broadcast Assistant/Scan Delegator implementation
> (BASS Client/Server), BAP sessions with Broadcasters are notified
> in the bap_attached/bap_detached callbacks registered by BASS.
> The associated btd_service must be available in the bt_bap
> user data, to match the session with the Broadcaster device.
> 
> This patch updates the way bt_bap user data is handled, to ensure
> the above.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] bap: Do not clear user_data before detaching bt_bap
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=790a0c5d75ec
  - [BlueZ,2/3] bap: Do not set adapter as bt_bap user_data
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cfb233b4c6b3
  - [BlueZ,3/3] bass: Add checks for bap user data
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fefeb495dd22

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


