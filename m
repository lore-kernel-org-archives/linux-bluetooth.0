Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.69.30.187
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794265004;
	b=vh0vyOxE8kq+4SBFoA2vGEyTDMdPoSbP++zew5PDwb6m+A9N54dZpi1JOd8kcix3WneB
	 AoCkqIhZNSomYFGwFc4XGysA8TT46IFCNbjxObUyA3Heh5+2YV6XLc563cRP4sgFrc/Us
	 oSYyoq8xptY1DMgvpRXhHM2vM6uPp3ntDpYLsGm8ELpb0fQXgj7F5KGRuwp3qu1r/9Ten
	 rw7BJmJTaB/88jEqNnvWYNEFz8uAkqYzTBcNj0jjrAuxJVhuiEizzUr8Tsw+cwDL6sWHG
	 i5DtN9FgA4KvjS5i9RJKv6j86X0vVOm+ngtxkvcBkOaSdoQVmuxoTNqGuDVYu0GYopA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794265004;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GWAVL70i6r6sAHI5CbKhPc1r3FwU+hCVb2gn7ZX9euY=;
	b=gmDNoMBLKWEtsoXM40OAAelIYYbQWhMf7CZBGNq7DeIvlVMBehfoh7b1qLR2nHHkkGzF
	 jEl2t8u5zYjnFYpTjtYF+CG930Aq9I2WTBaMc218rfWGoBT/1ZX8+hLZZtLUGgXHQY/KU
	 GSgcRZGQ4M+jOERO0eP7P1DhJ87DmBWz1Cz43nam3cyOtxHCBbXZcs7ZdT1Z1tyk8S5Wq
	 ZT744lapm3XDUjrkHJdgLTEKp/lc18rrFA2dyVQLi2AQJOxacA3Xn+cOTABbZYQVoKTAm
	 8FkHstVzOWBas3kx57pjzVlhEvxSPvk+ZMrogJoVE5GBgeg7FKS8mpRj5DJne6T9+hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=freenixos.com;
	spf=pass smtp.mailfrom=freenixos.com;
	dkim=pass header.d=freenixos.com header.i=@freenixos.com header.a=rsa-sha256 header.s=mail header.b=uR7gVJhX;
	arc=none smtp.remote-ip=54.69.30.187
Received: from mail.freenixos.com (mail.freenixos.com [54.69.30.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B78606A321;
	Mon,  9 Nov 2026 22:56:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 91B78606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=freenixos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freenixos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=freenixos.com header.i=@freenixos.com header.a=rsa-sha256 header.s=mail header.b=uR7gVJhX
From: Hex Lindqvist <hex@freenixos.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freenixos.com;
	s=mail; t=1794264996;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GWAVL70i6r6sAHI5CbKhPc1r3FwU+hCVb2gn7ZX9euY=;
	b=uR7gVJhXmXl+I0WLlrHtMgLpTbMNFHuQChRchHjUc3vZiAjNvrdUs1h4OUCdLZolSZZMaU
	rdOyN10H7wHDE43Lt0umjKmFJHSLivqI0SOXPoB26Gqx4EjW2v1cEg5WVZJDF1KKXnugAN
	CEZv0pJW0WFPKIU8xk65Osu+PayTbRekN/aFB5J+F9zjZmNxiAO5TzNCLJ825rA7KZB986
	isML65CbAL3lN9uQxH2DXFd3M+WM6C1XjUGs37kOhiP0MrzOPkL+qhz6Qf9G9fdajW+PD8
	ExuhpKwXgavXXnJLq8/MJ29eSWRLoJuyOovBgixOmMwqvDiBmb0UoQcPHfPIuw==
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Zijun Hu <zijun.hu@oss.qualcomm.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: btusb: Use DECLARE_FLEX_ARRAY() for memdump segment data
Date: Mon,  9 Nov 2026 14:56:32 -0800
Message-ID: <20261109225632.1227242-1-hex@freenixos.com>
In-Reply-To: <CABBYNZJdeHXP1XjYcTwUdCe_SFfxMETpSQbF7t0FHyxY4YfZQQ@mail.gmail.com>
References: <20261108042008.226295-1-hex@freenixos.com> <b83e0172-2f64-4e28-9750-1a5fb3dd6b41@oss.qualcomm.com> <CABBYNZLJpDXTPmE_=rJ=J3oUMWRzybHhut4y1kPTEU8y2AKKiQ@mail.gmail.com> <CABBYNZJdeHXP1XjYcTwUdCe_SFfxMETpSQbF7t0FHyxY4YfZQQ@mail.gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Luiz, Zijun,

Thank you both for looking at this, and Paul for the review.

On Mon, Nov 9, 2026 at 10:39 AM Luiz Augusto von Dentz wrote:
> On Mon, Nov 9, 2026 at 10:35 AM Luiz Augusto von Dentz wrote:
>> While this maybe true if the above code does produce new warnings then
>> it needs to be fixed anyway, from the commit message it doesn't
>> mention any build warning but that perhaps is because it is enclosed
>> into a union which mask it or something, anyway trainling variable
>> length should be accompany with __counted_by; so the compiler can do
>> bounds checking.

There is no build warning, with or without the union; the patch was
only about the zero-length array being deprecated. __counted_by does
not fit here: the struct has no count field, and the segment length
comes from skb->len.

> Maybe not DECLARE_FLEX_ARRAY, but [0] is not recommended for vla see
> the Link tag, in fact the first_segdata[] does follow it so this needs
> to be fixed anyway.

As Zijun says, segdata is only an offsetof() anchor, so it can go
together with the union:

	struct qhci_vse_memdump {
		__le16 seqno;
		u8     subsys;
		__le32 dump_size;
		u8     first_segdata[];
	} __packed;

	#define QHCI_MEMDUMP_HDR_LEN	offsetof(struct qhci_vse_memdump, dump_size)

The header is pulled with QHCI_MEMDUMP_HDR_LEN, the first segment's
dump_size with sizeof(md_vse->dump_size), and the kernel-doc gains a
line saying that middle and last segments carry their payload right
after @subsys. The generated code does not change.

Zijun, would that work for you? If so, I will send it as v2.

Thanks,
Hex
