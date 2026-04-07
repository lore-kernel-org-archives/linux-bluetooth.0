Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA702C0307
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 18:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775586346; cv=none; b=f4wpT9RJQ1ePKZqqRgyRn5BfsKojpfUlxP8ci1brzokVMvffGd2HqFur6li6pIRGcDxZrB3u/7ha0bI7f33qM4LU75YskfxxHZjEq5hnnRb5+ckVSOBKt7tV6iQkXXb4S0wEym6IiDePdJ0OaVUiiJugAosWUwXAU59IQGrkElM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775586346; c=relaxed/simple;
	bh=fIHQNLFLDXKvJ2osiz+LzV3miWUwwvX0QAPWHwWNNAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=It9H/KEizmyBL13zHZVOIYIMXKerZ8JRjwEO1JQoQ+Rq3Xa64dJVHHbLN7HMYFfQ07f7iFWrAx+ZOFDznNGqKJ3FsgyBK4LV+eu5Pdlc18uymG0hzPHGP8fki+T0pxzafaK12A++dHvmE2kOMbqi3kM03//R8gYhLsc9c91jyVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kRa74Wlu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kRa74Wlu"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso2166885e9.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 11:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775586343; x=1776191143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+WrARU3H5Z199x4U5Iol6cO9B4Dhw+DXctb8Kf3HRm4=;
        b=kRa74Wlu6aG4Sip5EczaQzNGeewYSQ6i7GdMN3mquapbuqbeAUzvG1JCHLN8999Aom
         lZRg69kAZjRrMo7sRWRTf6bdeRsmHCfgKkgIiuUzpD/82ihJ/twHmNoc/EkuISlxF8+8
         Jtis57CBGhrU6oSZPgHEHV0vcBFl+vQPizOsP8/6mZspDk+PY5xIL+qZ5Op23U+UcTPb
         gP7/wG2zrFEPGXX+BKIU9GZNTmitB58fGobCO9QFPlC/WUKZGUXuT2qQPDvRxTxtjhzT
         qxWvq1szvQ0wDqvvJ1ZN+gX5rL0sTJX6oLPI4mqGTHiQRHfIOatTHeBP752T2nUc1MQt
         rRgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775586343; x=1776191143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+WrARU3H5Z199x4U5Iol6cO9B4Dhw+DXctb8Kf3HRm4=;
        b=EzXS9H9/YomEwuAy5OtgGVziO0YbzuIzU42kibR6Z87AkDPmSy/k/0S67yQyrquaDy
         6HX7EOzIfYv0jNXErOIVxsr+yTeSp5oVIwJ1W7RE4dfZNHrchhMts/mN5YfuuIc/y24x
         fO49qdxopGzr7I9c4iixi3CWv1KlU+Ed1xSnUhHerE1CdZJt6IjDE3ihbOhQFBvIBirY
         tpRajcwReF2OY58XGnrYG4lOR+bjJFwDvAvh1XXSmyYyZcuCoXfYAiUXDV4scGNawM1z
         2m0fwMzOwMVHSOTgDS+dkohYDXlNGIDVDpL1XTXvFSD77kotjMsLzvEFNWygS5yVLSKb
         mzPA==
X-Forwarded-Encrypted: i=1; AJvYcCUDlA/ZYlZ3KvH2AC2yLm3V+ffFfz1259EdOezYNT95Kn0ojVRJ6Tyj4ktjebPWLr54Oim9Q3DgVNcTRpFqkKU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/LZBXaK4OtBDra6CGMCHCTr3rAZsTiabt81bf55wcNBF/CvWG
	2LQOWtwC2Pibf3J7D+efkZuyh8acSKqQA9+muNkAXz9Ot8evjqZXTVK/
X-Gm-Gg: AeBDiesTRg+j1MGr13YuTug/ABlwFYKvhx4sajgrYD/abDlDaW08uwREy8mTQRjrymp
	xna0WluhSMGj6xHu6Fq4AKvQmfWgALkjWozkHJhJircRKmLLn5p0Xp09FlIc1Ag22yBa3Ok7+Xt
	42akbGYsget8uX+xz8J9jRhZo/9nhQDKBd5rZkGEeXxIWZqf2TUkZW/JFnfZi3GSLlWklFhdQjI
	D3b5FAo0E2pLblYINAkLSDXA9LLs/PcQ+eUxzwEfAW7fHGLsqX9oBxyw265BlpzcGB1kdUojipo
	cReFeA3HEhyHtSNimAzKvh6vhuh25yVzIjBMydYHAcapqW+xkcGrO6aHWRwrjItZxQdnBwJrcjc
	eAm22tIMHNMRNaIa65POm0Llo6FxkEMPMWAG2Lh4aZFw9FK4BGjgo7yu7bsQHfnoJqecluCJK8t
	66IuzfvN1E45Lak4c7SEJ0iYwagmah4p4CQwfo9dnd4ch1W8RL5dEAlYE3DWziEOkM
X-Received: by 2002:a05:600c:4930:b0:488:aa33:dc8f with SMTP id 5b1f17b1804b1-488aa33dd7bmr93707555e9.0.1775586342522;
        Tue, 07 Apr 2026 11:25:42 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488b6ff70bcsm256033525e9.14.2026.04.07.11.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 11:25:42 -0700 (PDT)
Date: Tue, 7 Apr 2026 19:25:40 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Stefan Metzmacher <metze@samba.org>
Cc: linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>,
 Dmitry Safonov <dima@arista.com>, Francesco Ruggeri <fruggeri@arista.com>,
 Salam Noureddine <noureddine@arista.com>, David Ahern <dsahern@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Michal Luczaj <mhal@rbox.co>,
 David Wei <dw@davidwei.uk>, Luiz Augusto von Dentz
 <luiz.von.dentz@intel.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, Xin Long <lucien.xin@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Neal Cardwell <ncardwell@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <keescook@chromium.org>,
 netdev@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 3/5] uaccess: add copy_struct_{from,to}_bounce_buffer()
 helpers
Message-ID: <20260407192540.321f3879@pumpkin>
In-Reply-To: <f29570914590c50b9b6f451eb3a38d0fe1d954df.1775576651.git.metze@samba.org>
References: <cover.1775576651.git.metze@samba.org>
	<f29570914590c50b9b6f451eb3a38d0fe1d954df.1775576651.git.metze@samba.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Apr 2026 18:03:15 +0200
Stefan Metzmacher <metze@samba.org> wrote:

> These are similar to copy_struct_{from,to}_user() but operate
> on kernel buffers instead of user buffers.
> 
> They can be used when there is a temporary bounce buffer used,
> e.g. in msg_control or similar places.
> 
> It allows us to have the same logic to handle old vs. current
> and current vs. new structures in the same compatible way.
> 
> copy_struct_from_sockptr() will also be able to
> use copy_struct_from_bounce_buffer() for the kernel
> case as follow us patch.
> 
> I'll use this in my IPPROTO_SMBDIRECT work,
> but maybe it will also be useful for others...
> IPPROTO_QUIC will likely also use it.
> 
> Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> Cc: Dmitry Safonov <dima@arista.com>
> Cc: Francesco Ruggeri <fruggeri@arista.com>
> Cc: Salam Noureddine <noureddine@arista.com>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Michal Luczaj <mhal@rbox.co>
> Cc: David Wei <dw@davidwei.uk>
> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Xin Long <lucien.xin@gmail.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Neal Cardwell <ncardwell@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Aleksa Sarai <cyphar@cyphar.com>
> Cc: Christian Brauner <brauner@kernel.org>
> CC: Kees Cook <keescook@chromium.org>
> Cc: netdev@vger.kernel.org
> Cc: linux-bluetooth@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Stefan Metzmacher <metze@samba.org>
> ---
>  include/linux/uaccess.h | 63 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
> index 1234b5fa4761..a6cd4f48bb99 100644
> --- a/include/linux/uaccess.h
> +++ b/include/linux/uaccess.h
> @@ -513,6 +513,69 @@ copy_struct_to_user(void __user *dst, size_t usize, const void *src,
>  	return 0;
>  }
>  
> +static __always_inline void
> +__copy_struct_generic_bounce_buffer(void *dst, size_t dstsize,
> +				    const void *src, size_t srcsize,
> +				    bool *ignored_trailing)
> +{
> +	size_t size = min(dstsize, srcsize);
> +	size_t rest = max(dstsize, srcsize) - size;
> +
> +	/* Deal with trailing bytes. */
> +	if (dstsize > srcsize)
> +		memset(dst + size, 0, rest);
> +	if (ignored_trailing)
> +		*ignored_trailing = dstsize < srcsize &&
> +			memchr_inv(src + size, 0, rest) != NULL;
> +	/* Copy the interoperable parts of the struct. */
> +	memcpy(dst, src, size);
> +}

Return 'ignored_trailing' rather than pass by reference.
And this is probably too big to inline.

	David

> +
> +/**
> + * This is like copy_struct_from_user(), but the
> + * src buffer was already copied into a kernel
> + * bounce buffer, so it will never return -EFAULT.
> + */
> +static __always_inline __must_check int
> +copy_struct_from_bounce_buffer(void *dst, size_t dstsize,
> +			       const void *src, size_t srcsize)
> +{
> +	bool ignored_trailing;
> +
> +	/* Double check if ksize is larger than a known object size. */
> +	if (WARN_ON_ONCE(dstsize > __builtin_object_size(dst, 1)))
> +		return -E2BIG;
> +
> +	__copy_struct_generic_bounce_buffer(dst, dstsize,
> +					    src, srcsize,
> +					    &ignored_trailing);
> +	if (unlikely(ignored_trailing))
> +		return -E2BIG;
> +
> +	return 0;
> +}
> +
> +/**
> + * This is like copy_struct_to_user(), but the
> + * dst buffer is a kernel bounce buffer instead
> + * of a direct userspace buffer, so it will never return -EFAULT.
> + */
> +static __always_inline __must_check int
> +copy_struct_to_bounce_buffer(void *dst, size_t dstsize,
> +			     const void *src,
> +			     size_t srcsize,
> +			     bool *ignored_trailing)
> +{
> +	/* Double check if srcsize is larger than a known object size. */
> +	if (WARN_ON_ONCE(srcsize > __builtin_object_size(src, 1)))
> +		return -E2BIG;
> +
> +	__copy_struct_generic_bounce_buffer(dst, dstsize,
> +					    src, srcsize,
> +					    ignored_trailing);
> +	return 0;
> +}
> +
>  bool copy_from_kernel_nofault_allowed(const void *unsafe_src, size_t size);
>  
>  long copy_from_kernel_nofault(void *dst, const void *src, size_t size);

