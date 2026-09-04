Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D604938887E
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 20:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553274; cv=none; b=gdlFBd1ErQROiTgtDfn0oGE5fG7ImBzR1ABnRVAsDn7CQpO+nemInk8NPRWUA09GSme4P3GKAFQNb1OU4DaPQLsFG1GSqh5m9eSOsYDWvmfkWX6nWgNL7+CPrbPl3oRLPTRAIlXyKpIxOj8Q6fceuaeHu3pOy0gKWNyVgGgpCVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553274; c=relaxed/simple;
	bh=y1z++vBkbgblawGu3JL8htaABhBoyLJHDMqiKGFFixE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sXV6ox63WAWmWwJzUcpjaI66b9n3TSiz018PXLOpMjAYcds4ScrSCfsX2KM5MFnozTU00JMWoyn6xz70+PqeKRcMt0oqZ8Az34+cEYYZnx+HuAJvMF3u2z7Q2YoVL86Sef0GOj6+D11X2xmkyw52vH+iNz+Sk/VhRTc1HaP5gjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tc35LOi0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tc35LOi0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA40F1F00A3F;
	Fri,  4 Sep 2026 20:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553270;
	bh=JvsThgKHwDzEI1q4vBcNuLwZdib587NIe/Cuc9wM8hE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Tc35LOi0INscTd6lpOvJElMCNZy4H2R0MekAWjDnzhw5YF/ISZvVaa51ekJIuD7iX
	 o4kmJsTbzGkwTpdZVtJl/5NqwI5UhR4ObY20w07vIDi+RorWACA4Oi8vcFj1bWIaZW
	 QC6M7HLaTEEuVfjXC1ETnIfhIOlnEKoT9vZWZwRcWBsYHN4+I8o+H9IHvoIolL/NZk
	 jJXY0RXy42qsdwUKxp9ku+Gsk/q0z7FNnRR/+cLFsPfZZxSMpOofNzKv4youTlLHSA
	 D65Z1XKkIvSzbT4OMJegL8er8uFoaMkaYMGDrJC83wtpUAanICvOBxeXyjxq78Ju5B
	 AVJwViRPwukLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939633924A6E;
	Fri,  4 Sep 2026 20:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] btattach: Update for glibc 2.42 compatability
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <178855321113.954520.8179000280190568931.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 20:20:11 +0000
References: <20260903182709.473976-1-aaron@embeddedts.com>
In-Reply-To: <20260903182709.473976-1-aaron@embeddedts.com>
To: Aaron Brice <aaron@embeddedts.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  3 Sep 2026 11:27:08 -0700 you wrote:
> btattach is not setting the baud rate correctly on systems with newer
> glibc such as Ubuntu 26.04. In glibc 2.42 the baud rate termios.h
> constants changed value, B115200 was 0x1002 which was the struct
> termios c_cflag enum bits, but in 2.42 they changed cfsetspeed() to
> accept arbitrary rates and not just the baud enum values, and B115200
> was changed to the value 115200. This means you can no longer set the
> speed with c_cflag |= B115200 and should use cfsetspeed() to be
> compatible with both versions.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] btattach: Update for glibc 2.42 compatability
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=12f5eb726c6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


