Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793359980;
	b=1kuflZg661Qso3KIhiNKXn28CYYYKdkQhw9LD4o2cAM0lk3bK2b9D4X/7pW6jYdk9dGf
	 GPXb+3fp9tSo1ov4c/X+byCkBPCr6gy+ps+BdPXSgUpxr5miphKepvB13ZU6s1BlU2k+a
	 jEi37JMaaEwudohie05cxTEub5IvcfH6X1IVzZ3Dd0RkcYqCFoTIP6HFZ6OAmrsthWqgU
	 H7HgrF06pCJzNVXM0y/nyZWpHCf6TAkKOwjNbAginMGonQ+PN9SUcQJF0OX4yKw/1TpR3
	 9oqIYAdI2gZcq6Eeb+YTlbU1iz9xucwb5OVeXBSy9dF21r95odYoT2aGrlw9BAG/upQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793359980;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=tkMc0K2QRp4uZYMJTDc67OVOmAzKvQQMIGqhFsdpr1Y=;
	b=5m4gt3NNsXxy0gHPGCYc3XTTh4SUc6F1XTH5+4q94yzCw6mu7XmkAsNP3RU+lTC1GuiE
	 Po9tlxb8AR8DQ7nqANeNTCRbiZgklglusWMhsborytPk9E2k9QieZsq+lpJgf9hAW7Kbj
	 hK6hl1xewxlvRLcI2x7OU0tOx9Kmja3xfNbGPF8jxoPN/gt5IK0eTmp0GZ9Z6cHr/+fyo
	 lMtqkX+vD2r1r6XaeLuF9TwsXeAwjUaivtk3XBkCBWoIRUw+uvvwaAwHWM3snm+UJ/kzY
	 DGH90crWEYep4A93f22UNeOGg4R1r2GmduSdTXey5QzCYA4LGY8mIW+UH3/JWPf90Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ITKHxZlY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CE9606A31C;
	Fri, 30 Oct 2026 11:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ITKHxZlY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03061F000C1;
	Fri, 30 Oct 2026 11:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793359980;
	bh=tkMc0K2QRp4uZYMJTDc67OVOmAzKvQQMIGqhFsdpr1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ITKHxZlYyXgzi6LeGOmVcPfuw/80gGoQ5rXKEyGTSuZHSeHxUT7gkmwFdxdQ5ecga
	 Wy3m1Zz/kj46yTAUFiZQHB41n5EGwD9TpglALL+GS58PFrwCILOIzV1tnj0Mixqvia
	 32gwsbnHix4AUh/kCxdYqB7JeEed6K/3lje1fB3hqS5pViwAGNBFMSognBgwsK52MD
	 7rZvm4pmY3zqrnU9UagWbYkEeANhwcQmjFjBpQtw9PQiW/wzIoKiOmxJ86TDETWU4E
	 lnf7k881xCTIVD4UTx8xRikMIlLso4q/vzni+4UH+Cj+akUyXA8DKKfWPklnLeWYRr
	 qOYKcuP9n0zJg==
Date: Fri, 30 Oct 2026 12:32:55 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: christian.koever-draxl@student.uibk.ac.at
Cc: yang.li@amlogic.com, marcel@holtmann.org, luiz.dentz@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Christian Stefan =?utf-8?B?S8O2dsOpci1EcmF4bA==?= <ckoever@outlook.de>
Subject: Re: [PATCH 4/7] dt-bindings: net: bluetooth: amlogic,w155s2-bt:
 allow local-bd-address
Message-ID: <20261030-translucent-angelic-myna-ef2700@quoll>
References: <20261025192338.209574-1-christian.koever-draxl@student.uibk.ac.at>
 <20261025192338.209574-5-christian.koever-draxl@student.uibk.ac.at>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261025192338.209574-5-christian.koever-draxl@student.uibk.ac.at>

On Sun, Oct 25, 2026 at 08:23:35PM +0100, christian.koever-draxl@student.uibk.ac.at wrote:
> @@ -41,6 +44,8 @@ properties:
>      maxItems: 1
>      description: specify the path of firmware bin to load
>  
> +  local-bd-address: true

Drop and instead change additionalProperties -> unevaluatedProperties.


Best regards,
Krzysztof

