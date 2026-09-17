Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628A33D75BE
	for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 19:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672659; cv=none; b=pkt7F9GUxQq+ZlWxjNepbTgZrT7WjWHDmIQytG7bDK/mbLVcxpYW0SdirpfRN5IJnBByHevtiM5BpMBsLbrfjeqRh+cHMQnzstgZ9Mqa/Jjbs+CPCScWXN76i4ht4oK9NEoxKMVAYKyck+HbivLljVCQUzJYxdP8I3DiYO/TYIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672659; c=relaxed/simple;
	bh=2Aj4sSbh/RVl/sL5CSHTVfFz7egKcIs3WnBI+6A3060=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEXuLXIimbLFaSLVsaAa6whxPN7eefYbONgu82z5AhcBc67FLWXMWfygj8EStbAGJmai2zhM42F7wrTnrtm+zKYH+o+rS/1L+hrBcfCc2a5nz/crelu92qsZVnYgY/Rlj0P39KHE7NAehlcqYTgXf8rsHPWCMKrA5CoIjwA9jkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o3z8A82U; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3z8A82U"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e620fa473so7332405e9.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Sep 2026 12:17:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789672656; x=1790277456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A289qtxLP8KsJ4uN800Ibixjj5f1NjJiFBl0Y2uxPic=;
        b=o3z8A82UCobC5AA/3SfCNcIZKFBM78UkbGnURaVSvU+RwoAVxqEn44tYP+C/pVX2wl
         W6DspVXv/3Fc5M+dSCyzPd0PHsKcq/KKzx/hXhnTjRIraSb81KwYBR0HGIq6bdFN0+7i
         HpBQSVJoFuheZjYF9wJ74vA8JP85VE0jJqED6BLBpfc+sSxHoQ408n9SUQ2GHPfThQa2
         EkS00PmM4eR3p6/aJihOoA6p+3UJDsCEJ2+bGgsUi82IUiSc81/JB5ykvOIBd1Ab5/em
         XPyYN79+x+VxQXLYnY6MUd+BOhU3Ab/vHolDeLI7K4gKqqWeYEWlXOjw3SyLKHq8Ukdc
         DUpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789672656; x=1790277456;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A289qtxLP8KsJ4uN800Ibixjj5f1NjJiFBl0Y2uxPic=;
        b=LXQCvmbSxRl7ARbWM07pYp9Ndbl4LR7jtUBCoqRiag6HVJR1GAiV8RGD8u5ZgF99ck
         iBS6qT4yojQVsM163bGBknAHQV4PXk2TNzY32kNuf5gvYeN3LJsMgEkdGrHlfirlaTMK
         VEAbKpbbqJwDqaqJYhouOK7NzZEd1Fl6zeMibHFBUZT1FAreG6WGM8L401K1DQJfu1a6
         uLCDIQxeL1rWxn8PgxdVXvO4yCFZgmHcdViTxVf+898NcALwOTpnPAD/b3RTaryrtr4G
         ouj0MeqOYGmak+Iui2TjfCHzaDT5QQ/dLfKMDDqGKUOPOTHlAk0KyWJ2rsBvbvPy1F01
         KQjA==
X-Gm-Message-State: AFuF++kHDsXXEEjCzlORJdcIR5iQ+WzTxFVv5Dcu0DYTeGa5bW/8OICS
	tdAf/sQhhR8yzlRNkcrPE3BlPfhjK1+QUy7AktWihAk19OhKQtQ7ps69
X-Gm-Gg: AYBFou3dIhP8ZJneipfAiLzd7vh5Xp7Q2iooWrXKzs1wQUVpT4lHtJLhHCr4omS+NW+
	ooWXwlehmez1Cv/4qW9Rzn0OyxbqXfsU9jX/r1bWwAxzMEowV6Nb44d196V3SQo7+32Cppap1f0
	b+WZu/ga4rm3S5Y3kRY5tquRjp3r1idJz/mkivH9DAp+6YuTyUwtQ7uJYrnckfjoSwkAbDrFuXi
	qvy0kjcPm7SMI8Wqgw5yhnWRONnoRLWFWQcu2fUkpW77gdCwjtO09F/q+tpjk+hvZFd3EHaRQX1
	dRpXj5L9HRkOPfMvS8ykdSfsVRNYJBgPkrjgkL/d4eT11AHTgqnFPNijFgV4eOpoa/wUlzJguf7
	Xgu5l0tMCQxtPo+wKlLUdSpFn9fsbi7CrerrdqrAKRHdzI+RctuF0iiUx2JfCHLuhAT4L5z3rst
	/VRohZHlo0uhqb9qhpfAUrpDg5d0FCj3MkfvbiNpPHQopELwXTX6qHQAhf6bfor5s48wQ=
X-Received: by 2002:a05:600c:8b21:b0:49c:dada:f581 with SMTP id 5b1f17b1804b1-49ea528e1e4mr91418045e9.0.1789672656445;
        Thu, 17 Sep 2026 12:17:36 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf27198sm17948470f8f.15.2026.09.17.12.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 12:17:35 -0700 (PDT)
Date: Thu, 17 Sep 2026 22:17:32 +0300
From: Dan Carpenter <error27@gmail.com>
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [bug report] Bluetooth: btusb: Add support for Qualcomm
 multi-subsystem QCC2072
Message-ID: <aqw8zNc6tXeaNPNV@stanley.mountain>
References: <aqw8ShHyjdZhPc4U@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqw8ShHyjdZhPc4U@stanley.mountain>

On Thu, Sep 17, 2026 at 10:15:22PM +0300, Dan Carpenter wrote:
> Hello Zijun Hu,
> 
> Commit 2e63b55654e0 ("Bluetooth: btusb: Add support for Qualcomm
> multi-subsystem QCC2072") from Sep 13, 2026 (linux-next), leads to
> the following Smatch static checker warning:
> 
> 	drivers/bluetooth/btusb_qcom.c:2516 btqcom_set_bdaddr()
> 	warn: passing positive error code '(-4095)-(-62),(-60)-(-1),1-255' to 'ERR_PTR'
> 

See also:

drivers/bluetooth/btusb_qcom.c:2931 btusb_qcom_shutdown_unified() warn: passing positive error code '(-4095)-(-62),(-60)-(-1),1-255' to 'ERR_PTR'
drivers/bluetooth/btusb_qcom.c:2947 btusb_qcom_shutdown_unified() warn: passing positive error code '(-4095)-(-62),(-60)-(-1),1-255' to 'ERR_PTR'
drivers/bluetooth/btusb_qcom.c:3562 btusb_post_download_unified_bt() warn: passing positive error code '(-4095)-(-62),(-60)-(-1),1-255' to 'ERR_PTR'
drivers/bluetooth/btusb_qcom.c:3977 btusb_qcom_setup_unified() warn: passing positive error code '(-4095)-(-62),(-60)-(-1),1-255' to 'ERR_PTR'

regards,
dan carpenter

