Return-Path: <SRS0=o7la=44=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE69C10DCE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 01:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E3A1215A4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Mar 2020 01:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgCKBWN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Mar 2020 21:22:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:25057 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727506AbgCKBWN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Mar 2020 21:22:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Mar 2020 18:22:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,539,1574150400"; 
   d="scan'208";a="289210189"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.3])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Mar 2020 18:22:10 -0700
Date:   Wed, 11 Mar 2020 09:21:58 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Luiz Von Dentz <luiz.dentz@gmail.com>,
        kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-bluetooth@vger.kernel.org
Subject: Re: Re: [PATCH 02/10] Bluetooth: Add initial implementation of CIS
 connections
Message-ID: <20200311012158.GA3692@shao2-debian>
References: <20200306000424.GA30363@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200306000424.GA30363@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

> On Tue, Jan 7, 2020 at 12:22 PM, kbuild test robot <lkp@intel.com> wrote:
> > Hi Luiz,
> > 
> > Thank you for the patch! Yet something to improve:
> > 
> > [auto build test ERROR on bluetooth-next/master]
> > [also build test ERROR on next-20200106]
> > [cannot apply to bluetooth/master v5.5-rc5]
> > [if your patch is applied to the wrong git tree, please drop us a note to
> > help
> > improve the system. BTW, we also suggest to use '--base' option to specify
> > the
> > base tree in git format-patch, please see
> > <https://stackoverflow.com/a/37406982>]
> > 
> > url:    <https://github.com/0day-ci/linux/commits/Luiz-Augusto-von-Dentz/Bluetooth-5-2-initial-support/20200107-160723>
> > base:   <https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git>
> > master
> > config: i386-randconfig-f001-20200107 (attached as .config)
> > compiler: gcc-7 (Debian 7.5.0-3) 7.5.0
> > reproduce:
> >         # save the attached .config to linux build tree
> >         make ARCH=i386
> > 
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com <mailto:lkp@intel.com>>
> > 
> > All errors (new ones prefixed by >>):
> > 
> >    ld: net/bluetooth/af_bluetooth.o: in function `bt_init':
> > > >  net/bluetooth/af_bluetooth.c:760: undefined reference to `iso_init'
> > > >  ld: net/bluetooth/af_bluetooth.c:771: undefined reference to
> > > > `iso_exit'
> >    ld: net/bluetooth/hci_core.o: in function `hci_isodata_packet':
> > > >  net/bluetooth/hci_core.c:4480: undefined reference to `iso_recv'
> >    ld: net/bluetooth/hci_event.o: in function `hci_proto_connect_ind':
> > > >  include/net/bluetooth/hci_core.h:1285: undefined reference to
> > > > `iso_connect_ind'
> > > >  ld: include/net/bluetooth/hci_core.h:1285: undefined reference to
> > > > `iso_connect_ind'
> > 
> 
> Interesting, I don't get these error even when compiling patch by patch, those
> symbols are in a new file net/bluetooth/iso.c which seems to be properly added
> so I wonder what is going on here.


Hi,

We confirmed that it could be reproduced with gcc-7.

Best Regards,
Rong Chen

> 
> > vim +760 net/bluetooth/af_bluetooth.c
> > 
> >    718
> >    719	#define VERSION __stringify(BT_SUBSYS_VERSION) "." \
> >    720			__stringify(BT_SUBSYS_REVISION)
> >    721
> >    722	static int __init bt_init(void)
> >    723	{
> >    724		int err;
> >    725
> >    726		sock_skb_cb_check_size(sizeof(struct bt_skb_cb));
> >    727
> >    728		BT_INFO("Core ver %s", VERSION);
> >    729
> >    730		err = bt_selftest();
> >    731		if (err < 0)
> >    732			return err;
> >    733
> >    734		bt_debugfs = debugfs_create_dir("bluetooth", NULL);
> >    735
> >    736		bt_leds_init();
> >    737
> >    738		err = bt_sysfs_init();
> >    739		if (err < 0)
> >    740			return err;
> >    741
> >    742		err = sock_register(&bt_sock_family_ops);
> >    743		if (err)
> >    744			goto cleanup_sysfs;
> >    745
> >    746		BT_INFO("HCI device and connection manager initialized");
> >    747
> >    748		err = hci_sock_init();
> >    749		if (err)
> >    750			goto unregister_socket;
> >    751
> >    752		err = l2cap_init();
> >    753		if (err)
> >    754			goto cleanup_socket;
> >    755
> >    756		err = sco_init();
> >    757		if (err)
> >    758			goto cleanup_cap;
> >    759
> >  > 760		err = iso_init();
> >    761		if (err)
> >    762			goto cleanup_sco;
> >    763
> >    764		err = mgmt_init();
> >    765		if (err)
> >    766			goto cleanup_iso;
> >    767
> >    768		return 0;
> >    769
> >    770	cleanup_iso:
> >  > 771		iso_exit();
> >    772	cleanup_sco:
> >    773		sco_exit();
> >    774	cleanup_cap:
> >    775		l2cap_exit();
> >    776	cleanup_socket:
> >    777		hci_sock_cleanup();
> >    778	unregister_socket:
> >    779		sock_unregister(PF_BLUETOOTH);
> >    780	cleanup_sysfs:
> >    781		bt_sysfs_cleanup();
> >    782		return err;
> >    783	}
> >    784
> > 
> > ---
> > 0-DAY kernel test infrastructure                 Open Source Technology
> > Center
> > <https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org> Intel
> > Corporation
> 
> 
> ----- End forwarded message -----
