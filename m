Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794328808;
	b=h3Z4rw/t/bK+yVo71xFaB3ou2JoFpBcW7NJ5MdFnIy91ugAmlraSgIYi6BlsL4bsGCii
	 xFUWWNjD6knqXaLdSdmgGCIGYJVwA+P2PM2RIjhKqAI3tbRvMC+rij0f6U3Vo+9ZMYe9S
	 cNRKiVGBkkVSJo1o0BKVNs2VFt4wdqoIAGD4poSI0EXW9kX+CTaPx6Yg+PCVUBe57vSX/
	 vXZUMJYpw6xUfpVzJDT4bNmHzBiIplxdsbbJY48OUfN5xbFNiKaqbbL4/BamxGovRkJYx
	 QqDl4f/EQvigR4IwqlarrQzvFH21vd3ao3GhV5BqCd5Eln0gq52QEw6Nu/a9WM5EPPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794328808;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=o3E1E/t7POpuYCi7F2p180z/aOaIIrV/d5HeYexX+Hg=;
	b=DCjS+8AR7RIAlgYzdsFCwoJcUrKwNWySRcSEP5CwqKa7Qa/wCH1l8zuvLF5D7P95wZnj
	 vnoatq+Vn8gGZhPl1LzxF0l4AfoRbWRlcgFTgWKO3W2zvSCAMj7l7nA03ldFRiAQ13EGm
	 NUAtKakgIQYdUqUkTaPnMo9D6qm4D3sk1U7kZnAZGXTt4Umz4e0ChWV0XrcmRB2L/NiX9
	 7eLwF8kBjaxRnUXbPrWdtVTtI6C1DJKlZy545ox/w3zOfdZP4y5brOnIuKAx607mM3kNV
	 rjBAmzXFmxvGAcZVeeR20CQSk4htcV4ZqwzW4MY0lX/Eb+OIZAMSxbUV4HrWP8dnTBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OIVuQix0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4523A606A201
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OIVuQix0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55CE1F0089F;
	Tue, 10 Nov 2026 16:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794328807;
	bh=o3E1E/t7POpuYCi7F2p180z/aOaIIrV/d5HeYexX+Hg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OIVuQix0QblSnOiR3f2wu970njxECydIAtz+9Ttoql+LpB85vsIy+BlqZqDhrpjOF
	 NkKoSKL8JkqHeN8lftBvEZvO71gUepn+MPRrslqAkfuqbY/BB3WdF7pjLaPn3nHh/w
	 Fifh4PltEHQHZiBewD6yEv0QLoBc6stM276WaBRRVVFLh2ybTmocVi2tBcBQkjFt4N
	 TrPjEVMwYXEMt0DU82jhCiPFNcYpOmEpz2stPZo5vijdTvFaQC0fRXYQ5Dw/BYDDCR
	 Up4Zh8iCk4iVUwPXYIJJVpjP/tVqbX0DD431LEzQrYBwVbMaKFrievms0ZhslVjyqT
	 2TtPazzjsjsTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D834C39D5FE5;
	Tue, 10 Nov 2026 16:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v1 00/10] shared/gatt: Use util_iov helpers for PDU
 handling
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <179432880668.4080412.13530133738825558605.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 16:40:06 +0000
References: <20261109154501.1362649-1-luiz.dentz@gmail.com>
In-Reply-To: <20261109154501.1362649-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  9 Nov 2026 10:44:51 -0500 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This converts src/shared/{att,gatt-server,gatt-client,gatt-helpers} to
> build and parse PDUs with the util_iov_pull_* and util_iov_push_*
> helpers rather than pointer arithmetic on the PDU, so that the bounds
> check is part of the access.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v1,01/10] shared/att: Use util_iov helpers to build and parse PDUs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8d0c7e9ef0e5
  - [BlueZ,v1,02/10] shared/gatt-server: Use util_iov helpers to build and parse PDUs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=121ee5d9cbd0
  - [BlueZ,v1,03/10] shared/gatt-helpers: Use util_iov helpers to build and parse PDUs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=414080ffdb8b
  - [BlueZ,v1,04/10] shared/gatt-client: Use util_iov helpers to build and parse PDUs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b25e8e5d5a51
  - [BlueZ,v1,05/10] unit/test-gatt: Add malformed PDU tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bd9f53de7215
  - [BlueZ,v1,06/10] shared/gatt-server: Fix authorize callback getting handle 0 on write
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e927cda1b408
  - [BlueZ,v1,07/10] shared/gatt-server: Fix double response on prepare write failure
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6766a8172cc1
  - [BlueZ,v1,08/10] shared/gatt-server: Fix return value of handler registration
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0de968d4f2de
  - [BlueZ,v1,09/10] shared/att: Fix reference leak on signature verification failure
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ebd56ce3f4ee
  - [BlueZ,v1,10/10] shared/att: Fix signature length subtracted once per handler
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8f8bbbff3d10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


