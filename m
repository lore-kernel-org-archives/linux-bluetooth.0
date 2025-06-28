Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7101799F;
	Sat, 28 Jun 2025 12:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751112221; cv=none; b=KtNei/OdqB89LHe0RF3uRW7Yq+JYXnpV107GoH66pPuXz7fydHDzsMVVwToiFkeHIttwOMJmMHZ0/IDW3Y/kr7+kenIjXkdG0cM1sON+n297Hk9TMAFmm852nFGb/irxheJ0PjbOT+5fWZpYksLkGrQk5t/+JEPzy7qHGJ2n7pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751112221; c=relaxed/simple;
	bh=adw4vx0RKecc9InMMlHCSaFcrV1lp2SGd+hRdGVjNEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMc40r03z11zfMqkeOniHqCakiJj6DwZV3lgXGc2zbjbyO61hOwFzvtxCxn1/XTQr6E84bckFCmMoimPOSy39dQih8bi3EykmOJTNNYt4vo6FuD4eHjqI7/XPSeoLexOd7oBJSoeuEXnO9qK9YhSnE5YirhhSuPMmzYPCA+wjRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pOY5riDH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pOY5riDH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1EFCC4CEEA;
	Sat, 28 Jun 2025 12:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751112220;
	bh=adw4vx0RKecc9InMMlHCSaFcrV1lp2SGd+hRdGVjNEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pOY5riDHCyJcLDukUB55YL5gK3oqVWjFCbmkYdYK7e54zPYE57O2LiQnCJEHUyIZ6
	 jYAJdWIGUutBqp5pd7yGYpxj/9Nr0qs4AKHQJhtlt1bSI7n6YciivHChzylsHbb4xT
	 y23B3KC2VvnIPUO3h91ylFVjg5G0i35vp7pYNw8303y2PULTBXv8ImwxbDKkotixCa
	 KmEA27B9ehtFzsNmsLt0IRL9Xib+dN4s4DO9jZ4UGHjAa9YvRDr60wZokJGx2EtSAR
	 tzqLfa+7OpEK3cEMdWqo/WIjO836yZrXXExZezeiG1FmxDWZ1EwP3U+xfaRmtT323Y
	 Jw4IolTZijbFQ==
Date: Sat, 28 Jun 2025 14:03:36 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>, 
	Jiande Lu <jiande.lu@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>, 
	Chris Lu <chris.lu@mediatek.com>, Hao Qin <Hao.qin@mediatek.com>, 
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-mediatek <linux-mediatek@lists.infradead.org>, 
	devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] Bluetooth: mediatek: add gpio pin to reset bt
Message-ID: <rthuekbpdfszo2mw4b4zgjlv2nd45zbzzpxdjjxf6gpkrc5g5l@m7kfo7s4ltqv>
References: <20250627055924.7716-1-ot_zhangchao.zhang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250627055924.7716-1-ot_zhangchao.zhang@mediatek.com>

On Fri, Jun 27, 2025 at 01:59:22PM +0800, Zhangchao Zhang wrote:
> The enhanced BT reset feature builds upon the previous software-based
> BT reset by adding support for hardware pin resets.
> To maintain compatibility with existing projects that
> still use the software BT reset, both methods are supported.
> 
> When performing a BT reset, the system first checks whether the
> Device Tree Source (DTS) is configured with the appropriate settings.
> If the specified compatible and BT reset GPIO are defined in the DTS,
> the system will pull the designated GPIO pin low for at least 200ms,
> then pull it high to trigger the BT reset. If these settings are not
> configured, the system will fall back to the original software
> BT reset methods.
> 
> Compared with the previously submitted version, the following
> information are some specific revision histories
> 
> V4-->V5 modifications:
> -Modify the comments mentioned in v1.

What? This is so vague, means nothing.

> -Modify dt_binding files and 
>    make dt binding a separate patch.

This means nothing. Everything is "modify". Your changelog is terribly
uninforming. This must be detailed.

Best regards,
Krzysztof

