Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C4837B007
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 21:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779917402; cv=none; b=orPTgeXx0cnrt/QHKwNSfjw5ykdACt0Ds6RYs27+l53CXZCr8Xx66XfTMVrr6XJK1E0muRdmUtuC4R3wjFWhdjUjPXQ0I0YSJt1KkjopFOEqdlMkmaum+9lwhw9jr7eXDFWnjaOPdhNnqY9EMVLQ+VVHjh4HqWMlc8a5CJX9HD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779917402; c=relaxed/simple;
	bh=fLhHqEf8I5VQzcDcGUfBGybgep7L9vyLqQ9OmEbSn7w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AjmEdq6elu3iYoBFnHR9FXwJLcwJxDpKLiXkNlaZOKytXSx/3kH0oyYFMVtrR9cOVbNJDvef8srfRtTg787G3zRoLAVN5tuIrv+5Jdk/8BYgUxO7NPZiF8UVOrO6mw7I5OuOCNKe+XODchv8COzw4uhlbCeJwtmZsermEZZWH/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYHetXP6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYHetXP6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B85881F000E9;
	Wed, 27 May 2026 21:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779917400;
	bh=U/W6AN6zOcvCSSqwF5g6fSYYTTrZI0u9NnnY+6CKYeg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VYHetXP6wHHgVuYF0QISiKPF9BiRx0J3cgduWsi7Up8KHc5ob2PUXOa9oFbM/lSl+
	 ygtp5hEQMb+aiKANc09vUx8Z/BCp9qnq1na+KrhzrHa6E1Y9McXPFIzs2jOcB/tM5c
	 NS/Bo31pGnNk12Bg/kkKxZLZ3ltmWguSQ90bPoLDG2yPaBsFN0c0CPVcVbPNvQmjOy
	 CH26+0FAFlzG/h9SYxwc/yGs42+O2mICx7ESP8nUCMyxrF0zWFIG+Us/IaifSZ6dZK
	 Td5am3/CcX5q67Kkhk+2qSUayf0r+NdHHnI/LKy6ysbHOtH6ClqyWcD3Nkom/UQzGQ
	 2Qm3fRehkFocQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A32380CFDE;
	Wed, 27 May 2026 21:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 1/2] emulator/btdev: Add LE Set Host Feature V2
 command emulation
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <177991740540.657552.8254773075809788119.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 21:30:05 +0000
References: <20260526170309.3529062-1-luiz.dentz@gmail.com>
In-Reply-To: <20260526170309.3529062-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 26 May 2026 13:03:08 -0400 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Add emulation for LE Set Host Feature V2 (0x2097) command which
> uses a 16-bit bit_number field (vs 8-bit in v1) to allow setting
> extended LE feature bits. The command bit is set at byte 47 bit 4
> as defined in bt.h.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,1/2] emulator/btdev: Add LE Set Host Feature V2 command emulation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0039e1bec0a5
  - [BlueZ,v1,2/2] monitor: Add decoding support for LE Set Host Feature V2
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=68edaa560e92

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


