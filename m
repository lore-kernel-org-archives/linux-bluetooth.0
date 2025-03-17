Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61EE1146D65
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742256011; cv=none; b=GnKjFn8B1N1UyQ1tZoRrLzirqgNt1MslIaeS2i4FiaZUKmIci9cR8rzGo+1gXFvB9QEteFxBhVIB9Uh365ctm6sBF+JcPx2jwO4sPBRUm3QBs0iR69FMDMc/BkQewV/WSh5CJyn5RD2Gc+tfXIK1SQhpi5C4SGhcCfKAD0T2yio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742256011; c=relaxed/simple;
	bh=5i13wLKTyNDlBKchwfsIXJmrY3fLphQS5cqXHJehJHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPQl8JTmWY1xGgvx7x9m/zDI00uFv0P8aKuUznQ0M5QWbRnQN6T2ULYO/8eTKfq3/iirJ4+xjOq6ZQuJA2TD8UjhjW3hUvvPf2racqKX22f33mWwKvYlLaLfwzIXmE4z1XhBAg7CnoOn/HOvHqVrv1BJThcPi2yZHLmJ5GVgW6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=cLt2/jP1; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="cLt2/jP1"
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=cLt2/jP1;
	dkim-atps=neutral
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 5A07399
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 08:51:25 +0900 (JST)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3011bee1751so3994866a91.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Mar 2025 16:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1742255484; x=1742860284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TRQ/GwuEKDlWODVcSQfxpM5Lw2RQXG7ZSKeiwlAjR7g=;
        b=cLt2/jP1Ko35UMsCHcn3RoLnE+onqkGU8r9tJI2ojX7AyFzEvoRtvjN31csz7VbeBr
         0TCuZb2gm00ILfaBMv6/B0hp8Rqs0Zbb1PM+5wyHPqCGdfmgS9oIYm1Is9oeCYcdxAVJ
         UwBcU745Cb8kkj8a4D2y0fKTBX+7aNOwwjMVpjyvk4reUCGmurAranHmmJ1uXpUXXNKZ
         PKzPfgin97YURnNkOmQ4MbpL6z7v0vgnwkUMfDApVJRGopIuTWYMAmq6PsCDO9uYOhzk
         FaX+UsM9J8al6Yfz4sq2fNwp7c9b0qkIdXIDlLzwg/bvuEfz+bRc/Zxj1YfyxuYo3Hi4
         moRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742255484; x=1742860284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRQ/GwuEKDlWODVcSQfxpM5Lw2RQXG7ZSKeiwlAjR7g=;
        b=ZtlL0rIvj+jd8r1FVmfMqExCUDEVdkoYGaUqj2FIux0h8QqDFT9GyM5HG7TAMIR4b6
         /al2d3szYBX5ou3aPZd/9z13TB79bw9TLQXLb0WuGsLZNsQvekWcikIedMij1nORUZHf
         vVbTpU62IfFU+Og/OuMW4Djq02J+1WGAFsF/sNdOaaaptPDOkTgrI+pn5v41QeLLT3jg
         7BYFsbWBvmIKdAVefhH2+kuDsF2srwVG2DLcNgoSLIqSYBj61MEJMeq1z5BxpWnGBYdl
         hSUHphNt0LFS1mAlCbBicK5eN9vNnJMNcVaz80Mem2A+XCqFGJ155Kf/opR+ArKCNjpd
         goQg==
X-Forwarded-Encrypted: i=1; AJvYcCUZMdHxb+v3NWy0lNrD5mGzVDu7e1qmXOJehL3eiKiXBdtMGwRrA1DCM11IHpYjz4WGByxoRIZEgfSgz6D55tg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu5ntvr7f7UXtbN+9DY5bm5yMxOGbXWnhmQ+s8zDeEd8fls6yk
	DCt2DFQrNgMQhCkzjhh7QVpMnmgaqxKi6lYr7Aq54FJuuiiqPSxnK8tP1qxQtZWST52gmwvRy/9
	JnRTrLbA+NzrOIjvRJrEyNEeI+BXkUSoyI2gnHTy4EHttmT23hmRVDUIsIEZP5eLAHdg=
X-Gm-Gg: ASbGncsKaL7aJSrkS+jFUGzcyS2MQQwWK1l3lSgci2D7gIRAbkQ5VDv976ZhB+HS/Oc
	ClXggSKrwNrZWJMP6LxWsbishJLOMvtOx3+JGp1nJ5+JLYrfQBWBzidtWv1TSOAYy60y07r8e1b
	qAv/PFEDSivKo2L+M7D+rSxBQVEfC3l6WM9UFeyZGNTeKeMPzj/DOyNcpG7KZJd1mIcPKnwbyYE
	XI0SmfZ7xBRhHq+j2HyE95gyOW2092FdCXzjZghllfbsXqnLqBnDRidaliU+3+JjOloibcWOKdT
	myOhini9rnbEUaaBxn0uBvXSbF8l/8caKIn/lU3pMQFRdxrHiwrH43mgjQRpuK4lz5z1FlOiCoo
	=
X-Received: by 2002:a17:90b:4b92:b0:2ee:af31:a7bd with SMTP id 98e67ed59e1d1-301a5b03f3amr308526a91.5.1742255484405;
        Mon, 17 Mar 2025 16:51:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk+XPSS97YKPi4vp9oXul8r5wshwMpKmVOIfHLVbaOIyiKLKfsKF4T1efoV0atb9QgEGz0bQ==
X-Received: by 2002:a17:90b:4b92:b0:2ee:af31:a7bd with SMTP id 98e67ed59e1d1-301a5b03f3amr308500a91.5.1742255484114;
        Mon, 17 Mar 2025 16:51:24 -0700 (PDT)
Received: from localhost (162.198.187.35.bc.googleusercontent.com. [35.187.198.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153519fefsm6734019a91.12.2025.03.17.16.51.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Mar 2025 16:51:23 -0700 (PDT)
Date: Tue, 18 Mar 2025 08:51:11 +0900
From: Dominique MARTINET <dominique.martinet@atmark-techno.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com, haibo.chen@nxp.com, LnxRevLi@nxp.com,
	guillaume.legoupil@nxp.com, salim.chebbo@nxp.com
Subject: Re: [PATCH v1 1/3] Bluetooth: btnxpuart: Fix Null pointer
 dereference in btnxpuart_flush()
Message-ID: <Z9i1b9hzZzwJnIYh@atmark-techno.com>
References: <20240515070657.85132-1-neeraj.sanjaykale@nxp.com>
 <20240515070657.85132-2-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240515070657.85132-2-neeraj.sanjaykale@nxp.com>

Hi,

Neeraj Sanjay Kale wrote on Wed, May 15, 2024 at 12:36:55PM +0530:
> @@ -1269,8 +1271,10 @@ static int btnxpuart_flush(struct hci_dev *hdev)
>  
>  	cancel_work_sync(&nxpdev->tx_work);
>  
> -	kfree_skb(nxpdev->rx_skb);
> -	nxpdev->rx_skb = NULL;
> +	if (!IS_ERR_OR_NULL(nxpdev->rx_skb)) {
> +		kfree_skb(nxpdev->rx_skb);
> +		nxpdev->rx_skb = NULL;
> +	}

This is an old patch but I hit that on our slightly old tree and was
wondering about this patch: why does flush() have to free rx at all?

I think this either needs a lock or (preferably) just remove this free:
- This is inherently racy with btnxpuart_receive_buf() which is run in
another workqueue with no lock involved as far as I understand, so this
is not just about errors but you could also free something in a weird
place here.
As far as I understand, even if we don't do anything, the rx path will
free the reply if no matching request was found.
- looking at other drivers, the hdev->flush() call never does anything
about rx and seems to only be about rx
(ah, checking again as of master drivers/bluetooth/btmtkuart.c seems to
have this same problem as of before this patch e.g. they're not checking
for errors either... This probably needs something akin to this patch or
removal as well. All other drivers have flush seem to be mostly about
tx, but I do see some cancel work for rx as well so I'm a bit unclear as
to what is expected of flush())

Thank you,
-- 
Dominique
