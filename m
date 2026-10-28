Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.125.188.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793213025;
	b=kQDMRED/cuf903ZZtTMpv1l2iGLzqNunuSZWzCE0VZHvnKQ9s4zrFh0CF01DjVKUiaVB
	 n9MNJ6rfdQf3g/4pTaFVnHSKmz7QGnMEbTUgMTPiqJcuxPdsoUkTFX+KX/w4QJCTkwRwg
	 5Dz3IrX3HOrM9Irdc58cs+aub8xKqJMLzQx1j7CXOyhW2xL66BH/HSHHRXyxNpXpShUNd
	 /DiagZ05iE+yL4hOHoAywqfQRYNXc7xvx59Le49nAu9TjZ3YnUED+cdAwVeTDCGRR0fPl
	 FxaaeUhwYbh6oC4kv44ZaMjWLWLT1DqM/OEShO5YYrgCTBnD9mRBAgj+qZlcworsnDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213025;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LxeaRpJalAK9o9y/rJrI1nvI5x98N5L6JBdMxfFP0kQ=;
	b=lm0zJJNDLZzPcsKCzpi2c5oSrmr4gUgbzvbAUBZyO59iatnZNDGHAASXLeKYUwdDoDZf
	 AeZCJpHBwzNS++0lqlmfkb+x3T2eKwhWlGq9GfLAkWmVBOCMerCGA58gaE4F9J7HmmuGZ
	 BUQCPNPHiLcLKinOhRe7BlqytOA2ysHyjHE8eL1zhj7JNtUyJEeCY/7XVt9z1ydakqf+e
	 e4egmhZmAFdyKgzdkvZb+BfzpyfU3rGnhqG/rmlUvCoNwR5jZg80COhLuQvDgeLZOufa1
	 pi1iIvtf1doSpawFfKKI5cT862YS8oclO5q5tdyN2blj5s2np17WndsCRuSKdZIocTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=o8GJKJZq;
	arc=none smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FFB606A31C
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 18:43:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3FFB606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=o8GJKJZq
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id E32CB3F32F
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 18:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1793213021;
	bh=LxeaRpJalAK9o9y/rJrI1nvI5x98N5L6JBdMxfFP0kQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=o8GJKJZqqiiHIy/XgmHLmXWju7phzlobmGGJ76dsB+Xe3Oh1JjbJLAQs9Bl/M8qVk
	 vTUy/HFq6BaggI12b+0M/+hDbJjQYSs8MMuo+uRXRhRvq+lyEvWb2owLIFCPYcBaxc
	 7tPgLKnoCS08Bh/0qVoAcvpu1klm44NkBv7J9g3ddGLJSeGK7HPA3WlCRAWklakd56
	 ntwJ/azqhfkpu9GrNhnhc66nn858iJEXM5Y/gmbStpRFIb9NPPOStw+p6GKZNlFXkT
	 /JGswiC6t9L8Bky3KHJgMJy44fTsqXzxm+uqyldCzEASwwo/3NiIcdxBYTXtXREDdx
	 y0cyt5BwNJJxhic57tDsLb6M7fC0Sa2HCa1GWvZ3zORby5QBI3/myOhpHUe75LR6H8
	 L0MDhZ9qWHVHCmdmKwhB3MLGVA1K1IVXrcRVYF3pGYyzLQsZOOLot55X1L0qjdKjJl
	 AQ5+ECFrJqXg1Xwy/n3rloCcdA1ZMygIw3V9nSeldHvYRrUYiSunGnkiDxjYrAEBLe
	 BJG8YkMrf04hifNTiDxppYQNRRL/AzWQVizIxd4rC5QzAmUQRi+pwovkGRQvsubjo9
	 C84eYpjY0H7rIE+BfFci72kTSnaF9SraOs4J0UCIZD+6FEG4KEFB5joHO8YIJGZTm+
	 5e6wyyBKoUWq3P/pT4rrOseY=
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ad3bf3fe2fso350901a91.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 11:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793213020; x=1793817820;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LxeaRpJalAK9o9y/rJrI1nvI5x98N5L6JBdMxfFP0kQ=;
        b=nxAMLkmYMiZZp+GjcGZXZZc2Q3LB/S8Lq150JQW4CXz/tuy0lcBb3O4HKYv7zvhsfY
         GJaC6OyqtLfUJ4gqGRPRev/jLhKsEMwso2Vpb7POc9oxUIyN2SwLiAaRVJW7AL7rGtg7
         YIUxguETuB69JlFuVz1aF/ikHQ7sL/4Q4L1OCrqkkA10Os/8i8mNpYuKqq3EpyOx9ZlV
         sZNezbVYjWWtK1yIi4fIHoBhNKUxyfDJDG84189QASJ6uIVZvKiejb0pIm6oiUZ+NaLb
         OvoVBS++DVX8HJfHp2WJ41wnaiMC9AamvK9/FzgHNX5WKW5mhsPEQRn9NRajHoh5eWzd
         4dGg==
X-Gm-Message-State: AFq9FYKYVEWkX7Nk28s2C4rNcWp4BBQLHav+HscTMybgg94TqMmF39gC
	ZaBZL0cop9aRvXJgxqdt8TIYDI2uLIUBNAwRu8pGLCQdTs9aOuMR+luXJBFZqNfg4b1R0zS5QB2
	c6zs+Ac0FAR/k0gbXM2ojZnAoscdlBvCoreBHPSfBDBK8Rd3UQISPMdqSgIMn9rQSKdIGh8P9AJ
	/2kVZKORudaiHuqZr4aA==
X-Gm-Gg: AYBFou2tUucCFpvpN83j1xAth7S0oEdAJPUpSYf3qNzFsK4JbnxNBVLqC/0bdxrHADK
	FvjyyLidnuZ7WQVh22mIDo8PGTUGbb+Yo8YTtB/HTb4ClOqADwMdvkuTEw6Zr4ScdlUr2lU1Lxz
	71goWXFyJdjL05JtBOpMnZl/XyKE6/KFS6rh1fcOjQIWUNafBNcZKehDiqkSU66BvX6SXq0wzmm
	Cnmu8E8U3xUAYNNRu0s6mV54SfH7WOB3tZ+iH0v/Mt3Y0pLjRQXuNsAUQ/cOe25anBRGr/M7QMx
	UVayGGTShsFhHbJQmhW7LditbFWcpX/LsEKrkXx5+IiV4zKNaQOi8StcXc7jbae2j/xZGzNiSUX
	mpn1HvBoHTMODNMVUevzx20Lg/zm1E3rgGoZri0kJvzPRFqM/QfqhiyGiqfKRbKSjZUaObLz82a
	gtB+PPqyXgf+mXP7vPPDLckT8CW1TMkk3aVuwuN0r7066xBHecr6VWeCcsvJVNqsbhk97inwrqJ
	qpZBAhyaOg8Hae4mYgDlXodWkJCPLZCUtl26s5nA8pffd9rw/JC3ghMG7X/iuut4ev6hyor2Mcj
X-Received: by 2002:a17:90b:180f:b0:3ab:a188:b898 with SMTP id 98e67ed59e1d1-3ae57eae277mr4429460a91.2.1793213020313;
        Wed, 28 Oct 2026 11:43:40 -0700 (PDT)
X-Received: by 2002:a17:90b:180f:b0:3ab:a188:b898 with SMTP id 98e67ed59e1d1-3ae57eae277mr4429441a91.2.1793213019898;
        Wed, 28 Oct 2026 11:43:39 -0700 (PDT)
Received: from localhost (2001-b011-2008-445c-6e54-18f2-1df8-9655.dynamic-ip6.hinet.net. [2001:b011:2008:445c:6e54:18f2:1df8:9655])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9db612sm626696a91.17.2026.10.28.11.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 11:43:39 -0700 (PDT)
Date: Thu, 29 Oct 2026 02:43:37 +0800
From: ChunAn Wu <an.wu@canonical.com>
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
	luiz.dentz@gmail.com, kiran.k@intel.com,
	chandrashekar.devegowda@intel.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: guard debug dump before hdev
 setup
Message-ID: <auJAzRIrhM3x1WEW@an-XPS-15-9520>
References: <20261013125241.1230408-1-an.wu@canonical.com>
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
In-Reply-To: <20261013125241.1230408-1-an.wu@canonical.com>

On Tue, Oct 13, 2026 at 08:52:41PM +0800, ChunAn Wu wrote:
> An MSI-X interrupt can reach the debug-dump helper before
> btintel_pcie_setup_hdev() initializes data->hdev. The helper then
> passes NULL to hci_get_drvdata() and crashes the interrupt thread.
> 
> Return early when hdev is not available. This covers the GP1 and GP0
> error paths while leaving interrupt handling unchanged.
> 
> Fixes: 190377500fde ("Bluetooth: btintel_pcie: Dump debug registers on error")
> Cc: stable@vger.kernel.org
> Signed-off-by: ChunAn Wu <an.wu@canonical.com>
> ---
> Changes in v2:
> - Add the missing Fixes: tag required for the stable CC.
> 
> ---
>  drivers/bluetooth/btintel_pcie.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index ac7193400769..8d7927bd75b6 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -297,12 +297,17 @@ static void btintel_pcie_prepare_tx(struct txq *txq, u16 tfd_index,
>  
>  static inline void btintel_pcie_dump_debug_registers(struct hci_dev *hdev)
>  {
> -	struct btintel_pcie_data *data = hci_get_drvdata(hdev);
> +	struct btintel_pcie_data *data;
>  	u16 cr_hia, cr_tia;
>  	u32 reg, mbox_reg;
>  	struct sk_buff *skb;
>  	u8 buf[80];
>  
> +	if (!hdev)
> +		return;
> +
> +	data = hci_get_drvdata(hdev);
> +
>  	skb = alloc_skb(1024, GFP_ATOMIC);
>  	if (!skb)
>  		return;
> 
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
> -- 
> 2.34.1
Hi Maintainers,
Could you kindly help me to review the patch
Many thanks

BR
    An 
