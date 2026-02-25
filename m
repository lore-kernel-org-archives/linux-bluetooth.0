Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED9F3E9F99
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 18:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772045401; cv=none; b=EFiVkbvM5NeU1DeYKS7SUQEBPyi9WZ6VCQwnzRPU35MwoFFsikqPyHDy57TgbgIcNDUu8lU1ASY5QmwFQVQdIrFoSBQnAMFJ3SEujppXSNXZEac+NZ8Sr0u7MZjdIK5Q7ymqaxWVEE0PYlijXrylh/0cgpZMRgXwJQi9XGnQJtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772045401; c=relaxed/simple;
	bh=uKpgixcrjyandnj3KDkzLY1EExMwW0mLH5+zP9LgqHY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aeXk0CQQ3hRgMu5SM0Iikg4bWLepBL4dLG2P0L5YldhPBx1TvND38l2X/DsCoJhY8VHoIaGfarfoBFte/ISQQMWnFoHl9U8bhl07eDfKwNKdSHHOORvWs20Sd9OuRREM1CChqYYBXy/M/bFYQ7q4cZhtoQZ8uNJ4L8zAeG/6z8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WodGf7ot; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WodGf7ot"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5749BC116D0;
	Wed, 25 Feb 2026 18:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772045401;
	bh=uKpgixcrjyandnj3KDkzLY1EExMwW0mLH5+zP9LgqHY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WodGf7ots+Fclxb2DyPYm+SbPdPznuQ7thtSaUochWSKQL2WGWNSNaEn7IznEDwAw
	 ucsNEw9V0WlU4LsLSzsHvOItZgU4jbfsALxiHq5tQvulwP84wxQIndXnyFzXkZ5wOX
	 NnxYAKLwadpSzNbwxP3lPamfmEoomE3dG/4NQTRoiJ6t7xtzHCi1gQ3T9VRzMj7BK+
	 s6LzHiGzSMDE7QvysT5nP4bxUIEmmM0vjut0eqXS1hAUvB2H+WKupQ00jILdkLNDmJ
	 ZZD9m5o4np28VrajUI9Jfk0olHIrdST3ojk86Y/gzsO9rITW3Xi17eakptbwxmj9m4
	 lQbNZnCyFG34g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEC13809A90;
	Wed, 25 Feb 2026 18:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 01/12] client/mgmt: fix compiler error
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177204540629.868689.1287591271474106141.git-patchwork-notify@kernel.org>
Date: Wed, 25 Feb 2026 18:50:06 +0000
References: <20260225161715.20394-1-ceggers@arri.de>
In-Reply-To: <20260225161715.20394-1-ceggers@arri.de>
To: Christian Eggers <ceggers@arri.de>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 25 Feb 2026 17:17:04 +0100 you wrote:
> client/mgmt.c: In function ‘str2bytearray’:
> client/mgmt.c:2385:23: error: comparison of integer expressions of
> different signedness: ‘unsigned int’ and ‘long int’
> [-Werror=sign-compare]
>  2385 |                 if (i >= *val_len) {
>       |                       ^~
> 
> [...]

Here is the summary with links:
  - [BlueZ,01/12] client/mgmt: fix compiler error
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=451fff520c8a
  - [BlueZ,02/12] tools: btgatt-client/-server: replace ATT_CID with 'shared' BT_ATT_CID
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9648dbaa8d01
  - [BlueZ,03/12] src: replace ATT_CID with 'shared' BT_ATT_CID
    (no matching commit)
  - [BlueZ,04/12] peripheral: replace ATT_CID with shared BT_ATT_CID
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5767a7dded4f
  - [BlueZ,05/12] attrib: replace ATT_CID with 'shared' BT_ATT_CID
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cd6a809f7b43
  - [BlueZ,06/12] src: replace ATT_PSM with 'shared' BT_ATT_PSM
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=776f9062c845
  - [BlueZ,07/12] tools: btgatt-server: remove unused member 'fd'
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d5c85b052eea
  - [BlueZ,08/12] l2test: add comment to -F <fcs> option
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c8a7462f3490
  - [BlueZ,09/12] l2test: add comment to -O <omtu> option
    (no matching commit)
  - [BlueZ,10/12] l2test: small improvements for deferred setup
    (no matching commit)
  - [BlueZ,11/12] agent: move defines and parsing for I/O capability to shared/mgnt
    (no matching commit)
  - [BlueZ,12/12] client/mgmt: align implementation cmd_io_cap with its documentation
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


