Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE37EDE9BC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Sep 2023 12:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjINMoA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Sep 2023 08:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjINMoA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Sep 2023 08:44:00 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF7F1FC9
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 05:43:55 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3ff7d73a6feso10017295e9.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Sep 2023 05:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694695434; x=1695300234; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RVMnfKNHlwV6ahUqneKXp7GuP6scvwxex/BQBdlMFRA=;
        b=kgjP3RmMQJNPr8ljPM6TFjzSByj/FJHFM2QHKmTTfZeFoM58LrDANOWEiVcsWxixaN
         UO6YPsCxn1IRyZQb1a/zyC3rxU6/zR2CRyVv0UuXJ5+EijSDtHqCs6+EM+AC0shMdh0N
         1tqJbpnnvOIMv8cQj48Pr00ISbw3vNKun6oryfzJjjSFg2VKNhYfzmESzbuFYXHwp0zD
         3Y8cMmHk1B5OydWCQV5Ut/0Iqvj/okgRSYFSKwqReHMFrT9STK4cEeFn/8cwsKDhnbwV
         uHAsrB7Egq0EQgbwwMkpM4Py3eLLwYQo9i7jf4rwe1p02wgxpWROmS1MBHbYlolu6u/a
         g4Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694695434; x=1695300234;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RVMnfKNHlwV6ahUqneKXp7GuP6scvwxex/BQBdlMFRA=;
        b=QdXoRm4ZHEDgDjikS2GX74cmGHCvA+aOCLJvi60KD1x305kRxCB5wuvt1VNheVyFzX
         0krb9J12sVKzJDKMiJ4P5rUvfvKTjHorfz2RX3Y8pzo0JajZzujsKflcgV+b2+pqvDTf
         kLwD2MiGdUbepe2z9TiZZMEosivkI1QqBPK0C8t7smtlJ5Kx9kwjARQmQ7jxgmfqCDuV
         aye4n0DMAz9+39xW2j/NtmHNpF6rJJYEMdgL4EJtAi6aVBuRz9sFpcrLJ4HaL5XGRTv0
         hhW/VpEM445De5+UjkHA8Z+AS2Sqt+EehpKNgTEQu6K+Mh8+olBBpLSQMo9EXmhx/Ntc
         hZqw==
X-Gm-Message-State: AOJu0YzjTICKPGSCdfCNb+KCDFj3QDTsS6q+Uv+giuE1a6j55880a/h8
        gtKJ16XrYaQNmVWdHHFLaaUiQQ==
X-Google-Smtp-Source: AGHT+IHizEGuq+cT4++mpZfrpEE6exeXMp3yxFmX2ySqhur0dQwpWf3YFrbEFdNIUnwIadb+kIymEw==
X-Received: by 2002:a05:600c:3787:b0:402:ee72:2314 with SMTP id o7-20020a05600c378700b00402ee722314mr4705085wmr.3.1694695434062;
        Thu, 14 Sep 2023 05:43:54 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c231a00b003fe1a96845bsm4795661wmo.2.2023.09.14.05.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 05:43:53 -0700 (PDT)
Date:   Thu, 14 Sep 2023 15:43:50 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     oe-kbuild@lists.linux.dev,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix leaking l2cap_conn objects
Message-ID: <70e80b39-c974-4069-acce-d8ea7559555b@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913193839.3029428-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

kernel test robot noticed the following build warnings:

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-L2CAP-Fix-leaking-l2cap_conn-objects/20230914-034053
base:   linus/master
patch link:    https://lore.kernel.org/r/20230913193839.3029428-1-luiz.dentz%40gmail.com
patch subject: [PATCH] Bluetooth: L2CAP: Fix leaking l2cap_conn objects
config: x86_64-randconfig-161-20230914 (https://download.01.org/0day-ci/archive/20230914/202309141910.lGRlJL61-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230914/202309141910.lGRlJL61-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202309141910.lGRlJL61-lkp@intel.com/

smatch warnings:
net/bluetooth/hci_conn.c:2725 hci_chan_del() warn: variable dereferenced before check 'conn' (see line 2723)

vim +/conn +2725 net/bluetooth/hci_conn.c

9472007c62ecc8 Andrei Emeltchenko     2012-09-06  2720  void hci_chan_del(struct hci_chan *chan)
73d80deb7bdf01 Luiz Augusto von Dentz 2011-11-02  2721  {
73d80deb7bdf01 Luiz Augusto von Dentz 2011-11-02  2722  	struct hci_conn *conn = chan->conn;
73d80deb7bdf01 Luiz Augusto von Dentz 2011-11-02 @2723  	struct hci_dev *hdev = conn->hdev;
                                                                                       ^^^^^^^^^^
Dereference

73d80deb7bdf01 Luiz Augusto von Dentz 2011-11-02  2724  
6fc2f406e4158e Luiz Augusto von Dentz 2023-09-13 @2725  	if (!conn)
                                                                    ^^^^^
Too late

6fc2f406e4158e Luiz Augusto von Dentz 2023-09-13  2726  		return;

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

