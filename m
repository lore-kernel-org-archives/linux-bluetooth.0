Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793780688;
	b=Gp6qugcBif1MJLVg5qFhqQZaT+3Lfy1/bA+b2iQo42OV4ZvYMor+DRyV6yMwB+idh67c
	 cBnLo0b83ojW2UtUUO16tP2qqSgSRexgZuc62CCLletJFQdiQpF1Mda++DMa69MUfPCbV
	 fhIfecC3d9CcaxgsS5p8d5vo5hnLPHuiBEdcL3Aehkyvyp1Ht53oV1eU865ale84O2Lp8
	 jNUKWbSd0EvmCHhUDXnomm0cZmInsSVzp0vzuvI/VgSSa0Rty7KaxObzccEae2sPs1cbh
	 iz1SJaXficPKRQvBHybU07Vk7t0QlURO0bYCvZEafaI46vdHEkwWwxugzi7lGcNFu0A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793780688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+GDlXWJUsYv47EeExLeI8zNRHRArPEHoLs9WQdDARCo=;
	b=EdmlrPqLmFt1+gCVEDGfTuoB0FU3mb15luiyJgfoOKkbvE93DNj5fygo5H3nFh7zpF5j
	 mjFxDkKYIE2JJ1tFJ+lYZ/f1z9cVhJlmihAwIO2SNQm1CPjH1KVlIU0+buQr5iwuXzxuA
	 EPdWS81elsRMDdO6jvFcXm2IlGxmz3O3jAQnmnZ22I4zkjHCe31qpLVo/8tj5ArswzAcL
	 N1tnCXE16HvK0lqbDjsbbGWX+cW+VjrLTm65+2hgoA3YUgtZRTK2me3kwsDBDGBJ4sFly
	 ZwZwQuuVsqtb8Vz7Z3VmLOQ9oNuMvnJ5jtalmZXzACARPjYMcrLqGWZ4ikRZQSqO2NA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dRWBnV3N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6F7606A326
	for <linux-bluetooth@vger.kernel.org>; Wed,  4 Nov 2026 08:24:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BE6F7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dRWBnV3N
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c347be93d54so7267966b.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Nov 2026 00:24:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793780686; cv=none;
        d=google.com; s=arc-20260327;
        b=oaaDGuiiktf2prvaLp2KjzuqHjVjdLlJWpUvuJcKvCQwjZ6MI5s9qXq9qWBhApN0XC
         IdBld9305MvwG+Jgp915rcqVzkmsGSG5WMxPilyp6qnwVu/WisTWOda/R7n3BV1uETJu
         RZa8es6UsgfgtosNLNvAmZ4FxsTCkuHej57dKQaKP2APUgseOn+YeVAqWKkM1hf+srLa
         uj9GZt/X60jvSZ2uif2iF+4g4H1nSz3QiLWmBzjBhuVO9vlfZRee8zOrl1F6fP9zWmBi
         ppvjz447QHsEGSCRGeBr9PbI+iPDJAyaKoySJgKFoih1wfI15bT0bzZTpioWR666bURT
         i65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+GDlXWJUsYv47EeExLeI8zNRHRArPEHoLs9WQdDARCo=;
        fh=npLmsmpQrvfY2L2s9Y29xuqh0TY3SlTBkcxu9XePD5w=;
        b=VBVXNaoJeJj8x66PekZ8pDO8HZmGbdp1L9G3WS1kbuPhM5pAz20gJnjm1tpqDcAF4L
         0YVJqulNqvhWeFzyCZgP2tdQhi4ygiMUvRIJ+sRkqVpu/LKz3zIGfUOJ6g5W1Td0OeMT
         6xw6K7M8SSJ5doKnurs9q3aKlbTEl+rqDAeq29c846r5gk28fOxQlmP1wy5Zcq+ege8Q
         RpdcGY7ZpRuRH1jy7Jp4tW/DQBo+Z0SWU0AUrzA2Yuqy4R5NvJttMumn3YADh3OXGRxh
         bnpO/LBEXO/5yCVyhpr8OfC86MfYyxU4IE5hjHLz3zg3MRagXHJgxkd5J5c+37DiLTN3
         Gdww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793780686; x=1794385486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+GDlXWJUsYv47EeExLeI8zNRHRArPEHoLs9WQdDARCo=;
        b=dRWBnV3Nh4PROZw+QpcipQd8jacvXRo2SiAcx9F0GSEdnpef5TLxpdLLHcOI+znKWY
         BwxU4N5boHG0FVdrA5NGjzperhdOTlthNJYkBKDPeJjJJlK/Xy3MsYjYvou4iiQn/Muy
         BvW7x+H+H5MtnI3bE5tIcddZ57QmqBsBD+2NLCVJzKJ6QDMyux2+CrZGTOvgnnPATyZd
         Nyu+PUiRFhobHG+SXMjcb+LWhkhwkxu+zzxw9+wcf9uupVgnMei476FWifQaR6mIKnl+
         0jZxMPv6CFYG9Zw9OhpWuoGgdqlzXr3zpktswjfN83Ng2hNmXg7+6bcQF6ZJfHo350I6
         UILA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793780686; x=1794385486;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+GDlXWJUsYv47EeExLeI8zNRHRArPEHoLs9WQdDARCo=;
        b=VU5YwQPubNHWSthZ9kgxWIKDoCyyoEBCnK+KlZfBGYBzsgF/Yog2JjAAaYjleJtKNG
         XB1JrClJbjHJF2cGlqOlxLv0GWNlLSJPXo1gI4crDD/+IjyEru0SAeJVqm1KmVw3S1V5
         qWtFho9dTSAO3sR9GKJJjxlEeDIuAxtBcJtz7Nf48HN3gB5Snnn/+gzuSJ6J4twMSWIi
         0l0rhkLN3GtJMms9gcNlc9hHbk/wXyJ37Eo7zwBT8OwOE03cKcy3pJh0aqp5CZXZ0OHa
         2fgnRaaYBfZPP1SBtYDajEorlSpZQswyjRyodxhNiQixs9Zxs6wbOYy4DZwgnhEKyS/5
         tm3Q==
X-Forwarded-Encrypted: i=1; AKwUvBzkq5FHxUXW/EvgFxsHPql0jiEkErrTHPRv4qpqUmoCcke2DbXkI9kEXosWUJ/7QVpTJPb+vXlNLJXmKpYbPXM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EIL/H0kbw8Hfr0KjcPnD59GLrhNlrzxLmudhCMnxSE9o81DMs
	XcSC45g6GZ0Drx85UzY2tLhbhBd40X2jAm+17vfIfFSf8li/CkDnJDXyrImQ8CiEdl+09BPeX3+
	J0y5ryZdlCQZtOl6kUeTIEi2m0dD9lCY=
X-Gm-Gg: AYBFou1GWtC1NkGaOXeVt68su/pa0Lvem8mvvXuyaM+k7YmAmqRrXrRyYIy/vkAHxgX
	PlTytPfmEETiE2KLezQOpuPG75EJDxPMP3nm+lnmIC4BtHToQt80MbCf7+6fbdNp2Za/+rIlZ3U
	HloRYxEvmK03wCDy1yGMv1/vuWcXJmhDoZzrUnCtgfBMCo5pAcF33NoYMksX1Hi8QV3vnarTVPr
	w9YEr6eCq7336rhd2lI6EoS2PdjzLhxo6WVtdT7lkFo5fRtlCa4ZEkJCUzDxEbiQf0U5HWEf5nE
	6pbamlKWKORphIR4nP1ovanvJmePbDycAHjErF69x8VdN0nDQQpfHFwQpVEYaUSLgSFp2eae+y3
	hAC6Ck7LJTdqVeTDsU+rw2x+lHzgH+sB91VoRRNXPrQMPMl+2Mg/IAn0kFo9rP1+6c6c=
X-Received: by 2002:a17:906:6411:b0:c42:e6c8:e45a with SMTP id
 a640c23a62f3a-c4ca7a4c8b9mr1386970366b.3.1793780685708; Wed, 04 Nov 2026
 00:24:45 -0800 (PST)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179376960391.50454.8822263457423416137@gmail.com>
In-Reply-To: <179376960391.50454.8822263457423416137@gmail.com>
From: Chengfeng Ye <nicoyip.dev@gmail.com>
Date: Wed, 4 Nov 2026 16:24:33 +0800
X-Gm-Features: AclHuK-R2OdQr1K9gGtBoNEjfvIOvN0HOzedAfw3-hfWuJgFyYUBaWV7yfFSPt0
Message-ID: <CAAo+4rXReQNa8q1_zkHn87thQeSLQHyPhioCrDbT_1K8L=rQSw@mail.gmail.com>
Subject: Re: [PATCH v6] Bluetooth: hci_conn: hold a reference for LE
 connection timeout
To: Yaohan Li <shunsheng1218@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yaohan,

On Wed, Nov 4, 2026 at 1:20=E2=80=AFPM Yaohan Li <shunsheng1218@gmail.com> =
wrote:
>
> Hello Chengfeng,
>
> We independently reproduced the LE connection timeout use-after-free
> and tested your [PATCH v6] ("Bluetooth: hci_conn: hold a reference
> for LE connection timeout") on a clean Linux v7.4-rc1 tree
> (6628e7d4c6b2).
>
> Test setup:
>   - QEMU/KVM, KASAN-enabled kernel, /dev/vhci virtual controller
>   - Management SET_ADVERTISING and L2CAP LE connection
>   - Kprobe-assisted timing injection at le_conn_timeout() entry,
>     50 ms park, with mgmt disconnect at discms=3D2015
>
> Results:
>   - Unpatched v7.4-rc1: 42 slab-use-after-free reports,
>     with the first relevant frame in hci_conn_failed()
>   - Your v6 patch applied to the clean tree: 0 KASAN reports,
>     with 200 confirmed probe hits under the same timing setup
>   - Control run without injection: 0 KASAN reports
>
> This is a test of your posted v6 reference-counting patch, not
> merely our independently developed fix. The result supports the
> lifetime fix under the tested interleaving; it does not establish
> coverage of every Bluetooth shutdown path.
>
> I also confirmed your analysis that a naive
> cancel_delayed_work_sync() replacement is NOT safe: the mgmt
> disconnect path holds hdev->lock while calling hci_conn_del,
> which would deadlock against le_conn_timeout's hci_dev_lock
> acquisition. Your reference-counting approach is the correct
> solution.
>
> Tested-by: Yaohan Li <shunsheng1218@gmail.com>

Thank you for reproducing the issue and testing the v6 patch, the
detailed results and your confirmation of the locking issue are
helpful. I also appreciate your Tested-by tag.

> We can provide the full console logs, build configuration, and
> reproducer details privately if useful. The investigation was
> AI-assisted, and the patch application and test results were
> reviewed by the human tester.
>
> Best regards,
> Yaohan Li

Best regards,
Chengfeng
