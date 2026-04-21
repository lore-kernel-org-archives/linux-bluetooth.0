Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39424386C39
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 13:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776779239; cv=none; b=dch9uFgrSx6CqSuSEBcICRqI19h0tw141PLWCmXEVzn7lHSuv1TkCENu1V6K902OnL1co0HCXB5poxBjtMcr+EmGtd6bMUZykII7NVrUVVHwiwowHtByskLzdqjkTeqIRyBVd/zFkYWkJcJT7etfiOxbwLGqAR5g9h8dsWNKmAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776779239; c=relaxed/simple;
	bh=cPnsphPvzsrHtnf1o8LVbV3zHViJj9GbATvXL4hU8vs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aODrKAgsLalKB9XpdC5yTjyt4ZCDV7VAmjS1QDbLp2wBKlU+Foss6LAf79i2eMkWoGx0/yMf8qlqAHtZ/19m+8nCPbP/ra4c3s0E52gUnu46zWwR/VO+9rrvywjR8K31ep0QqHCYRYa53QPzh2N0MtDd2uZHLyeCUt0Rd9WO/VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=vo/UrfbJ; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="vo/UrfbJ"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-479932ccbc8so2565575b6e.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2026 06:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776779236; x=1777384036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ncZC6vM9FFS1oO5nJct87+zQrMiu09u9moJUQ3KEN4o=;
        b=vo/UrfbJvKLB2plXoOTGIHW8XsWBJ/onm4e3AsV0Jeh6iaIETIG1cG8W06GfzZ/lbH
         50aCIeGvZvniGCR7fMpEz/GdjifxuXxFiPP6gO/bvkNFaER05kO1QcBa7OOMiulcxK0H
         WqCchgvPPUKnx8PbQRiPaWqcCsD8V9BkVeZgSWzvtErowJDBV2JIXpVzTsa/JjWA1/i3
         DJng/kIIVcFeHXhRrxeIVdhV+aRyBEBLapNrTXk6wjvdiyUkD3l6Md9GioPd05dYKmTJ
         NP5vYK0LUhP7dW7FlWpBKKTvA44Hv74FwVOCf006ePfm4yYIyQld5qV0eQk4dRikNkma
         JtbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776779236; x=1777384036;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ncZC6vM9FFS1oO5nJct87+zQrMiu09u9moJUQ3KEN4o=;
        b=pHWfR+4bE+e2KljmUPKdQRJqpEtL0G1mUw6m8EVaVtPp790svQSQxDSP3dThslP7HY
         xDAdxurWrJ5DidZ2yViTjjdEmBmRGulEFR7P/wngxsh9eDILnbBFnCXagXOp86rSjZgD
         fLh+dFNLUdMpAxF5Q7EPcR4gfK0lxGUmsjgP4C2Um7u4J5qui6F+vBR185LzsJlZjs6C
         OidwVuysIKx1wWl/CPMjyWX9hioLnMk41O3iNePDPA/tfudHfguG/kt6zTKM4ahp3T4U
         0VGGPt0cHNfPCuYm6my/x7RCT8z5DEn7P16/zs6GKZN/12WWqigUv0beyrcIsH/MQkw+
         tEtw==
X-Forwarded-Encrypted: i=1; AFNElJ/G51XsZaaucqjwfVBUbjSfRCteIHtLawSSa8eIv+iOf7txS4YFSeNf0zlI+5EWG1evmDgY3AjlvCYCRgDWYrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi66YFlNEVeTwy0IXLo49RroyYHx2jWKsPTOG6p1MeJ+eYXCzE
	IOb4BgnKiiVRvEZDdSmxDAasvCp8crLKPxP+rAmG8w6K3ulJ8cd+vvZHLgqv3kOE/Lg=
X-Gm-Gg: AeBDiesSeipZ9KtkMQvo9AwFvbl2Az6xBF7zGEGAmQN/kvdqcSOZ3iF39R5deXVF7xg
	eOiJ5A+q2Kne6xv/u0jz/kleswgLP5fl87vBqyzZ3daCi3bKoihWgmTucB57nK6Q3FKc85lYKlu
	mkKDNjIBrosLbG2uEoau8AZ8hYXaroG83ZJHOYUpxiuUgWsYHb4kZcjPZYlii5NFvJLRywCdxGg
	8OUN0izRUiEqM+rCoqC8ILcuhk2piHFgRCgo9c9BDjJ0pWfwjPQwhs2sah8f8oTf40Fziez7pNi
	WAUUUkAV3NpaGlT7gU+NUrEYD0VflKHYBH7tgYV38QpL+beE3MWDWnC53sgiGbHwBp2Y1EJfD5H
	GQjV5Wl2ZdiMO2IwPUzhAovfCIKX4LjOgqmBIzti/h6c1prXV63/njN9FevUOp6XwbQ4abog/yC
	shOXAMh39g++c64NBEdFp34UcJmRNpcgDQ2XZamsgsn2QCfw==
X-Received: by 2002:a05:6808:1a06:b0:463:ab56:9ec5 with SMTP id 5614622812f47-4799c8f3109mr9384478b6e.16.1776779236082;
        Tue, 21 Apr 2026 06:47:16 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4799feaabf2sm8808115b6e.4.2026.04.21.06.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 06:47:15 -0700 (PDT)
Date: Tue, 21 Apr 2026 06:47:11 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, marcel@holtmann.org, luiz.dentz@gmail.com,
 mchehab+huawei@kernel.org, jani.nikula@intel.com,
 gregkh@linuxfoundation.org, demarchi@kernel.org, rdunlap@infradead.org,
 justonli@chromium.org, ivecera@redhat.com, jonathan.cameron@huawei.com,
 kees@kernel.org, marco.crivellari@suse.com, ferr.lambarginio@gmail.com,
 nihaal@cse.iitm.ac.in, mingo@kernel.org, tglx@kernel.org,
 linmq006@gmail.com, linux-doc@vger.kernel.org,
 linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH net-deletions] net: remove ISDN subsystem and Bluetooth
 CMTP
Message-ID: <20260421064711.04e3e71a@phoenix.local>
In-Reply-To: <20260421022108.1299678-1-kuba@kernel.org>
References: <20260421022108.1299678-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Apr 2026 19:21:07 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> Remove the ISDN (mISDN, CAPI) subsystem and Bluetooth CMTP protocol
> from the kernel tree.
> 
> ISDN is a pretty old technology and it's unclear whether anyone still
> uses it. I went over the last few years of git history and all the
> commits are either tree-wide conversions or syzbot/static analyzer
> fixes.
> 
> When we discussed removal in the past IIRC there were some concerns
> about ISDN still being used in parts of Germany. Unfortunately, the
> code base is quite old, none of the current maintainers are familiar
> with it and AI tools will have a field day finding bugs here.
> 
> Delete this code and preserve it in an out-of-tree repository
> for any remaining users:
> https://github.com/linux-netdev/mod-orphan
> 
> UAPI constants AF_ISDN/PF_ISDN and the SELinux isdn_socket class
> are preserved for ABI stability, but the rest of uAPI is removed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---

Acked-by: Stephen Hemminger <stephen@networkplumber.org>

Will remove it from iproute2-next as well
