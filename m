Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB40D24819C;
	Wed, 15 Jan 2025 09:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933602; cv=none; b=O9HRldeZgCi8NDuVTycCjddPCbKBY87/TVpVAOgeNLcWNEblzk5SRYqPNrxUgNbQwsCqjAaYvv+yxTc+p+in+zLJU6367utSTL2iw/iVwT6FLIHDeYOls4MLeGu+Fzw7otRYHYQU7fNoPM8n6b5y75WD+iUuTP97EdJ6OP4CuCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933602; c=relaxed/simple;
	bh=tq+DecNHeDMGaTXRfV8aGYEGZtCdjHMc9XnAvqkFd6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soaD21bZ7CkhdASYYA7Dw0ssEulVbnOkDvyJqnUTSz10LiAUMTpftKNz3Oevjm165gUtKHCXEEA8pBiNf8bzZcYLExOD67OQy8Ibq0oe8p/QSySul/wBqP2QmEksZ4XcW1TB7+FHH3FG5eue2OuqqdFmMyrWvHtI1GgNFltagIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BYPLumkI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BYPLumkI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E96C4CEE1;
	Wed, 15 Jan 2025 09:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736933602;
	bh=tq+DecNHeDMGaTXRfV8aGYEGZtCdjHMc9XnAvqkFd6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BYPLumkIxIqbLYqnKOUDHNjpG9sMJt4XOQBZCRtGyKWLDr8KxsVQNQ92nq9c2XlR/
	 4vT3cidNnagFRUD8ENFhrmoeIqd3ORVJPSd+rGF6sZCPK7AkX2A1rAVlyxCgHlWELo
	 C/XSY72t5BIfwThr4lh3DV0/fcZ4CKUQb2VnqIooGzERB8nbhzP48MCjfGMtvglUSX
	 0BVFtWeziXOK7heGcB0iBc9/aQKQsecOEpqA8ksvq2rUFqUmA1bKOgxPmyMFI5M5jt
	 CKv2MnEdAXtNacdaM+XKleDCnx1mxNDDPjRQy/XuKXFuV5qE2in8liwo/DVbatXIpc
	 7MrUxvwvUJ0pA==
Date: Wed, 15 Jan 2025 10:33:19 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, amitkumar.karwar@nxp.com, 
	sherry.sun@nxp.com, ziniu.wang_1@nxp.com, johan.korsnes@remarkable.no, 
	kristian.krohn@remarkable.no, manjeet.gupta@nxp.com
Subject: Re: [PATCH v3 1/2] dt-bindings: net: bluetooth: nxp: Add support to
 set BD address
Message-ID: <7tac7unei4f7ojryqsymjkcb7iz6vhiru4i32okql3xdm6lk3m@7x2y2kqub5os>
References: <20250114141912.2363131-1-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250114141912.2363131-1-neeraj.sanjaykale@nxp.com>

On Tue, Jan 14, 2025 at 07:49:11PM +0530, Neeraj Sanjay Kale wrote:
> Allow user to set custom BD address for NXP chipsets.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
> v2: Add allOf and unevaluatedProperties: false (Krzysztof)
> v3: Drop local-bd-address: true (Krzysztof)
> ---
>  .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml   | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

