Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0516117BB6
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2024 09:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732611629; cv=none; b=NOEj+FqQF8N91teWAOU9K47XlOY3pfgs9pI5qYlMf8oKnlONOzvtdfmNlNuMB7eqwoLmVdsGabURCtX/rSFbeE6r5eNyfpOlTTXqz+V0Xi/iFEmVhP1tyPJstsVoI8zDQlLZbppnSzeaELjsBL0dX6PtWY7Z/AZzqtqRCijv44c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732611629; c=relaxed/simple;
	bh=+7SpuMcrjwJ/YiLx54TrDaZKnKyyL7xaMQsuKK66MEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p77lVpDbaRgMhdBDHK9awh6vQNxwzGrKWtHdweRMH/eiG/Xs1NYSaJ92KyiXcifALDGH7yEZ4gydOenQxqLTQOVKdczE73bPpYhdTBAACju0UfrvJrdy0SaaotIOfKz27/GZZqb/rs2+NtFw+rZNLQ0gl+YP8jWnVMSTyIAAi3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J+FpmXQi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J+FpmXQi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732611624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAEZZmA0v1k80nlOysurYutIwKXMOWMnay0WZ+kcQrU=;
	b=J+FpmXQiyzNo1bhtM8jS9WImPTMhjwDoIPhNmj2y2lfT8JLuEIKtQBwpBhaUOIEWXdlUf5
	kmXopkn/kvRGqggJpX9QJ2OPhzQtbrk1Z3B2DTc5AONt5+oBqwXxwhbDfQbspqJ/7rlCWg
	6GFY8Vx0NWVV3Cls1Co6D6jfnkV6TEI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-5denDacrPVyX-cUix5BX2g-1; Tue, 26 Nov 2024 04:00:23 -0500
X-MC-Unique: 5denDacrPVyX-cUix5BX2g-1
X-Mimecast-MFC-AGG-ID: 5denDacrPVyX-cUix5BX2g
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385b87aee0aso1426738f8f.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Nov 2024 01:00:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732611622; x=1733216422;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAEZZmA0v1k80nlOysurYutIwKXMOWMnay0WZ+kcQrU=;
        b=CA+9J0wZWNkor7Ein38Qtb91qiHEO6UMc+LTPVrB0R1nmmxwkPavCGOylDr6wJ2trG
         RV8kGlcLo1fp9fFwAXTfJ0+4i6sJdPWXKjo1gowqsE9IcVBM2wepreX8pm85eCyOXy7Z
         EUvJkc9PGcOZ0slvpyoWTfUG8GYdoS+n41zPtoaw37ndTNgjcemzMbeXLAxr8mzF6ERt
         vQZFl3/3O+abXUUGkrCxi/CG5BeFjmkjt6CeJQhZlGilueYPjvZinEV3DJI/v0dREOja
         9N4zWTlb3kkiD6k0IW5Uf4NnUmfPBVGiTj/lI8SCTarqyw+t54Ed+tJhyDpyE6ilAveM
         u6gA==
X-Forwarded-Encrypted: i=1; AJvYcCVxf5iGqNsLYPsLqNJtoVZhQuGQ9jI0h6GSXtLXvjis/RRDy8gB8Rng7Du3SDo6eGtoxYiqap76QHorK0wBHmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVJ9FWgHfG3ybfJOYecuohHY4CFFENBWt8VgvhUD6JmEpHk8Zj
	ePeYyTNU4mqSHEeuN6Mqmjjt470UTzL5tvfs6U7B624KOcAOcDHEcE/dRUKDMMkoyEsBN0x3zYp
	k3qB7Vc9hygPn5EpzsxVIAxbA+pOXRWCFLVdMNtXr8mcE39Q+WsSMicJEUXJBmCQYJQ==
X-Gm-Gg: ASbGnctkg0KIujKni58y1UPheBPh4GHYDdcpmmSREv/wXPWqibj9FfJyJ0ecAVzHpU1
	aLLciaFTej/UHCTOAelDrNP8/b49sQkCcEfqmy6OwYja4FCq+nGlF92i/B/G3ELJaoPyruxldBa
	jkrPKukjecUrrwvXVOZ7N4Lkbo2i96kUDfAlLRkauGbqLqlHNgAuhF0QtbWbOjW/0+f62Kb9HrK
	XAG66TRo9lpg8g1ftEdapB+RaE2rWPZ/8sRv0SXeFSbzxClw/mMYHUxYq3qhxmELxayeodiN8KK
X-Received: by 2002:a05:6000:4802:b0:37d:4fab:c198 with SMTP id ffacd0b85a97d-38260b69dffmr14125803f8f.26.1732611621650;
        Tue, 26 Nov 2024 01:00:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8jYA0GTdG9hgUI38n8Ov8NGoouv5zqqCEPjjl2QpgvmIaQFxgpgIbKOkHE4UlowpkKNfIEg==
X-Received: by 2002:a05:6000:4802:b0:37d:4fab:c198 with SMTP id ffacd0b85a97d-38260b69dffmr14125762f8f.26.1732611621303;
        Tue, 26 Nov 2024 01:00:21 -0800 (PST)
Received: from [192.168.88.24] (146-241-94-87.dyn.eolo.it. [146.241.94.87])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3825fb36612sm12643663f8f.59.2024.11.26.01.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 01:00:20 -0800 (PST)
Message-ID: <7f968fde-8a41-4152-8b39-72d5b21a19a2@redhat.com>
Date: Tue, 26 Nov 2024 10:00:19 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 0/4] net: Fix some callers of copy_from_sockptr()
To: Michal Luczaj <mhal@rbox.co>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 David Howells <dhowells@redhat.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-afs@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>,
 David Wei <dw@davidwei.uk>, Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Marc Dionne <marc.dionne@auristor.com>
References: <20241119-sockptr-copy-fixes-v3-0-d752cac4be8e@rbox.co>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241119-sockptr-copy-fixes-v3-0-d752cac4be8e@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/24 14:31, Michal Luczaj wrote:
> Some callers misinterpret copy_from_sockptr()'s return value. The function
> follows copy_from_user(), i.e. returns 0 for success, or the number of
> bytes not copied on error. Simply returning the result in a non-zero case
> isn't usually what was intended.
> 
> Compile tested with CONFIG_LLC, CONFIG_AF_RXRPC, CONFIG_BT enabled.
> 
> Last patch probably belongs more to net-next, if any. Here as an RFC.
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
> Changes in v3:
> - rxrpc/llc: Drop the non-essential changes
> - rxrpc/llc: Replace the deprecated copy_from_sockptr() with
>   copy_safe_from_sockptr() [David Wei]
> - Collect Reviewed-by [David Wei]
> - Link to v2: https://lore.kernel.org/r/20241115-sockptr-copy-fixes-v2-0-9b1254c18b7a@rbox.co
> 
> Changes in v2:
> - Fix the fix of llc_ui_setsockopt()
> - Switch "bluetooth:" to "Bluetooth:" [bluez.test.bot]
> - Collect Reviewed-by [Luiz Augusto von Dentz]
> - Link to v1: https://lore.kernel.org/r/20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co
> 
> ---
> Michal Luczaj (4):
>       Bluetooth: Improve setsockopt() handling of malformed user input
>       llc: Improve setsockopt() handling of malformed user input
>       rxrpc: Improve setsockopt() handling of malformed user input
>       net: Comment copy_from_sockptr() explaining its behaviour

I guess we can apply directly patch 2-4, but patch 1 should go via the
BT tree. @Luiz, @David, are you ok with that?

Thanks,

Paolo

