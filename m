Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FD122D792
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Aug 2026 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786479654; cv=none; b=TuajMxYEf8zTUe1bhtjs2g9pY3trMdr3UnQn5eLwFmPDe5w8sFFwKILe3dBVRXhfjjwQBSxfPJ3SZG//gZUaDly8y+Dk0eWwfmyYrZhHyxNy9goqdUsl+1mvbHdB9ia4nSlXaw2b5JL4mOPg5p7MUUTn2AeTysjpDyKHOBADkNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786479654; c=relaxed/simple;
	bh=GmfkQle1bN5vh6Eh9/57Fqm44cbCScj1QLgzMBy42nA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P1GCXUZHnSelFDKe9dJq93WaiEHlNQRKayBqhwP2bX9bU1AUMX6qz3hItWqhOUD0gtxvgumf+DBOTw6VwHpBgUcrkL9r3eE74aWQhRlEdkgdZyrtTTVXOVfk4pRSBju9kHEnDyH3MzXL8fAssiEZmqXclYNSaLadrTQ2AidoKzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opb85oSt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opb85oSt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C8C1F00A3D;
	Tue, 11 Aug 2026 20:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786479653;
	bh=Md8ibOfVfo08JQ8PaQWpVvoCD4NhrdehKGvyyEKxAGE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=opb85oStcwjS6TtxH9oYhf28YETH5t7x/zgO/RFPcFSeFFekhvYlbCk/H/vEE1r3B
	 fQwFmlyzjQ6oXCtWsFl2FEu17tLkWZDRAamLOlnel+R5OvN/MnEFj9XiZ6+j5HH6Gt
	 Kji7OzeuAZbFcCAmPSukfRPgV24TUtsAp+B5WY8FeBVhXAgEjyZuvwCD4ZJ9P/7IvW
	 6E+hhBeSMgtRjEyADeY7X1+2qSXsBviAHbh06L1cI3yu8VVFyB7v0BHWREcUDoNe1J
	 GIsNBu1KA81QAaiOSfu32f180+rsO6aPpZ+FO6ayoOf4izZSPDonkTDGA1xpdz/NSS
	 JM2SRJD9X8E+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939FE3809A0A;
	Tue, 11 Aug 2026 20:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] client: Avoid scan prompt when discovery is
 already
 active
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178647960920.1138292.11461123973777581306.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 20:20:09 +0000
References: <20260808200806.134373-1-z4pdyy@gmail.com>
In-Reply-To: <20260808200806.134373-1-z4pdyy@gmail.com>
To: z4pdy <z4pdyy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  8 Aug 2026 22:05:17 +0200 you wrote:
> From: z4pdy <305461556+z4pdy@users.noreply.github.com>
> 
> Check the adapter's Discovering property before prompting the user
> to start scanning. This avoids prompting to scan when discovery is
> already in progress, which previously resulted
> in an org.bluez.Error.InProgress error.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] client: Avoid scan prompt when discovery is already active
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ea77a7229c76

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


