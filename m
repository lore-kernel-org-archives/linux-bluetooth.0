Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB5E1581EE
	for <linux-bluetooth@vger.kernel.org>; Fri, 31 Jan 2025 11:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738322191; cv=none; b=i+GadUtLSjZ2ATR9OiZpyHGHppvzT+6pKOHaJXcgvwcTCCHhR/z0y45fpknobepbFelulyXh09o93sHPWKQcLb/jzNupZcdGX023h7hzy5ERXul5K/SSjRuPTqToiE7Vcqoy42CT5gweB7t0hKR0EXjH+CIfGBwEGDkeCJoHPd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738322191; c=relaxed/simple;
	bh=PdZEoTRNq5jbP8lSPsBMJ8L4O5s0YHxovyiBKgkWJ1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMA1BIVnZsg4at1c33SEPXEcaNuIi0ykTpSjRvevsTK5sUEr6seJm45ndKkSUTNmJymN2QiwMf/udZ/a/EyV8K6hhpbRQjexgF3W6V97UUEeA/qL5NPd7OuTXQ1NXwi+Lo6IvqAtCBvIUte/l2+NJAtTFSJzzohhQuajKgbFoZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=IBUegPIP; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="IBUegPIP"
Received: from fpc (unknown [5.228.116.177])
	by mail.ispras.ru (Postfix) with ESMTPSA id A062540769D5;
	Fri, 31 Jan 2025 11:16:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru A062540769D5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1738322184;
	bh=3haojVuKmr+YPpWr0/WnmkpVRPb2fJ2PPUQ7v55yse4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IBUegPIPEwbDe2/sw4HL6j9nUEh5LqsGD+GhceXw8BhjHIk++cyYRdNRF7bVqnw5l
	 gekfvE0YOynmjybh7/PXDOtmwl5obXFeWVcsSiIGxFRitAcwDckUI8y+rekGCOKLpx
	 5tCAB9AWHNeXkDCgMZ5dP8j1jQiSBueruJttMOlU=
Date: Fri, 31 Jan 2025 14:16:19 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: patchwork-bot+bluetooth@kernel.org, linux-bluetooth@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH BlueZ v2 1/2] audio: actually try to enable MTU
 auto-tuning
Message-ID: <20250131-00ce5ea414812708056d347d-pchelkin@ispras.ru>
References: <20250129084950.41987-1-pchelkin@ispras.ru>
 <173825823449.1027237.5797702882442522177.git-patchwork-notify@kernel.org>
 <CABBYNZKm+xj4wmuzBgCjJq4genR73a6Gj-C1uvGHW3MiNdHNSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABBYNZKm+xj4wmuzBgCjJq4genR73a6Gj-C1uvGHW3MiNdHNSw@mail.gmail.com>

On Thu, 30. Jan 12:51, Luiz Augusto von Dentz wrote:
> > Here is the summary with links:
> >   - [BlueZ,v2,1/2] audio: actually try to enable MTU auto-tuning
> >     (no matching commit)
> 
> Ive done quite a few modifications to the above change, so instead of
> using a auto_mtu it now checks if -1 for not set, Ive checked with a
> couple headsets I have and it seem to work fine but perhaps you want
> to check as well just to make sure I didn't screw something up.

It works okay for my setup, too. Thanks!
