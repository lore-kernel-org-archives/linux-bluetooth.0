Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C053130491
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Apr 2024 15:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282029; cv=none; b=e9d+X/45g9gXb6KzTl4zVfNOKEMhnUcoLJCFQqc/MuwP/uIsah8yPKr/ry92eKH6GBUq49f2lo5MkVzoMjcNfFgAVcwSF5AtEWANY9LDg66xf8zomxFl38ai2uetu/KmLVVAFerzwewGusYSZgo6mXVFvLg5y4NgzOB9cAu9IKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282029; c=relaxed/simple;
	bh=2q5ai9V6hcdFkDRwdmMqrKpUuBsf4FbILAitbJ0WR90=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ora36KrCaA2FamXpMTYPEBVUSUo2M3Slo3kH8NbIMlWbcL45oFYupnx1RdCC5htgTJVKsOJQU0DwqWsvCAjNmn2fCDveaWk81h1pmmSI+vuYB4h1GWpXBFm7qLdzpjYxaPIIoxffNbgA/9W4KFRqs+OxvvuEhv7Ybx0Jv4IJKXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ieGCqeXj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ieGCqeXj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id ED383C4AF07;
	Tue, 16 Apr 2024 15:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713282029;
	bh=2q5ai9V6hcdFkDRwdmMqrKpUuBsf4FbILAitbJ0WR90=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ieGCqeXjYeH64UcrNoxQUy3q3MbpXqGv6xbRiqmjIsCWdte3fnWAu+l7E4zD/u1/H
	 VNA0XghHgdR2uOS/5QAqoRLwlzxnoKASCR8gXgx+DYYA8/Ywj0bfgBo7CXtWL+hEfe
	 H2q9TSb8PVHMBcE64JjpyRyitPTSDXiwRmTTgJX13W+UXUjeG1Yf/bYEAYpPMaQ5cp
	 NZwNTbfWoD4G3V12WEqMNJccqEKnXYMPaxG64XVjp+QOAc6qAerzJO83ZhK5TQYYoe
	 ZoCKhGjM3+n7odtSzeo5dJ+BE++RRoAp66ipHrDZJHWme3+BFA+y65WuSiERr61PrI
	 JczagCWVeOMIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E235CD4F15D;
	Tue, 16 Apr 2024 15:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] set: don't modify input sirk key in
 btd_set_add_device()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171328202892.2661.4948820778449077936.git-patchwork-notify@kernel.org>
Date: Tue, 16 Apr 2024 15:40:28 +0000
References: <b468e20424d271295c84c72059952acaf65968a5.1713002640.git.pav@iki.fi>
In-Reply-To: <b468e20424d271295c84c72059952acaf65968a5.1713002640.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 13 Apr 2024 13:04:26 +0300 you wrote:
> Currently, btd_set_add_device decrypts the sirk in-place, modifying the
> key passed to it.
> 
> This causes store_sirk() later on to save the wrong (decrypted) key
> value, resulting to invalid duplicate device set.
> 
> It also allows devices->sirk list to contain same set multiple times,
> which crashes later on as sirks-set are assumed to be 1-to-1 in
> btd_set_add/remove_device().
> 
> [...]

Here is the summary with links:
  - [BlueZ] set: don't modify input sirk key in btd_set_add_device()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b411b98bf4f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


