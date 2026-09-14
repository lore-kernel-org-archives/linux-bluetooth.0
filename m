Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3772486418
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2026 15:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398073; cv=none; b=MK4h+TNqkJTzvZEV+i2FaQDGceX/UPV49t4vHGewC1qIsB5QpLHnZrQkauHk1mQWEVyRVh9YutblhNr6W4XqvDXNNFcsgs2mJJq5ObpHmPYU8kLUaZ5XqjumSDM35+pBVYHuM3q53/UoACfI+6NgkNnaIv/bpTCws34TockUq/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398073; c=relaxed/simple;
	bh=DdA1VEuzvRSqQRr73JdhRMoARbU1JAjCZzD7w5SX80I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IvAeix1Iir1ump45sgE5ZM7TmU+dYidgyMyVMN4PKZO0LNhi96dA5luog0O+w01h436VCDYU8/TrKm8sIIEnj9tG5WK7Rz8PCNUPaCdHH0Ahn0gJl2uGaIEAFidumPNqLbrWmydIF5teyN3w8c8YUEXQ2Ytgn3Hr443ASonHAcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWLt8dM5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWLt8dM5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D0A1F000FF;
	Mon, 14 Sep 2026 15:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789398070;
	bh=GvvNjfS74zAtGurEr96xSZ/LMjlYOS5BPW+PE0zwI9Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bWLt8dM5xFg4fuDa+ijpEdEg+s3bIPKvE6+6RcEyC56UAZowxspxhqfarxtrYvUO6
	 s+0so9/+3b7lRQeN9SSljvvErqzOklkOlQSQIwgL8LyxWZwsXZMh/MERgHJAAGdTgC
	 uF0nMrj9oP141wQPOdidjgPd6rqI9BI3ULMCXJq26vzTDIfaRP1AFuUOXqgqp9109p
	 JvrgodS0uGdHepYo5vDAa4kdVZ0a4R6u3GsP8KjcRnWDNow95zTtx1VhVz+VXoCBmX
	 6O0bTJk/aNk+wt02356davHADRlF6Fu88qJ4EJdMJ8oK5EGWcqASmGwPylDPtJQtrs
	 fLsa8tJX7P5Sg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 97BD23924A6F;
	Mon, 14 Sep 2026 15:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/4] test-runner: use virtio-fs by default,
 functional test speedup
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178939800541.619193.9614288052625360897.git-patchwork-notify@kernel.org>
Date: Mon, 14 Sep 2026 15:00:05 +0000
References: <cover.1789237077.git.pav@iki.fi>
In-Reply-To: <cover.1789237077.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 12 Sep 2026 21:18:19 +0300 you wrote:
> v2:
> - refactor start_qemu() argv building
> - split out rootfs setup to separate functions
> - fix bug in check_virtualization() that causes problems here
> 
> ***
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/4] tools/test-runner: replace alloca() based argv setup
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7856c910c27d
  - [BlueZ,v2,2/4] doc: enable virtio-fs in tester kernel configs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=67e1394c8054
  - [BlueZ,v2,3/4] tools/test-runner: use virtiofsd for filesystem passthrough
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6c1985716322
  - [BlueZ,v2,4/4] tools/test-runner: Fix CPUID register clobbers
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c8e2b951b07f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


