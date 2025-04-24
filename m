Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFB228C5A4
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Apr 2025 17:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745515191; cv=none; b=qYC29EGdWOi16JJyD18mV3eWCw/vE2ZLWqeHG58rNDptUDbv1Q1NNSaaqeTqkq++mcyTwAbw8DLfAgewHWTJSGXEiSEmXM/6rzSROwcNbbi8Ea+1VyRrslzR2T6FjSDX2Fos9YWjjpUnFZoQNi/UlmVfSb6zDKsnRK0a5KbFXGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745515191; c=relaxed/simple;
	bh=eH5iJnGm+cK50XUZEO5r+V9eLleOErS9lQDXzVb4p1I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qmM96CqTkGkF498ijoOfRs00GmrYC8sAkSqr3zpzzss65WAtD5SGAP58xRTkmeLdeCkVmdYqvkOphWIONBwO4oqgcJS9U6NkaZ2UlECayCWZLIenWGVOBdka0T15zziTJvX7zAaFbjw/LdwxfC0k8nEyPP9bAqHgvAytbzxaB1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiD7zzj7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiD7zzj7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD842C4CEE8;
	Thu, 24 Apr 2025 17:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745515190;
	bh=eH5iJnGm+cK50XUZEO5r+V9eLleOErS9lQDXzVb4p1I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GiD7zzj7Dsdh/R4QqGmLDRH0JYDdELY+aUqySvzNRUWOl2/aBQW5pxuTG0ZzrMpam
	 639S8mDOcVR87/oFPKopmOfqtgGqe1/iMeL4erzm1ZxtA7QabXm4sNpIqPzv34FSLz
	 VscEiC6nLSJWrz7uiEbY6TDhObd6AZ6Z+NmoQpRVxt8Gl7bDfAhMhNLZFspBAV/atd
	 54zz3UazVU2v5h/D0epHJBXMP+4MDrm3jrdXRI09ALiBx2wP61a5cgpJPL0M7c1OQp
	 5fMm2FKS75qn2KSjgteu18Uje+J/ZHnACah+/vBGf7R78brLz30fA6f/uNBjuhl24z
	 LT1XWcsgXMQ6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE003380CFD9;
	Thu, 24 Apr 2025 17:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v5 0/6] Support Sixaxis gamepad with classic bonded only
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174551522950.3427772.7545327135550796292.git-patchwork-notify@kernel.org>
Date: Thu, 24 Apr 2025 17:20:29 +0000
References: <20250424162933.182103-1-ludovico.denittis@collabora.com>
In-Reply-To: <20250424162933.182103-1-ludovico.denittis@collabora.com>
To: Ludovico de Nittis <ludovico.denittis@collabora.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 24 Apr 2025 18:29:27 +0200 you wrote:
> This series adds a new "CablePairing" property to allow us to
> indentify devices that have been paired using a custom USB cable
> cable method and that don't support the canonical bonding with
> encryption. With that information, we can dynamically enforce
> encryption to drastically reduce the attack surface, compared to just
> disabling the "ClassicBondedOnly" property.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v5,1/6] src: Add new CablePairing property
    (no matching commit)
  - [BlueZ,v5,2/6] client: Print CablePairing property
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=373146be299f
  - [BlueZ,v5,3/6] sixaxis: Set CablePairing when pairing a Sixaxis with USB
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=56516d6cc8d9
  - [BlueZ,v5,4/6] adapter: Add btd_adapter_has_cable_pairing_devices()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c5dffe0ce2fe
  - [BlueZ,v5,5/6] input: Automatically use sec level low when using a cable paired device
    (no matching commit)
  - [BlueZ,v5,6/6] sixaxis: Set security level when adding a sixaxis device
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=08e327733161

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


