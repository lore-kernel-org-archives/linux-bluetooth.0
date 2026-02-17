Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4682D2C3257;
	Tue, 17 Feb 2026 07:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771314710; cv=none; b=ZIQJJ+tc3XstWBCpCyEy+sFhcQ8+x5Dz7fPKvM6i983OEMkSDPtMUURYcizyOVfC6f1K4tBZoIFR89Kt/abzMdpxdcXgGZIXhyfBGx1JTAZ0wvTMNAYBt/tuRgBwLfiGWe3fo86sLOfNvjxuJ9Y7pX2XN+g8visazqDr06SWS0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771314710; c=relaxed/simple;
	bh=+62KFVzOzcLbrBzIwrjzp6k1GLrdJRZUAdp/CEJjzGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJFKtKb+3fcvIcYfCxbTHE21+CHpZyy2v+WU/m1KsaJFEnMJtj47CGA7MuwSeQs38CjDGXnnwBHeyzc05+uhSZsWlRNaydKROGuNpC2ZHRa0JE7uvRU7bTZIKxOlvfVfaqQ/8R3kgg3SjR7TlgH8gGwe+AxcaA3IvK1Glj/+s80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMdo9U/6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMdo9U/6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448C7C4CEF7;
	Tue, 17 Feb 2026 07:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771314709;
	bh=+62KFVzOzcLbrBzIwrjzp6k1GLrdJRZUAdp/CEJjzGI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AMdo9U/6D5PYFqsu8trJZAPLBpc5ulvOlQ/XaDyIeWebvmqqRAfvjBu9GusvETRTO
	 /EU7Hye2bcqsToT6SDBO8ydEF6QucCxXUIjwRJWVtJWH/qPK5KPvjP+ci0ZBUXLZet
	 6lIHt4ubix30bGggO63BUPYf36xh8d8NYXg1X4V+lsj37l+Riwwjj7eMWM9dwCyf1O
	 1sd+nNX6IQKEwFLD8S1vZY4UCggJMNmsjb8cwCZ+aZZZjEe6KKfMvMLQkkK4jmzCIJ
	 9DjpJdeYrr3GDyGXNU2FOUNyd031lF8vS8ZqRMWyXpszNiJ84jFDi3fhrfFU2aTIK+
	 Li729Fp+2N1Ng==
Date: Tue, 17 Feb 2026 08:51:47 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Rocky Liao <quic_rjliao@quicinc.com>, quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, 
	janaki.thota@oss.qualcomm.com, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: bluetooth: qcom,qcc2072-bt: Split to
 separate schema
Message-ID: <20260217-avocet-of-glorious-romance-8cf9ec@quoll>
References: <20260217054731.3058567-1-vivek.sahu@oss.qualcomm.com>
 <20260217054731.3058567-2-vivek.sahu@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260217054731.3058567-2-vivek.sahu@oss.qualcomm.com>

On Tue, Feb 17, 2026 at 11:17:30AM +0530, Vivek Sahu wrote:
> One big Qualcomm Bluetooth schema is hardly manageable: it lists all
> possible properties (19 supplies).  Split qcom,qcc2072-bt to separate
> bindings, so device schema will be easier to read/maintain and list only
> relevant properties.

Huh? I do not see any split here and I do not see how this commit msg
relates anyhow to what the patch is doing.
> 
> Signed-off-by: Vivek Sahu <vivek.sahu@oss.qualcomm.com>
> ---
>  .../net/bluetooth/qcom,qcc2072-bt.yaml        | 48 +++++++++++++++++++


Best regards,
Krzysztof

