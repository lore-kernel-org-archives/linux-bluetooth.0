Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F389A263C82
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 11:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739532169; cv=pass; b=MIs/2rudwvI8Q3ReXauQ5ij4i2DDcbe7DFGVOUY1hQVET0tDtOiozKqpvAL2OJitwzBeSmnHRlSw0CTEho8ACOPLghJhHEfJEMc/PMwTq4x5wdq1IADl9ioOGmLNd11GXe34NflDAT/EgQ9LV+NCOfF4iLB3c79qav48uZI+//E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739532169; c=relaxed/simple;
	bh=C76pKuRBSgxzLMaO099PtoKcJmFrPp1yfVkhS0w5Ie4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=I3qxAb9fD4Aq4vWhdpKAeJX3blhGJl4LL6wSm1um1EZi0sl2apayI8JRgDOCenhYkfSKXpORwv+1hOMYKBZUnOHy1OjoU76fbQ4wcvAzp5GYPK7Fu06ilmxn6xz3avwqqbCy3wpy2wt0YZCl5XJF6iho+zH8+rt0P9Jq8Rs3+JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=ludovico.denittis@collabora.com header.b=Hsd6wGp8; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=ludovico.denittis@collabora.com header.b="Hsd6wGp8"
ARC-Seal: i=1; a=rsa-sha256; t=1739532164; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ry7sDGXltO5/vtxJaKkYtjPsuYL4kY4X96Wzx4KJN66jBxDAqVnLfbWsedb7thcnKOXo3X+AWArbj4mJDSuBZBpca8VPKKyaJR9MJ6pMoxMyz0C/my0advjIQEprcwIJdraou7d0AYdyOa2Aswjoz2MRK8YVmylvIs8BlQq6KfM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1739532164; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=43Gnyoz7EcvcRlBfM0CjyN+GOFGqhGZ3p0N8UsXlex4=; 
	b=ZoLFzaUxoGAOSNAJn2rKoOELDNHhXgrr65GOrrK1q5ec3Eecv+Dy3kl4/OkLtCkX4pJeV4Zwu22wFzb4dQzM16/HXpr9YcmAA0W9yf8xDM168hH1bWSunM5I/kvWObCJBfRVQMcMQbSeJCQ13U+0ZGRy8aHOqkMtd0MKeqfzWQ4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=ludovico.denittis@collabora.com;
	dmarc=pass header.from=<ludovico.denittis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1739532164;
	s=zohomail; d=collabora.com; i=ludovico.denittis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:From:From:Subject:Subject:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=43Gnyoz7EcvcRlBfM0CjyN+GOFGqhGZ3p0N8UsXlex4=;
	b=Hsd6wGp8biZnrT8C/jiNerjStTCRemlxwtNhteP69RHKOhkX+rKpGrjtMynXHmWJ
	FbRewsQ+pxXceX1wPtqUtIcps4zFccWvXrgYJNDe3b7sQWTsgsisV0n2++k4c1auVLo
	B4J7JZB7qCp1rgMYymGqGaQLq568uSGeKO+/48bI=
Received: by mx.zohomail.com with SMTPS id 1739532161660558.1092632505888;
	Fri, 14 Feb 2025 03:22:41 -0800 (PST)
Message-ID: <fdb8f9d6-077b-4fa1-871f-6057e5be5c45@collabora.com>
Date: Fri, 14 Feb 2025 12:22:39 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ludovico de Nittis <ludovico.denittis@collabora.com>
Subject: Re: [PATCH BlueZ v2] device: Clear pending_flags on error
To: linux-bluetooth@vger.kernel.org
Cc: ludovico.denittis@collabora.com
References: <20250128115659.23655-1-ludovico.denittis@collabora.com>
Content-Language: en-US
In-Reply-To: <20250128115659.23655-1-ludovico.denittis@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

What do you think about this patch? I saw that this was still pending 
while my other related ones have been merged. I'm not sure if you'd like 
some changes or if it simply fell through the cracks.

Regards,
Ludovico de Nittis

On 1/28/25 12:56 PM, Ludovico de Nittis wrote:
> If setting WakeAllowed, or the device privacy, fails, we may end up in a
> situation where `pending_flags` is still set to some `DEVICE_FLAG_*`
> values, for example from `device_set_wake_allowed()` or
> `adapter_set_device_flags()`.
>
> This can confuse further requests because they'll assume that there is
> still a pending request in progress.
> ---
>   src/adapter.c | 1 +
>   src/device.c  | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 5d4117a49..3eb343cbc 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -5580,6 +5580,7 @@ static void set_device_privacy_complete(uint8_t status, uint16_t length,
>   	if (status != MGMT_STATUS_SUCCESS) {
>   		error("Set device flags return status: %s",
>   					mgmt_errstr(status));
> +		btd_device_set_pending_flags(dev, 0);
>   		return;
>   	}
>   
> diff --git a/src/device.c b/src/device.c
> index e8bff718c..3c2337198 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -1575,6 +1575,7 @@ static void set_wake_allowed_complete(uint8_t status, uint16_t length,
>   			dev->wake_id = -1U;
>   		}
>   		dev->pending_wake_allowed = FALSE;
> +		dev->pending_flags = 0;
>   		return;
>   	}
>   

