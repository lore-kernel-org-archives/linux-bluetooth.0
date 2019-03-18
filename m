Return-Path: <SRS0=9Smc=RV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43EA0C43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Mar 2019 21:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159682133D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Mar 2019 21:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbfCRVLd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Mar 2019 17:11:33 -0400
Received: from mga03.intel.com ([134.134.136.65]:49265 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726891AbfCRVLd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Mar 2019 17:11:33 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Mar 2019 14:11:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,494,1544515200"; 
   d="scan'208";a="308294292"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 18 Mar 2019 14:11:31 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1h5zXf-000Ia9-2a; Tue, 19 Mar 2019 05:11:31 +0800
Date:   Tue, 19 Mar 2019 05:10:45 +0800
From:   kbuild test robot <lkp@intel.com>
To:     SpoorthiX K <spoorthix.k@intel.com>
Cc:     kbuild-all@01.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add support for LE ping feature
Message-ID: <201903190526.yWf29TOn%lkp@intel.com>
References: <1552905425-24048-1-git-send-email-spoorthix.k@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1552905425-24048-1-git-send-email-spoorthix.k@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi SpoorthiX,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on v5.1-rc1 next-20190318]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/SpoorthiX-K/Add-support-for-LE-ping-feature/20190319-031345
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'


sparse warnings: (new ones prefixed by >>)

   include/linux/overflow.h:285:13: sparse: undefined identifier '__builtin_mul_overflow'
   include/linux/overflow.h:285:13: sparse: incorrect type in conditional
   include/linux/overflow.h:285:13:    got void
   include/linux/overflow.h:287:13: sparse: undefined identifier '__builtin_add_overflow'
   include/linux/overflow.h:287:13: sparse: incorrect type in conditional
   include/linux/overflow.h:287:13:    got void
   include/linux/overflow.h:285:13: sparse: not a function <noident>
   include/linux/overflow.h:285:13: sparse: incorrect type in conditional
   include/linux/overflow.h:285:13:    got void
   include/linux/overflow.h:287:13: sparse: not a function <noident>
   include/linux/overflow.h:287:13: sparse: incorrect type in conditional
   include/linux/overflow.h:287:13:    got void
>> net/bluetooth/hci_event.c:4828:32: sparse: incorrect type in assignment (different base types) @@    expected unsigned short [unsigned] [usertype] conn_handle @@    got  short [unsigned] [usertype] conn_handle @@
   net/bluetooth/hci_event.c:4828:32:    expected unsigned short [unsigned] [usertype] conn_handle
   net/bluetooth/hci_event.c:4828:32:    got restricted __le16 [usertype] <noident>
   include/linux/overflow.h:285:13: sparse: call with no type!
   include/linux/overflow.h:287:13: sparse: call with no type!

vim +4828 net/bluetooth/hci_event.c

  4818	
  4819	static void hci_write_auth_payload_to (struct hci_dev *hdev, struct hci_conn *conn)
  4820	{
  4821	        struct hci_cp_write_auth_payload_to cp;
  4822	
  4823	        /* Check for existing LE link established between local
  4824	         * and remote device, also check the controller capability
  4825	         * for LE Ping.
  4826	         */
  4827	        if ((conn->type == LE_LINK) && (lmp_ping_capable(hdev)))  {
> 4828	                cp.conn_handle = cpu_to_le16(conn->handle);
  4829	                cp.timeout = AUTHENTICATED_PAYLOAD_TIMEOUT;
  4830	                hci_send_cmd(conn->hdev, HCI_OP_WRITE_AUTH_PAYLOAD_TO,
  4831				sizeof(cp), &cp);
  4832	        }
  4833	}
  4834	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
