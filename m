Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC32C388E77
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 20:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776802242; cv=none; b=l3sZy21W1KO0wQ8D1Z/Hg7yM//WofZJ16aJJmwe7kqI074M50EhjEiBuX0iM9F+Navsb3EK1GsTG3NRmL8URHWz4VaiO83APCJjn9+v2DEu8PmC8g7mtpmnePSDhspIC3NoTBSD9Loai1pvOB5hLjvvqNI2X4wXi3uoV3EPZ5NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776802242; c=relaxed/simple;
	bh=2UkOAn5Fg1iolrzU+OXdT1dmzVxzcjImTRpiN6Lgjc8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZgAlaoo+PLt34WnvJ3sqHoCSl5n0ch1kC0Jfgu9uYfJp2sF3qslvdfJJ1wNF1Uuqxpiwp4+Wufrj8rCGa+qbEp4cwViUMjYaB7btJhg3naAtUxECr8iWEpqqFjgLnLQ3/WDo4iCzP88RA/qe3KcO1N/gywqVgR/xFptdgo+Z7A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWpzTQJD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWpzTQJD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E85C2BCB0;
	Tue, 21 Apr 2026 20:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776802242;
	bh=2UkOAn5Fg1iolrzU+OXdT1dmzVxzcjImTRpiN6Lgjc8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lWpzTQJDYpmE0AT+u8DwaVgKmDxcyvSv3g1Dp6gIH+V9h8xLgPsPHgVBQVR1OcHPt
	 UqRNfW/IBpCDrukChX9ibzQ4ekPnCw/H89Mi2ygVGrvq9rP2Bi2WKAw6zCuqAQ4y3J
	 cAXtv72Z3jUuqSdd8DAfymXkVpKFBU7W6gTDrpiwkXYRWtVlymCv6Ot3PYgQo0UW8p
	 EIiuoi0ZZgM09BKSess5bbpdl1UCd0QGmNt/WDFnFQ1dHFs+wRLS0jN0BRnQJ1op/7
	 +Eb6KuqHq74EKqRDocxk5Juxp/UDE3A1Xznw+sCdUdNTnsA01Ckej1nMry6fL4VIUH
	 8oS2/JTybUbPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DF23930207;
	Tue, 21 Apr 2026 20:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1] doc: Add AI coding assistants guidelines
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177680220555.2983905.6941799530284104698.git-patchwork-notify@kernel.org>
Date: Tue, 21 Apr 2026 20:10:05 +0000
References: <20260421155141.1863559-1-luiz.dentz@gmail.com>
In-Reply-To: <20260421155141.1863559-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 21 Apr 2026 11:51:41 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Add doc/coding-assistants.rst with guidance for AI tools contributing to
> BlueZ, covering licensing compatibility, human responsibility, and the
> Assisted-by attribution format. Reference the new document from the README.
> 
> Based on similar documentation from the Linux kernel:
>   78d979db6cef ("docs: add AI Coding Assistants documentation")
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1] doc: Add AI coding assistants guidelines
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9dffe61bd8b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


