Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBB539E18F
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 20:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788897675; cv=none; b=KMjXeVXusrK3GVOsiU6D9PpQc+ffFOtQsiHg3PBhFdi+uJHbBNoweXkyrOpq1gIl/pOAGwD0x0BwuXvhlobfbigl3xeakEyTxcKAZYdRBOC7huvqi6uszd4G2XCvRDqAsOUMVdsYpP+A3GMW8Q/V13UJfRZepsTIVXzVi/8DyGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788897675; c=relaxed/simple;
	bh=B6YUVZ35l/Suj8QP+RAl9FQgnYGvKBWrAW6q/g2Ic3Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E2AG+sGhR1gdMxsyejKA8tehaZYL0patfuGovyY/vF3xH2gGO8jAxCXEt/oIByJYn5TvTqwQfEZktObe3PYxSuVboROiF5DgSBeivWaXHQlhz04dvtN/oY18xKH215eEqjQjMK909mAEXGcL8wjcHpPTKKkT71YcV6330w0Wgew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ax8KJ4fW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ax8KJ4fW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9511F00A3A;
	Tue,  8 Sep 2026 20:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788897674;
	bh=YF0Nz79sptg3/70MmqH2Z+IXgRi4hoBv6YqWGUiPqmU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ax8KJ4fWd/KqmIMVavDzg0cFaJjNi4zPuvSz29Yj7MYZYkXYPyy3vYonwkaevte+v
	 8q2T+/EqY8gIDuyrOUUGUvGimvWHJ3ukL29Zy2jt7IaVWzyPM3+F1DBNaxxzaah3h9
	 W/iDRKSgbfxHnAi+NA/0jNopCNrM1o1heVyGe10OjPcToIxyAvH2bt7hTtbKs13X2v
	 MrGhnHTOwh8OxPPLhy8NO8yCI4y8s64pkVJNK99E4hUiBaCgR4EsNxd1cPaBiTyFyB
	 hMyV5VulhGOSxlSnKYjWZHL8QjKQyvzP8Z2RHJ+xNQFClo3vvLPjSlt10EAf3qN+rd
	 OUVIXwyuLMSIg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09BC380820D;
	Tue,  8 Sep 2026 20:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v7 0/9] Functional/integration testing
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178889761229.3720652.8197583151733196686.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 20:00:12 +0000
References: <cover.1788712996.git.pav@iki.fi>
In-Reply-To: <cover.1788712996.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun,  6 Sep 2026 19:49:42 +0300 you wrote:
> Add framework for writing tests simulating "real" environments where
> BlueZ and other parts of the stack run on different virtual machine
> hosts that communicate with each other.
> 
> *** v7 ***
> 
> * Bump to pytest-bluezenv==0.1.9 (better core dump / oops reporting)
> 
> [...]

Here is the summary with links:
  - [BlueZ,v7,1/9] doc: add functional/integration testing documentation
    (no matching commit)
  - [BlueZ,v7,2/9] test: add functional/integration testing framework
    (no matching commit)
  - [BlueZ,v7,3/9] build: add functional testing target
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=af075cdc0937
  - [BlueZ,v7,4/9] test: functional: impose Python code formatting
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9f223eb701e3
  - [BlueZ,v7,5/9] test: functional: add some Agent1 interface tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b626b5893f45
  - [BlueZ,v7,6/9] test: functional: add basic obex file transfer tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b73c31b53020
  - [BlueZ,v7,7/9] test: functional: add tests running the various kernel testers
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a321411065b1
  - [BlueZ,v7,8/9] test: functional: add test for adv_monitor crash
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2bbf2db84c2b
  - [BlueZ,v7,9/9] test: functional: add test for AVRCP crash
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=24fa99283d9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


