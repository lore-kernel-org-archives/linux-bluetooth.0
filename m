Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794586995;
	b=cOoH0WB9gfID8eaUKu5m3uM2cfGlHNABPs1dkiL2HEWNSOdkcyZYU3OnjkROjnb60ETe
	 1WdTpT5C5idLT3ICx9iUENSRcQXs7VLwvMtL9PCZKl0YROmIEsmOf0lY+n14hrdVLjCZI
	 NtrWykYWKgrrX0kDw+d9s5xHH3rOYUCWxk+bg8ITqkW44FZQAxsS31AXRa+o4n/nB9XM2
	 HJD6jPXBmF+nKoMQiBoVetCeBQkfL4SpKlmwid0Di2UD6jsZqFKFJK+f62vY7xIS5ggDc
	 L5Nhu1ZNAQTHyMbEE3HsBUOZMx2mee5+xkvGqwP5Mdf9E7uZ+ZwDfifBmSE8j8qySZQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CJTYIzmEgvGVR2zpUCC/cFO0VF8PI0DwXdborWCtJ4Q=;
	b=i+E0L/zq02kCoD6YB3wlQrFOPh3mslq2eZlhJ2ZbL6DvcF8sM0Ax2JqWvEKpSHKnUYtU
	 K5Zkghgzu33QZedz31i3L8ZjODR7u/ScNs+Gqwx4B9wi+5mAEidYYHloY7h8E+Qp/m+e1
	 zY8V7X+sEUU+zgnbrcnasMWCOQTb1EGrMY3afdkVw7HkPtjVErXfRzQgB/mB7+GpuvzDa
	 Lb/zPYsV5Yikq7mG21TPkZf1slWhdzw6ZqpbcxJnyXWVsxkrWHKdLqfE5uP/G2nzAmcg+
	 Wi6bWYPRO5wEp2JvaCeZ2047ygSw1mQpY9WNkKZEnN0l/REZDJO67f7PQfqoJH3ew3A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pIFDfV5y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.50
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C496606A88A
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 16:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C496606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pIFDfV5y
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-48e94879f02so368430fac.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 08:23:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794586994; cv=none;
        d=google.com; s=arc-20260327;
        b=dxvq0sWUJD5zo91B3apBgME/Dc+kCzHVWyjQqZdmQINchpZxrFmAMVbhjBKCXrAffr
         81TBLWirDTYF7YL5zWiePj/F4Y4yGtnnx6SheZBAJuy2p0nEU6FLmq6cW2YBJT9jggWH
         c2cfb5qzinDXpgAuPZIb5dk2El2UmMew6Q9FAGHG31xPGyC5JrP2rhbq/HdsMxOndbW7
         YJXzCVYQ2BowlVTtt3MTQhwBdp5fKPSkJ7s9hmtMHE13EvnWAkjWdGFrSiwGDVS4Zo25
         EwX1L6Tk4GjCSKtSa4Rb1EN6/IOXn4WMZsLYN7H66krY2EbrqZPDgi6sR6UKF+NFiiw7
         Orpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CJTYIzmEgvGVR2zpUCC/cFO0VF8PI0DwXdborWCtJ4Q=;
        fh=ObCY1VZUb340lhmoOd//Cgdk+ZZ5xWaPmnUWvq3MVe4=;
        b=hKzCZPOo9cUUMWFMAPlkCT2wcD53KPZu/X0mUZfAvoYqpHpyHLHX+rWJYbtI5Kt8ya
         f7tlgjNnWNmJzZI4a7Vf4q9yXlrOd8ycUasv8M4Y1Lcik+PL+B2dt8oshQ246g3gyHlg
         MxqvNsOweRUKYLUratQhKWuo3sd83/DZEUVVIQifY3DbQ4+JaqAv7xJKSje8dtB3gImv
         LGbqkA7J7ZlmwK3/m8lkYG1/+JUYvH/CqBIM2a02o5EPFv7PbXXzmR/rXDVnziPWEYQG
         DBYH5KmPby0PRJYsnls/FcCwHnc9JrM1OUmBGRyzNGFCzBN9ta+EpMJRJkd4aVR+D9lK
         n3lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794586994; x=1795191794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CJTYIzmEgvGVR2zpUCC/cFO0VF8PI0DwXdborWCtJ4Q=;
        b=pIFDfV5yKQjSU77PRiyLPDwL4kx3d0fNVxmtW1rtKvaKRnjf0VQSoTNjNJYWLKJTeN
         30Bb3GpQS/sQZ3jQQ726gaIb+eF4I8RCD/weWRvXtnQmF+1T90bGC+t7cyTkuZ/6v4pq
         yq4RIeO9IKvdMJktBFnXRqH6RXSCQ6iANN/3pFbcgXhI4tSxYG1EU4TTnuyvGIM/4cBD
         93iTS14KeK15fX8tQ52Jg77pcW15IXVivTxhlCu9RAvP0nZrwGlYi+NazXIYC/UFw5S3
         EChzWgnS0cVXvYGjQPg6KtFcIbhLty9vyDlMGvfU3KJBHdVpxcPg6BlQzbzTyQckwuRv
         VbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794586994; x=1795191794;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CJTYIzmEgvGVR2zpUCC/cFO0VF8PI0DwXdborWCtJ4Q=;
        b=sfiIGjhklGvcAvW2/0XrUR5oARACiZ74MzVGoJHPEIDDGuHmnZte/Do7IL3DauKj7z
         vrf9B29hHo+X1ABu5sUu6Y+UGCzFRoKcnVIYZORhLsns5BHqikmEbZviZjxUFm2qDuTx
         qMJPNqpvkYb2zgNe9tn736SPY5ukKZ+ObK0kzR6bMs7/B0WPKC6AyXErLXuJwKo/peLU
         6lSGBr8ziC20xzQnrgiHo4SnIDL9fQ94MEgAC8AsIXL1z/VAL8Eh/Y1peZavaUV3f016
         TVPwPGJ/239kIWZIxcKOUXf3rH7KWuBYp6tNacmWK9LXdoDhCxH42cvbrWm6wAkncQLC
         W1kQ==
X-Forwarded-Encrypted: i=1; AL+hErGyQtEngtHteAdcUa7ZikvfZTHOPVOyZcgMlyHVlQjU+PK876xoD6RRoF9VgP6ENqH+PIx8MwCV4L54HfZv2uw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZCGCmKG62Ps6EcSK/rZng9/23Jh8RLmv+PbfdI85dvQYMKTmE
	+qbvsiHJN4+stGZTvfjLU0a5mUZkn6cCdY7pji4tIOAVkd6rteOyOwzA434mphgpcZbw5WNamg5
	64SBCLotj+ZcyKctBaC835qx3o/oU4vo=
X-Gm-Gg: AYBFou1xHShlp/kUn34Vo+Rr1gPcfanrOd/JoXahqsP3od5RRb1jalUd7kF0z59pEy9
	dLz/f3Ptbh2ZmPZuizvQfcRb6YleN/tqZEHtQxSmXZ2j8TZF9fbYwR73BGvJq/88Ev+i7htrEY/
	5oZV7w6M3ba8srMdDVpVIiZihjAYaG/gEDCgkG4XCuiuwYKeVthTs3yUrO+DRioBgCZNE4qlzDU
	mHEi/G1cAVeePRbzEm1KqxR1s4JmY2RvgXfGPlZnOb2TRTNo36zK/7flSdZSpNTUD0NbWcnFdMJ
	2odMi0dloGLDTO/J9j37lwQU4PKq1+JobbEIiAdmKZcPU3VT/7HREL7xVUkQotOsp1vVpy7H+i3
	rOprCqMjKl0ViyA9LTTn/cFV5oisSOidEUDuHWj1tkFByYtzs4um4XjzWKJbPVP/xHmudKPqpVY
	diNnSRiu5uoIXf7sQ20TuB8kig/ru0w5qMjrR+fKu9dt9N/v6JJGQoX1+zQ2g=
X-Received: by 2002:a05:6808:2220:b0:56d:3258:bd23 with SMTP id
 5614622812f47-56e6562e981mr1867273b6e.65.1794586993776; Fri, 13 Nov 2026
 08:23:13 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112173812.18696-1-piyus@iiitd.ac.in> <20261112173812.18696-2-piyus@iiitd.ac.in>
 <CABBYNZK4akYzoWc97v8FTXc77+godNTHASn8ZnfNji=jPd2oiw@mail.gmail.com> <CADq=QSz7GMXXjsykU87=6yCcWL1QX3NVOpxjQpJD3T2KG-nssw@mail.gmail.com>
In-Reply-To: <CADq=QSz7GMXXjsykU87=6yCcWL1QX3NVOpxjQpJD3T2KG-nssw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 13 Nov 2026 11:23:02 -0500
X-Gm-Features: AclHuK8DtyOoUdbmb6DHHh2aXLVHhhaNU2EFb3ReHs-x-vDvJi2tW9GZvx5wqys
Message-ID: <CABBYNZKeBYiJTH6m+yo5bqfpmVO6cpqLcz5ZdQ0xvw5kjnGN9Q@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: clear the SDU before the receive callback
To: Piyus Kedia <piyus@iiitd.ac.in>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kapil Vaswani <kapil@presceralabs.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Piyus,

On Fri, Nov 13, 2026 at 11:20=E2=80=AFAM Piyus Kedia <piyus@iiitd.ac.in> wr=
ote:
>
> Hi Luiz,
>
> Thanks for sharing this!
>
> On the double free: that free isn't new. The block this patch replaces
> already did it,
>
> failed:
>   if (err) {
>       kfree_skb(skb);
>       kfree_skb(chan->sdu);
>
> with skb NULL by then, and l2cap_reassemble_sdu() has the same block.
> So if a shared skb can reach the callback, the existing code
> double-frees in exactly the same way - this patch neither adds that
> nor fixes it. What it fixes is the use-after-free on chan->sdu.
>
> As far as we can tell, it can't be shared here: skb_share_check() only
> acts when skb->users !=3D 1, and nothing on the ACL receive path takes a
> reference - the only two skb_get() calls in net/bluetooth are req_skb
> in hci_core.c and req_rsp in hci_sync.c, both on the HCI command path,
> and
> append_skb_frag() doesn't touch skb->users. We may be wrong about
> that, and if we are, the fix belongs in recv_pkt() rather than in each
> caller - it frees the caller's skb on one drop path and leaves it on
> the others. Happy to send a patch for that separately.
>
> You're also right that "frees the skb outright" was wrong: recv_pkt()
> consumes the skb on its success paths and leaves it to the caller on
> most of the drop paths. I have a v2 ready with that sentence fixed,
> but the diff is unchanged from v1. Please let us know if you want it
> posted.

Ive sent a fix the 6lowpan, so no need to respin this, I will add the
missing Fixes tag that sashiko flagged.
