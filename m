Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314BE140363
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jul 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720450232; cv=none; b=FQAk7814JWQh4Mw7efJW7fnzD0iMLi7WQJtUHpu+HAnRDPAOVEnrpOCsA+dinGTC1cXhKQZCdQURFbzt9Az6QkpCYw0X8gO+BmaVmJN4y6gmXrUU3UkVmuvHM6aaiJF+RSJsskFN5jDABzXGiUVeOhJ4miSr679ETqOM2RgszYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720450232; c=relaxed/simple;
	bh=no/K6dn+3PRQmQh++fqtN2x1D1YExPXyNLKw6y4v25Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=htOaNS9Y3hBM8rnqbnZXM4fV0Km7PX2uGBM5cU6RQ0ags5qruu/oMTIAXKzjMGkv3NW0EN1VwnaEy/KI8GbrAgvdAFBzuUE0OKmr25mB7mQUHKjvsJGEEsI8MbY2FuMNhXFAIVHN5q+6k80ff3I4h8+bCRk39Zta/kUNCpKtyCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t6h12Rms; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t6h12Rms"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8842C32786;
	Mon,  8 Jul 2024 14:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720450231;
	bh=no/K6dn+3PRQmQh++fqtN2x1D1YExPXyNLKw6y4v25Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t6h12Rmsny0j4Wm7tvf6pocxtSN4MO7Ky8vSaa0g1D+sMPRqmL62mDQksUpCZ//O1
	 EE0MBWESH2NO2ssM8JvpNrwYyc4z795baNGk6PndvZ76QJGMSolDpwXNhIllmTQySR
	 N959Y/WW443esoyHx4NWWalpMxcLogivdTaV6dSSegM1Tei4FZ68D4OKCZCcphHSEN
	 M2i6QOD+cygxKlNV2zB2aBGha0aSq0mAMKbW/Gyh2H8gBKVdgcf22gEud66/as5T1u
	 HMkjrmz7E0X0IcTVB++UCFZDaFf9jvpFncA6FjyvlCNb9h/qJf1iR0SMVVcon9YIls
	 xK2ilIMfQRQJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6A0FDF3714;
	Mon,  8 Jul 2024 14:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/5] fix error found by SVACE static analyzer #2
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <172045023174.5742.4150345566884002104.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jul 2024 14:50:31 +0000
References: <20240705075709.26809-1-r.smirnov@omp.ru>
In-Reply-To: <20240705075709.26809-1-r.smirnov@omp.ru>
To: Roman Smirnov <r.smirnov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 5 Jul 2024 10:57:02 +0300 you wrote:
> Several bug fixes.
> 
> Roman Smirnov (5):
>   obexd: add NULL checks to file_stat_line()
>   shared/shell: prevent integer overflow in bt_shell_init()
>   tools/isotest: limit the maximum possible data_size
>   tools/rctest: limit the maximum possible data_size
>   settings: add NULL checks to gatt_db_load()
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/5] obexd: add NULL checks to file_stat_line()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0fda2dd545fc
  - [BlueZ,v2,2/5] shared/shell: prevent integer overflow in bt_shell_init()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=85d98aecd6a9
  - [BlueZ,v2,3/5] tools/isotest: limit the maximum possible data_size
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c389209ce455
  - [BlueZ,v2,4/5] tools/rctest: limit the maximum possible data_size
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8e495f00cded
  - [BlueZ,v2,5/5] settings: add NULL checks to gatt_db_load()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=804696dee795

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


