Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF29346791
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449811; cv=none; b=L5zsezBBCc/1NxHOkRk/kbZjzT8C2QlCqzHHtFSXXZ+T9SEFrTkbUVoDF3BrwSZUIXUxZwzTzcIZgcAAz+O2GwGt+8X2vKzNLrve8/82OJCBqxKOrfmEg/sE4nCZSs+YrDFzjuVoIRnYKPQVjzUgl7rbWDA5VOgao/qgPiGmTU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449811; c=relaxed/simple;
	bh=SYwOh2jxsy20l7bMnJaBfl+wuyPlsmjnUmLLeoDBQIU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xlc2LdvBioVPVgYiaIhEHgMDgHXVknwTAkspht72nhy+OCjZ+VXy2xqT9IVj1T5JY3Jn+JuULVQovJLNLzzy8CrZcinzHkUANazNJ9A5t+jnuKTY3ePBH7UihpAkqMQdeTsN8SXRf4RchcBAtcMkTmKbe2BzHrw5Txo+rzYe0tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MT1r7Xsj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MT1r7Xsj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267B5C116C6;
	Mon, 26 Jan 2026 17:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769449811;
	bh=SYwOh2jxsy20l7bMnJaBfl+wuyPlsmjnUmLLeoDBQIU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MT1r7XsjTkA9AhJ0AygDzKtOZh4JjgmhkSte4Ueo0Vk5ni7YtHMOEbsr/RwS5Qw7z
	 eQIvsHDq9x6QNUK/deCiWpFw4SHPci0uHX6jkj2X/CgcsdWpWlejY0ld++LRAXD1g4
	 G5C+r6o1MTiizutbhQageWVcOik/GClJ60c2wPxH3L57ovw4gJLrw/Rhao4DZFSNq4
	 wGSDFHjSNgIqNNDPnwxUK34bVE3ANSRYvTMfywu5ohOYBhxTjsQYMc1Lf/h/hlonLh
	 R7l5IbpCODXNJ8ZPJd/yiSbHpfulOM2IMJbTj6w4PTtDeSwM9ni/LukzC/jU7DYPNy
	 BLJKhPisrAaMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8B5D380A94A;
	Mon, 26 Jan 2026 17:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] shared/tmap: Fix TMAP/SR/SGGIT/CHA/BV-01-C on
 big
 endian
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176944980559.117979.2565536006432477470.git-patchwork-notify@kernel.org>
Date: Mon, 26 Jan 2026 17:50:05 +0000
References: <20260126165754.3567649-1-luiz.dentz@gmail.com>
In-Reply-To: <20260126165754.3567649-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 26 Jan 2026 11:57:54 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fix the following error cause by not converting the role value to
> little endian:
> 
> TMAP/SR/SGGIT/CHA/BV-01-C [Characteristic GGIT - TMAP Role] - run
> **
> ERROR:src/shared/tester.c:992:test_io_recv: assertion failed: (memcmp(buf, iov->iov_base, len) == 0)
> Bail out! ERROR:src/shared/tester.c:992:test_io_recv: assertion failed: (memcmp(buf, iov->iov_base, len) == 0)
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] shared/tmap: Fix TMAP/SR/SGGIT/CHA/BV-01-C on big endian
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=521088388bab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


