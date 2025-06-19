Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047DA21CC79;
	Thu, 19 Jun 2025 09:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750327026; cv=none; b=YdhKDOzJKvkYBpZ0fLDQZmTwFDnr3S9gbtXsgy6jizz2FyFtiDS6R51Y6TTQwwg88fJjLk38nmj824xSlRtydnt3nxgnneVeSZVnX2uIpyV/tYdp+eeCuMUi+yuR/gWydZmK0dI0saIHtuSx5OksDiN72i0joFk2b0XtZm8qA6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750327026; c=relaxed/simple;
	bh=FJl3qdYpg6zgOGZVK6n5oQKa8fLrJgPej0TUr488JGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIWX5TS0kzu2KCIR3sXMjIAI1FN74WacleOEudpNoScmDcr7pgssTJheXLGartSAz/3xCiiMnIzfnD8HX2B0sE0hzQsvo8tT5pszPSGGRJlS+5EjLNpH9Luf+0/rdW2bwE6MQfeDwFlt0sFBuukDaHHhLmfIy1HI/BAxsURrV34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/SYhRc0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/SYhRc0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACAEC4CEEF;
	Thu, 19 Jun 2025 09:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750327025;
	bh=FJl3qdYpg6zgOGZVK6n5oQKa8fLrJgPej0TUr488JGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i/SYhRc0YgG7XfqYZ9mXh1HpFgjD1HTa5rXFsQksLxFg3dSFzfV+kFeDCIL8o7wOC
	 p2+zna45L8rwVZFOe50xcdpKVlqUIIr5UeveSGAANC9ajjcU6iXELxZA7BnyTPcvJ9
	 GD8G6Hx2Zaxlv0ULalCLYrDVacBO5QHA1k1kGxk9T/02kZEm0rNKNwKEk0RygC4NjT
	 mgvFXhGgeSbYR6ZU+qfSg+hG/jY8T4WyJjZSEQj1zKJZkdh9I1wmF/K9hT2LYN9/gY
	 kfqHpVaD/iWER2TeXUM+3+iBRyFrh8pBVSJwLHbed5F4pcsD7rEx1iTTKGhxeYWK6J
	 BiTpdXvfYr4YQ==
Date: Thu, 19 Jun 2025 11:57:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, amitkumar.karwar@nxp.com, 
	sherry.sun@nxp.com, manjeet.gupta@nxp.com
Subject: Re: [PATCH v3 1/2] dt-bindings: net: bluetooth: nxp: Add support for
 4M baudrate
Message-ID: <20250619-vegan-beluga-of-intensity-74d4da@kuoka>
References: <20250618152113.25500-1-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250618152113.25500-1-neeraj.sanjaykale@nxp.com>

On Wed, Jun 18, 2025 at 08:51:12PM GMT, Neeraj Sanjay Kale wrote:
> Add support for 4000000 as secondary baudrate.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
> v2: Use the available 'max-speed' device tree property. (Krzysztof)
> v3: No Change
> ---
>  .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml  | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> index 3ab60c70286f..4a1b6ea48a2f 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> @@ -34,6 +34,12 @@ properties:
>        This property depends on the module vendor's
>        configuration.
>  
> +  max-speed:

Definition is in serial-peripheral-props.yaml so you need to add its
$ref. Just like other bindings.

Best regards,
Krzysztof

