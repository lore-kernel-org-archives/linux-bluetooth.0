Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6CF15666B;
	Mon, 11 Nov 2024 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731325669; cv=none; b=PUjS50r1We6Jh5PqsJMDhh3+o/bCF6P0FGKV4jpKEOhWQTuFaxiPSulJuolABAPWqRSYQ5ugWQZ8V+JNJVE4LF4ktQI9LuxUUUnDqjxUpWKDn1DKwowGPgaa/bByEoOuRkzjp7R0b3h6GvcYu+OxIGVnTS9mqqLUWXf92xcO/Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731325669; c=relaxed/simple;
	bh=5djMP0zfplNhwi+uRW+WX0FrSX70E2848BtYGXQR5Cs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kxLkXm9qv0L65VAafIvL5ooIIZgRFSc9N1ek+eh6QStT8IujbuDyNYF4ug2qEwv4k4Qx4zzxrYmrfb4F3Y6MjOkxcCfLTXsQbi2Mw2XOxJJmYLhpx6xEUnJvRwAeJ63e05l34F3bFE1izqVPjr9i9/AuS1xNpaT1jPZyi6GGMn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cqsSjQ2/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cqsSjQ2/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731325667; x=1762861667;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=5djMP0zfplNhwi+uRW+WX0FrSX70E2848BtYGXQR5Cs=;
  b=cqsSjQ2/EzBaG2vgRfToRQfPs22nHobCnjfiOTRXRoHEVjjXSR0kbXY8
   928x4Xe9XBL4kv8bmv6dlYjWuW7Ai/Alb4ses+PdrIaTkRmXH/5ahOHTQ
   B3hdGnCs8rghYmUSssc43UEISSQ6aml5azqwnM7c5hmyQ7uacJp+1MDG+
   dM/0N/kL4wn0S8x7kJVdm60hlPSya3DVtHjAa2ej+C4H6H0aD5LG+veiy
   /tTFdJTUSc1d87Zt06BIag0uwIo9K+LE33qVQSS8FMFDFyn+WSetZvEpQ
   b6aa4P6kOT2T1aCrlQf1MoI2/ox5JGUGUoHzw2mHAafDyEdYw5aUA1AAc
   g==;
X-CSE-ConnectionGUID: ion0PxhPQbezV6Gyi/tYCA==
X-CSE-MsgGUID: kyzb8klQR4ef7QorsrZHFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31293997"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31293997"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 03:47:46 -0800
X-CSE-ConnectionGUID: ci7DUUYTRP6Yd9RjZA+j8w==
X-CSE-MsgGUID: 3QYAQafmTGijx5ef0bBYVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,145,1728975600"; 
   d="scan'208";a="87685693"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 03:47:43 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: zhangheng <zhangheng@kylinos.cn>
Cc: marcel@holtmann.org,  johan.hedberg@gmail.com,  luiz.dentz@gmail.com,
  erick.archer@outlook.com,  kees@kernel.org,  geert@linux-m68k.org,
  jirislaby@kernel.org,  linux-bluetooth@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] tty: rfcomm: use sysfs_emit() instead of sprintf()
In-Reply-To: <20241109091748.4037589-1-zhangheng@kylinos.cn>
	(zhangheng@kylinos.cn's message of "Sat, 9 Nov 2024 17:17:48 +0800")
References: <20241109091748.4037589-1-zhangheng@kylinos.cn>
Date: Mon, 11 Nov 2024 19:44:10 +0800
Message-ID: <87y11qyoz9.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Hi, Heng,

Thanks for your patch.

zhangheng <zhangheng@kylinos.cn> writes:

> Follow the advice in Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.

Please provide a cover letter [0/4] for your series, and send your
series with `git send-email '[0/4]' '[1/4]' ... '[4/4]', so that it will
be shown as a thread in most email clients, like shown in lore,

https://lore.kernel.org/linux-mm/20241107101005.69121-1-21cnbao@gmail.com/

While your email are shown as separate emails,

https://lore.kernel.org/lkml/20241109091748.4037589-1-zhangheng@kylinos.cn/

If there are no direct relationship among 4 patches in series, you can
send them separately instead of a series.

> Signed-off-by: zhangheng <zhangheng@kylinos.cn>
> ---
>  net/bluetooth/rfcomm/tty.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
> index af80d599c337..21a5b5535ebc 100644
> --- a/net/bluetooth/rfcomm/tty.c
> +++ b/net/bluetooth/rfcomm/tty.c
> @@ -201,14 +201,14 @@ static ssize_t address_show(struct device *tty_dev,
>  			    struct device_attribute *attr, char *buf)
>  {
>  	struct rfcomm_dev *dev = dev_get_drvdata(tty_dev);
> -	return sprintf(buf, "%pMR\n", &dev->dst);
> +	return sysfs_emit(buf, "%pMR\n", &dev->dst);
>  }
>  
>  static ssize_t channel_show(struct device *tty_dev,
>  			    struct device_attribute *attr, char *buf)
>  {
>  	struct rfcomm_dev *dev = dev_get_drvdata(tty_dev);
> -	return sprintf(buf, "%d\n", dev->channel);
> +	return sysfs_emit(buf, "%d\n", dev->channel);
>  }
>  
>  static DEVICE_ATTR_RO(address);

--
Best Regards,
Huang, Ying
