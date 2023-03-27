Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B470CC6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Mar 2023 14:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233022AbjC0OZh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Mar 2023 10:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjC0OZU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Mar 2023 10:25:20 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01BF49D4
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 07:23:27 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l37so5161150wms.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 07:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679927006;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e8WSsMhxzrn75/5BQYHfB14+MaBjiPUmnGVHA9W9Qhs=;
        b=mX3FLVSfj1i5xg2HDI6+lj1Jgz6qP2qgAiu+kEt4yzxt5n0/H9VkNAtiLHWJ4Z+GR8
         hkVaAGPHxD7AgglzIuubRjblHavFlDG3YVmnBjl2VG2tw6EaEiXPoFl7hYeHOpS4WGYJ
         +CJyL0HgPEZZYK8HFEEyT4uRN6wWaWFdIgTFQlZP9HFqU8u99xaiqFdNcMc3AkLk5yfF
         WTgaDa3Uxdar4ovXtAWd4XVhYwgth0QsfysWdyva7GVIoGOc0TePbykwIXEUxiLeMqm3
         ExAlw6s2UhJrYhVqjxDf73IQZsPNOxVzBanvzM2BRUwFA/KiiCC5dwxVWa2QN0lnFkG1
         uCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679927006;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e8WSsMhxzrn75/5BQYHfB14+MaBjiPUmnGVHA9W9Qhs=;
        b=tkozBO8sJnMAa70WKlwYGXs3x7W5CwyRqTf2xN1zNGPho/EqcZ8KZ2URdbXZ8P+179
         u9hbt+L1w+rzGSrDiuvw0Z08xyACUjyCWujS1FnjA1Qd0lvb6He/N7qf39Z/8c5z1ejl
         74F0X8//HdIOdHDY3TPXPkNoG88teMYpVc6cgP6AYwc6zyLw2R0fRO4KJuyP7oVsZsZQ
         FPzYB/YWM6Yybo5hXJ4R17/z/VS15hUSVf2ERxEpYS9YOf04x4Q4kFPbJtutsi/TbA0a
         eAFIuQZRXyKfPV/SWKYuAzQNRek8u9TGTU0917smkx2eatNe2H4wi5bEeHl1JwkWX5Jb
         woKQ==
X-Gm-Message-State: AO0yUKX8+/X/RL1/fSLXKwOnBky5zVD2LTjNO/p0XdEy32cGzqAjzuzb
        k7cMJULqhJYt81wHSUz/hdA=
X-Google-Smtp-Source: AK7set9TL/FPUSrzhU8M3APHh5F3sNpZmO3w8yfvfX18JiMJPvidtrBe/kV45HHUijNH/fa9qzp8zg==
X-Received: by 2002:a7b:c7ce:0:b0:3ee:5147:3acc with SMTP id z14-20020a7bc7ce000000b003ee51473accmr10162550wmk.36.1679927006321;
        Mon, 27 Mar 2023 07:23:26 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id c13-20020a05600c0acd00b003ee42696acesm13858542wmr.16.2023.03.27.07.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 07:23:25 -0700 (PDT)
Date:   Mon, 27 Mar 2023 17:23:14 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     oe-kbuild@lists.linux.dev,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH 1/2] Bluetooth: hci_conn: Fix not cleaning up on LE
 Connection failure
Message-ID: <324e4379-6011-4d56-91df-f00f03b78ebb@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324204525.3630188-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-Fix-printing-errors-if-LE-Connection-times-out/20230325-044559
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20230324204525.3630188-1-luiz.dentz%40gmail.com
patch subject: [PATCH 1/2] Bluetooth: hci_conn: Fix not cleaning up on LE Connection failure
config: riscv-randconfig-m031-20230326 (https://download.01.org/0day-ci/archive/20230327/202303272048.I3jduMCE-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <error27@gmail.com>
| Link: https://lore.kernel.org/r/202303272048.I3jduMCE-lkp@intel.com/

smatch warnings:
net/bluetooth/hci_conn.c:1202 hci_le_conn_failed() error: uninitialized symbol 'params'.

vim +/params +1202 net/bluetooth/hci_conn.c

9b3628d79b46f0 Luiz Augusto von Dentz 2022-04-22  1188  static void hci_le_conn_failed(struct hci_conn *conn, u8 status)
9bb3c01fdb2201 Andre Guedes           2014-01-30  1189  {
9bb3c01fdb2201 Andre Guedes           2014-01-30  1190  	struct hci_dev *hdev = conn->hdev;
f161dd4122ffa7 Johan Hedberg          2014-08-15  1191  	struct hci_conn_params *params;
f161dd4122ffa7 Johan Hedberg          2014-08-15  1192  
e15b8378a4f322 Luiz Augusto von Dentz 2023-03-24  1193  	hci_connect_le_scan_cleanup(conn);
9bb3c01fdb2201 Andre Guedes           2014-01-30  1194  
acb9f911ea1f82 Johan Hedberg          2015-12-03  1195  	/* If the status indicates successful cancellation of
91641b79e1e153 Zheng Yongjun          2021-06-02  1196  	 * the attempt (i.e. Unknown Connection Id) there's no point of
acb9f911ea1f82 Johan Hedberg          2015-12-03  1197  	 * notifying failure since we'll go back to keep trying to
acb9f911ea1f82 Johan Hedberg          2015-12-03  1198  	 * connect. The only exception is explicit connect requests
acb9f911ea1f82 Johan Hedberg          2015-12-03  1199  	 * where a timeout + cancel does indicate an actual failure.
acb9f911ea1f82 Johan Hedberg          2015-12-03  1200  	 */
acb9f911ea1f82 Johan Hedberg          2015-12-03  1201  	if (status != HCI_ERROR_UNKNOWN_CONN_ID ||
acb9f911ea1f82 Johan Hedberg          2015-12-03 @1202  	    (params && params->explicit_connect))
                                                                     ^^^^^^
params is uninitialized

acb9f911ea1f82 Johan Hedberg          2015-12-03  1203  		mgmt_connect_failed(hdev, &conn->dst, conn->type,
acb9f911ea1f82 Johan Hedberg          2015-12-03  1204  				    conn->dst_type, status);
9bb3c01fdb2201 Andre Guedes           2014-01-30  1205  
abfeea476c68af Luiz Augusto von Dentz 2021-10-27  1206  	/* Enable advertising in case this was a failed connection
3c857757ef6e5a Johan Hedberg          2014-03-25  1207  	 * attempt as a peripheral.
3c857757ef6e5a Johan Hedberg          2014-03-25  1208  	 */
abfeea476c68af Luiz Augusto von Dentz 2021-10-27  1209  	hci_enable_advertising(hdev);
9bb3c01fdb2201 Andre Guedes           2014-01-30  1210  }
9bb3c01fdb2201 Andre Guedes           2014-01-30  1211  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

