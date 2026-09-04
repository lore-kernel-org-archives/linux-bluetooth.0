Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A4152120F
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 20:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553277; cv=none; b=uUULf1YV8ATMiFYSyYMFP0YytJB1jRilCMiiknu639paWEf7is7grcEj/jteRIULvXkAMJZsohBc3VhVEEkIMBBMg7l9SlZcdArBcikAG6ccPvWBC6jYHhc9gcUaWjHyKbWq+zGo9UJGusiYSalp8yRg8nOAX2FJGDnHhorPEk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553277; c=relaxed/simple;
	bh=Vp3c0v4vy33jMhQuF4bn/ILJZNi/YiQt6rv3XUhFEuU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mgE5x7ly7uhhFL+hrHe2K5/6gsJhTRpdaFqiI4tuUe3qD8GJ9h11Q9UtmNs8E1e6PP6KNr81iAeVJC3DvN5xCs0ZlSCvkW66sqWYbFCIDMWajscnhbYcw3+ZSrsOZbaHB0EcBOBcEbNY61GMtllL1O3Ft4h2sUIAUeQNhWoHUYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGg1aHLm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGg1aHLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77301F00A3D;
	Fri,  4 Sep 2026 20:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553273;
	bh=/qAOoWJb3etgrLXyn8tmkKWGX1uaVabras1375f71+Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mGg1aHLmkESGrBFC38E6N19a7CAaYWI8oS+bM/5xha1al7kpp0SnRSV/c3KAgC1Uk
	 OQSWBQMVY18wvL25Iq2pXHWeb1uCbcdcc1A1UBxhvCPfu358FQZ+mM9Xki4/0o49sO
	 URLAHymSORsqyFynsSbROIFwDoltiMj/J35/OrLxNTVSb2J+IdY7uJLHVVU4yKlRUj
	 lwZKUgAUvyZXJiNNc+R+ylTZvQ53gGrJ5tKHz18gOMDEqbn66x/SpEXvp2MA3Zn8dG
	 6m1/9cfaQHelH/2xKJieN08+Gjo5cB8mznL0U8xX9N5dR5if4/bgPnaUr39iWlRHOk
	 CJLxNBdr202uQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938EF3924A6E;
	Fri,  4 Sep 2026 20:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] emulator: btdev: fix inquiry_timeout() inquiry
 destroy
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178855321415.954520.9219865402519236088.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 20:20:14 +0000
References: 
 <835710b340044363cabea364ab73d98ef409b6bf.1788466641.git.pav@iki.fi>
In-Reply-To: 
 <835710b340044363cabea364ab73d98ef409b6bf.1788466641.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  3 Sep 2026 23:21:17 +0300 you wrote:
> inquiry_timeout() removes inquiry_id callback, whose destroy removes
> inquiry_timeout_id callback. Doing this from the callback itself frees
> timeout-mainloop.c timeout data under it, leading to crash.
> 
> Fix by setting btdev->inquiry_timeout_id = 0 first to avoid the early
> free.
> 
> [...]

Here is the summary with links:
  - [BlueZ] emulator: btdev: fix inquiry_timeout() inquiry destroy
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e271e0adae50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


