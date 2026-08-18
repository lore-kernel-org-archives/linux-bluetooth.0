Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FC530ACE6;
	Tue, 18 Aug 2026 09:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787044776; cv=none; b=ltd5XFTQ86ZZABtHzxakSZnBJ1c/QUPjQ5NdL09TlKkzsJouq7ov+PkNdW4PET8RI/RVP/LrdAQ0f0Yz0kpQeEEcCZM2H4NjGHFqayZ5qFFW8+YCidPi9FpTg4I/LA5cy33rxl8gJotq3Ddb4fz8tXtU0DZZuHSul7s7E1jyMxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787044776; c=relaxed/simple;
	bh=fn0hNt3woDkAlXx/Bsy23gRrXiwkY89HFeuVMsvHXGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+sMG+3iGC2+pEFGuxlGlgRDPEm0uU9Y+AeMM+3BcmaFccV9LFycBJG6EDSjdXaoRWcFPkfl5ZMGtfkjPRp7yrDSF3I50tKTkOqLterR+WDNk4J/R0yiJNvypUr3ldrQDCWZ+KG2tx2ivk3lV76VdCyOoWmqs1uemv5BA/+1pLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRxla4bR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRxla4bR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04E8B1F000E9;
	Tue, 18 Aug 2026 09:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787044774;
	bh=uibDylrhGrrhtJIW2eZzAxZoYmV9jxgghXJedNrwnd4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QRxla4bRdhClvY3rXy09Kmx899jEH50aQtGr3BvW/5RAkNo4fm/xi7yv2+QGXJca+
	 I3JEUSMRoXM3ydvQUopDh51T469rGqm0QdF6MowTy2NPauWHoPedXya6DnMQDMhzHh
	 BIbnjAWe8ioN4aK64fSxlzZOSosok57DVIaVxeSn7O3WquJAoDv+X/MyMqr+jrDvpM
	 q5JRsUi92PfiO2AXfMLM7G7ObF/aIl3/wwEM2WATvX+1kqwFhHb08PiwP0CIgg3QrS
	 PPmsPKh2IXwW+jkY5GEeqr5zZKzbxIx1an9xJcLD0uMmD/gan6MaIscTfmHaO7mMRh
	 mVl846hgvzZTA==
Date: Tue, 18 Aug 2026 11:19:31 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	luiz.dentz@gmail.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linusw@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kaihsin Chung <kaihsin.chung@synaptics.com>
Subject: Re: [PATCH 1/2] dt-bindings: net: bluetooth: add BCM4384
Message-ID: <20260818-warping-magic-leopard-f5ee10@quoll>
References: <20260817095550.648774-1-kaihsin.chung@synaptics.com>
 <20260817095550.648774-2-kaihsin.chung@synaptics.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260817095550.648774-2-kaihsin.chung@synaptics.com>

On Mon, Aug 17, 2026 at 05:55:49PM +0800, Kaihsin Chung wrote:
> Add the brcm,bcm4384-bt compatible string to support the
> Synaptics BCM4384 Bluetooth controller.
> 
> Signed-off-by: Kaihsin Chung <kaihsin.chung@synaptics.com>
> ---
>  .../devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml        | 1 +
>  1 file changed, 1 insertion(+)

How many duplicates of this are we going to get?

Best regards,
Krzysztof

