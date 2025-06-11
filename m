Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6974228851A
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Jun 2025 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653401; cv=none; b=m5GbxqiebJLhVMEVQtxlASeORUf8amget2kYZq1OarBbdg4xMycQ2jbaqjug80pvKlUYVxmZzvLMJo8VGpl5IxlLtiN9pZE5PyuQ7dDQY50JcU527t8axqIJRaIdrphrlXm9otwLLazrloAxcQniUH8rGi6hvSs3jcowpO6eRPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653401; c=relaxed/simple;
	bh=9NqVvsw313EbnpHz72HWpzXmIBGkMVGKU/kFKwbYPfU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aQzX3Mo4AKZJQzRGIyi+30vjJ8m4+PU1bp+EcpvEIGsMC5L3fqizWpIQRuUaMSAuo5m2uVhJI7uEwF4YXev0hoD4+cnqaCD1DiQDXsH5lsxzOp5Nw0ff7j4F8mBcEK9eoUwL6dBbNLd8xWL/e67fcZHNRwidxidgM5XZfO+J78Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pP6lX2id; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pP6lX2id"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E929C4CEE3;
	Wed, 11 Jun 2025 14:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749653401;
	bh=9NqVvsw313EbnpHz72HWpzXmIBGkMVGKU/kFKwbYPfU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pP6lX2idQL28CV3MsVdPhjOToIwDKsJCLCw2Ye0xPw0qCevmWX37KN/oIH7Sx2Udp
	 1DeycvLFHQ8l4wriItjwCOMvjAHviQ01Ng+If11H9k2gGkiNxozg/a5xw5qzUZeGzU
	 jjXEUmo6gm7qoxgN25jYkzFhJDigRd+oX0MMzSH/oWqV7DDC2AEyEZVMp1y0Ojk4cy
	 +7D/mEUFBKjkaZ4+pQp9FfprV+h3Oe9+sUvRHk2BCkhB9nx6CvnoHq/sgeufONhH9p
	 WG8knEKxR2DikeJOqh4iYOsCxpduhQ3z2VD/Jw4rdefeRTnixi42tv2VLs3jq0gxRm
	 LHwDEhowmRxog==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C7539EFFC5;
	Wed, 11 Jun 2025 14:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/3] pbap: use the public DBus connection
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174965343098.3352496.12893471046688485261.git-patchwork-notify@kernel.org>
Date: Wed, 11 Jun 2025 14:50:30 +0000
References: <20250611131125.450039-1-kernel.org@pileofstuff.org>
In-Reply-To: <20250611131125.450039-1-kernel.org@pileofstuff.org>
To: Andrew Sayers <kernel.org@pileofstuff.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, pav@iki.fi,
 frederic.danis@collabora.com

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Jun 2025 14:06:12 +0100 you wrote:
> DBus requests are received by the public DBus connection, because it
> registers the relevant bus name.  My previous patches told PBAP to
> listen on a private connection, but DBus doesn't let connections share
> bus names, so it needs to listen on the public connection instead.
> 
> This adds a little more complexity to the logind callbacks, to avoid
> unregistering profiles during shutdown.  It also removes an API I
> previously added, which is no longer used and would only encourage the
> next person to make the same mistake.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/3] obexd: Pass at_(un)register value to logind callbacks
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=883c1c11c644
  - [BlueZ,v2,2/3] pbap: use the public DBus connection
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=df0036d9e41f
  - [BlueZ,v2,3/3] Revert "obexd: Support creating private system/session bus connections"
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=aea0f46f173f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


