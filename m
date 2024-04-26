Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20A713D8B5
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123014; cv=none; b=T/x174PLQk2v2JfqCyW8EmGyu/LGNXVE9GOfQe0cw+bpV7pKyYoBC2u4vlUiFGoJdliEIhbEb7Ibs/bJDAgybvSgAmkfHwu54qeO1sjPAA9S/Sgu2KoKQxB0Uoq+FhXUpneTnQlL1TEiBZWgphlr7Nhyc3FFxTHOPdKejdWNs/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123014; c=relaxed/simple;
	bh=zAgKQvFrqBDTFX13F6wBlBpnyEvLpQwg/v9jaYHnoJA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kjt58qLlqwkP6r7Hvi3t7T6Jqpbx3LbkKqrCvXxIntRsfHZVzqbe4RpmHk3u9a3a3EwMGAuSIzXYnkibFQO6nfNdeKwiBgy7ol2XFd6duXiB+t2+Xg1rrEE5eR0onPPkJ/4Adc5CSA2G3oj3KdHLpMvjPWlrKliLlVKGgSVGe6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hp9BbYGJ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hp9BbYGJ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41b5e74fa2fso8600065e9.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 02:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714123010; x=1714727810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wtWpy9Lgm95m3RnkoldI8iHDQ2l7NCe3R0HbIn79igY=;
        b=Hp9BbYGJPRO7x800A60sIDFETsZDoFNBX6PmVuwMog9X3e6ffnxUyIy4QuH81qdzvD
         oCf98oTJ9w/XE/ZmACpdC3b0Mm4prvM0j8a7dk3jGF+t5K8wEVvkM0xei6GRQyxZ/p8g
         ITvodSYstBr9/UyLxEYtjk9B0EUv75els85zEQ4pglfF7OCiqNGtrAMW6odKaGNpNpv5
         DYDTqRe0uzv8jUa0jMR2GvamIaDIFPMmNqT8h0DW0STC7NbPvQKwUWrwfwjn5M+rGdo2
         zlJ2rApm2PKoKhKRtyUNNqglFvjRGhs4cr+d6uwDfRTPaPbb/Lww+C6O2ZproN79AHSI
         4hXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714123010; x=1714727810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtWpy9Lgm95m3RnkoldI8iHDQ2l7NCe3R0HbIn79igY=;
        b=RWDI5ZChFMO/6Q8pgQe6lJCkp1YdBQzAMkIRlQ6nfM58UP23yyRHJnGmNrBflotyr9
         NgngW61/fQkLq993iJMvp+i/kvMPpmIdPjnmcaY8Kau9trcHaQrb5sB8HIXwUFogpvES
         eaqADC09YBJApQ214HXgl4JB0e0VEbXf7/EGEPxW/4U/zrLALUx8z6Whf/WKr9lKWMOs
         ydu9MoIPsRUvZDA5l3OkjY7B0tOtHyUW3oNDtks7WwfwdNLTIELc44uok0uXaC+3Hgd1
         xgPTlrSEyIsHrIS9dszmSY2Rv4slODT/g1xlafm3syh9Ztgc+FcKbKt8SfQsetIsMmrL
         S01w==
X-Forwarded-Encrypted: i=1; AJvYcCVnF7wPujQ45NSTQR1QMyOzTajo2GUEuxEYr140S8ynYtSd22WsChu/wAq1SenhQiBD+dsFYYAeIS3lfmsN4HZ1o9wHrdIoCU47PDLz3Nf4
X-Gm-Message-State: AOJu0YzHKB6EidNBIwtpGNSZX06lqZnaUSsGutQZwVLt5V6YGYVp5WP1
	mPjWu2CpIcH7iZW+wVHA+mwjRDoLkd0Rixn2UIkgJyvAeKi8eeHS4bQ3bB5u8D0=
X-Google-Smtp-Source: AGHT+IEG8i+8YqPGXE7NyAEe92XBUgHIuPaem/HnPBOUmFEDTzHhIh4tS8CKnTcfaMOX01XFtN6+Qg==
X-Received: by 2002:a05:600c:138f:b0:41a:da4:319e with SMTP id u15-20020a05600c138f00b0041a0da4319emr1483014wmf.18.1714123009923;
        Fri, 26 Apr 2024 02:16:49 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id o3-20020a05600c4fc300b00418f7605249sm28153560wmq.24.2024.04.26.02.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 02:16:49 -0700 (PDT)
Date: Fri, 26 Apr 2024 12:16:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: daveti@purdue.edu, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix slab-use-after-free in
 l2cap_send_cmd
Message-ID: <cff764c2-a3d1-4a12-9260-54122e7a1fef@moroto.mountain>
References: <20240426072006.358802-1-iam@sung-woo.kim>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426072006.358802-1-iam@sung-woo.kim>

On Fri, Apr 26, 2024 at 03:20:05AM -0400, Sungwoo Kim wrote:
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 84fc70862..a8f414ab8 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -3953,6 +3953,9 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
>  	if (!chan)
>  		goto response;
>  
> +	l2cap_chan_hold(chan);
> +	l2cap_chan_lock(chan);
> +
>  	/* For certain devices (ex: HID mouse), support for authentication,
>  	 * pairing and bonding is optional. For such devices, inorder to avoid
>  	 * the ACL alive for too long after L2CAP disconnection, reset the ACL
> @@ -4041,6 +4044,11 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
>  		chan->num_conf_req++;
>  	}
>  
> +	if (chan) {
> +		l2cap_chan_unlock(chan);
> +		l2cap_chan_put(chan);
> +	}
> +
>  	return chan;
        ^^^^^^^^^^^^
This doesn't fix the bug because we're returning chan.

As soon as you call l2cap_chan_put() then chan will be freed by in the
other thread which is doing l2cap_conn_del() resulting in a use after
free in the caller.

regards,
dan carpenter

