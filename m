Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452866;
	b=DhnoAFInR3+HuUPJymve+tZBHZ2tfKDR7UHbyA5gIQzVimQ/hBo79smy/J5yQHCXX36h
	 NKHOqegvOaYtve10FDpJCi3TLK/FHkrjDXi8Ush0IC3QM6b4A/VQdYtYva8JKGM9OwDQW
	 A5IxjgtkHsKWomxXo154Dc4t6fAOfkNKkK28V6e4uUl+ye1yFMrDmL/s5wJCvAU/I36me
	 5bcp+ItdN0B3yxs0gZ/OTFJtmK3Z+AsNFOnNS4xglNnNctK8lp9WeDRtwyq2TBeczXXtt
	 OBzY/GDaiNKqvb1covV0YVEwr4kyFvPRnKlW0k+ehx6l5+PdKahzpxAQwWK3D8oazRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452866;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qj+Vf7iw31F6E3cdPbEJP4QDR12K07wi1jtJIqbi0Q8=;
	b=ry6LVnpg5GbCRC4aO2hT1vs4Blg97G6cfex5NDiepSlJNyhy3X6GXJv7P1kXljsmGCMK
	 lteiPIzeJexGpc+pE0yCNoXl+UaguWPqEWlj3HX2S78TDS4W7EZOUCtcPtYt/XUNI8AWA
	 UhkF7lADdrhh+IsiWnhG/ASQrqNps3aCLNiLYNS/JCfAvQZSIYzi5XVzDQUIi+rlv5+pY
	 6qSRtmJ5USFYkv+LgxK+0PqmxO/JNQ9ICABPGm+mZ+8D6iUvYuQGiq3hRYnX0pW/eDmKe
	 qxHcDXS0OVeDugwKQvWjzbkrBJuJZBj3hR+7rclvR31iuO3vXnBN4lUcUgPKZ4SFL/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tg6L9Pec;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F505606A321;
	Thu, 12 Nov 2026 03:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tg6L9Pec
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEAFD1F00A05;
	Thu, 12 Nov 2026 03:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794452865;
	bh=qj+Vf7iw31F6E3cdPbEJP4QDR12K07wi1jtJIqbi0Q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tg6L9Pec2a7DHzg87efKuIkDIKraSFwySsPAK9BoHxnJNX83Cuw/2TDx2e47abmyB
	 X+mxY/fgZkwUqPG7qFOo0EeKDG1XCgQN8w7E4xRegf19L9J8c8dTp1Us5y6RZJvIrk
	 cVdQ4pexsVSuP90fJvZSHjjHvwaPQC857R9iEcVHlk77XnykS4xqY0s8Wmk1Ns5Kl3
	 hfAD2EsjvzyH/9eU5gXDx9pgbT1kXLJb6tYr4bBb/gwrAuXr+H54Qp9mpQlL2tgHKK
	 3eJqRUY5lDd1mG2rOf6MmDndRmnY546Pd64ArjALXLnHfBS+KnOTceVGdTFdUCIjOm
	 lWhvoYDeJc+rA==
Date: Thu, 12 Nov 2026 03:07:42 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Max Chou <max.chou@realtek.com>, tfiga@chromium.org,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Bluetooth: btrtl: Fix NULL return on errors in
 btrtl_initialize()
Message-ID: <avUtfkGrgTazGYFP@google.com>
References: <20261027072148.3963826-1-tzungbi@kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027072148.3963826-1-tzungbi@kernel.org>

On Tue, Oct 27, 2026 at 07:21:46AM +0000, Tzung-Bi Shih wrote:
> In btrtl_initialize(), the `err_free` error path frees `btrtl_dev` and
> returns `ERR_PTR(ret)`.  Because earlier calls in btrtl_initialize() set
> `ret` to 0 on success, any subsequent failure path that jumps to
> `err_free` without setting `ret` to a negative error code causes
> btrtl_initialize() to return `ERR_PTR(0)` (`NULL`).
> 
> Since the caller btrtl_setup_realtek() only checks `IS_ERR(btrtl_dev)`,
> a `NULL` return bypasses the error check and causes a NULL pointer
> dereference in btrtl_download_firmware().
> 
> - Patch 1 fixes a NULL pointer dereference observed when
>   btrtl_vendor_read_reg16() fails.
> - Patch 2 fixes a similar issue found by inspection when bt_skb_alloc()
>   fails.
> 
> Tzung-Bi Shih (2):
>   Bluetooth: btrtl: Propagate errors if btrtl_vendor_read_reg16() fails
>   Bluetooth: btrtl: Return -ENOMEM if bt_skb_alloc() fails
> 
>  drivers/bluetooth/btrtl.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Hi,

Does the series look good to you, or is there anything you'd like me to
change?
