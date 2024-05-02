Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C641415B55D
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 May 2024 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714671948; cv=none; b=gh87nhrx5gmCWNjuszylJ0y75O/D9kY7LZdAH/Tdaz3kpDDTLZgRYgRB9noOYuW2O+CYi2HtWS58/Qw+z33PIu1JDBdYFe/j1reZXhoQXf5Qwx7viJxj6N91rLM29jvDkKb3o8LTQMUEU5mMGEOklLxgysZEZeE5G7Gh0d04ilI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714671948; c=relaxed/simple;
	bh=IHxGn1w7e072y8lu8XMZs77quMjYuFA4X7pRPCXprfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psifg5OBog0y2IIDXFEdHAdXNhLZUlGjfErWvy2Mu6mjl6gPAqshFK69+1lLnnpeP714+ESurA0WndnRVylefoSmTam7CIqDSknhSZFS1xUdVLkSpqBBR6Wfmr9K+bC1uzY0vqsc6OBBeiGl1NvxfNdAiIOt3A+trGA/Z3WXmeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dJKf9Gtv; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dJKf9Gtv"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1e5715a9ebdso69588645ad.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 May 2024 10:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714671946; x=1715276746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=exzo1UieylDBJQODCUVqGFbljUasMvDy96izXXeVha4=;
        b=dJKf9Gtv/MQbi9CX6AolyH6LMBHl1/8kbKdX4OcK23Br5xTZPmJcPKhCrzZJF3Pcpa
         bjbEND08crOLeeuwqxTT7/yilYzTRDpf1lpOE48kNoD55Ku9ex7GWNlznvWbygRz0R0S
         BcBKNoxM1eYWlnD8DeRcqlzyixxLIJgAR00bA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714671946; x=1715276746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exzo1UieylDBJQODCUVqGFbljUasMvDy96izXXeVha4=;
        b=m1Go+IIraaSisLIE4rK6wtx0umJhGm70kZiNW/39shPOmuJq1F4HWNc5++v7042h3h
         72/wp+7nE8Y3EFsqFPA/7QdXYQRMXhFuBBZcn6vy4LQtCCmPkqzYXBC6Nh8ZfChnCDyX
         j8Pz/PQjJIYQsRju1Vu2aMeZFvVOX7fqXnWtEWXsI2dreShoRAg9nh0yejtf2DWB/iha
         IChpj5Z3fmQ0THKwx/sPjMU08bZIifyA8NhZspmgE6jNUEt85v8zFHoClkgUlNyjyu9m
         xZ9CTGbfur4fAnHvxfCN5c1GLtohVEmC5Hcj9AuNTPmxngz9OOzvfoKTT2MIXVKn6p1a
         BiQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX6tcXojquUJjK7fITWE6sslhVdE5rNJ9GXCKFH8Fxip7FYVJbReFCsMZkzGXgJcJCghJ8E7OMe46KKzXQ6UywUzJ9+DCALny8AhgpTRze9
X-Gm-Message-State: AOJu0Yxltp4q12DHuQ4VrQMEdUhF3ri0AvazrjfnA8TWH1DyaBlF3QpR
	4KmN31kd1IxsLBuJhiD9YjM4m7NrZjLMKRHGvKIwo4BugYNyIJhm+vbSDdONAQ==
X-Google-Smtp-Source: AGHT+IHJuvpvzMrm4vn0maKzGW0icLGJ4G7TA0twF54RBTausoyPGzqBnQ+KeL8WeHu9J80IQqyC1w==
X-Received: by 2002:a17:903:1252:b0:1ea:bc:53ac with SMTP id u18-20020a170903125200b001ea00bc53acmr449268plh.44.1714671946197;
        Thu, 02 May 2024 10:45:46 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s9-20020a170902c64900b001e5a5ea5287sm1588059pls.208.2024.05.02.10.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 10:45:45 -0700 (PDT)
Date: Thu, 2 May 2024 10:45:44 -0700
From: Kees Cook <keescook@chromium.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] Bluetooth: hci_conn: Use __counted_by() and avoid
 -Wfamnae warning
Message-ID: <202405021045.CEE4DCA@keescook>
References: <ZjO9qCx10KUJbK6w@neat>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjO9qCx10KUJbK6w@neat>

On Thu, May 02, 2024 at 10:22:00AM -0600, Gustavo A. R. Silva wrote:
> Prepare for the coming implementation by GCC and Clang of the
> __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time
> via CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE
> (for strcpy/memcpy-family functions).
> 
> Also, -Wflex-array-member-not-at-end is coming in GCC-14, and we are
> getting ready to enable it globally.
> 
> So, use the `DEFINE_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> With these changes, fix the following warning:
> net/bluetooth/hci_conn.c:669:41: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Link: https://github.com/KSPP/linux/issues/202
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Nice! This looks really clean; I'll point people at this patch when they
want to see these kinds of conversions. It has it all! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
