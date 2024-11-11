Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370D54C66
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 16:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731341422; cv=none; b=uuE0wpWeLqfjF744q/xLtS3otHbqvE6zbGAFJ6+taCpiw0CNasHy98a1J3iA4AwhfVN9G4p4e87mU6ZtnMqDdsJgiBgOYXwhQJ614dTtk3Z5x/x2h+fSVW9Iq0EofZiNbFwg6bvbE7gU3sbL64Kv6AlQll17FV1nCqUi9UkhzfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731341422; c=relaxed/simple;
	bh=DkhDgK3eZxZxeyvOjueA6uRCO4IPoYTJgK/m5cAJkng=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ASrgkAMPOuzsZtPn5Wy3slimn6tPffK48JKFNXqrBlEj2Sxrs6EjfWOqhmHOzZUiaM1VNt4GJVprayg94oIlO9l7N2zrNVCxfnCwLOgwFXqownyBu7m1zUVtPOE1DAt6zohdipZNz5+3K9Jz6YzDWLCVrbGQ8bkmbNMloeOLaIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7cPhetZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7cPhetZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C63C4CECF;
	Mon, 11 Nov 2024 16:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731341421;
	bh=DkhDgK3eZxZxeyvOjueA6uRCO4IPoYTJgK/m5cAJkng=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V7cPhetZWj21fkJcMuGS7QfPFMuZjuvipN+FjSy1dU/mKqftJmbHcGOTIpStvO1WK
	 sK7Ubp1hXuVe4U059fl8dvNw1678Wj8ah5QwWmVLbH/LyZlQelavDXE1bpIinN5SSc
	 B5w7gRGUKggZ1y9YOAXUJ6w5E6lWTVCxupx472+LTKBymrkhG33m9cTiOiWjfGdgdf
	 5QTF5mLXFG9Um85kKb9OcxGyvXEk2bvEzol3QGfAeRZkRqMqAnzLZtj5grEWzrUwdW
	 O2TkVLHc7TX1THYMIUZy86mM2CYg7JpQJbEyG3uk58O2HgX3gX0YW+NIszhhH1QCSt
	 fhQfkOctLmXEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB7393809A80;
	Mon, 11 Nov 2024 16:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/2] Bluetooth: SCO: Use kref to track lifetime of sco_conn
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <173134143176.4081786.18186640433728678880.git-patchwork-notify@kernel.org>
Date: Mon, 11 Nov 2024 16:10:31 +0000
References: <20241107183455.129897-1-luiz.dentz@gmail.com>
In-Reply-To: <20241107183455.129897-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  7 Nov 2024 13:34:54 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This make use of kref to keep track of reference of sco_conn which
> allows better tracking of its lifetime with usage of things like
> kref_get_unless_zero in a similar way as used in l2cap_chan.
> 
> In addition to it remove call to sco_sock_set_timer on __sco_sock_close
> since at that point it is useless to set a timer as the sk will be freed
> there is nothing to be done in sco_sock_timeout.
> 
> [...]

Here is the summary with links:
  - [v1,1/2] Bluetooth: SCO: Use kref to track lifetime of sco_conn
    https://git.kernel.org/bluetooth/bluetooth-next/c/c5438f5c915a
  - [v1,2/2] Bluetooth: ISO: Use kref to track lifetime of iso_conn
    https://git.kernel.org/bluetooth/bluetooth-next/c/607ef969e6eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


