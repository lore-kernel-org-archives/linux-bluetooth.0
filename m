Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CEE20F07D
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Apr 2025 11:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743594912; cv=none; b=jp4JMdy+GA6oYf2jBZA1pAJgqOwpyZ5ux/9yL1rP6qcNN3lb+UcU3+r9GRRj9xtrDqKo0nGKKRb/tfPNp/CeeLaGK+Hj9TaUJARH3HvYK9kFMfearWP9FZtI1TvNojlK17VXxN0xlX9FyT8eSgjwpTmgDkupjME0fjzToBlNnRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743594912; c=relaxed/simple;
	bh=nENsrqmWbegOZG/r1X2PxQn++esBRh+Li8k0rldpTEo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TnL6Pr6vy0+u/pmKfsRRKIg2hkUzUQcfCIS4goFM9XHMOp2bh/qCkjmNU28rdEnc7RnzwYEw5drF9Vop/iUtYj2Sqgdjr87MgiXNES/kyxiwsX7n/E0UQmuwEiJCYQs1pl/Eog/YYuneXTA7/Gt/cNhAiYECvCSJbJ5ZthqOEO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JNKPBy8S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JNKPBy8S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743594908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wz4FfrnCRhg6e7/GKO5rTqDjU53m8lZ5KDISSPVBre8=;
	b=JNKPBy8SIkM0iPCfkoy004cal006X1sG8sgPtetVpk7qd3ZfxxwuJH0QwjyqHhc80OmpMs
	Cz9hL6ekHutdScT+7FSqJgPR5a/JZKGCxH2jbq5qDdEln2o15VH7gPwopBhSlzPjZWyW7H
	1tU7NLixIlWFGEk3DG3pkJpNFjIpHCQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-s-P8Bi0SO9WZn_S0JpTFSA-1; Wed, 02 Apr 2025 07:55:07 -0400
X-MC-Unique: s-P8Bi0SO9WZn_S0JpTFSA-1
X-Mimecast-MFC-AGG-ID: s-P8Bi0SO9WZn_S0JpTFSA_1743594906
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac710ace217so490075766b.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Apr 2025 04:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743594905; x=1744199705;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wz4FfrnCRhg6e7/GKO5rTqDjU53m8lZ5KDISSPVBre8=;
        b=rwDaDT1F3ERpSus+97m7aRti04F4wyGIChnOyckEciVnRgHV420gSZgIFQTRYDJjMw
         8kv5f9Ae7y3hSGBhONE1GpQmQZtb+M8DV4/cY7wnrPThwCNX+rRo5TnZDyvI6k6Xguce
         3T0KiFaEM8+u74hoCGa/VWvEaX/SkfDqbuaNzvzo20dtO1H1I0lYKnBOSfXyL8nw5RK3
         wXznNuBTuHo+AuVBadoRT/4BlhMdbBpylLCjpD4Uvep+eCploe02XAp2JW2mn6rf0aXy
         TCsFmjWanEBMZhXq5ex911Pu6wXqPcUlQ62yMS3+2g42jzxw3sy2+oZOey6TuxjjrBhf
         Q7aQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuiBAuZwe2YDOsBdflrEcdTeXrLsXhQ6/iL1hr8lBo1rxs5W3KR9f4jK7bSK3svKm/RzvFb+6Pe8wC2vhXtbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNtQE3boiUnfpcSs9uZAzQy+woXvfA4+q0QjzEiwvN6DRGjeN3
	QkH129F5hoQ0rbEWL1Mkih8O4CPOHJk6Yp2VX4Lczp/DWOdFHm/cT8vggS2STaBbF/c+vIAL7fK
	9tCgjk9KDRN9AlJyU3uI6mi+H03H5A8NQX1gRHkd1oA/Ah0qFNSgYNezS1d5yZB/4WMK65TXnrA
	==
X-Gm-Gg: ASbGnctfkXhUkzPq3mLCTa//aOrrXXUR/m9aL+AiCq/ffgDDWzOZsEVF7eKKiJaZXXT
	CjZP+TqrjlROWVwIRRkKCrv9Xz3+AzB7jNyx9aNvKh/NOEAhgrtILXS6RTXKkxGHR3dYritb3G1
	hug5en5t/Yxj360U7MHi4xQcDZyPr6/ewSS4qciWphg7HRxxz3vE1B/eu/aNXXb9ycsTB+EW9AF
	RC9XWW4zDEM+Tvsg1atLcpbqiyDDfZaXITVAh7Kp58GcPssB8gSYKlXTXR/XRG3cHgzXnaWnfvC
	/eTv2RH+dU1uLKXB+W03YhihO9UmKvfBSe7xgTxqJW/t2aRwY21zDS5siWU6hxcaJZML7kZ15y0
	nXh512BwifgGTBLS8v1uNqkdpfEYPnfTvU6Rxn/CvFFn1R8g6GGNCwvPU/95kl+c/4Q==
X-Received: by 2002:a17:907:7e82:b0:ac1:effd:f2ea with SMTP id a640c23a62f3a-ac738a82f63mr1519900666b.24.1743594905454;
        Wed, 02 Apr 2025 04:55:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5nJsoUbdzDsoVfY6aWJ+75CkT2U3THLfZxOsW3hmwXfpxrhyV3hBIjXRvBVKnq7fFcjCx/w==
X-Received: by 2002:a17:907:7e82:b0:ac1:effd:f2ea with SMTP id a640c23a62f3a-ac738a82f63mr1519898866b.24.1743594905016;
        Wed, 02 Apr 2025 04:55:05 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71971bf3fsm897184966b.182.2025.04.02.04.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 04:55:04 -0700 (PDT)
Message-ID: <cc9f5c30-45a6-4130-bdf3-732e5f1c6d2b@redhat.com>
Date: Wed, 2 Apr 2025 13:55:03 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btrtl: Prevent potential NULL dereference
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Jeremy Cline <jeremy@jcline.org>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <0174d93d-f3a5-48ed-a755-ed7f6455c1bf@stanley.mountain>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <0174d93d-f3a5-48ed-a755-ed7f6455c1bf@stanley.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2-Apr-25 1:01 PM, Dan Carpenter wrote:
> The btrtl_initialize() function checks that rtl_load_file() either
> had an error or it loaded a zero length file.  However, if it loaded
> a zero length file then the error code is not set correctly.  It
> results in an error pointer vs NULL bug, followed by a NULL pointer
> dereference.  This was detected by Smatch:
> 
> drivers/bluetooth/btrtl.c:592 btrtl_initialize() warn: passing zero to 'ERR_PTR'
> 
> Fixes: 26503ad25de8 ("Bluetooth: btrtl: split the device initialization into smaller parts")
> S

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


igned-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/bluetooth/btrtl.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index d3eba0d4a57d..7838c89e529e 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -1215,6 +1215,8 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
>  			rtl_dev_err(hdev, "mandatory config file %s not found",
>  				    btrtl_dev->ic_info->cfg_name);
>  			ret = btrtl_dev->cfg_len;
> +			if (!ret)
> +				ret = -EINVAL;
>  			goto err_free;
>  		}
>  	}

