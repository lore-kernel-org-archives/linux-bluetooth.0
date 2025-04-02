Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981711EB9F3
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Apr 2025 11:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743591868; cv=none; b=tKCPw0bqPnxxDDs4gkbY9QZP8T31mmCC2+H0hj1tkucBwtnVvkwwgP88Ewsk57lm6vUGSgfooX1rGDjQjG/jsZ0mrZUK2jn7xeA3znpXv5Ev7qKAePVqN+wPgvLNlika3mB9BFMZeEVuZN5li19BhYKR9nhbWuqAb3ROKaSiLFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743591868; c=relaxed/simple;
	bh=zuWdNMKv4jFpUEv03k57TS7zZVpBZOgXI2SS02WW0oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZKmfA6hE43cP2E8qXXFkTDVYtDNhjZ1jJULmXa7YgE0tPkQ9D/7o5NTVFmy1POk+gLvUnp/eX1ixBL7CojqdXWKh5ZaSNjelj9LSPFwZOsc83XdltYDaXvULyad2VnE7LGI4H3qCL0mQ81IlwtJ9ipuBg5hFDqIt52G3BjHnsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FQ/l7bke; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FQ/l7bke"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso5126075e9.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Apr 2025 04:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743591865; x=1744196665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WiWQ1IjSqnVvfaZMMteWA9D4GWFNY1IcFJZCyB9/5DM=;
        b=FQ/l7bkemtUotUhBAs+chUizguhvzMGEyBs3J0dat+HKPNYEZNTQuW03TgxX6jqqf5
         capJndmJDQBSVQMAtvysc6BOHEN+h5sfz7wP+uPCW7olihKUAAI/Gnbm7I0uIfgT5NIx
         oggAFmnh0jhT/oRKeiFmZhjLT9eSuHHMV36bv8C+5q5mURPDrP9VwO3a921hpDK3GrOy
         3le2y8lu5zvWngSpn25oIsotbhag/cT7Gr5lVVOMXxd5s4ZetFtWKrOOxP16UErRE8O8
         bxJB4fW8j+nAkbE7pZYGtXRnWMI/4oNW2WunSRlU/vyUvkZB8PLbz1h1byOWEsuJep5c
         R0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743591865; x=1744196665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiWQ1IjSqnVvfaZMMteWA9D4GWFNY1IcFJZCyB9/5DM=;
        b=EwUyn+6T+BO3QTaqbo4pvMztiz5s7s4euKc/ghgCQok1wHzq1LHYM7lqzzCUAY14xV
         5DhjXRq6+xsLlj0G1evvkUANGXjaC0SljnXFyiewkKcqiCd76HIEJW5oOUcJ6ND1cP6E
         d6Tbn1RvH3r2FkMDyFe6+NcmVu5+GSci62MJKG1I6MB9wg5qCK+wsETyESKMQI9bsvl2
         IsOfJKbRTcymeER/SY6NVxOGDHfv2tOm/5pwraohdYGGqM3/+y3eGv9gCS8O324OOQkj
         +DAdDlj2X63EC55W000jbt7tEDubdQn4CEluZoTw8KHRbzcdIckSC0oCsn6J5lhF9uQ0
         xBMw==
X-Forwarded-Encrypted: i=1; AJvYcCUSK10k10XqQQrP5un+5iE+z49cOd2KO2A0EE411Muddm/EUELhBnCMCywf+LPFhBfev2AK3hvuM3Ay4KVSngs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdE7ymGummD5wBuOzfwpnqlvc7V38WxudbKyny6l6ORDUXlRIQ
	poIGLBS/JeC5hH8FFIvqDCwtRRg1ufR3MvznzBWeJcAJXLTmC3bx0bEe1SCc+ro=
X-Gm-Gg: ASbGnctdF5bKHkRC5QSslzIOpn6HNVnsbyof5gxu6VyhOuwy5lpPhwSBoSni/vD4B3C
	ZYF31AXw4rQ/HkOGWlNk6+8W1BrnJvn7vBKmw+I4JG9dzposYL6VWhWy/6Td8NDf4x3kzJVRDOi
	n3zpfsq+IzXcqLbaNgwwx7uXIn2CNsazAeO29Y9I8pj93kP4c9IHZyPQVw63KfEWJDShhdg16NO
	jQY45hx/WTXLOwWeB1OXGgFnATr0nYshNtXRsGkSIbCoGveSQBnGEDjQYJ8tcxZ8c5x1ceixZKD
	kTPurDmQcOyyDH5k9rfXrxxwlQ07fpWpJEeaMfJBTroA04jcrw==
X-Google-Smtp-Source: AGHT+IEuSwJMvS8cZa0Du9xKI27gsODZuLV0ZBW+bJBs4DUPfdJgnj+2vvUti8wHM7UgzyboWnQO2g==
X-Received: by 2002:a05:600c:4c8a:b0:43c:f3e1:a729 with SMTP id 5b1f17b1804b1-43eb70464d1mr12811005e9.12.1743591864857;
        Wed, 02 Apr 2025 04:04:24 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-43eb60cd74dsm16962315e9.20.2025.04.02.04.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 04:04:24 -0700 (PDT)
Date: Wed, 2 Apr 2025 14:04:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Russ Weight <russ.weight@linux.dev>, Danilo Krummrich <dakr@kernel.org>,
	martin.blumenstingl@googlemail.com, linux-bluetooth@vger.kernel.org
Subject: Re: [bug report] Bluetooth: btrtl: split the device initialization
 into smaller parts
Message-ID: <ba834820-4b23-404a-a8ce-cd3e01042fa0@stanley.mountain>
References: <20180806204257.hqrwgufmu6ukq2sj@kili.mountain>
 <109d2b01-3e9a-4410-8f30-e393503ef7f6@stanley.mountain>
 <Z-hr0s8xkkM6AEpU@bombadil.infradead.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-hr0s8xkkM6AEpU@bombadil.infradead.org>

On Sat, Mar 29, 2025 at 02:53:22PM -0700, Luis Chamberlain wrote:
> On Fri, Mar 21, 2025 at 05:35:18PM +0300, Dan Carpenter wrote:
> > On Mon, Aug 06, 2018 at 11:42:57PM +0300, Dan Carpenter wrote:
> > > Hello Martin Blumenstingl,
> > > 
> > > The patch 26503ad25de8: "Bluetooth: btrtl: split the device
> > > initialization into smaller parts" from Aug 2, 2018, leads to the
> > > following static checker warning:
> > > 
> > > 	drivers/bluetooth/btrtl.c:592 btrtl_initialize()
> > > 	warn: passing zero to 'ERR_PTR'
> > > 
> > > drivers/bluetooth/btrtl.c
> > >    559          btrtl_dev->fw_len = rtl_load_file(hdev, btrtl_dev->ic_info->fw_name,
> > >    560                                            &btrtl_dev->fw_data);
> > >    561          if (btrtl_dev->fw_len < 0) {
> > >    562                  rtl_dev_err(hdev, "firmware file %s not found\n",
> > >    563                              btrtl_dev->ic_info->fw_name);
> > >    564                  ret = btrtl_dev->fw_len;
> > >    565                  goto err_free;
> > >    566          }
> > >    567  
> > >    568          if (btrtl_dev->ic_info->cfg_name) {
> > >    569                  if (postfix) {
> > >    570                          snprintf(cfg_name, sizeof(cfg_name), "%s-%s.bin",
> > >    571                                   btrtl_dev->ic_info->cfg_name, postfix);
> > >    572                  } else {
> > >    573                          snprintf(cfg_name, sizeof(cfg_name), "%s.bin",
> > >    574                                   btrtl_dev->ic_info->cfg_name);
> > >    575                  }
> > >    576                  btrtl_dev->cfg_len = rtl_load_file(hdev, cfg_name,
> > >    577                                                     &btrtl_dev->cfg_data);
> > >    578                  if (btrtl_dev->ic_info->config_needed &&
> > >    579                      btrtl_dev->cfg_len <= 0) {
> > >                             ^^^^^^^^^^^^^^^^^^^^^^^
> > > Assume btrtl_dev->cfg_len == 0
> > > 
> > 
> > This is the length of the firmware file.  Does it make sense for
> > request_firmware() to load empty files?  Probably there is a test for
> > this in the firmware code which rejects zero length files?
> 
> We don't know the size of the file until we try to read it. Although
> kernel_read_file_from_path_initns() perhaps should allow for empty
> files, I do agree it seems odd to use the firmware API for 0 length
> files.
> 
> We should extend tools/testing/selftests/firmware/ to check for this.
> Care for a patch?

I was hoping that maybe the code already existed and I just hadn't seen
it.  I wouldn't have the foggiest idea how to write it myself.  This code
returns 0 if there is a zero length file and that results in a NULL
dereference.  I've sent a fix for that.

regards,
dan carpenter

