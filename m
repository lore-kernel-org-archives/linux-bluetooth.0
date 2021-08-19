Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A167C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 19:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 461D8604DC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Aug 2021 19:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhHSTPQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Aug 2021 15:15:16 -0400
Received: from mga12.intel.com ([192.55.52.136]:44320 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229465AbhHSTPQ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Aug 2021 15:15:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10081"; a="196212038"
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="gz'50?scan'50,208,50";a="196212038"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2021 12:14:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,335,1620716400"; 
   d="gz'50?scan'50,208,50";a="451746209"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 19 Aug 2021 12:14:36 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mGnUq-000UDD-09; Thu, 19 Aug 2021 19:14:36 +0000
Date:   Fri, 20 Aug 2021 03:13:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Koba Ko <koba.ko@canonical.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH] Bluetooth: btusb: add a reject table to disable msft
Message-ID: <202108200333.kwevIpy1-lkp@intel.com>
References: <20210819135927.49715-1-koba.ko@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20210819135927.49715-1-koba.ko@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Koba,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bluetooth/master]
[also build test WARNING on v5.14-rc6]
[cannot apply to bluetooth-next/master next-20210819]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Koba-Ko/Bluetooth-btusb-add-a-reject-table-to-disable-msft/20210819-220108
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git master
config: mips-randconfig-s032-20210818 (attached as .config)
compiler: mips64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-348-gf0e6938b-dirty
        # https://github.com/0day-ci/linux/commit/bbff58c00c9efb048da28df9dbc3c79c0c40763b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Koba-Ko/Bluetooth-btusb-add-a-reject-table-to-disable-msft/20210819-220108
        git checkout bbff58c00c9efb048da28df9dbc3c79c0c40763b
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   command-line: note: in included file:
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQUIRE redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_SEQ_CST redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_ACQ_REL redefined
   builtin:0:0: sparse: this was the original definition
   builtin:1:9: sparse: sparse: preprocessor token __ATOMIC_RELEASE redefined
   builtin:0:0: sparse: this was the original definition
   drivers/bluetooth/btusb.c:1852:18: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:1856:18: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:1860:18: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:1864:18: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:1868:18: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:1874:18: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:1912:21: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:2421:25: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:2430:25: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:2431:25: sparse: sparse: cast to restricted __le16
   drivers/bluetooth/btusb.c:2432:25: sparse: sparse: cast to restricted __le16
>> drivers/bluetooth/btusb.c:2917:23: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected struct usb_device_id *match @@     got struct usb_device_id const * @@
   drivers/bluetooth/btusb.c:2917:23: sparse:     expected struct usb_device_id *match
   drivers/bluetooth/btusb.c:2917:23: sparse:     got struct usb_device_id const *
   drivers/bluetooth/btusb.c:4131:28: sparse: sparse: cast to restricted __le32
   drivers/bluetooth/btusb.c:4162:18: sparse: sparse: restricted __le16 degrades to integer

vim +2917 drivers/bluetooth/btusb.c

  2829	
  2830	static int btusb_setup_intel_new(struct hci_dev *hdev)
  2831	{
  2832		struct btusb_data *data = hci_get_drvdata(hdev);
  2833		struct intel_version ver;
  2834		struct intel_boot_params params;
  2835		u32 boot_param;
  2836		char ddcname[64];
  2837		int err;
  2838		struct intel_debug_features features;
  2839		struct usb_device_id *match;
  2840	
  2841		BT_DBG("%s", hdev->name);
  2842	
  2843		/* Set the default boot parameter to 0x0 and it is updated to
  2844		 * SKU specific boot parameter after reading Intel_Write_Boot_Params
  2845		 * command while downloading the firmware.
  2846		 */
  2847		boot_param = 0x00000000;
  2848	
  2849		/* Read the Intel version information to determine if the device
  2850		 * is in bootloader mode or if it already has operational firmware
  2851		 * loaded.
  2852		 */
  2853		err = btintel_read_version(hdev, &ver);
  2854		if (err) {
  2855			bt_dev_err(hdev, "Intel Read version failed (%d)", err);
  2856			btintel_reset_to_bootloader(hdev);
  2857			return err;
  2858		}
  2859	
  2860		err = btintel_version_info(hdev, &ver);
  2861		if (err)
  2862			return err;
  2863	
  2864		err = btusb_intel_download_firmware(hdev, &ver, &params, &boot_param);
  2865		if (err)
  2866			return err;
  2867	
  2868		/* controller is already having an operational firmware */
  2869		if (ver.fw_variant == 0x23)
  2870			goto finish;
  2871	
  2872		err = btusb_intel_boot(hdev, boot_param);
  2873		if (err)
  2874			return err;
  2875	
  2876		clear_bit(BTUSB_BOOTLOADER, &data->flags);
  2877	
  2878		err = btusb_setup_intel_new_get_fw_name(&ver, &params, ddcname,
  2879							sizeof(ddcname), "ddc");
  2880	
  2881		if (err < 0) {
  2882			bt_dev_err(hdev, "Unsupported Intel firmware naming");
  2883		} else {
  2884			/* Once the device is running in operational mode, it needs to
  2885			 * apply the device configuration (DDC) parameters.
  2886			 *
  2887			 * The device can work without DDC parameters, so even if it
  2888			 * fails to load the file, no need to fail the setup.
  2889			 */
  2890			btintel_load_ddc_config(hdev, ddcname);
  2891		}
  2892	
  2893		/* Read the Intel supported features and if new exception formats
  2894		 * supported, need to load the additional DDC config to enable.
  2895		 */
  2896		btintel_read_debug_features(hdev, &features);
  2897	
  2898		/* Set DDC mask for available debug features */
  2899		btintel_set_debug_features(hdev, &features);
  2900	
  2901		/* Read the Intel version information after loading the FW  */
  2902		err = btintel_read_version(hdev, &ver);
  2903		if (err)
  2904			return err;
  2905	
  2906		btintel_version_info(hdev, &ver);
  2907	
  2908	finish:
  2909		/* All Intel controllers that support the Microsoft vendor
  2910		 * extension are using 0xFC1E for VsMsftOpCode.
  2911		 */
  2912		switch (ver.hw_variant) {
  2913		case 0x11:	/* JfP */
  2914		case 0x12:	/* ThP */
  2915		case 0x13:	/* HrP */
  2916		case 0x14:	/* CcP */
> 2917			match = usb_match_id(data->intf, msft_rej_table);
  2918			if (!match)
  2919				hci_set_msft_opcode(hdev, 0xFC1E);
  2920			break;
  2921		}
  2922	
  2923		/* Set the event mask for Intel specific vendor events. This enables
  2924		 * a few extra events that are useful during general operation. It
  2925		 * does not enable any debugging related events.
  2926		 *
  2927		 * The device will function correctly without these events enabled
  2928		 * and thus no need to fail the setup.
  2929		 */
  2930		btintel_set_event_mask(hdev, false);
  2931	
  2932		return 0;
  2933	}
  2934	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--sm4nu43k4a2Rpi4c
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--sm4nu43k4a2Rpi4c--
