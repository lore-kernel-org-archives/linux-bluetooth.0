Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013962D6E72
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 23:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769641533; cv=pass; b=nNVjB4H2E2IM3NV/q/iEIiM+BkVxtb3Yp5lMF9QEl6q8xAqv20YwOxvJ8xlmG9i5rTWf5A/Iu14rSqmgemL/j1nGuQcC7hXsSsjIztMNqBskTYzTup1S82dYqJQp5XFx8AKDH/ShqwDJCNAlPnVutA9kkQgZVnIYWCeN7Dmd7qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769641533; c=relaxed/simple;
	bh=BJJ5EyAULyT29APIYvNRD7OK/3b1aB/bKnae6dnMGck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LswKy78KHVnIVyTF6eub5h/b5HqLw1kus1kzZlE4BiHxdQYzs9Kc14NE7BjKrNr5g+POTzbo+hcd3WjgdJO1kVUuh0Iib8F/gY2q6TqscC9+OzKW0WzuxuSKvmVUKuuNCqY6ugHzNNFoAsVL82QyH5zHBow1Pl7Jaw4ynIaveUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=klNhEogQ; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="klNhEogQ"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79456d5ebf9so3680467b3.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jan 2026 15:05:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769641531; cv=none;
        d=google.com; s=arc-20240605;
        b=edfaDMlJP+0JN3yajPaFN2110OoNVyVi9n+BkCZYoJ1tdK1oTcW/vIE4goig/tzmHI
         019mJiInaxu/pggqCUftjImtpUE1Gl5Tv4JBdTNm8AMMM7QmzeT8+bpamK9MtZv79Wb9
         RIVL2qPKFURgG5otVoATYRHWlN9BzI/qyJwHu/s1VZ3jCGPGb2I+t6F3HlfcytQsoDyE
         4NMo79KXVPaj5Fs/op81p8OAc+KQd4OVEsuwWUi+jtE20w2gVyqgwESfzLvVnZNIjmaV
         qgijIqEB+Oe/LGVDCNvGIlP/e48TigfrCKs5wF1Kh5mk+fqVHjZYdZkylPsjE/0MwS3c
         Soyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GXfstxUaPHdoMELxydVw3jERoCwNn5zjB4l5TlHmHog=;
        fh=DBIRJP4DvnAE+M31BcQ50XI3CAn/idN52/MNTtsfw9E=;
        b=DzjCQjgLq6vowXArnAvlVAixOgC6LpmY6JHPvAYxxYYlxTlinOya5kAAYSh6c0Vl7Q
         MCi9ai7tJjlyGGUPKvRl2ak7gAkLEAEW1KJ+Y0XnMuVMiNjNvQ4Etu502LbD76+qCk4j
         a50CkjO5KExHu6QJcgSNZPtV54H5MZVGj3tfc8qXbeeoo8slztuVa4W35XIX2MXSwfHZ
         xSIDWpE/Km0T8dDDp+MSHyvYFIyLHG29AgSciM26ca7tCOtdi3btSCMvoyhW0WZBC17Q
         3UK240wDL8pkWTrh37pDjI38dxDV9BJBrBnZhrI/HmHoVJUuSC3p68WbG0nShhNq5I0b
         LOgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769641531; x=1770246331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GXfstxUaPHdoMELxydVw3jERoCwNn5zjB4l5TlHmHog=;
        b=klNhEogQvc7emA16lWAaMu4FIonBz93IFnzOm6KA4WYzw1w/B0kZUuazdYabWQxd2h
         evR4NHo9pubgmEyJfIngi8+VbOTucAapjgfl9fqs/eXl+R8uPFdHHYU30DpB3cTB1AeU
         47szQU3vYWmbx5juTz5Dc0sKZvmU29fP4fvHbwnftMurHlYn5QxdV9fcm96LKtUXYhhg
         KsZExa4HQKtjnaMc/ZZYx8+7LHs6t5XN2ps4MuLzEESLf4rWI1zfOgqc1D7sg9ycjoHW
         DFUKNvPW7CH/po3tEIiat3f8lISuJ/QdTDhMlI6BzY5hApU3mJMiy0OdBL3jFsVUYWG8
         zcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769641531; x=1770246331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GXfstxUaPHdoMELxydVw3jERoCwNn5zjB4l5TlHmHog=;
        b=DiOLeOgBHBAOvReXTCJYDhGIqFf6lhjrSD/VQlFOdMqP6C9ydGi612PWonbOnc6HY3
         DzMHIu7cDDGC815ZQ6AVq0o3Ws9rO+JdH4w1N9ZH2MT8XL//pcGBF2K1EDdDlPVRNNt5
         yeCETC0TGcgbG3TAscs/+ooHF3MTe92yCd935HVDHkfipjzJz/9Z91dVOrVP76YEKByz
         zAf/UvEG+AKxbFyFnhfyk69DKNOSHZ4Gu85Ju0RRMVBxdX3vBMPpVpljoIYy1qUWTlw7
         DCTOrMhVtMnP9zOITNjk4Q09/bHua41PbN1jbemkZzFSRwVTlUmKH08vVRdpc7IUNULP
         viAg==
X-Gm-Message-State: AOJu0Ywep3auWeZPtKjgH+w/gjBmASHvuG1effPnqVXXPog84a0QUkJT
	rjRFQ8jcTNFuZ9COb2z6skuqQ8CDI2UchK2uaGEwl4/W2GxF3gIkQvHioVH4Y8OdmTZoxy+ghWu
	RqbJ4r3AQ5u4XskJzJ5/rhoGSnO8zJw6NGA==
X-Gm-Gg: AZuq6aK7MG7D7xwB6WjQPI1A4sRE4lPhWtnDP6osPnyq8o6r3Omna9wn1IVYD25IXej
	zwpdvclyGgYs/THI96BEJL54v3JkCeGeZAmqpKCtblz9CsBHpEB6jlkxG1NcDLS+r3vi0x/zpvb
	A2zCvR9ULa1NsMC44tc1vaoSECkOGGdkXQvaA9ljNr+ZbCokVnumf9yK7ZV8Uucj5LXDHwLeo2Z
	OnUp8AOUiv4tKC9o+VKZKDfMxbyQqVv8XZN7nByrVXve3ODerESzZktM4IbPicXisufMRH8BwmF
	T2vI5D/usFUCvcfxQ60RhK8fhpkfM/P+5j2UmWb1Qg5LdDNAhTJdNU6ZQkN2OuGSgUM8
X-Received: by 2002:a05:690c:6a87:b0:794:2c3d:792e with SMTP id
 00721157ae682-7947ac1a662mr57137497b3.36.1769641531018; Wed, 28 Jan 2026
 15:05:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128183454.545066-1-luiz.dentz@gmail.com> <20260128183454.545066-2-luiz.dentz@gmail.com>
 <a19a6b2cc4b6639171f9c0588b2efdd99101259f.camel@hadess.net>
In-Reply-To: <a19a6b2cc4b6639171f9c0588b2efdd99101259f.camel@hadess.net>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 28 Jan 2026 18:05:20 -0500
X-Gm-Features: AZwV_QiP3ZXcMFx7JAyQfKf3yv_rIv_mlvbSssIjZadtXZ0ZYxqfH8P3pX0EP98
Message-ID: <CABBYNZJ=3iRZi8jxPPwWtHNqF_sNObjpy9vPgVGqYtB04Os_cQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ v1 2/2] build: Remove health profiles support
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bastien,

On Wed, Jan 28, 2026 at 5:58=E2=80=AFPM Bastien Nocera <hadess@hadess.net> =
wrote:
>
> On Wed, 2026-01-28 at 13:34 -0500, Luiz Augusto von Dentz wrote:
> > From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> >
> > Health plugin hasn't seen any updates in decades and most of the
> > industry
> > has probably move on to LE and GATT.
> > ---
> >  .gitignore                    |    1 -
> >  Makefile.am                   |    2 -
>
> There's still --enable-health in the AM_DISTCHECK_CONFIGURE_FLAGS in
> Makefile.am
>
> Cheers

Opps, thanks for pointing that out

--=20
Luiz Augusto von Dentz
