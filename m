Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F0D156237
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Mar 2025 07:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740985808; cv=none; b=sgP1y7RQw4LkCOaRnAJrMB62zMO3oCeTT4mKXlNnDeXpVu5nSJRR64BaXbHTuPaLMIsDfG+OSrFmHPBIX9a6bppXUmDFeTEjYHxfZXG8amSWUR/s/crzP26vv1SDjTACi97FHszNOcmb6rZ7lsjlCksKubiZlZNp7H0elOYqxRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740985808; c=relaxed/simple;
	bh=W2Vj39751Bhjtkz/CVuLaVLdqFoOBBQpqm1/ISMyOt4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=H6Gjx0QPaqn4gsGyyW5QUl+jlevAN3xNU55iQ//FsoiWPyYniuvXGW0zSF3ZjhVfPTJc15ORiWfFF3djQGi2uG9NV9vs682o4NtM2v2cA9UGZpSDo+lYOCCDxQSv95HAUEFcY2Ax/I+H3uzmjgmtZ+u+z9bYz9W2Ta7drOOXOO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cm26+Q6e; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cm26+Q6e"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e0b70fb1daso7068410a12.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Mar 2025 23:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740985805; x=1741590605; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fpWKkfL+fl8msV0fvERh8Rvd4rH1OW4GUOLjUnGu4fw=;
        b=cm26+Q6e3yaYG5pcY1rT7Y6UXT8mErvpCA2yMLQpcakv3js0KT1QenrbG3xcqluIRw
         q4t++GZVxF7UXXC6HXx+cZmpp5/tua+g+LqCCn68lss2A3qTF+7g+1FWrZnchoW+pXrf
         /ewnq8tV/eLYq3SCUZvDsJNcqoHqeObXcwls46aYXBxmVS57qq6BD1LTBX75t0MALzmx
         uXKqNXb7MQpyvIcHPfw231a+FxlOsJ/MuOuvHnJw8MtYQWXvCNH/ftgsghF0inkpIuFb
         cEWKzwJmprmtRD/wk+RPhP5WPCNParx5gcdTDMxg6d6MAd6L02EwoOt98ICUlOLMH0aa
         /cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740985805; x=1741590605;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpWKkfL+fl8msV0fvERh8Rvd4rH1OW4GUOLjUnGu4fw=;
        b=GO09xmkpMsuy2XcOCqizeXq/F9YMzVbwou552jzY1z3ChqwWLpYbu8uR4SX2fICqCZ
         KX7iCY32f2pGeGZpBS0/qaVf8d6H0u7nFtW7rZf6GGZlriyvzljeNIakGYQYXwaYlI9i
         GhSPGmecfIR6EQwAtrKOwD5DItpPfdnbI7i50KR6kcMCAp+qWFhf83sGU5PyVuPE1tjw
         Y7qru30+WhY2EteT+8+gGrq4YhrZBjx9E5rCJwvdV2yoi8Ugu77ZADGPIt/0dBvVEtbG
         hNBv0CxqvUc3TEy2zADRA+DhmQplDRwDH7wTpOqg6PTyG36slTJKHgPQOJ3bdm0Z8zlL
         EoLg==
X-Forwarded-Encrypted: i=1; AJvYcCXRE15vrO2O+XbxQQrPnG2lrZuBqmaX+hcFouYi72xfMXwKkc4lrbkwVWtsEOcqffeyAjU31XhKAAWY4SuhMXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZI4WZBO6UyiK4oByL6fr22NPt2RmtLfGmnApziO29JLfpItSv
	vSPSYnDiMF7q5Aas8yi+jf7cGcvC0YuyTF6ImUGoORIgzG3y/K63VCLCbOGue/U=
X-Gm-Gg: ASbGncvJknFyj3E6guwjCd40k305fXyqWiaYoEDAeHjqeR3MYfc6gtlbFZmOZD9Xjm2
	2ugs4FpuAK74FH1PlzBtGiprW/5gTqJsEg4CCqYZ2MTHljUM9teBdk2qQ2eFOonNTiI35FKFy3k
	HnAPTz7wWEgmsN59tzDdHUsamoXC8bpiOjBZn9Q1XU5PhYlgKMQFJRv7eCF60055OqhK5uZtJIw
	k6JBYWH0JiZ7C2dvpTO4JzNdlQTpOXcHWV5yUPDRQ5BPu0zH0CLhCpaGsWjIWG3qunMHudWN/QX
	bCAqKDtGc+6Wq9Je6Gpl7KrugQsABxWfXidMq84fuxtjqeqaDw==
X-Google-Smtp-Source: AGHT+IGu7WB+BBuNdB0Gl8etcZ8tx1a35hIS/Ur49IC/bSwNk6QJEaciA0rEzNztLVjNeIARFIoN0Q==
X-Received: by 2002:a17:907:7ea5:b0:ab8:c215:fd27 with SMTP id a640c23a62f3a-abf25fa8e4fmr1344109066b.14.1740985804710;
        Sun, 02 Mar 2025 23:10:04 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-ac104bbbd2csm93483366b.175.2025.03.02.23.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 23:10:04 -0800 (PST)
Date: Mon, 3 Mar 2025 10:10:00 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Kiran K <kiran.k@intel.com>,
	linux-bluetooth@vger.kernel.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
	chandrashekar.devegowda@intel.com, vijay.satija@intel.com,
	Kiran K <kiran.k@intel.com>
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Add support for device
 coredump
Message-ID: <d61fe144-b47c-4e60-a95e-26522792dd50@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227102625.20642-1-kiran.k@intel.com>

Hi Kiran,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kiran-K/Bluetooth-btintel_pcie-Add-support-for-device-coredump/20250227-181131
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20250227102625.20642-1-kiran.k%40intel.com
patch subject: [PATCH v1] Bluetooth: btintel_pcie: Add support for device coredump
config: sparc-randconfig-r071-20250302 (https://download.01.org/0day-ci/archive/20250302/202503022332.biRVCDMP-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 14.2.0

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202503022332.biRVCDMP-lkp@intel.com/

New smatch warnings:
drivers/bluetooth/btintel_pcie.c:493 btintel_pcie_read_dram_buffers() error: snprintf() is printing too much 100 vs 70

vim +493 drivers/bluetooth/btintel_pcie.c

b8cc1a1cce30cc Kiran K 2025-02-27  454  static int btintel_pcie_read_dram_buffers(struct btintel_pcie_data *data)
b8cc1a1cce30cc Kiran K 2025-02-27  455  {
b8cc1a1cce30cc Kiran K 2025-02-27  456  	u32 offset, prev_size, wr_ptr_status, dump_size, i;
b8cc1a1cce30cc Kiran K 2025-02-27  457  	struct btintel_pcie_dbgc *dbgc = &data->dbgc;
b8cc1a1cce30cc Kiran K 2025-02-27  458  	u8 buf_idx, dump_time_len, fw_build;
b8cc1a1cce30cc Kiran K 2025-02-27  459  	struct hci_dev *hdev = data->hdev;
b8cc1a1cce30cc Kiran K 2025-02-27  460  	struct intel_tlv *tlv;
b8cc1a1cce30cc Kiran K 2025-02-27  461  	struct timespec64 now;
b8cc1a1cce30cc Kiran K 2025-02-27  462  	struct sk_buff *skb;
b8cc1a1cce30cc Kiran K 2025-02-27  463  	struct tm tm_now;
b8cc1a1cce30cc Kiran K 2025-02-27  464  	char buf[100];
b8cc1a1cce30cc Kiran K 2025-02-27  465  	u16 hdr_len;
b8cc1a1cce30cc Kiran K 2025-02-27  466  	int ret;
b8cc1a1cce30cc Kiran K 2025-02-27  467  
b8cc1a1cce30cc Kiran K 2025-02-27  468  	wr_ptr_status = btintel_pcie_rd_dev_mem(data, BTINTEL_PCIE_DBGC_CUR_DBGBUFF_STATUS);
b8cc1a1cce30cc Kiran K 2025-02-27  469  	offset = wr_ptr_status & BTINTEL_PCIE_DBG_OFFSET_BIT_MASK;
b8cc1a1cce30cc Kiran K 2025-02-27  470  
b8cc1a1cce30cc Kiran K 2025-02-27  471  	buf_idx = BTINTEL_PCIE_DBGC_DBG_BUF_IDX(wr_ptr_status);
b8cc1a1cce30cc Kiran K 2025-02-27  472  	if (buf_idx > dbgc->count) {
b8cc1a1cce30cc Kiran K 2025-02-27  473  		bt_dev_warn(hdev, "Buffer index is invalid");
b8cc1a1cce30cc Kiran K 2025-02-27  474  		return -EINVAL;
b8cc1a1cce30cc Kiran K 2025-02-27  475  	}
b8cc1a1cce30cc Kiran K 2025-02-27  476  
b8cc1a1cce30cc Kiran K 2025-02-27  477  	prev_size = buf_idx * BTINTEL_PCIE_DBGC_BUFFER_SIZE;
b8cc1a1cce30cc Kiran K 2025-02-27  478  	if (prev_size + offset >= prev_size)
b8cc1a1cce30cc Kiran K 2025-02-27  479  		data->dmp_hdr.write_ptr = prev_size + offset;
b8cc1a1cce30cc Kiran K 2025-02-27  480  	else
b8cc1a1cce30cc Kiran K 2025-02-27  481  		return -EINVAL;
b8cc1a1cce30cc Kiran K 2025-02-27  482  
b8cc1a1cce30cc Kiran K 2025-02-27  483  	ktime_get_real_ts64(&now);
b8cc1a1cce30cc Kiran K 2025-02-27  484  	time64_to_tm(now.tv_sec, 0, &tm_now);
b8cc1a1cce30cc Kiran K 2025-02-27  485  	dump_time_len = snprintf(buf, sizeof(buf), "Dump Time: %02d-%02d-%04ld %02d:%02d:%02d",
b8cc1a1cce30cc Kiran K 2025-02-27  486  				 tm_now.tm_mday, tm_now.tm_mon + 1, tm_now.tm_year + 1900,
b8cc1a1cce30cc Kiran K 2025-02-27  487  				 tm_now.tm_hour, tm_now.tm_min, tm_now.tm_sec);
b8cc1a1cce30cc Kiran K 2025-02-27  488  
b8cc1a1cce30cc Kiran K 2025-02-27  489  	fw_build = snprintf(buf + dump_time_len, sizeof(buf),
                                                                                         ^^^^^^^^^^^

This size should be "sizeof(buf) - dump_time_len".  It's better to
use scnprintf() here vs snprintf().  The scnprintf() function returns
the number of bytes which were actually printed vs the number which
were printed if there was enough space.

b8cc1a1cce30cc Kiran K 2025-02-27  490  			    "Firmware Timestamp: Year %u WW %02u buildtype %u build %u",
b8cc1a1cce30cc Kiran K 2025-02-27  491  			    2000 + (data->dmp_hdr.fw_timestamp >> 8),
b8cc1a1cce30cc Kiran K 2025-02-27  492  			    data->dmp_hdr.fw_timestamp & 0xff, data->dmp_hdr.fw_build_type,
b8cc1a1cce30cc Kiran K 2025-02-27 @493  			    data->dmp_hdr.fw_build_num);
b8cc1a1cce30cc Kiran K 2025-02-27  494  
b8cc1a1cce30cc Kiran K 2025-02-27  495  	hdr_len = sizeof(*tlv) + sizeof(data->dmp_hdr.cnvi_bt) +
b8cc1a1cce30cc Kiran K 2025-02-27  496  		  sizeof(*tlv) + sizeof(data->dmp_hdr.write_ptr) +
b8cc1a1cce30cc Kiran K 2025-02-27  497  		  sizeof(*tlv) + sizeof(data->dmp_hdr.wrap_ctr) +
b8cc1a1cce30cc Kiran K 2025-02-27  498  		  sizeof(*tlv) + sizeof(data->dmp_hdr.trigger_reason) +
b8cc1a1cce30cc Kiran K 2025-02-27  499  		  sizeof(*tlv) + sizeof(data->dmp_hdr.fw_git_sha1) +
b8cc1a1cce30cc Kiran K 2025-02-27  500  		  sizeof(*tlv) + sizeof(data->dmp_hdr.cnvr_top) +
b8cc1a1cce30cc Kiran K 2025-02-27  501  		  sizeof(*tlv) + sizeof(data->dmp_hdr.cnvi_top) +
b8cc1a1cce30cc Kiran K 2025-02-27  502  		  sizeof(*tlv) + dump_time_len +
b8cc1a1cce30cc Kiran K 2025-02-27  503  		  sizeof(*tlv) + fw_build;
b8cc1a1cce30cc Kiran K 2025-02-27  504  
b8cc1a1cce30cc Kiran K 2025-02-27  505  	dump_size = hdr_len + sizeof(hdr_len);
b8cc1a1cce30cc Kiran K 2025-02-27  506  
b8cc1a1cce30cc Kiran K 2025-02-27  507  	skb = alloc_skb(dump_size, GFP_KERNEL);
b8cc1a1cce30cc Kiran K 2025-02-27  508  	if (!skb)
b8cc1a1cce30cc Kiran K 2025-02-27  509  		return -ENOMEM;
b8cc1a1cce30cc Kiran K 2025-02-27  510  
b8cc1a1cce30cc Kiran K 2025-02-27  511  	/* Add debug buffers data length to dump size */
b8cc1a1cce30cc Kiran K 2025-02-27  512  	dump_size += BTINTEL_PCIE_DBGC_BUFFER_SIZE * dbgc->count;
b8cc1a1cce30cc Kiran K 2025-02-27  513  
b8cc1a1cce30cc Kiran K 2025-02-27  514  	ret = hci_devcd_init(hdev, dump_size);
b8cc1a1cce30cc Kiran K 2025-02-27  515  	if (ret) {
b8cc1a1cce30cc Kiran K 2025-02-27  516  		bt_dev_err(hdev, "Failed to init devcoredump, err %d", ret);
b8cc1a1cce30cc Kiran K 2025-02-27  517  		kfree_skb(skb);
b8cc1a1cce30cc Kiran K 2025-02-27  518  		return ret;
b8cc1a1cce30cc Kiran K 2025-02-27  519  	}
b8cc1a1cce30cc Kiran K 2025-02-27  520  
b8cc1a1cce30cc Kiran K 2025-02-27  521  	skb_put_data(skb, &hdr_len, sizeof(hdr_len));
b8cc1a1cce30cc Kiran K 2025-02-27  522  
b8cc1a1cce30cc Kiran K 2025-02-27  523  	btintel_pcie_copy_tlv(skb, BTINTEL_CNVI_BT, &data->dmp_hdr.cnvi_bt,
b8cc1a1cce30cc Kiran K 2025-02-27  524  			      sizeof(data->dmp_hdr.cnvi_bt));
b8cc1a1cce30cc Kiran K 2025-02-27  525  
b8cc1a1cce30cc Kiran K 2025-02-27  526  	btintel_pcie_copy_tlv(skb, BTINTEL_WRITE_PTR, &data->dmp_hdr.write_ptr,
b8cc1a1cce30cc Kiran K 2025-02-27  527  			      sizeof(data->dmp_hdr.write_ptr));
b8cc1a1cce30cc Kiran K 2025-02-27  528  
b8cc1a1cce30cc Kiran K 2025-02-27  529  	data->dmp_hdr.wrap_ctr = btintel_pcie_rd_dev_mem(data,
b8cc1a1cce30cc Kiran K 2025-02-27  530  							 BTINTEL_PCIE_DBGC_DBGBUFF_WRAP_ARND);
b8cc1a1cce30cc Kiran K 2025-02-27  531  
b8cc1a1cce30cc Kiran K 2025-02-27  532  	btintel_pcie_copy_tlv(skb, BTINTEL_WRAP_CTR, &data->dmp_hdr.wrap_ctr,
b8cc1a1cce30cc Kiran K 2025-02-27  533  			      sizeof(data->dmp_hdr.wrap_ctr));
b8cc1a1cce30cc Kiran K 2025-02-27  534  
b8cc1a1cce30cc Kiran K 2025-02-27  535  	btintel_pcie_copy_tlv(skb, BTINTEL_TRIGGER_REASON, &data->dmp_hdr.trigger_reason,
b8cc1a1cce30cc Kiran K 2025-02-27  536  			      sizeof(data->dmp_hdr.trigger_reason));
b8cc1a1cce30cc Kiran K 2025-02-27  537  
b8cc1a1cce30cc Kiran K 2025-02-27  538  	btintel_pcie_copy_tlv(skb, BTINTEL_FW_SHA, &data->dmp_hdr.fw_git_sha1,
b8cc1a1cce30cc Kiran K 2025-02-27  539  			      sizeof(data->dmp_hdr.fw_git_sha1));
b8cc1a1cce30cc Kiran K 2025-02-27  540  
b8cc1a1cce30cc Kiran K 2025-02-27  541  	btintel_pcie_copy_tlv(skb, BTINTEL_CNVR_TOP, &data->dmp_hdr.cnvr_top,
b8cc1a1cce30cc Kiran K 2025-02-27  542  			      sizeof(data->dmp_hdr.cnvr_top));
b8cc1a1cce30cc Kiran K 2025-02-27  543  
b8cc1a1cce30cc Kiran K 2025-02-27  544  	btintel_pcie_copy_tlv(skb, BTINTEL_CNVI_TOP, &data->dmp_hdr.cnvi_top,
b8cc1a1cce30cc Kiran K 2025-02-27  545  			      sizeof(data->dmp_hdr.cnvi_top));
b8cc1a1cce30cc Kiran K 2025-02-27  546  
b8cc1a1cce30cc Kiran K 2025-02-27  547  	btintel_pcie_copy_tlv(skb, BTINTEL_DUMP_TIME, buf, dump_time_len);
b8cc1a1cce30cc Kiran K 2025-02-27  548  
b8cc1a1cce30cc Kiran K 2025-02-27  549  	btintel_pcie_copy_tlv(skb, BTINTEL_FW_BUILD, buf + dump_time_len, fw_build);
b8cc1a1cce30cc Kiran K 2025-02-27  550  
b8cc1a1cce30cc Kiran K 2025-02-27  551  	ret = hci_devcd_append(hdev, skb);
b8cc1a1cce30cc Kiran K 2025-02-27  552  	if (ret)
b8cc1a1cce30cc Kiran K 2025-02-27  553  		goto exit_err;
b8cc1a1cce30cc Kiran K 2025-02-27  554  
b8cc1a1cce30cc Kiran K 2025-02-27  555  	for (i = 0; i < dbgc->count; i++) {
b8cc1a1cce30cc Kiran K 2025-02-27  556  		ret = btintel_pcie_add_dmp_data(hdev, dbgc->bufs[i].data,
b8cc1a1cce30cc Kiran K 2025-02-27  557  						BTINTEL_PCIE_DBGC_BUFFER_SIZE);
b8cc1a1cce30cc Kiran K 2025-02-27  558  		if (ret)
b8cc1a1cce30cc Kiran K 2025-02-27  559  			break;
b8cc1a1cce30cc Kiran K 2025-02-27  560  	}
b8cc1a1cce30cc Kiran K 2025-02-27  561  
b8cc1a1cce30cc Kiran K 2025-02-27  562  exit_err:
b8cc1a1cce30cc Kiran K 2025-02-27  563  	hci_devcd_complete(hdev);
b8cc1a1cce30cc Kiran K 2025-02-27  564  	return ret;
b8cc1a1cce30cc Kiran K 2025-02-27  565  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

