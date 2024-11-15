Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522B5383BF
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 00:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731631326; cv=none; b=Lb0DquqnEiKUweFzdHG7z3AIdGtJU+tjx0tbTkNVQP+lspQAT03nomqjYt49kLf9nhtFOKWfLpfE3nbFaGvr8x9u2dnEvxXbCAPVwi1vd4ApkCTB49TPx62fxPmI7PwrhvQcBeVA1IFByN3Z8LckPVyN2RUkLUZ6ljnh8F5E9jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731631326; c=relaxed/simple;
	bh=wNWjS1w+AL5XBvjuZ2qv8OYKCN44FLliVjmUsq8W9SI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b7cpAx/sXkFnGXWIRRiJi+Fu2wVPFkAY3rHiW/0TppvS96n/iDM4jvmq8cOr52WNAwOvs8RvJQRe6T5AVeaIy0qukP/ESzt7GQlOqxdFftvJbbotyI52vOd7AftLWzxs85lbT0zCCOk+w9EWaUM1d9DP17J9QWJaZ8+4kepBcog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=B7R47H+c; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="B7R47H+c"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2110a622d76so11118005ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Nov 2024 16:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1731631324; x=1732236124; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sHYyJiPL1uVix6sXcBSVhUMJXzftDKX8AxtiCADtdRg=;
        b=B7R47H+cM70KKWYzHJv1k8LqmufpNEVHnWAbSATUQ5qjM6NiuU2ofnsOnh75zByWeU
         TALFWRJyjLgaJKxYR9heQ1IU0bv4mdDP92U4OvKXygPLSltNkqziqSLoDxcHBTxcpENj
         laCgkKXpuO+yl1QNGQkfl3t9+SqUDk2YRnDLk0/bO+iSK20BFTX27v1czR9e/7UyRXRO
         mrEdiOCwbEy6WVTEpLcrmu3FY91EPrpugdnFtT0QLhum9szmrV7M4E++wYaUd8Uel8NR
         IBKYVdxNMP+OusW3X0NaqBrhF3YPzCvhRRpAJNZfHqUO9HSM4oxUzlZZEhAAXxA1rs2R
         Nraw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731631324; x=1732236124;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sHYyJiPL1uVix6sXcBSVhUMJXzftDKX8AxtiCADtdRg=;
        b=tKczuVeUI1DwVD7UZvDnttF4hY66xnhQBx3ElPMX8jAApZSwht9RORhsJwXDX+qEkn
         o872kDwyk7TvHrtNVnx1Nj4ynxTHWDgLpYD6W2E1sIqFcbvOIALKZLwHGhR1LBGXsCo+
         wbNfgYs1C4AmguQcLqRQd0zaY0qdS9gwDj2mJqBQlbW+T08zsMnEKjLjRGpmdx0IRvbc
         TTJOu/sHYdxVyvUZhmZZcndjRY9m9jbffvqOHzn+CIdVNNjbVsB1815xFZqVV9++Tq4q
         m2KD6V5LcR9c/UkZ+O9orNGoWHPV9EHtHSquWlIwn/csSnnkOsgCiQ7YwnA9Sq5gplQO
         OkGg==
X-Forwarded-Encrypted: i=1; AJvYcCWJRywAYcBnIRZdKgbmyYIuOLuJGPWGA1Gv/LSO9+nYL4GnGrJg2s13MCmtJv5zwDmGhgmK0vNLg04Q+6LB9jE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPRUdbaK4tXAp42gIbXawkZ0tyZieHKjdk9unMn0KQR0ccF+oE
	yOIy4RIgGGcjp59u3fK9AaNYQrpPtmsg+A9BcMo1+GyGZIBAUL6VPlLtRdnUw4Q=
X-Google-Smtp-Source: AGHT+IE7Do7E26R9csxUvunCbYmDAxnBlmmxHkrIkRFyVqSZXRT0PlbFTltbjGaMph4d9Vfrgfn0dQ==
X-Received: by 2002:a17:903:234e:b0:20c:5cdd:a9e with SMTP id d9443c01a7336-211d0d77b21mr13206615ad.28.1731631324502;
        Thu, 14 Nov 2024 16:42:04 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:40a:5eb5:8916:33a4? ([2620:10d:c090:500::5:db2e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0dc5d70sm2305715ad.29.2024.11.14.16.42.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 16:42:04 -0800 (PST)
Message-ID: <156ce25b-4344-40cd-9c72-1a45e8f77b38@davidwei.uk>
Date: Thu, 14 Nov 2024 16:42:01 -0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/4] bluetooth: Improve setsockopt() handling of
 malformed user input
To: Michal Luczaj <mhal@rbox.co>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-afs@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 David Wei <dw@davidwei.uk>
References: <20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co>
 <20241115-sockptr-copy-fixes-v1-1-d183c87fcbd5@rbox.co>
Content-Language: en-GB
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20241115-sockptr-copy-fixes-v1-1-d183c87fcbd5@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-11-14 15:27, Michal Luczaj wrote:
> The bt_copy_from_sockptr() return value is being misinterpreted by most
> users: a non-zero result is mistakenly assumed to represent an error code,
> but actually indicates the number of bytes that could not be copied.
> 
> Remove bt_copy_from_sockptr() and adapt callers to use
> copy_safe_from_sockptr().
> 
> For sco_sock_setsockopt() (case BT_CODEC) use copy_struct_from_sockptr() to
> scrub parts of uninitialized buffer.
> 
> Opportunistically, rename `len` to `optlen` in hci_sock_setsockopt_old()
> and hci_sock_setsockopt().
> 
> Fixes: 51eda36d33e4 ("Bluetooth: SCO: Fix not validating setsockopt user input")
> Fixes: a97de7bff13b ("Bluetooth: RFCOMM: Fix not validating setsockopt user input")
> Fixes: 4f3951242ace ("Bluetooth: L2CAP: Fix not validating setsockopt user input")
> Fixes: 9e8742cdfc4b ("Bluetooth: ISO: Fix not validating setsockopt user input")
> Fixes: b2186061d604 ("Bluetooth: hci_sock: Fix not validating setsockopt user input")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  include/net/bluetooth/bluetooth.h |  9 ---------
>  net/bluetooth/hci_sock.c          | 14 +++++++-------
>  net/bluetooth/iso.c               | 10 +++++-----
>  net/bluetooth/l2cap_sock.c        | 20 +++++++++++---------
>  net/bluetooth/rfcomm/sock.c       |  9 ++++-----
>  net/bluetooth/sco.c               | 11 ++++++-----
>  6 files changed, 33 insertions(+), 40 deletions(-)
> 
...
> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> index f48250e3f2e103c75d5937e1608e43c123aa3297..1001fb4cc21c0ecc7bcdd3ea9041770ede4f27b8 100644
> --- a/net/bluetooth/rfcomm/sock.c
> +++ b/net/bluetooth/rfcomm/sock.c
> @@ -629,10 +629,9 @@ static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname,
>  
>  	switch (optname) {
>  	case RFCOMM_LM:
> -		if (bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen)) {
> -			err = -EFAULT;
> +		err = copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen);
> +		if (err)
>  			break;
> -		}

This will return a positive integer if copy_safe_from_sockptr() fails.
Shouldn't this be:

err = -EFAULT;
if (copy_safe_from_sockptr(&opt, sizeof(opt), optval, optlen))
	break;
