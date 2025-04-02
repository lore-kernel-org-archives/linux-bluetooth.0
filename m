Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57B91F3FC8;
	Wed,  2 Apr 2025 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743628198; cv=none; b=H4QfKDlGSHQbKLOORuuWersS5RfM3YM8jrFgfIya+mIM75MAof/oFrvNKXTr4kVP84imkVDefCfmx/Hhd9Q6pl5b8YLdooJt9nXT/Z8wgSw6NQdyhU2Ewdy7MS1diKpdVbiaknDJGE1IXiLk0AWVF6f33MrbRz1gjO2N5sejRmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743628198; c=relaxed/simple;
	bh=SpmlCTn51quMZjrQeg1xdGLaRKKmRZRyvQpMym4sJu0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h0GPkIahf7AMKFxC+e05MPSbJS/d2U6CmHrHPmq5xhiI9s91x5pxRwQPEL58Eavi58asn6O45TZx+WOZEOknNuCOD38itOFIA2u5ESSs9+yqmj7LxjuVmyCQO+v0P5s86kHanj/t4sNhvg3I2wiE6fcVGUHqnigSGbxJcf8Ksy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9+d7Xwy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9+d7Xwy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54972C4CEE5;
	Wed,  2 Apr 2025 21:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743628197;
	bh=SpmlCTn51quMZjrQeg1xdGLaRKKmRZRyvQpMym4sJu0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I9+d7XwyHCP3M6vM7cfUhmXRanJffBqTQJq0c3LJenmGOANE6Tc3wV9WyIhXo9B9C
	 eXpoGb+LuSJLFaGB9RDusorDxc14LioM6oxe9WYfuvzxfx4aVwyvEyte8HOkXVHTat
	 iK5PJUCg+7Xke2bbJCC/3QEe3wafgeo8uvz/v17IFwn7zljr4NpAmSGoXOaSNR+sIg
	 x4/VhzSIrJ6WvNrEiKpw1WpiI1X694rvJVirZ05yoSLMnwWPMI8aQUVjqdEgXnBjb/
	 r6yFhZQuLctM5M71+xW6falGraQzQGkVndhDp1P1PoSxT2jEB5HH4xkn4sCF7pOiDL
	 Oz+bNGeMAx8yQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EA8380665A;
	Wed,  2 Apr 2025 21:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btrtl: Prevent potential NULL dereference
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <174362823399.1678044.12965511758413449194.git-patchwork-notify@kernel.org>
Date: Wed, 02 Apr 2025 21:10:33 +0000
References: <0174d93d-f3a5-48ed-a755-ed7f6455c1bf@stanley.mountain>
In-Reply-To: <0174d93d-f3a5-48ed-a755-ed7f6455c1bf@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: martin.blumenstingl@googlemail.com, marcel@holtmann.org,
 luiz.dentz@gmail.com, jeremy@jcline.org, hdegoede@redhat.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 2 Apr 2025 14:01:41 +0300 you wrote:
> The btrtl_initialize() function checks that rtl_load_file() either
> had an error or it loaded a zero length file.  However, if it loaded
> a zero length file then the error code is not set correctly.  It
> results in an error pointer vs NULL bug, followed by a NULL pointer
> dereference.  This was detected by Smatch:
> 
> drivers/bluetooth/btrtl.c:592 btrtl_initialize() warn: passing zero to 'ERR_PTR'
> 
> [...]

Here is the summary with links:
  - Bluetooth: btrtl: Prevent potential NULL dereference
    https://git.kernel.org/bluetooth/bluetooth-next/c/113f1345ce0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


