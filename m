Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743E714830D;
	Sat,  5 Oct 2024 18:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728153179; cv=none; b=cOxhqYeNJSFuFXBZRhWDFUiinWHWIL3RdFyPV/gK8PzC2vdyA4nDCmlnKAd+FN6FvvPGXtwnJ/6eFwxtmKYtUbe059i4zZIcbtbEIVRmIMtHCDk0MXY0UBWzxnmPROgeR9JJRr7/A0PC1cUC0B+EUPfRRIlu3J/UX5N6Uwfe+J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728153179; c=relaxed/simple;
	bh=wBVEqLRClwP+JuVd3fIDjmM3hNLkhr0pR4QELq5zwnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKcB5jwSXyygMCuUtIoUDg0q0xQKNhb7n7vK/CIhjouLoXw1a2NQdLXimEMrmmnefU3EqFaFvhal/S6bkAao7O1Y158XKqUVkDLNGB6OBukkVUzgVT59na0A48x7jRv5OLi1lk3T67FTGE1TZUXUnlgsYOBJaM9dWLJSUEjMpPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ce8SFvxp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ce8SFvxp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F781C4CEC2;
	Sat,  5 Oct 2024 18:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728153179;
	bh=wBVEqLRClwP+JuVd3fIDjmM3hNLkhr0pR4QELq5zwnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ce8SFvxpJJ9CiwYpE+C46vnIwiEe7ZGHYi4JuygjhX3MRgcox0ocCgwD4rzRhE9Tl
	 5ydJSwqahmPbDkVmLBw85+YtceYdc2+10xZZzVYId627SeXMf/aGjhAKfZRd7iCkwn
	 HVgKbMKE2HhcFRv/X0czjcT3XlkGFgasDJt0Arz9QeSOGJ2V6yh+k4kRVbFfyBRedP
	 41tDDdRc1gKgqHEk/cdR/wYGp1KrUNIePgtZT+YnqCjSpACqspaxmmkY5vG4gtnQde
	 T8hEIRy9v+Oll88Y8QdR6G5nuIK7fdiS6ufk0qm5o2DYDGZBf5+kmDEgdAIGJPgNmt
	 lO4wZway6jRoQ==
Date: Sat, 5 Oct 2024 13:32:58 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: sherry.sun@nxp.com, linux-kernel@vger.kernel.org, marcel@holtmann.org,
	haibo.chen@nxp.com, linux-bluetooth@vger.kernel.org,
	LnxRevLi@nxp.com, devicetree@vger.kernel.org, ziniu.wang_1@nxp.com,
	rohit.fule@nxp.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	amitkumar.karwar@nxp.com, luiz.dentz@gmail.com
Subject: Re: [PATCH v3 1/2] dt-bindings: net: bluetooth: nxp: Add support for
 power save feature using GPIO
Message-ID: <172815317734.505678.8487892144174399506.robh@kernel.org>
References: <20241004121941.572539-1-neeraj.sanjaykale@nxp.com>
 <20241004121941.572539-2-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004121941.572539-2-neeraj.sanjaykale@nxp.com>


On Fri, 04 Oct 2024 17:49:40 +0530, Neeraj Sanjay Kale wrote:
> This adds a new optional device tree property device-wakeup-gpios, which specifies
> the GPIO connected to BT_WAKE_IN pin of the NXP chipset.
> 
> If this property is defined, the driver will use this GPIO for driving chip
> into sleep/wakeup state, else use the UART break signal by default.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
> v2: Rephrase description and use "-gpios". (Krzysztof, Rob)
> v3: Use device-wakeup-gpios instead of h2c-ps-gpios. (Krzysztof)
> ---
>  .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

