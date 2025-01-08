Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE33225D7;
	Wed,  8 Jan 2025 08:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736323253; cv=none; b=ma9C5OK6V8xNGnk7zfVA6x2GMdh/59sKIwXQfNGhK+V6XRt6a0u72iPFbknmwNBQjPxC4mGHKKoL2TWA9s6UPeh3rxWDu9YJP2xAIyiJkvtjDVzq7u/2DJRl970qJX+0Wkqmarlz/djqlfrHGS2SvzRmk/YtZK/0yMEhCyrpZ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736323253; c=relaxed/simple;
	bh=gP9hRl4PVfWr/Sarqp96Mo9Bh1/vBjgiGSrhH0kdBr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XBqWg3ZyyFLC2n+0zdB4Ttu/K8PFX653R8XCYjkuGoLE20dtYlL+uUArDsHrhKVl/tGSqGMYPCGLFmbYWu/U9djBpXS4xQ1hpwbsFkVz/qoHRoXNIB5x9yBl3Le1FK0zW25OTYmfeg9f6Z8AbnWpcB78szeXWZYaeHMDjE++v2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MaiL22XN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MaiL22XN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C9CC4CEE0;
	Wed,  8 Jan 2025 08:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736323253;
	bh=gP9hRl4PVfWr/Sarqp96Mo9Bh1/vBjgiGSrhH0kdBr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MaiL22XNi7L5GBNdcteBA9UFDa29EnPKJ/Iyw3oO+NakWftL5t/C1Cnyd0AdRvV4J
	 V0ID/Lg45AwVYNAzeDOXO2+6W/+on0NbYc6yNIyqPDFh2Bl2SOftvkpZTlyR7JIgwm
	 VtmHbcflShzEEKxG542VsU2KznnktOTxPtQyXWLW5rURpr3SRbfZ6PFCAf6eLhUyE+
	 YucgRGMh4GuNEfZapgupZRaoZ2yx/dOtWH786zQ86qRPAHdMV4+0bhfJGdo7M01z8L
	 m9dy+JdnYheLmCQgwmar7M8d8sKSNmX8L9ALOS7lEjmd7NEGf71w/A8Dmopkh5JGGE
	 MqVxDN50Mc62A==
Date: Wed, 8 Jan 2025 09:00:49 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, quic_mohamull@quicinc.com, 
	quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/1] dt-bindings: bluetooth: Utilize PMU abstraction
 for WCN6750
Message-ID: <5jswtxditwlmnpgi7dwuakd3ew4yhjy4cko4lmxt74kzyb2tvl@nrz3l3ev4hh6>
References: <20250107134157.211702-1-quic_janathot@quicinc.com>
 <20250107134157.211702-2-quic_janathot@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250107134157.211702-2-quic_janathot@quicinc.com>

On Tue, Jan 07, 2025 at 07:11:57PM +0530, Janaki Ramaiah Thota wrote:
> We are now using the on-chip PMU node for power sequencing to manage the
> enable/disable functionality of Bluetooth. Consequently, the inputs
> previously marked as required under the Bluetooth node can be removed.
> 
> For instance, the enable GPIO is now managed by the PMU node with the
> property bt-enable-gpios.
> 
> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> ---
>  .../bindings/net/bluetooth/qualcomm-bluetooth.yaml           | 5 -----
>  1 file changed, 5 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

