Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B823E51E0;
	Thu,  2 Apr 2026 14:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139422; cv=none; b=NHklNQFgNrnX9ftZvDlzy9IE4fHKYI3JTC8ylpUe5LTkKfyOPsoxnX6rZgPkNbNb5xEOo73rbeX+sr5sBa8ONi5TRmtTfqYRQ6iCepLPfFIo4PdPgQcjiUNLDEKYNNCjA3YcCqz5xVzRaAMrSNyLDf11UTO3id6gwaQH5AgdtUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139422; c=relaxed/simple;
	bh=xe35+uNdW3BijJVQotEOFkYIOCKqvRideA3jxEZxBQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LMt+/7UkKryK66NCmDdQqYAapIQ4+MXxWaftf5d4ytYTnxilneS7SIEbCT0qeTzAUIPWRgRlakxEa877nZjICz4nD95p6F9RGkICd4m7ofPj0qrNEbZoUnSjugEtKNkE3ifadaB2XpqGE9voi2DGPiccVaECWw/ZbFp3WT1B87I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qwOwyaMZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qwOwyaMZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAACCC19423;
	Thu,  2 Apr 2026 14:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775139421;
	bh=xe35+uNdW3BijJVQotEOFkYIOCKqvRideA3jxEZxBQM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qwOwyaMZ47oTytPkGkhaaFA3+gizYBsfEIbyIlzu38qUvCEUx5BbxeiBTdtwWyRdj
	 vjQNyoKa60DbzxXkCNbJjamMfeoyUzWvr1h2RSNE44G3xzaEPEOyIITavUQizlMnc4
	 Bzk+07Xj7/TsgFnhtJhHRdkKzj0+CbaV95GMtujbskq6Vriq3OQhJ/LHhacPrFH/rm
	 NpNy5pnb8HhgXeck36vOw+Ve8ZucO1j1jEWuQsySV3T/7S67c+qyaw7aNAgtBlzeQy
	 WTbQaNsGIC0JYwM0qpEXeiIjoMN08Sxygf0T0QpLsaZFPOBC+OCcoENEnu1Ndy6D5E
	 6X6HtiW+7+rWA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w8Iqx-0000000AF7n-263X;
	Thu, 02 Apr 2026 16:16:59 +0200
Date: Thu, 2 Apr 2026 16:16:59 +0200
From: Johan Hovold <johan@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Bluetooth: btusb: fix wakeup irq devres lifetime
Message-ID: <ac56W_SOCZHnRG67@hovoldconsulting.com>
References: <20260402092704.2346710-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402092704.2346710-1-johan@kernel.org>

On Thu, Apr 02, 2026 at 11:27:01AM +0200, Johan Hovold wrote:
> This series fixes a wakeup source leak and a (currently benign) OOB
> wakeup interrupt devres lifetime issue.
> 
> Included is also a related cleanup.
> 
> Note that these are intended for 7.1 (e.g. as the fixes are not
> critical) and apply on top of linux-next which has commit 2db5a8b68e31
> ("Bluetooth: btusb: refactor endpoint lookup").

> Changes in v2:
>  - fix wakeup source leak (new patch)
>  - fix disconnect-while-suspended issue by making interrupt non-managed
>  - amend devres lifetime fix commit message with a reference to changed
>    devres behaviour
>  - clean up error handling (new patch)

> Johan Hovold (3):
>   Bluetooth: btusb: fix wakeup source leak on probe failure
>   Bluetooth: btusb: fix wakeup irq devres lifetime
>   Bluetooth: btusb: clean up probe error handling

Sashiko reported two pre-existing bugs related to these paths and I can
can take a look at fixing those as part of this series:

	https://sashiko.dev/#/message/20260402092704.2346710-2-johan%40kernel.org

So please hold off with applying this one for a bit.

Johan
