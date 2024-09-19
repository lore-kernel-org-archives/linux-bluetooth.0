Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2CA1A2542
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2024 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726765832; cv=none; b=C/zdXkg4OebIBuF39KMmAx7L48+8vYjfOy/qEaK+/nWKBFrOhp63KcVIcaEfkofEmRXr44GCWP2dmLQRsV3rI3TSGdkNw5fNi2OH9uiM8wbPrjm/VEYR+VXmdbH5XipvXvZ+rpuhvOE2xJwgqxir6ggiWyZqMpYYwHB6y9YSjtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726765832; c=relaxed/simple;
	bh=uSG6PQmoa1MKL8ji3ptE9FPmQF6OyT5qrOqG4a7PCqI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eflOIuMufsQvscGSMI+P+k0oT+Cfn14RjpoztP0g7tKAS5yvAhzVtBaRJhaFuV0m6hVZo0JF835/dXGaArfurJfy56G49eOxT8gsPBdhTqLiTJEX4Fjk/vJUXc3tRSZPi7f2BSVr363INoMSMoQboKR3v05/N2m6cGvczbFvSSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahTNKfF2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahTNKfF2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1FBC4CEC4;
	Thu, 19 Sep 2024 17:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726765832;
	bh=uSG6PQmoa1MKL8ji3ptE9FPmQF6OyT5qrOqG4a7PCqI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ahTNKfF2ifXIquMbUjNKUXXHLj/O3VlvOcf58zptB26NXDryWg9Z3lEXUcofswuZD
	 Cm6Mc1VDaqLi3FU6H8YnGHpCo7KdSbo/3m7svaHxC/iNivkiEPEjkf+PlyEgIs2UJm
	 7h9Qs7GVw396rLSiF1tnWwOvWxy1OyNKUp4AVpmrLUbCB20W46uuCMpQVqPEKi6nG5
	 d3Uv6uvgJd8PvoPEBLKxqp/2A/ePUowFh65lMXt38QQTRwovS/fcKVh4wel/bFi9Ts
	 jnZgc5HXxqZB5O8syIGE79jN03iwujAf8mduYsZutq0Wb4875CjMq1TmeshNfFNyjm
	 xSSLyEE92dn6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341093809A80;
	Thu, 19 Sep 2024 17:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] mesh: Move local basename into utility file
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172676583376.1626973.14678657878725648322.git-patchwork-notify@kernel.org>
Date: Thu, 19 Sep 2024 17:10:33 +0000
References: <20240917031745.1641153-1-raj.khem@gmail.com>
In-Reply-To: <20240917031745.1641153-1-raj.khem@gmail.com>
To: Khem Raj <raj.khem@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 16 Sep 2024 20:17:45 -0700 you wrote:
> Defining an override via a missing.h can prove difficult when a file
> needs to use basename and dirname both the APIs and needs to include
> libgen.h for them, in such situations there will be signature clash
> for basename function.
> ---
> v2: Remove reference to missing.h in Makefile.mesh
> 
> [...]

Here is the summary with links:
  - [v2] mesh: Move local basename into utility file
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7104f37735cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


