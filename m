Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B1D3A6407;
	Tue,  8 Sep 2026 20:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788901030; cv=none; b=XmDVfdETWyT/amKz+fdDZ+py4CBrINqP5qVBqIkeGBk0cSlqN1x3s8zCRca4QIdOopDL6m6Hh5Xr9OK9fxb6RtCtyaptJLcWktY1skEOdebTaSo1Mo4qWtNa1+8mOOV1os8vRKEOiIGauFKE1YU2HRawIG6RQa0tRyJg1AUwRPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788901030; c=relaxed/simple;
	bh=tgUzFVUfbuuoPe5hu9WjjVvaItyNFSr3ry58Nz6BJak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zdn2MA6JoWjyQT8WwkuRqXkdSj5GeF9zfZOK1tGaCtDPo/EH+THo13zkGRciYOMgGMnDr3oruWZklGVs4bqqm858cK76kYwHddqzZyP+1zTjsvgH90iTlZjMZf8ePAVRqbBCPTwzqYUJ6swfDX6iUWHIrjpOhaXGC2vLwDSE4YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWH5M8S0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWH5M8S0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6E71F00A3A;
	Tue,  8 Sep 2026 20:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788901029;
	bh=sAaPG5zRAKSsvN18OWek38Yk2K13JLkcId+D90NVXl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OWH5M8S00SpFu8YrQkRMxB02KAPTmX5gzvJ6a7LdDfwDGWwNpxNlAYoIr0gYV8/bz
	 YuEF6GFySIUXZd1/QreJEmhFYMs8sXCrxA0IgZZvULmspHox+kmogy2/f+S5zXGXCl
	 fCmcmVa/PspBK5dlSWHD+rMF7+A0Kd1+Ti3FdP/m+lNyWnEFAZJfm3RNPfCv8V4E5n
	 uINbeFrIokVe30ArLxkFIY8x/tdDU2MXdoU8vbUYVvgs2++NzmncKJRQ3Ugji+4POy
	 t5nRl91mX4JRByQiF1+mjYK6sMjA9Z6zM6KRPF34uakzk7MwLBhzvtaCblHdRj7wWX
	 h8Q8LSUrIEJDw==
Date: Tue, 8 Sep 2026 13:57:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2026-09-07
Message-ID: <20260908135708.552fcead@kernel.org>
In-Reply-To: <20260907172648.457103-1-luiz.dentz@gmail.com>
References: <20260907172648.457103-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Sep 2026 13:26:48 -0400 Luiz Augusto von Dentz wrote:
> bluetooth pull request for net:
> 
> Core:
> 
>  - hci_sysfs: Fix NULL pointer dereference in device_del()
>  - hci_sync: Fix not setting CE length properly
>  - btqcomsmd: destroy RPMsg endpoints before freeing hci_dev
> 
> Drivers:
> 
>  - btmtk: Declare MT7920 (MT7961 1a) Bluetooth firmware
>  - btusb: mediatek: Fix leaked runtime PM reference in reset
>  - btusb: Fix leaked runtime PM reference in btusb_reset
>  - btusb: Fix UAF of btusb_data by rx_work
>  - btusb: Properly disable remote wakeup for MT7922/MT7925 on Ryzen platform
>  - btintel_pcie: validate packet_len before skb_put_data
>  - btintel_pcie: fix tx_handle bounds off-by-one
>  - btrtl: Don't leak return code when parsing firmware format v2

You're missing a bunch of your own sign-off tags.
