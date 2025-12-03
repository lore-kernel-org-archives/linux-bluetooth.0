Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53ACD482EB
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Dec 2025 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764797590; cv=none; b=dkG3nHpjgtHR4IRLbzcP2fcrAR4KqKFAXZGRCwui21N+WAhkTTvoWgl+Alys2is6aeNhJ3lFUC0WGs4/A3tFDND0oepmAgd5H0k5qyOHDU7/+maZ9c8hpvJ/TR+8UC4IvF5lANNBugngv9VFQVGzDQYe3vPM/lQrgPZSJmEPSwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764797590; c=relaxed/simple;
	bh=YX8oTmZTL84eNoobthP6HBvKEj6keG0JuIXxzjyw1dI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rO69DuCSfbLfQoV33q/QXqOCWKumRbhpAxbkvRT4D0xrANkrznIrppxQeEN2xAE0fh7/LMP95YPetxcWG19fcQ4ohat4JoYuqqW6hjJsXuS4Ewt/RfJEHpl6xAz8MFzk4VjN7SY8xSmBZEKilUC+RTnIBrogZwWqYFAumSOaaSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edYonBhM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edYonBhM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FBAC4CEF5;
	Wed,  3 Dec 2025 21:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764797587;
	bh=YX8oTmZTL84eNoobthP6HBvKEj6keG0JuIXxzjyw1dI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=edYonBhMrQ9mLdBydlinFT4SZC4KFOugASFb3HOktyNHaEZXTO2Gq98/9PAzJKfV2
	 4oOd7pCu6uX9XZbmAVVQiaPQCWjqBDvp4cqi4/D0y1t9Aq6vKAoFx0qit2JyBY/qIz
	 fhLfBIZABBD0j7TXzjPLcJceBIRcaEUVjYLEIE41JN3PBXFsaqHCkPfjVSFnAYHXYS
	 RT548obYQvMiVd865q+Txlb9lSnS91qEJj71/kMR/MIBj2Idp1pbk4dpNLxPu9pnoa
	 vSHwGHu60ofauEiyjj17rtpwozdmIvZT6tFtM0hb0mBj4yi01tcfJ41PaSK1U1vuxN
	 qtMcVkV4UB9hQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B59183AA9A81;
	Wed,  3 Dec 2025 21:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 0/7] Add TMAP & GMAP information services
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176479740655.84322.12625187572932573679.git-patchwork-notify@kernel.org>
Date: Wed, 03 Dec 2025 21:30:06 +0000
References: <cover.1764708372.git.pav@iki.fi>
In-Reply-To: <cover.1764708372.git.pav@iki.fi>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  2 Dec 2025 22:47:45 +0200 you wrote:
> Add support for TMAP and GMAP services. They contain only device
> audio capability bitmasks.
> 
> v3:
> - rename after_uuids -> after_services + make it a struct
> - add tests for btd_profile_sort_list()
> - leave it as the GSList version for now, tests use queue
> - add commits to mark VCP connected only after its attach has finished
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/7] profile: add after_services for ordering profile startup
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5806271a69d6
  - [BlueZ,v3,2/7] test-profile: add tests for profile sorting
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=37f1d5de78d4
  - [BlueZ,v3,3/7] device: use after_services in service autoconnect and sort also GATT
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cdcd845f87ee
  - [BlueZ,v3,4/7] service: implement btd_profile::after_services callback
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7f8ac0c1fbcd
  - [BlueZ,v3,5/7] bap: have unicast client wait for VCS & TMAS & GMAP
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b78808cfb3b8
  - [BlueZ,v3,6/7] shared/vcp: add ready callback to bt_vcp_attach()
    (no matching commit)
  - [BlueZ,v3,7/7] vcp: wait until client ready before marking profile connected
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


