Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B69341674
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 22:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767998614; cv=none; b=SKp0mDnNKVtC9G6uxt5HjKoMEs4LzyaFqnxjUETeikHlRTKrWPT1V3fOugo8IlWsTsx0hMNBULxIBsf8PY3hRzLxJ+y+G+kpS01J+Q+NDjrAQ4T1DFP79+5nZqnEuod4vtIK3nvQZNMvouZ5sHerBynb7GSgyF0UNYlacV3ngdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767998614; c=relaxed/simple;
	bh=9epU0/vcYTFcmjX737SxLOiVlT7YLJLTW/hMMCX5wwA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sG+tmUemZq6hmQ2w5h28QiLndbIin5GrrRcYq1nEY65stBVO1pujdWYs23VH1i8j1s3R/f2xI9DmN04NxvSNRJsSTFOBWX/XJWLSjVTUFZ5Q3U4cnUfDC+EouJks/6wOLCHKFYEj7dFJiy2neY8pjhJfyVIzRwI9LqoE6fehrFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ildMaWmz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ildMaWmz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1ED5C4CEF1;
	Fri,  9 Jan 2026 22:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767998613;
	bh=9epU0/vcYTFcmjX737SxLOiVlT7YLJLTW/hMMCX5wwA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ildMaWmzYUlcQWj0AHiDtwlVPUkbd0JzBLfPPET/9Lj7bA6bjVdH/cLL4+y4m0Oxp
	 +LKhJuCv3YJ57MkaGC3AtG7Qbc3ZnwzQ+eXYJO5YRspEoNs5tkAqT3Ui256mV00Nkr
	 tyoLdYDLNBQ3Desvlwn3ftiOfB95fMZozRtJe1w+gek5+SqdtdUvJpuRCv9lu3b+aj
	 +1s3FYA7y98iBh1jvnHT3n4q5+Z4tc+RoZ5zDaqmg0TKHNlR9l9emNQ+eEgvYiYHFr
	 6RcNZ5M1ICcQhVmWOuUWEd3thbWOPRN+aPkib1UIK1fqw+YSVl7PlklhaMMA2Ce7yv
	 UzWqx5Pv8m2aA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B59FA3AA9A96;
	Fri,  9 Jan 2026 22:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] gatt-client: prevent use-after-free when clients
 disconnect
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <176799840952.418288.9019955065774055286.git-patchwork-notify@kernel.org>
Date: Fri, 09 Jan 2026 22:40:09 +0000
References: <20260109202925.774809-4-dalegaard@gmail.com>
In-Reply-To: <20260109202925.774809-4-dalegaard@gmail.com>
To: Lasse Dalegaard <dalegaard@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  9 Jan 2026 21:29:27 +0100 you wrote:
> Clients with an acquired characteristic subscription would free the
> client during disconnect. When notify_io_destroy then tries to remove
> the client, it'll use-after-free.
> 
> Add another reference when allocating the notify_io and unref it again
> in notify_io_destroy.
> 
> [...]

Here is the summary with links:
  - [v2] gatt-client: prevent use-after-free when clients disconnect
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a94f994201a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


