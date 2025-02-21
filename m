Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBAC202F79;
	Fri, 21 Feb 2025 21:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740173897; cv=none; b=SSVeKY4gcgRXIh8vweFzW9F2kxRQBZFHoI6jksFxWv/ToKxexjJUuHlYOiAqzizpbPTXrnDqzLgYJdowSrnKvHz5vlhGLrnVH/rlVDaHXOwGThJVldUUgpCWXAQkplHJXa3ZX7fM1fUBCafb67nHYM0JDEQIu+mLnRtHlPc3qSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740173897; c=relaxed/simple;
	bh=7sLBywq7fUyjhIpIJ/D6KwDzFVC+tpw0wqVA3JEaEXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOr9dHQ/n51Mhv7AqYwFSezyW0mjwpg2OaRUQAHlfHGDblxUkXhDYARIGpxU3E4F0igAuNv/BkiWiiUOULHWfsV7qN/yZzl7l+qEaEpEYKrMTJXiQJYzgEoas9FifHkoDW6KddoTZDtxszw3o38T6D3QzLQT87MPQi8TC50ljdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYAf719d; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYAf719d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460B6C4CED6;
	Fri, 21 Feb 2025 21:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740173895;
	bh=7sLBywq7fUyjhIpIJ/D6KwDzFVC+tpw0wqVA3JEaEXE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MYAf719d7xAKijWtx7qfD2bvyzU1cjGOQJlu+KaJEQBWPblOvNJ5v7F2i8HxkIwWI
	 WOpKBmDAD1/H1X/U6JQ0ZNOmwyN1wRMADUDf8fGW9QSm8tHbp5Q9GBwUJEikmLDuqS
	 /KCqxQeDJf8B4mMlrkmLIg2YNKOyCCU+CsmMi7bi7F1Z9N39WYFA98ew+Ke4DJjgRm
	 Sn4QqA1WGj+RBk+1fDKf7gi1dWVj9wEKqaXeUhoT6c1DZ8TyDOXlry+GdUTubrDzSr
	 z/m/bcP3Xeo7P1enVb/SrcP7EVLlDr267LrrcIJ3T+g1ea4Y76CUjf1jR7qyDOkfUX
	 1VrUVauT9E1yw==
Date: Fri, 21 Feb 2025 15:38:12 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Loic Poulain <loic.poulain@linaro.org>
Cc: amitkumar.karwar@nxp.com, krzk+dt@kernel.org,
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
	neeraj.sanjaykale@nxp.com, marcel@holtmann.org
Subject: Re: [PATCH v2 2/2] dt-bindings: net: bluetooth: nxp: Add wakeup pin
 properties
Message-ID: <174017389223.118561.13018790360138407008.robh@kernel.org>
References: <20250219091512.290231-1-loic.poulain@linaro.org>
 <20250219091512.290231-2-loic.poulain@linaro.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219091512.290231-2-loic.poulain@linaro.org>


On Wed, 19 Feb 2025 10:15:12 +0100, Loic Poulain wrote:
> NXP bluetooth controller may have GPIO pins used and routed for `WAKE_IN`
> and `WAKE_OUT`, such pin info must be known so that the driver is can
> configure the controller's firmware accordingly.
> 
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
>  v2: No change
> 
>  .../bindings/net/bluetooth/nxp,88w8987-bt.yaml       | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

