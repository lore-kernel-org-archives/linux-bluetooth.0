Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B921DFF7
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Mar 2025 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742567724; cv=none; b=MYRm4EPjvQ4lXQl2r66Hhb5/v7HQQZUb8Cb+E7+WOGeSmc9YSO2iJP/yVSpEmxNfgR4T7+DaBbmyyzq0Of4v1sS+DWQgsd4YSbQmvZElM7DPEOvul7dfuoW+ORoII7paacuRzNCeM7/OdTDc73Q0lvaBWH5SW96EsBXYpeWI6Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742567724; c=relaxed/simple;
	bh=IojejEi7i/69//vhEO8NZlXg4XB4QuwXBeYl8t9+NEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faoyLtGJNPhl5coClCSPsB5v0vD7+Ht3yD0UXv0nmBM04oFeU+6zuYrJJ6zjpm/79pKbON0OLgNp3bKQL/FtLC0G0mkpzfgg9fqyjJmAMvA447i4FBtg25XSX5BXhIy4RajxpMgZ90xveqX44EZ1KQkZGnULJ6jwGZZdPjeD7ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yhBPkPd3; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yhBPkPd3"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-391342fc1f6so1684645f8f.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Mar 2025 07:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742567721; x=1743172521; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Krs1soYAg6lMZba8YcAiYF9vML7T1zUmPq5yqraRnFE=;
        b=yhBPkPd3WK7hBq2DCJ4dHgurEZtXgvOlrT/0F6JsQcLjBL0367tf/lOl5D/XcX7+nX
         Oxu5vsMig7/ElkFQ7nQaDd1rINOj5PojZRoq8KPMLarzRB9CO/1u+gxZz9o9jWV1pktt
         1bbQY3hcEjrvHWvomqH/ph/jfnY3gtCbNRxBNOuBdIwIGEkHY1jt2Z0/aBrujUdFBUDQ
         dr9DXkLc7CMO8m6ZD6WxeCI+t9nDPlwM1XndkzsQZYeo4QpdthvSQJu5S4wFN0Qqp48T
         wLf4j0T4Vw20GhsO1pt48eigEQUwzAlAyh8ZKLLAmg5pIsatflI7MYUZMaHc55DxDH/S
         8qng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742567721; x=1743172521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Krs1soYAg6lMZba8YcAiYF9vML7T1zUmPq5yqraRnFE=;
        b=CjRMKImxBdOWzILuM352w04a0WCCQS3261a+Ca+gZL/rGFJWl7OHCtY0r/l0zKoIPF
         uf3L6O5xCf6WpfTjPXCZLGmpVjuRymzWMHlOWxPjTBK86D8Fgz5bbegNU+y35erXUWDJ
         JouaJK/YfcUZvLBsQGmbu/QJiI8scMGC9tdsnYOiWTLcpyxgqUHpBmAwPLMZB1BfVVUm
         Du867Llx3GzZrM0CZRGWr0MHHFacB5eHBzfdu8g14EPV8WxP0RSbjYG9lxKNXdmSM2J0
         QelXgYAW6ZwrCQDg8PfBXtT5OZBVGqnFOCK6Ni8diQ+qNPh61WT7UnSdHSBx0HtGWnwG
         oooA==
X-Forwarded-Encrypted: i=1; AJvYcCWQ8nbilXIcNm5lrVGnVM4xabkjVph2BhA/52FdPew/S2GJ/c7Zgt5tHDhV54p+VTZ1JxO3wBQYjB2P2rflEf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEtASR1uPuUzbc4GTwQpFFy9xDi+z8bYtBWVpcb9faI2Yg7y/Q
	Dl9CaMYtsMBgVT9hgxg6so8R1c/k3l7Bv2MltHLI+0hcscboAFcJ3ssqsLvEGEE=
X-Gm-Gg: ASbGncuqg16Ec2BXenKDBIOgRRepNUWaVyLYDaaSyGryUGeseqjutM4rAuil//+Et9j
	g1FyHrboOTFdJOqY+xU1MBe0qC73IkK5nNaIb0cqf994cMUyPci1sGEFgJn6GA0cF51aE+fCCMT
	5jgXjUk5C+qD8EHdxq82aLBcdTOQ9NJFFaODDOWfASA0P7kCQofEqJR1RylrizmNx2cNtjjvWwk
	hEzHV+6DmJoqJhROwxmcnFuv+97wB+/VFyIZnmg0VJr3TmCBB1GsRSooIICOgIG6g9IgYTpJvBL
	mVEuExIpfBV3CT98rWKCqs858PmKhkFyb8I2qPFNqqQeeAOGoA==
X-Google-Smtp-Source: AGHT+IG1Z3e+I49NrxtBoWndMYX+kjnHIAZ2Q2UaenOR6h2Ljs7lTVJjxW/KUDNyY+4fePSVXR1jZg==
X-Received: by 2002:a05:6000:1549:b0:391:37e0:d40f with SMTP id ffacd0b85a97d-3997f901462mr2892496f8f.17.1742567721273;
        Fri, 21 Mar 2025 07:35:21 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f9e6544sm2549904f8f.68.2025.03.21.07.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 07:35:20 -0700 (PDT)
Date: Fri, 21 Mar 2025 17:35:18 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Danilo Krummrich <dakr@kernel.org>
Cc: martin.blumenstingl@googlemail.com, linux-bluetooth@vger.kernel.org
Subject: Re: [bug report] Bluetooth: btrtl: split the device initialization
 into smaller parts
Message-ID: <109d2b01-3e9a-4410-8f30-e393503ef7f6@stanley.mountain>
References: <20180806204257.hqrwgufmu6ukq2sj@kili.mountain>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806204257.hqrwgufmu6ukq2sj@kili.mountain>

On Mon, Aug 06, 2018 at 11:42:57PM +0300, Dan Carpenter wrote:
> Hello Martin Blumenstingl,
> 
> The patch 26503ad25de8: "Bluetooth: btrtl: split the device
> initialization into smaller parts" from Aug 2, 2018, leads to the
> following static checker warning:
> 
> 	drivers/bluetooth/btrtl.c:592 btrtl_initialize()
> 	warn: passing zero to 'ERR_PTR'
> 
> drivers/bluetooth/btrtl.c
>    559          btrtl_dev->fw_len = rtl_load_file(hdev, btrtl_dev->ic_info->fw_name,
>    560                                            &btrtl_dev->fw_data);
>    561          if (btrtl_dev->fw_len < 0) {
>    562                  rtl_dev_err(hdev, "firmware file %s not found\n",
>    563                              btrtl_dev->ic_info->fw_name);
>    564                  ret = btrtl_dev->fw_len;
>    565                  goto err_free;
>    566          }
>    567  
>    568          if (btrtl_dev->ic_info->cfg_name) {
>    569                  if (postfix) {
>    570                          snprintf(cfg_name, sizeof(cfg_name), "%s-%s.bin",
>    571                                   btrtl_dev->ic_info->cfg_name, postfix);
>    572                  } else {
>    573                          snprintf(cfg_name, sizeof(cfg_name), "%s.bin",
>    574                                   btrtl_dev->ic_info->cfg_name);
>    575                  }
>    576                  btrtl_dev->cfg_len = rtl_load_file(hdev, cfg_name,
>    577                                                     &btrtl_dev->cfg_data);
>    578                  if (btrtl_dev->ic_info->config_needed &&
>    579                      btrtl_dev->cfg_len <= 0) {
>                             ^^^^^^^^^^^^^^^^^^^^^^^
> Assume btrtl_dev->cfg_len == 0
> 

This is the length of the firmware file.  Does it make sense for
request_firmware() to load empty files?  Probably there is a test for
this in the firmware code which rejects zero length files?

regards,
dan carpenter

>    580                          rtl_dev_err(hdev, "mandatory config file %s not found\n",
>    581                                      btrtl_dev->ic_info->cfg_name);
>    582                          ret = btrtl_dev->cfg_len;
>    583                          goto err_free;
>    584                  }
>    585          }
>    586  
>    587          return btrtl_dev;
>    588  
>    589  err_free:
>    590          btrtl_free(btrtl_dev);
>    591  err_alloc:
>    592          return ERR_PTR(ret);
>                                ^^^
> Then we would end up returning ERR_PTR(0) which is NULL and would result
> in a NULL dereference in the error pointer.
> 
>    593  }
> 
> regards,
> dan carpenter
