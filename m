Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6FF1D540
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Aug 2024 18:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722883684; cv=none; b=Cb+G0AjBm34OlRIfn39fcxXxKHJN6aPi+YRILDSNJ0o2U5BRU18zYklaOlqW7HF3wvcCFyaSASvowAOUeIIBlIzW3RSkTJT4mm3wRBZ7vicAehmpaV1yd8uH+QVRMSfdMHP3Q7IUxdcczr+e7Ir+bUeRc5y/r9YEb9UToOOo6w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722883684; c=relaxed/simple;
	bh=2FQvdAEz9c7t59DnbbJlR0dBMhbPZ3sABY47I8zXsxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OhUkfAoYFn9OfOFFpPnHfyLl/t4hSyXMUT+WAM7G7ZpCCjvW4f8GYW5d4SrSEfAxNEGFhLu8YhIhoTgkq15KdS+6fGrw2nJ+le8cCL4HVImNKLlOWvFnUJIhIRaUy6eqDgr7gxNu02cN7ufKNIEIGR/jJ8jP0Vi6dIN7SAoWO7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=VBzF2hzh; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="VBzF2hzh"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fd9e6189d5so86303295ad.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Aug 2024 11:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1722883682; x=1723488482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HMNhcFmSQ5UcD0HqrK9ywZFFx1lvm5X7nz0EGtEQvgE=;
        b=VBzF2hzh5hU/UiSpdjKhsfTVWQhSRu8OjFcBULZ8Ze+JKlbEQl8y5E4843XOrhSmEI
         llzRO4bIc1K8WWCFQMzqvtqNJlkAg7myOpkfdESCAOs31N/UKnVt2UcM0WD6AD0jikMh
         BAc94Iu9WVBtAd8DFuZMI3j04NUFKpO6lbrqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722883682; x=1723488482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HMNhcFmSQ5UcD0HqrK9ywZFFx1lvm5X7nz0EGtEQvgE=;
        b=KfL9yEDfrT29oe+ee9qB26b9PiiDCrpupdQUJOJNFPBnnpcZ595ufbZeNauG4+U48U
         RxDehFj66KkURhCd7YX2iB4GqUIgYmVlPi5JnVUll/DvwFbtU4vE+2QmneBtDyd2Vj6i
         96GLC3mbjED7P1vFQQo8dULkoR6/RZJOceAQIc0wC0kLlscGLogllr0Hb8RIolmEHvpu
         DlBeLs8WUApTowivTS1301pj/QmH0AZF/gyrHJM8IHDK1nrAXlhMJxY8CMxHaKxqZn69
         GoWlfzxFbSJT4yVdT43svltsDy19Qk7v247JwN/zlpnn9I/yonHLv/24Li1ceBYZT5ce
         9dxA==
X-Gm-Message-State: AOJu0Yzh8IRJPeW05rnKT76OUZtV5z0wZ9jABxTF1ModmCEkFYj+AtNz
	fs/N75hv6+0XyJZGqYwUC72uzRA1lOSK5sXf+DvX0g5r4y6jjyo/slFyMfADfr+eV4sSTOxljHM
	e4Q==
X-Google-Smtp-Source: AGHT+IG6eJZSfymiHUYaiCyEcgd4DWhLixPN0Fdi6UuKMBSdGRmp8Iyxg1Awy5Vo4qrVRA8fUmwptQ==
X-Received: by 2002:a17:902:d503:b0:1fb:6616:9cd4 with SMTP id d9443c01a7336-1ff5735b795mr130933825ad.38.1722883681662;
        Mon, 05 Aug 2024 11:48:01 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff592978f2sm71938845ad.255.2024.08.05.11.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 11:48:00 -0700 (PDT)
Message-ID: <98e263a2-ecb9-4228-82d3-8bd35636359f@penguintechs.org>
Date: Mon, 5 Aug 2024 11:47:55 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QCA6390 broken in current kernel
To: Zijun Hu <zijun_hu@icloud.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev,
 Paul Menzel <pmenzel@molgen.mpg.de>
References: <27e6a6c5-fb63-4219-be0b-eefa2c116e06@penguintechs.org>
 <CABBYNZ+vVFUm1Tb+BvViYMJd6XQczTYPgyO++GGbCcWrkaC4Kg@mail.gmail.com>
 <30319168-9456-49dd-be27-480b2a068fe3@penguintechs.org>
 <1a519b2f-f5cf-40b3-8223-162dc04f8ca8@penguintechs.org>
 <21645f07-da90-4441-8dbb-d999298165e9@penguintechs.org>
 <09962266-9b55-408b-8b5d-d2387c871eef@icloud.com>
 <0940abda-fe74-4009-9a83-7384bb8cf103@penguintechs.org>
 <1ff58133-7322-47fc-b3db-6fe4a697aefe@penguintechs.org>
 <7e447839-4976-4d3b-aee5-c0961637deb5@penguintechs.org>
 <3996ac6a-4b9b-4049-83e7-530eb49616de@icloud.com>
 <9fd98bc2-d19a-4ad2-9f0a-02baae89ac08@penguintechs.org>
 <34b74dbf-d57d-473a-93aa-ba970f4e4b7b@icloud.com>
Content-Language: en-US
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <34b74dbf-d57d-473a-93aa-ba970f4e4b7b@icloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Zijun,

On 8/2/24 5:08 AM, Zijun Hu wrote:
> actually, my first reply is earlier than the other branch of this thread
> as shown by below link (^^).

That is true. However, the source of the regression in this case was 
Bart's change. I was also trying to make sure that the discussion didn't 
diverge. I meant no disrespect to you or anyone else.

wt
-- 
You're more amazing than you think!

