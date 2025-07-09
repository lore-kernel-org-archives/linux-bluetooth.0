Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8982DAFAF
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 12:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752065629; cv=none; b=S7XOqxes1toidy6q4I7MymP6TUHetcWCJx9aqmjDWC3VcXeqpj2idNliN6tSe5nyjAAs++cvdUnwzRZDwl+++JLVrntmnnufK3u8jUMCkjDl9UnNw255bHKPib9MyBFEs5o3D1kxS7layXflv0h5pD8ByLZX1s3/Bdib1CDS6H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752065629; c=relaxed/simple;
	bh=ZJXSMVp2sxuRhpQ5h/qL6mP3YeWK1vUQLlkLamatXXM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d5lBWJkJIj6BZhqvqFXl1B8sKqlasWM3oSAJmb9RaLPncSQ1kX39vj0tik0APQR/NqnNRcvND8Z8sxP0+b/RT2avKOrsmtqg42s72tJ4yO0hNbc2EcF8UindC6ETepUVrny6ovUuH7uijz0t880TBHWbyb4gIKQvJNIrep0tCSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eBIPsBJi; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBIPsBJi"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-32b435ef653so44743211fa.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Jul 2025 05:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752065626; x=1752670426; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UVOnVJCZ+8RW/oEl68yN8Tmu1Ljhi+/eZzu8p0LIFY=;
        b=eBIPsBJij4xDu9SS9xji7+sRix0SS6Ow0ApLSQkv6g0+F3Zp3PQ3yN+Lv2F4m+EJqG
         SSRTXQTHgyzJfZjFl1p0DtKghGCu3OGQREtoiut7dvK3EWNE2XnkSsRc2pJpTCydtcim
         VngUNErjPaizNqDkAzTjlvi+2U4Xj97f60CBw6HVmv095z62zfRikmXq7UkUmJ/4wRWl
         XcUnyj7rdGfa5R2eBQxEx+pAJmvd8IfvsyLG9p65fzajlKcXJK/VZFIN8yEv/NIzHbOM
         Oc0vZt3iTcwOLe/gfuQwSZGTyvrvT1YVAgEHNtxGL4yerxKrTF8yEBYJKb6Z4jdTNTv6
         4roA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752065626; x=1752670426;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0UVOnVJCZ+8RW/oEl68yN8Tmu1Ljhi+/eZzu8p0LIFY=;
        b=kbhFjhqVA6mXONuGoJY8EZECEhrXEO2QuCeM3/qAzgxClsmM6vM+gbHvq7hpkieA0r
         Sx/v5dqdyAM2kaj06hKWDrSqcwSag/Pb+dI3jRQC1wnlE/Z7OGfmuXhme57gzGaBvwrK
         M7+YNbY6pSOWA2LE9IK30hATo0TAg0qdXKHymwf2m55/UUz0plDBo2WoGRm8KTEqfUks
         tKptv1y/3UNVvSDlhEelhYC4Rf3gPuuRcT8DhwOvhb6i2YS5fxOMuRTk7O6WUsz13MCZ
         KEpkQrOqP09T+yrI/UAAT3C/s1GNeiSAK8MdD9hFImXoVwB46/XZ9U8Nu6lMvP8poE1N
         QmmA==
X-Gm-Message-State: AOJu0YzKX7D6HpTlfbnTHv5w65/BVQ+IqLLE+dl7wOQaBT/CvCbrAKDt
	Od9u2nti+PIm6iMeYOqH6QWN6iK0xkSaXr/oSzQIPJAUBxKlKYCr0Q8L1k+ymhS2jxfFKsY+dEM
	h9NnGiUpht8R5e1E2manNfVDR/QeEr+9z2TqyUy5Wag==
X-Gm-Gg: ASbGncsmvJoMIKtZW/7sD16MSOgbpvfNBAWKz5bc+gXwwM/ygQ0L8vskuBDaQqnTGjy
	vxYXCwBXMdgH+BAVmknqEiCGhQVKNmB2w4HkHJTIRuhdWmEgnA0nfu3f3u7p3RcmHnCIfDbDJPQ
	bYUAUe7mbxpjXmJM8blOuGfe2ZnlTSbxJ75PTiPn3xraQ=
X-Google-Smtp-Source: AGHT+IG/bfD8tAswgZmza5l1/uBRdqk3/bJl8jWW86vzJTHEd9X9nXqR1vK4vJwvzDv8QP7O7uXkg5/WXQ6+fTM02bs=
X-Received: by 2002:a05:651c:40c3:b0:32a:7d76:2642 with SMTP id
 38308e7fff4ca-32f4836088amr6078421fa.2.1752065625478; Wed, 09 Jul 2025
 05:53:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250709121852.2811885-1-i.iskakov@omp.ru>
In-Reply-To: <20250709121852.2811885-1-i.iskakov@omp.ru>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 9 Jul 2025 09:53:32 -0300
X-Gm-Features: Ac12FXwBbB0t67NhOGALAwEfgtuHI44zi3KX6xfjstxpcoil_EtscXuRSiGfM1M
Message-ID: <CABBYNZLgE9Pq+KvxjgDtMYqh5qZix0ZtTPTW-rfXN5aushHTqA@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 0/4] Fix bugs found by static analysis
To: Ismagil Iskakov <i.iskakov@omp.ru>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ismagil,

On Wed, Jul 9, 2025 at 8:21=E2=80=AFAM Ismagil Iskakov <i.iskakov@omp.ru> w=
rote:
>
> btio: fix range validation of security level
> Expression is used as an index for accessing
> an array's element in function 'l2cap_set_lm'.
> This expression can have value 4, which is out
> of range, as indicated by a preceding
> conditional expression.
>
> profiles/audio: add nullity checks
> Return value of a function 'btd_device_get_service'
> is dereferenced without checking for NULL, but it
> is usually checked for this function (28/35).
> Return value of a function 'queue_find' is
> dereferenced without checking for NULL, but it
> is usually checked for this function (182/183).
>
> src/shared: add nullity checks
> Return value of a function 'util_iov_pull_mem'
> is dereferenced without checking for NULL, but it
> is usually checked for this function (64/80).
> Return value of a function 'vcp_get_vcs' is
> dereferenced without checking for NULL, but it is
> usually checked for this function (4/5).
>
> obexd/client: fix err condition causing memleak
> Dynamic memory, referenced by 'err', is allocated
> by calling function 'obc_transfer_get' and lost
> at bip.c:139.
>
> Ismagil Iskakov (4):
>   btio: fix range validation of security level
>   profiles/audio: add nullity checks
>   src/shared: add nullity checks
>   obexd/client: fix err condition causing memleak
>
>  btio/btio.c             |  6 ++++++
>  obexd/client/transfer.c |  2 +-
>  profiles/audio/a2dp.c   | 35 +++++++++++++++++++++++++----------
>  profiles/audio/avrcp.c  | 24 +++++++++++++++++++++---
>  profiles/audio/bass.c   |  3 +++
>  src/shared/bap.c        | 23 +++++++++++++++++++++++
>  src/shared/vcp.c        |  3 +++
>  7 files changed, 82 insertions(+), 14 deletions(-)
>
> --
> 2.34.1

There are some coding style problem catch by checkpack:

https://github.com/bluez/bluez/pull/1413/commits/b55a78ea5a866b48d8051fd9a2=
e15d2abc1d15d3

Please fix those.

>


--=20
Luiz Augusto von Dentz
