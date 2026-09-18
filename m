Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6755542A165
	for <linux-bluetooth@vger.kernel.org>; Fri, 18 Sep 2026 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752078; cv=none; b=rKpWjmq/vh1ZrWsoK426jIezJjfMftKFHppsuzignnUdg1FKDwbFkRXuXaOesl8yrNF8a/MWDrSPWmPmN9NCvXHIvwKsqsprKsD1Qnl7aKUjAj9D+8shwsjinNdfimCvxh/h3eQBVjq36A9u86Un/n83eOpIfUa6qxVIYEOkIqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752078; c=relaxed/simple;
	bh=RyFb5wQsEjKSFkfmr8ATUn/zusLmgLS3RrPXr8BDc/M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TsJje6Eg2AL/KIqilwNWJdcPby1CrHahoWVSODyRkrbEbzzRoMz4SnDT76RR5WKaElUjFWTDGnes3qJpCrONMwnxkVBFh2/+wB+NKK1FjfD4N/nUsHoDEBjFHO19SSZ3TXQnhDHMX9JHFzVXTIOcQDgb0fr1JUj1v+r8q6YmSHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A8R3kPZ/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A8R3kPZ/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87DE1F000FF;
	Fri, 18 Sep 2026 17:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789752072;
	bh=oesIhXLfuEznIVtVJhmH+WkHf2lwxdszgc2OLm5ONEc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=A8R3kPZ/7bTn0MQKc38JT0bQ3DOAvdVlhBSYPy4iRI9u0IUshOCh6j6Y2oA8EiKN3
	 LGujcJdtvaDQQUX9uCAnBahQKq3reOXaCZpbWXEn4NVJyJJ5Gcf3LcrXAGmsJdH5wl
	 dkz7IGQNMXFwgxsOrdQUO58dmjL/D+7Ht3J8YiAf+M4K07wRXdF8Fmf39asUT0W8G0
	 4ZOoZqbbt6vtllvOuW80x6rF0T4dOiwv4RfOCzsgplemnlKHl8avnjjHcF3xWdIAQw
	 7o4nJdETtCNezNIlvsnzjKuqQyWF+dIhtol07K13aFZ5TLSfJ48sb2O2oQhH7VhoPw
	 mFn3FOvg5/OPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19810380DBD7;
	Fri, 18 Sep 2026 17:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] doc/qualification: Add ASCS PICS file
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178975200590.1061421.162653018879655714.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 17:20:05 +0000
References: <20260903072948.719744-1-frederic.danis@collabora.com>
In-Reply-To: <20260903072948.719744-1-frederic.danis@collabora.com>
To: =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  3 Sep 2026 09:29:47 +0200 you wrote:
> ---
>  doc/qualification/ascs-pics.rst | 203 ++++++++++++++++++++++++++++++++
>  1 file changed, 203 insertions(+)
>  create mode 100644 doc/qualification/ascs-pics.rst

Here is the summary with links:
  - [BlueZ,1/2] doc/qualification: Add ASCS PICS file
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=12fc9c791485
  - [BlueZ,2/2] doc/qualification: add ASCS PTS tests documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=92f13ea19b67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


