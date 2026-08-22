Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05D738E5ED
	for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787386233; cv=none; b=o7gQxl8n3tAy8SuYoeg4bgBltXbit/6OWFAdUcua57PYZCUOIw3rp4pqpO44cpH/59bKOYuaC1htRJy5D+1NX68cXJZT0NLBH/i5IwKQLARzdtojJ+FmndzyAr4qFGXDl9rz2Z43Yg6TE+LZFaywMNa8buzQLQUJfqj7PIBYSU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787386233; c=relaxed/simple;
	bh=GzsnqybtEeIEXRxD1/jQsF/biSfYAhhrHp4FnmH5LNg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=q4ZlD9HYaurxeM9LWPUHnxVunbVoTksOZoPVDsi70zztEo5INyowMXsdouXdrpb2VSQsr/EMqMEvcY71540m0+iaPlP+zhyUA5wWBn0QUBRpH8/ntte4vtWsMHXlunteBQZ5vtrrJxccihQGz3ItDGi+iNBza5oiu3KdwgcWPeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQdONhs7; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQdONhs7"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f59f25ec4so867228f8f.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 22 Aug 2026 01:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787386230; x=1787991030; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/WLIOyN5e+42p5FHJTXJ2LgHUHUABa7KAUy5fhDC4CY=;
        b=XQdONhs7GVSWMxzVwgx3Wnsg19H7QPB8LMopd1NFjkcB000MtVlNd6vRWUO7l4ptos
         1QPPT0ljNuDsP7HXgHSElD5iRfNBbgO+Af9zt+7TuD9NhV7IpWUkvj6AESDJ0j8eEcGa
         JMtjlPlH813NSddrrqZdCtAucSfVCocDonLOztfq8qORSSEKKgig2VgvUhv1dE7CR8rx
         ycEMhflo5uLv1hhCvHWP71KppBMUHHL3+VLF6ZnTlu6Ac5TCtSgoRdWwnhF54fjkLZjz
         9waEK4LNVnD9V9QKdJ8GKCcwtXvCl01VrFW2DisHrCSu7xlEkXmBbz7i/JCdJ1aHufYO
         zd5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787386230; x=1787991030;
        h=in-reply-to:content-disposition:content-type:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/WLIOyN5e+42p5FHJTXJ2LgHUHUABa7KAUy5fhDC4CY=;
        b=P0OECHn/TfBrAS8FSC3HGR8ROYNN9Ntrqq6P3sktyjIWCfsPlxeXXIZ+S8XdmxtEQs
         5hb+q+9VlqTsMl5ohO3g4SN7dDf9gjsSsxqaHYtyVNEYVIpaRroPcJxcB3Sic5jQnfCS
         wxTb0+zTlv/cB+zVPdVzwLm+t5AtoNM9fQNMi8zNFAIyO4SB7n4o1rI3sOEmLXxqgUnZ
         HMrr/dQ448s425nrTyEw2nfrLwQIA/ledJEGWMv8pXGXMq8pqmjOgeXNUFjYANJa4/na
         tb7hsHRl/HJe4wbjon3ITMN1KoS11/S/MuD36rUgsG6J7fFJL/ncPntUZbeJ0Uh1Fphf
         weuA==
X-Forwarded-Encrypted: i=1; AHgh+Rrh+tZQfcsSu2ctep5JTO1cWZHrBhz4Q2HBsxF27im4K2AJlKuggDOvum4v/ikv9pwnE8ZAkoIKp0FfcjG2PJc=@vger.kernel.org
X-Gm-Message-State: AFuF++lZ00OhP0/kxJF/hIT9kE1/yLFsUb8xJBIUAIWkYVxqVjwI7A3a
	6ZT287dy88Q6dec2YNOr2b+hFtdPjcINWzHtNVjzLGJ9uxiDx2rQq3Ny
X-Gm-Gg: AR+sD10gsYRBrja+QP5nnZgkv/eey3Cz/ICxSUhUQwz+Auiz+0ulDbZ9PjjDplnkRyd
	h3lF3R04VbMARinF3AUf1TDYQoVFrXhMBEOSF66GgQWg3J0PajCgOwur2TA+ptU9x+J+5F8aqRx
	UuJkm2jdQc7Z/b7aBMhtntMe2ThCOQ4CsO3mVmBhX0EBwmhOEQwHslsoFZDahV4JXeOBAd/9MBv
	jG788iZY5EBjUVWnRbmTmJcD9X/ZSD93N6px/RgBMxOVIVDjQgW4bsvzdHWMXsLiYZya3zkhZCy
	KBCdbraTHMnj9CM4tpgnJ3iRbsUM5TbIZ0Jxkf0/AYVzYUDGLPBegVwO0qNSI0Rt/E7L4ua+HOi
	0q0RcW1T4wTiyBC3D20tWBf6ODUJxgxMDvprGH5lispyWW8npxkb3WHQX6Aj0XgngcdbfdVCiYv
	rpDcP4TOT53c4ptzoWomRy8nFv7AW+k71Iz4+sjYUzfYMiZ9omRfFen0VA
X-Received: by 2002:a05:6000:27c4:b0:482:c678:72d3 with SMTP id ffacd0b85a97d-482c67873d2mr5600177f8f.15.1787386229786;
        Sat, 22 Aug 2026 01:10:29 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482c9a9f145sm1423683f8f.0.2026.08.22.01.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:10:29 -0700 (PDT)
Date: Sat, 22 Aug 2026 11:10:24 +0300
From: Dan Carpenter <error27@gmail.com>
To: oe-kbuild@lists.linux.dev, Hilda Wu <hildawu@realtek.com>,
	marcel@holtmann.org
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev, luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	alex_lu@realsil.com.cn, jason_mao@realsil.com.cn,
	zoey_zhou@realsil.com.cn, max.chou@realtek.com, kidman@realtek.com
Subject: Re: [PATCH v6] Bluetooth: btrtl: Add firmware format v3 support
Message-ID: <202608221220.dvi7OT84-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260814065920.413487-1-hildawu@realtek.com>

Hi Hilda,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hilda-Wu/Bluetooth-btrtl-Add-firmware-format-v3-support/20260814-145920
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
patch link:    https://lore.kernel.org/r/20260814065920.413487-1-hildawu%40realtek.com
patch subject: [PATCH v6] Bluetooth: btrtl: Add firmware format v3 support
config: x86_64-randconfig-161 (https://download.01.org/0day-ci/archive/20260822/202608221220.dvi7OT84-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch: v0.5.0-9187-g5189e3fb

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Closes: https://lore.kernel.org/r/202608221220.dvi7OT84-lkp@intel.com/

New smatch warnings:
drivers/bluetooth/btrtl.c:1106 btrtl_free() warn: variable dereferenced before check 'btrtl_dev' (see line 1098)

Old smatch warnings:
drivers/bluetooth/btrtl.c:1326 btrtl_initialize() warn: passing zero to 'ERR_PTR'

vim +/btrtl_dev +1106 drivers/bluetooth/btrtl.c

26503ad25de8c7c Martin Blumenstingl 2018-08-02  1094  void btrtl_free(struct btrtl_device_info *btrtl_dev)
26503ad25de8c7c Martin Blumenstingl 2018-08-02  1095  {
9a24ce5e29b15c4 Max Chou            2023-04-17  1096  	struct rtl_subsection *entry, *tmp;
9a24ce5e29b15c4 Max Chou            2023-04-17  1097  
268d3636dfb2225 Alice Mikityanska   2020-01-24 @1098  	kvfree(btrtl_dev->fw_data);
268d3636dfb2225 Alice Mikityanska   2020-01-24  1099  	kvfree(btrtl_dev->cfg_data);
9a24ce5e29b15c4 Max Chou            2023-04-17  1100  
9a24ce5e29b15c4 Max Chou            2023-04-17  1101  	list_for_each_entry_safe(entry, tmp, &btrtl_dev->patch_subsecs, list) {
9a24ce5e29b15c4 Max Chou            2023-04-17  1102  		list_del(&entry->list);
9a24ce5e29b15c4 Max Chou            2023-04-17  1103  		kfree(entry);
9a24ce5e29b15c4 Max Chou            2023-04-17  1104  	}
9a24ce5e29b15c4 Max Chou            2023-04-17  1105  
8e4d5e1dbe2345c Hilda Wu            2026-08-14 @1106  	if (btrtl_dev) {

No point in checking for NULL when we have already dereferenced
btrtl_dev so many times.

8e4d5e1dbe2345c Hilda Wu            2026-08-14  1107  		struct btrtl_enh_ops *ops = symbol_get(rtl_enh_ops);
8e4d5e1dbe2345c Hilda Wu            2026-08-14  1108  
8e4d5e1dbe2345c Hilda Wu            2026-08-14  1109  		if (ops) {
8e4d5e1dbe2345c Hilda Wu            2026-08-14  1110  			if (ops->free_patch_images)
8e4d5e1dbe2345c Hilda Wu            2026-08-14  1111  				ops->free_patch_images(btrtl_dev);
8e4d5e1dbe2345c Hilda Wu            2026-08-14  1112  			symbol_put(rtl_enh_ops);
8e4d5e1dbe2345c Hilda Wu            2026-08-14  1113  		}
8e4d5e1dbe2345c Hilda Wu            2026-08-14  1114  	}
8e4d5e1dbe2345c Hilda Wu            2026-08-14  1115  
26503ad25de8c7c Martin Blumenstingl 2018-08-02  1116  	kfree(btrtl_dev);
26503ad25de8c7c Martin Blumenstingl 2018-08-02  1117  }

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

