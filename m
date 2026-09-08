Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 262B756E057
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885093; cv=none; b=qYEDpdJoaIS9e9rqvvEe76C6VUShqVfIECvGZVNSBAak75+1SMGA4wnQWpFIl6vSfjhxyNORx4a2o3UNaulCQza9RbUeIxnI13X8sPI4/7p6ewfneyCbELaa63F7V3784W5xdY3vCNl2nZXdeN3dXtNRyCsUfxniJ2rOpbSWJL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885093; c=relaxed/simple;
	bh=j/zvVx4+9ksW0xv6BZloOoS6voLGtHMCJse1VO216s8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bWbGDJtNedtry5I21+ZKi8l0a85k443jwQdm4Hz18yrhCxNdl7/4QtrcQBFBe0BvvWlpt+ZfvVyyMzNVAH5zmMFD1WFwv7W//oKFohoqXfAKxvi3P8+X1pLOxNrYIm4Eag0LX27o3GrVYzyeUonTlo0YyOm/3uaQ/6l8COB2yF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxl5OaaJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxl5OaaJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4576D1F00A3A;
	Tue,  8 Sep 2026 16:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788885091;
	bh=vQLW6v8zZh4R1+zsm7p5N3XyW8u1rNotN2vUmCt3Gv0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oxl5OaaJYDc3ug9PQW7W9c8TKjmoEPEKsNW9ileG8hqj6syul6ON9smwGEGQjkcrj
	 o428OI6m0GUapCKF3noHJK+yTS+NTd1yrSRryY3puslhsnz8smU+BqwCvZfPj6GeLr
	 f6gEivUiH+UvC11slIxYdybFqafUa6tbqylJ3OG32MSMWWYG2FEd04alYPDhpBdX+b
	 ZP18/Kig2iK3+H32UjwpGKzBkQ+4rh9fh5BlZtd5tKclLiFvt3z+eQ18i/KWmYciAl
	 5lJtJqCkKFJ2Da2hVaZaY2IOTPlWK+RSOGy/IIbt0vokxp7GsGDrQuNMZuNrk2BmLh
	 Ipft3bOv5w7Pw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1999F39EAF6D;
	Tue,  8 Sep 2026 16:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: cap device debug regions at 1
 MB
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178888502963.3627954.4649873667262966331.git-patchwork-notify@kernel.org>
Date: Tue, 08 Sep 2026 16:30:29 +0000
References: <20260908133421.163043-1-kiran.k@intel.com>
In-Reply-To: <20260908133421.163043-1-kiran.k@intel.com>
To: K@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Kiran <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, chandrashekar.devegowda@intel.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  8 Sep 2026 19:04:21 +0530 you wrote:
> Validate device-supplied debug-region boundaries during mailbox TLV
> parsing and convert start/end values to a validated region size. Cap
> debug-region sizes to 1 MB to prevent out-of-bounds reads if firmware
> reports oversized memory ranges. Skip invalid or oversized regions
> prior to coredump capture.
> 
> This issue was reported by Claude Mythos.
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btintel_pcie: cap device debug regions at 1 MB
    https://git.kernel.org/bluetooth/bluetooth-next/c/ea6d8993c910

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


