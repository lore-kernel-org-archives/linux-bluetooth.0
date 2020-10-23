Return-Path: <SRS0=0zex=D6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B59C388F9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Oct 2020 13:43:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FD602192A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Oct 2020 13:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465140AbgJWNnU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Oct 2020 09:43:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:22932 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S465135AbgJWNnU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Oct 2020 09:43:20 -0400
IronPort-SDR: 0h5LP0tBNLiuVoeTRNKrXpA5Hd/lLx4FiXQQHBG/EQq80ANjabxg2RvkS5WAvvJSCRxE02o38q
 SM/ngbkxJKYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="165083894"
X-IronPort-AV: E=Sophos;i="5.77,408,1596524400"; 
   d="gz'50?scan'50,208,50";a="165083894"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2020 06:43:16 -0700
IronPort-SDR: 1BbfSWd3QniDpjKdHujT8tODUg616LZDDMQaBwd5Uxwq3h1oh8LYUPXrwkI0M7QGCOQbdOBk1C
 +wphLfnkZ0Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,408,1596524400"; 
   d="gz'50?scan'50,208,50";a="302672671"
Received: from lkp-server01.sh.intel.com (HELO 1f55bd7cde4b) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 23 Oct 2020 06:43:12 -0700
Received: from kbuild by 1f55bd7cde4b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kVxLc-0000Dx-9S; Fri, 23 Oct 2020 13:43:12 +0000
Date:   Fri, 23 Oct 2020 21:42:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, marcel@holtmann.org,
        johan.hedberg@gmail.com
Cc:     kbuild-all@lists.01.org, max.chou@realtek.com,
        alex_lu@realsil.com.cn,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: btrtl: Ask 8821C to drop old firmware after
 shutdown
Message-ID: <202010232157.C8DumIU3-lkp@intel.com>
References: <20201022142648.446-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <20201022142648.446-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kai-Heng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on bluetooth/master v5.9 next-20201023]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Kai-Heng-Feng/Bluetooth-btrtl-Ask-8821C-to-drop-old-firmware-after-shutdown/20201022-222743
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
config: m68k-randconfig-s031-20201023 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-17-g2d3af347-dirty
        # https://github.com/0day-ci/linux/commit/d430672c074dec68229560c1d1309c99cc769efe
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Kai-Heng-Feng/Bluetooth-btrtl-Ask-8821C-to-drop-old-firmware-after-shutdown/20201022-222743
        git checkout d430672c074dec68229560c1d1309c99cc769efe
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
>> drivers/bluetooth/btrtl.c:589:37: sparse: sparse: restricted __le16 degrades to integer
>> drivers/bluetooth/btrtl.c:589:37: sparse: sparse: cast to restricted __le16
>> drivers/bluetooth/btrtl.c:589:37: sparse: sparse: restricted __le16 degrades to integer
>> drivers/bluetooth/btrtl.c:589:37: sparse: sparse: cast to restricted __le16
>> drivers/bluetooth/btrtl.c:589:37: sparse: sparse: restricted __le16 degrades to integer
>> drivers/bluetooth/btrtl.c:589:37: sparse: sparse: cast to restricted __le16
>> drivers/bluetooth/btrtl.c:589:37: sparse: sparse: restricted __le16 degrades to integer
>> drivers/bluetooth/btrtl.c:589:37: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btrtl.c:590:37: sparse: sparse: restricted __le16 degrades to integer
   drivers/bluetooth/btrtl.c:590:37: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btrtl.c:590:37: sparse: sparse: restricted __le16 degrades to integer
   drivers/bluetooth/btrtl.c:590:37: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btrtl.c:590:37: sparse: sparse: restricted __le16 degrades to integer
   drivers/bluetooth/btrtl.c:590:37: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btrtl.c:590:37: sparse: sparse: restricted __le16 degrades to integer
   drivers/bluetooth/btrtl.c:590:37: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btrtl.c: note: in included file:
   drivers/bluetooth/btrtl.h:47:45: sparse: sparse: array of flexible structures

vim +589 drivers/bluetooth/btrtl.c

   556	
   557	struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
   558						   const char *postfix)
   559	{
   560		struct btrtl_device_info *btrtl_dev;
   561		struct sk_buff *skb;
   562		struct hci_rp_read_local_version *resp;
   563		char cfg_name[40];
   564		u16 hci_rev, lmp_subver;
   565		u8 hci_ver;
   566		int ret;
   567	
   568		btrtl_dev = kzalloc(sizeof(*btrtl_dev), GFP_KERNEL);
   569		if (!btrtl_dev) {
   570			ret = -ENOMEM;
   571			goto err_alloc;
   572		}
   573	
   574		skb = btrtl_read_local_version(hdev);
   575		if (IS_ERR(skb)) {
   576			ret = PTR_ERR(skb);
   577			goto err_free;
   578		}
   579	
   580		resp = (struct hci_rp_read_local_version *)skb->data;
   581		rtl_dev_info(hdev, "examining hci_ver=%02x hci_rev=%04x lmp_ver=%02x lmp_subver=%04x",
   582			     resp->hci_ver, resp->hci_rev,
   583			     resp->lmp_ver, resp->lmp_subver);
   584	
   585		hci_ver = resp->hci_ver;
   586		hci_rev = le16_to_cpu(resp->hci_rev);
   587		lmp_subver = le16_to_cpu(resp->lmp_subver);
   588	
 > 589		if (resp->hci_ver == 0x8 && le16_to_cpu(resp->hci_rev == 0x826c) &&
   590		    resp->lmp_ver == 0x8 && le16_to_cpu(resp->lmp_subver == 0xa99e))
   591			btrtl_dev->drop_fw = true;
   592	
   593		kfree_skb(skb);
   594	
   595		btrtl_dev->ic_info = btrtl_match_ic(lmp_subver, hci_rev, hci_ver,
   596						    hdev->bus);
   597	
   598		if (!btrtl_dev->ic_info) {
   599			rtl_dev_info(hdev, "unknown IC info, lmp subver %04x, hci rev %04x, hci ver %04x",
   600				    lmp_subver, hci_rev, hci_ver);
   601			return btrtl_dev;
   602		}
   603	
   604		if (btrtl_dev->ic_info->has_rom_version) {
   605			ret = rtl_read_rom_version(hdev, &btrtl_dev->rom_version);
   606			if (ret)
   607				goto err_free;
   608		}
   609	
   610		btrtl_dev->fw_len = rtl_load_file(hdev, btrtl_dev->ic_info->fw_name,
   611						  &btrtl_dev->fw_data);
   612		if (btrtl_dev->fw_len < 0) {
   613			rtl_dev_err(hdev, "firmware file %s not found",
   614				    btrtl_dev->ic_info->fw_name);
   615			ret = btrtl_dev->fw_len;
   616			goto err_free;
   617		}
   618	
   619		if (btrtl_dev->ic_info->cfg_name) {
   620			if (postfix) {
   621				snprintf(cfg_name, sizeof(cfg_name), "%s-%s.bin",
   622					 btrtl_dev->ic_info->cfg_name, postfix);
   623			} else {
   624				snprintf(cfg_name, sizeof(cfg_name), "%s.bin",
   625					 btrtl_dev->ic_info->cfg_name);
   626			}
   627			btrtl_dev->cfg_len = rtl_load_file(hdev, cfg_name,
   628							   &btrtl_dev->cfg_data);
   629			if (btrtl_dev->ic_info->config_needed &&
   630			    btrtl_dev->cfg_len <= 0) {
   631				rtl_dev_err(hdev, "mandatory config file %s not found",
   632					    btrtl_dev->ic_info->cfg_name);
   633				ret = btrtl_dev->cfg_len;
   634				goto err_free;
   635			}
   636		}
   637	
   638		return btrtl_dev;
   639	
   640	err_free:
   641		btrtl_free(btrtl_dev);
   642	err_alloc:
   643		return ERR_PTR(ret);
   644	}
   645	EXPORT_SYMBOL_GPL(btrtl_initialize);
   646	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--xHFwDpU9dbj6ez1V
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AQWG4FUAdgEA

--xHFwDpU9dbj6ez1V--
