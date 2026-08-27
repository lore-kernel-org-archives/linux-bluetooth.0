Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB32420E7C
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 17:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787850665; cv=none; b=Jvttgb7yUGjHolivCyjtd3iXNS4yZf512iuIK3yEzy6Jxhwod6J9R95MwPepxYd+MTTTBO7tmPMWEs0kGeJozVkiTk74lueW4qh8RlGvKQTp+tu+M986Ah94F7U2bgFbWfifY9f9AAF2m76AkoPSL1qUWkU1zgIO57Bbn7i+MgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787850665; c=relaxed/simple;
	bh=w55AX5iZdXJaPm78pAyROqm7fw39Q3dyBWeu24YB7Zo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XK8Pk6k0YGUa5YPoU8kLwt1nnfMVAytyipmfy7UhUd6hyNPwMh3NMqqDp4GnbJajDmbBFt7FdtdGXamRm63xdtX6M1XC61DNLF6FUhb8ziMVf00qwEdcFhDMdv3j/e2cK1yv5APD/gzPTxAGCImHsslediREUcHRVDGFiU+f06Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZEuVwn+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZEuVwn+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164B01F000E9;
	Thu, 27 Aug 2026 17:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787850664;
	bh=KzixvtGCnijvRjF/o5BpD4V/8ANsRXhAXzC3niwGR/4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CZEuVwn+BBmzTPw5I9PGq2albX1K0xSrqXgMEWEl+Ca55/uxF9YtsYcoB5tJoJCoh
	 gKOmYAlfy4PQufjSP4HgCLQg0pRQf4eo9bl8nMDbon+AKrJ3/MfU4EAGXyAbjaFzKD
	 FNfTHIsaba5I+9sFBR5uv/LVrkEyRafrJe8MqwwOvPpuq5YVAhIioi5R0F4dY7Ls1t
	 v96XvexULzi4bTR9L2suT+bTinXs+yuUwWb726mI2X3U53e54EXqUSf9Uqv6unzEOo
	 kUfc8fAe8UaMaWVaR+zl+GejsCSaR7RV0KhPKm8C8fS2AjMoJ0Tm+IMS7pLAGNsTVw
	 PBpjL5Dr2sWWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D08FB3809A89;
	Thu, 27 Aug 2026 17:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bass: Fix heap buffer overflow allocating subgroup_data
 array
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178785060938.1754949.8855555799316444746.git-patchwork-notify@kernel.org>
Date: Thu, 27 Aug 2026 17:10:09 +0000
References: <20260827145652.1566826-1-hadess@hadess.net>
In-Reply-To: <20260827145652.1566826-1-hadess@hadess.net>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 27 Aug 2026 16:56:37 +0200 you wrote:
> bass_build_bcast_src() in src/shared/bass.c parses the Broadcast Receive State
> characteristic value received from a remote BASS server.
> 
> It reads an attacker-controlled num_subgroups byte (range 0-255) but always
> allocates a single bt_bass_subgroup_data entry (24 bytes):
> subgroup_data = new0(struct bt_bass_subgroup_data, 1);   // line 337: always 1
> for (int i = 0; i < num_subgroups; i++) {                // line 343: up to 255
>     subgroup_data[i].bis_sync = bis_sync_state;          // line 355: OOB write
> 
> [...]

Here is the summary with links:
  - bass: Fix heap buffer overflow allocating subgroup_data array
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3c18444ced8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


