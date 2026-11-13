Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794587575;
	b=HVDHK7pO05jeer97+4eDoVf8oMdDTtnGy02izELzmf5G9hFgX1p4V+yY3TsLKFjoNcIL
	 MXvucQXIVMXneHesZMknjDdS0Xr8a+iL55W3fMNyh20fFbLUuV96lkn9Emp2QxHTcT2sP
	 wkK5Xa7dsY6OkMwZMkZBOLWtDr1q2djqKR+gxdzJ7dRyP1cyniAmEKPkxUx/2aKzfqmGg
	 kLR12SFMvqHdAJEcXI1e+ETWfTNkZG3v9mxKnfiQ9d7FxANtKjQOKkXeYuwPoOVkVwdim
	 HmhT+Bpo+5CluMoBhBBp2W/ygJJYsVweuDqBZAAaabL2ea+M32P3tl3OxtQlZeQlf6Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OhQ4VvBeytePCKEBDRXAk9FEqcTaWFnpXRWzd42nCrE=;
	b=jiPRFTPC9SSEKCGIY0MwvDrbDIRu5PSDamIhOQo4E8PMnuf7IefHmDUAWEt9QL8mAavX
	 xu73eLdvaBOPFBNDpUao2+UP546Jp1BVYSXQa+OmPV91J0pG2pYLD4qOz7Yer6JXIKtl6
	 jBFdDuYF+63eJosvFDZSC+qncaDHWUWLv6nJFTAQs6CiP5JrsUIdADcwBziIF2gS0p9fX
	 0ryVBmApcvZkdIcXUiANeDN+zqKdI5HyUjEEQ7X8G9YqJRljCvArN0pCpkpLaeC3zHWin
	 O8GROAiqq38tZ7nopCmd2S1cxI2oELfpyx0FgILJJt8tZVST4axjhyvvO74a4c/1SpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=iiitd.ac.in;
	spf=pass smtp.mailfrom=iiitd.ac.in;
	dkim=pass header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=WGLfZu+N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F639606A337
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 16:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F639606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iiitd.ac.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=iiitd.ac.in header.i=@iiitd.ac.in header.a=rsa-sha256 header.s=google header.b=WGLfZu+N
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4d30639709so219450166b.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 08:32:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794587571; cv=none;
        d=google.com; s=arc-20260327;
        b=rEQ/4XA6sc3VgtQ+j85NZaKh6cR14xkPLHZ/O2Ur+8fGjHna48cJCDwKTqCegGqc/V
         dFe4JnBkjPSc24Vzv+PyEK5DTv432RvVE1E6Ncy53tK9ZKEc8d3l6+s0WKJsY2J6RfjG
         DX0P5/vYGh5HNMZjiWEXeZxalRjZxdAepLmE+y2mB71/lT55dMm4xlV/MdjsvQHsujeS
         gdWzG3sWTFapRI/T9KDn53cOQj82xHJQOB5Cv/IzANfHFtQ0TOCXlM8vz6h//Ht0RK5M
         WAK+7xMEjz1QKSDHhCVW46g7nVpZxqCQiS7Mo0VSfdmyxOwcEtvkJac5SPylJotWHZlG
         D4Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OhQ4VvBeytePCKEBDRXAk9FEqcTaWFnpXRWzd42nCrE=;
        fh=XG9QD7pdR1hfuJqxXmEpqE81HFqAJ0mQMCjhgGFseqI=;
        b=f9QU9oLrXomsgo+vibTYhkpOTHQ8bitGUDbk6DPH66WQCNscT23wJqxDw/TP2TNnaO
         7IEr8+ReQEWrDsyKH0/kkwbHaSw14eKKOKAQAd6zXQdB//NF22CjVdeoM0f1I6Nvtct2
         38ZMs+6tpvxrIn/iJN4j/W8puSLxyUz1BpH3RSYGfxUXQey50Ft5ciaysJ7i//EqJk+D
         05+u/1bTP/fORsIHvrUviPb/OepWraTAtVTUrI3/7mHwgTuRBZ9V4cCkftLIxYH6SigX
         IqsIg7B7LiMH70/VVUt8xShjQFwbfFu1HeFcdkml5ML9lOg/LmeBCfgM/vv1Dala/tv9
         MR/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iiitd.ac.in; s=google; t=1794587571; x=1795192371; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OhQ4VvBeytePCKEBDRXAk9FEqcTaWFnpXRWzd42nCrE=;
        b=WGLfZu+NiPQoyA0vDbMykLD+krbRxp9B60Od8eNtRf0KH5qx5oN1mBHD532BaYYPLQ
         nJ3wGbxu8hRo5MUJ9jNyQN34I7wCzdffdgMt4QK367T0OJ7XTkkNQ1IV9pESwebmF/of
         q9UvfIlWaKbJPI01LWTmZYQkW1stEGqAXgdG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794587571; x=1795192371;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OhQ4VvBeytePCKEBDRXAk9FEqcTaWFnpXRWzd42nCrE=;
        b=mHRwsRVXFH0SEq70I5xnnNoSEH9GLyY0eGnPtHhA07JP/5GlTaXiJaWX2uEiS/F0e9
         fD4CxoXULN5lkqvuuSzZ3rBdQTtAy6Q6l+1JaXmXyogkbaWpJg6hBd+iIdI4CCWBAxpv
         t8jeMkhxQbzxeHDVFIXw/BrcyJ9i5A5tCkbGG0R9yA1O+PY1uoVA1E/T3Zvzq+0ItD/P
         TrA8WunLuH8wtj3QgKHAOELNRAshPbtH3vm1MYRkWBGWKIux+tSBUhaSNltXrqlo8M00
         8tSEaVZdz9Yv/kZXqt7El9h4p/uodbX5Y4zPB8GK1hzcrgWocK5lW+ewbhbPrb80srGW
         gqbA==
X-Forwarded-Encrypted: i=1; AL+hErFV9U40LksgmSomeRv0DN/qlUoFjnTtewJBGiWt7FUVbYx8sKdLtx1E4vdfsxtz8t1dvyMUGJ8KOWiFOHO4Om0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Tvqa9+0/okd4F0Ck6qwOAxBSWCF0TrSAX6E8ZifUZmRMECKdv
	mK6EDj9F/s6H80NSOX1cpX6EfCnFq6lLha68J1t1S98eFCjorf2kcbtT+5aUuOokEIh3QB1fChN
	Z1zqq0z75ihjZ4JAp7fZTsuLEW/K6v3UQDzSmetYO0A==
X-Gm-Gg: AYBFou1qsKMaj1byb7xLifNgmfqycRGeFxll/1fuAAbpnyz6kzMOJS3Zc9lSVfm+tyY
	ANF7Iy//ZwfEm3IbsmnlgiwjXDyPAaxqPZCfOZsol7LJZeW44/V+AU0wg2q8UxwNQ25MdYcc+Jy
	/jP1HxyfxQNSK0oWaY758FRDhTJxk6Sx+/YOOFOpBFTu02U3rxw7d7U01CM5T0OV7tzYQbxZ5Za
	ONoDGZkblx3L7jUvcHyedAaWIeXrDHSLjZugFd8BiW58CUxwVEjTbjDFEB5QQThSlPQwH5MM/9e
	s9Xn9K1aF66OZlO/pMdFqglMdrDUWJR88E+eXUXDC1gxRFaZOVcPx7TtmTiUPs+Rtm6FSHnqT6S
	0S2T46Dj5zO2sNqyFJq7QV0l9FpwTvnDUCD/cpNbsJKsJ+rwPSdzAI03WFw5ejARYRCW+dDhiEd
	AdoDggNej0aZP8YmZpr263VZCvyBJcIOaWJx2/1B6jKrgxmaen/jQug1w=
X-Received: by 2002:a17:907:9304:b0:c46:9ee4:8f0 with SMTP id
 a640c23a62f3a-c50963d470fmr304538466b.10.1794587571235; Fri, 13 Nov 2026
 08:32:51 -0800 (PST)
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
 <CABBYNZK4akYzoWc97v8FTXc77+godNTHASn8ZnfNji=jPd2oiw@mail.gmail.com>
 <CADq=QSz7GMXXjsykU87=6yCcWL1QX3NVOpxjQpJD3T2KG-nssw@mail.gmail.com> <CABBYNZKeBYiJTH6m+yo5bqfpmVO6cpqLcz5ZdQ0xvw5kjnGN9Q@mail.gmail.com>
In-Reply-To: <CABBYNZKeBYiJTH6m+yo5bqfpmVO6cpqLcz5ZdQ0xvw5kjnGN9Q@mail.gmail.com>
From: Piyus Kedia <piyus@iiitd.ac.in>
Date: Fri, 13 Nov 2026 22:02:40 +0530
X-Gm-Features: AclHuK988UL3AkRvIvimRf7f5ka9T8GhR_5iJfAVFt9_JRB0HJ4AO-rpsVa8HZE
Message-ID: <CADq=QSy6Z_5Zj92mQQZzOCNwYpEa0eXHY7DO685koCPEJ=0CBw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: clear the SDU before the receive callback
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kapil Vaswani <kapil@presceralabs.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sounds good, thanks for taking care of both!

Best,
Piyus

On Fri, Nov 13, 2026 at 9:53=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Piyus,
>
> On Fri, Nov 13, 2026 at 11:20=E2=80=AFAM Piyus Kedia <piyus@iiitd.ac.in> =
wrote:
> >
> > Hi Luiz,
> >
> > Thanks for sharing this!
> >
> > On the double free: that free isn't new. The block this patch replaces
> > already did it,
> >
> > failed:
> >   if (err) {
> >       kfree_skb(skb);
> >       kfree_skb(chan->sdu);
> >
> > with skb NULL by then, and l2cap_reassemble_sdu() has the same block.
> > So if a shared skb can reach the callback, the existing code
> > double-frees in exactly the same way - this patch neither adds that
> > nor fixes it. What it fixes is the use-after-free on chan->sdu.
> >
> > As far as we can tell, it can't be shared here: skb_share_check() only
> > acts when skb->users !=3D 1, and nothing on the ACL receive path takes =
a
> > reference - the only two skb_get() calls in net/bluetooth are req_skb
> > in hci_core.c and req_rsp in hci_sync.c, both on the HCI command path,
> > and
> > append_skb_frag() doesn't touch skb->users. We may be wrong about
> > that, and if we are, the fix belongs in recv_pkt() rather than in each
> > caller - it frees the caller's skb on one drop path and leaves it on
> > the others. Happy to send a patch for that separately.
> >
> > You're also right that "frees the skb outright" was wrong: recv_pkt()
> > consumes the skb on its success paths and leaves it to the caller on
> > most of the drop paths. I have a v2 ready with that sentence fixed,
> > but the diff is unchanged from v1. Please let us know if you want it
> > posted.
>
> Ive sent a fix the 6lowpan, so no need to respin this, I will add the
> missing Fixes tag that sashiko flagged.
