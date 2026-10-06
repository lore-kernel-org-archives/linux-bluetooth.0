Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24741280309
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Oct 2026 16:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791305635; cv=none; b=rlkScXzUCXnCUriuXSNynf/lovyPQQOOW3wx7/eAKfS/R9zx3RA3RRf55ypeaLyPcyc0VAfM0QnijhZtU8GEiTBUxvReokXXYhARdocGgYwflt8go8sgxe7vSlIOk+q06/S7lb4mm+XKO1AsQQTRrPh6Jh52yMwbufWlQgi2JkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791305635; c=relaxed/simple;
	bh=RCEdzTLBvBCGfOYvnczfN31PcQLB2CLoajbWizNic64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q4oHQJioIjZXpdOm6JVeNY0WfUEJqemZsWWfEjIxta5XlwzaaL52uifOlM/3gEJBCdVuguOe+pihaaSATxzsbc4g78C6PpB2O4JtsQUi5zAQkEqQGXzzYvNp52wsMdjqc5N6Dpirz/RGrKY5TQW2kAA6xJ0IlLF2qv/EgDCYBJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+s8xSIK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+s8xSIK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5601F0089B;
	Tue,  6 Oct 2026 16:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791305633;
	bh=P0237ryviagEPhNF/F2l2ipbsVOI7vcOSde3tI8r/l4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=l+s8xSIKg9j5lrwY3rEu3KdaqyBd3vhUNKFq0kxGjbsoNlvwB8xhQNDzJUpTAqvIQ
	 vNaESIo9lvHnfxwbmwMiGYcEj2tGgvC1UitgZG/24IpYAkI/Uc63TOSNV8abr8XZq4
	 qHUInLn8vPaah17RZIJJ248WNq1O7bGeMpZyTtr/oG7/7KonrpnV9izHk65utI0VzO
	 YlsOQCUW3GqTpdaZdm68OG15vkeK8jwtkxmSCQsG3Yd3z+VnRn2pwvetIOsgWTuWMZ
	 h07HfXM68LHnETBSNUv2eAqJo2mC9FPzjqgJl0pL6Wyfk0qfEdjbSFgkjgHA6qZNNd
	 Af+qYcvgK1WFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B454E39D60A1;
	Tue,  6 Oct 2026 16:53:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] doc/mgmt: Document Advertising setting as
 Global
 Advertising
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179130563226.2711940.9825841812660336441.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 16:53:52 +0000
References: <20261005152111.3419786-1-luiz.dentz@gmail.com>
In-Reply-To: <20261005152111.3419786-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  5 Oct 2026 11:21:10 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The Advertising setting always uses instance 0, and with extended
> advertising it has a dedicated advertising set, so only instances
> sharing that set are overridden by it; the others are advertised
> concurrently and removing instances never disables it.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] doc/mgmt: Document Advertising setting as Global Advertising
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9b18ccef2c09
  - [BlueZ,v1,2/2] mgmt-tester: Add Global Advertising tests for extended advertising
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f8f352d133fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


