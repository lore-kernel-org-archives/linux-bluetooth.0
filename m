Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FD4420E9F;
	Wed, 19 Aug 2026 09:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787132675; cv=none; b=G4pX3qbcnqyoWCoKMxd5629QhdeRUoEv0iOvnKnRpY2gxkWDo793LHQitx2CDMOoPhnHKti6z+k2PWzFkIgdjLKu5GETt/uoWigbM4Qld5SYM6rWI+NJaohOlPSeUhExjpyodswphZuErR4WesKpH7Z4YEWR5XXxSq0OJFePhIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787132675; c=relaxed/simple;
	bh=4e8KfB2/Wtipn2kbc6ukAs3sB8JL1UNcTAomff3plqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiATvvOlP5QIdbIb+975jqHlPi5XxYxtSR9qqanp0LLcTQdFHMc+D7HwsXFLfSVmqVeQkBNygqD/nUnasZMMqiheTgxx5CSxXxVOXawqmF63PIZt2oM+8lgfpZGYxQdLp2UwV6C45ItnFhlieupR5un9Zj4A6KQURyoYh5779Wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9F+T7Qv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9F+T7Qv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2901F000E9;
	Wed, 19 Aug 2026 09:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787132674;
	bh=Dkwr/Hje0BQ3+olEU0ZehfMJ6CUYHHUg12g0nukSveI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L9F+T7QvaEVlxj3b7Uwo5a0hYQa3bXU8O9NRp4BqhA8+xbd6DbbiFAWHqX3os3lXt
	 9TMWUvUw5JmO1kj564tlWxqvZsfVbjZGHdUcLqDIn4/l9JtEAmqh7q9zM9EkuBHl9e
	 c6+IHw7gkqrXro9s0m+p1QBm4oRiuw7qmlMFjSeHYwz/RQPZSXzAH0lua55xM8OLpq
	 UkylNNS/9JLGjm1u18npjHbaiWlDy8/zomvuvfoe4qxsNEYktWErOCQ2RdwPgLvPG8
	 j3KRVgBaZzELQ/vtSCW51CkzTMTd230amLe023dkILmx1ve1yUS2NENElzhxqMdJ8y
	 3jxjR2IlJFUPw==
Date: Wed, 19 Aug 2026 11:44:30 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org, 
	luiz.dentz@gmail.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linusw@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kaihsin Chung <kaihsin.chung@synaptics.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: net: bluetooth: add BCM4384
Message-ID: <20260819-grumpy-bloodhound-of-emphasis-2bf0fe@quoll>
References: <20260818014948.996739-1-kaihsin.chung@synaptics.com>
 <20260818014948.996739-2-kaihsin.chung@synaptics.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260818014948.996739-2-kaihsin.chung@synaptics.com>

On Tue, Aug 18, 2026 at 09:49:47AM +0800, Kaihsin Chung wrote:
> Add the brcm,bcm4384-bt compatible string to support the
> Synaptics BCM4384 Bluetooth controller.
> 
> Signed-off-by: Kaihsin Chung <kaihsin.chung@synaptics.com>
> ---
>  .../devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml        | 1 +

It's another version of this patchset with same mistakes. Please read
previous feedback very carefully.

Best regards,
Krzysztof

