Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE12C433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Apr 2021 10:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE926128C
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Apr 2021 10:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237919AbhDLKP4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Apr 2021 06:15:56 -0400
Received: from mga04.intel.com ([192.55.52.120]:30401 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240414AbhDLKPW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Apr 2021 06:15:22 -0400
IronPort-SDR: ZRrjzMJsa9XOFeespSoB5Vc8RUlTvvD1Y8ixpBkwveiw+eS7pf/+4Uwtd/aAsFYsNQuA0oM6v6
 GM8qfo2uo9lA==
X-IronPort-AV: E=McAfee;i="6000,8403,9951"; a="192025811"
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="gz'50?scan'50,208,50";a="192025811"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2021 03:13:12 -0700
IronPort-SDR: cKHoe1LmG3olGVeCBOtBITVqtcwhNjMxTjOcuN1fsViZX/EKMaxIOIUyKE/GcR8vv40ly5IPiw
 hiEaBR/yJ2RA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,216,1613462400"; 
   d="gz'50?scan'50,208,50";a="420351138"
Received: from lkp-server01.sh.intel.com (HELO 69d8fcc516b7) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 12 Apr 2021 03:13:09 -0700
Received: from kbuild by 69d8fcc516b7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lVtZ6-0000OA-Aa; Mon, 12 Apr 2021 10:13:08 +0000
Date:   Mon, 12 Apr 2021 18:12:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joseph Hwang <josephsih@chromium.org>,
        linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, pali@kernel.org
Cc:     kbuild-all@lists.01.org,
        chromeos-bluetooth-upstreaming@chromium.org, josephsih@google.com,
        Joseph Hwang <josephsih@chromium.org>,
        Chethan Tumkur Narayan 
        <chethan.tumkur.narayan@intel.corp-partner.google.com>,
        Kiran Krishnappa <kiran.k@intel.corp-partner.google.com>,
        Miao-chen Chou <mcchou@chromium.org>
Subject: Re: [PATCH v1 2/2] Bluetooth: Support the vendor specific debug
 events
Message-ID: <202104121845.yyM0jLUc-lkp@intel.com>
References: <20210412072734.2567956-2-josephsih@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <20210412072734.2567956-2-josephsih@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Joseph,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bluetooth-next/master]
[also build test ERROR on v5.12-rc7 next-20210409]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Joseph-Hwang/Bluetooth-btusb-support-link-statistics-telemetry-events/20210412-152954
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
config: alpha-randconfig-s031-20210412 (attached as .config)
compiler: alpha-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-280-g2cd6d34e-dirty
        # https://github.com/0day-ci/linux/commit/d3bd96f611be6b3248ca68c2bc628c29e5419b92
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Joseph-Hwang/Bluetooth-btusb-support-link-statistics-telemetry-events/20210412-152954
        git checkout d3bd96f611be6b3248ca68c2bc628c29e5419b92
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=alpha 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/bluetooth/btusb.c: In function 'btusb_setup_intel_newgen':
>> drivers/bluetooth/btusb.c:2963:2: error: implicit declaration of function 'btintel_read_debug_features' [-Werror=implicit-function-declaration]
    2963 |  btintel_read_debug_features(hdev, &features);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/bluetooth/btusb.c:2966:2: error: implicit declaration of function 'btintel_set_debug_features' [-Werror=implicit-function-declaration]
    2966 |  btintel_set_debug_features(hdev, &features);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/btintel_read_debug_features +2963 drivers/bluetooth/btusb.c

cda0dd7809f89e Marcel Holtmann        2015-01-26  2903  
0a3c1d45eca09c Kiran K                2020-11-19  2904  static int btusb_setup_intel_newgen(struct hci_dev *hdev)
0a3c1d45eca09c Kiran K                2020-11-19  2905  {
0a3c1d45eca09c Kiran K                2020-11-19  2906  	struct btusb_data *data = hci_get_drvdata(hdev);
0a3c1d45eca09c Kiran K                2020-11-19  2907  	u32 boot_param;
0a3c1d45eca09c Kiran K                2020-11-19  2908  	char ddcname[64];
0a3c1d45eca09c Kiran K                2020-11-19  2909  	int err;
0a3c1d45eca09c Kiran K                2020-11-19  2910  	struct intel_debug_features features;
0a3c1d45eca09c Kiran K                2020-11-19  2911  	struct intel_version_tlv version;
0a3c1d45eca09c Kiran K                2020-11-19  2912  
0a3c1d45eca09c Kiran K                2020-11-19  2913  	bt_dev_dbg(hdev, "");
0a3c1d45eca09c Kiran K                2020-11-19  2914  
0a3c1d45eca09c Kiran K                2020-11-19  2915  	/* Set the default boot parameter to 0x0 and it is updated to
0a3c1d45eca09c Kiran K                2020-11-19  2916  	 * SKU specific boot parameter after reading Intel_Write_Boot_Params
0a3c1d45eca09c Kiran K                2020-11-19  2917  	 * command while downloading the firmware.
0a3c1d45eca09c Kiran K                2020-11-19  2918  	 */
0a3c1d45eca09c Kiran K                2020-11-19  2919  	boot_param = 0x00000000;
0a3c1d45eca09c Kiran K                2020-11-19  2920  
0a3c1d45eca09c Kiran K                2020-11-19  2921  	/* Read the Intel version information to determine if the device
0a3c1d45eca09c Kiran K                2020-11-19  2922  	 * is in bootloader mode or if it already has operational firmware
0a3c1d45eca09c Kiran K                2020-11-19  2923  	 * loaded.
0a3c1d45eca09c Kiran K                2020-11-19  2924  	 */
0a3c1d45eca09c Kiran K                2020-11-19  2925  	err = btintel_read_version_tlv(hdev, &version);
0a3c1d45eca09c Kiran K                2020-11-19  2926  	if (err) {
0a3c1d45eca09c Kiran K                2020-11-19  2927  		bt_dev_err(hdev, "Intel Read version failed (%d)", err);
0a3c1d45eca09c Kiran K                2020-11-19  2928  		btintel_reset_to_bootloader(hdev);
0a3c1d45eca09c Kiran K                2020-11-19  2929  		return err;
0a3c1d45eca09c Kiran K                2020-11-19  2930  	}
0a3c1d45eca09c Kiran K                2020-11-19  2931  
0a460d8fe2db68 Luiz Augusto von Dentz 2021-03-23  2932  	err = btintel_version_info_tlv(hdev, &version);
0a460d8fe2db68 Luiz Augusto von Dentz 2021-03-23  2933  	if (err)
0a460d8fe2db68 Luiz Augusto von Dentz 2021-03-23  2934  		return err;
0a3c1d45eca09c Kiran K                2020-11-19  2935  
3f43a37838d5b5 Kiran K                2020-11-19  2936  	err = btusb_intel_download_firmware_newgen(hdev, &version, &boot_param);
3f43a37838d5b5 Kiran K                2020-11-19  2937  	if (err)
3f43a37838d5b5 Kiran K                2020-11-19  2938  		return err;
3f43a37838d5b5 Kiran K                2020-11-19  2939  
0a3c1d45eca09c Kiran K                2020-11-19  2940  	/* check if controller is already having an operational firmware */
0a3c1d45eca09c Kiran K                2020-11-19  2941  	if (version.img_type == 0x03)
0a3c1d45eca09c Kiran K                2020-11-19  2942  		goto finish;
0a3c1d45eca09c Kiran K                2020-11-19  2943  
604b3cf87fd217 Luiz Augusto von Dentz 2021-03-23  2944  	err = btusb_intel_boot(hdev, boot_param);
604b3cf87fd217 Luiz Augusto von Dentz 2021-03-23  2945  	if (err)
0a3c1d45eca09c Kiran K                2020-11-19  2946  		return err;
0a3c1d45eca09c Kiran K                2020-11-19  2947  
0a3c1d45eca09c Kiran K                2020-11-19  2948  	clear_bit(BTUSB_BOOTLOADER, &data->flags);
0a3c1d45eca09c Kiran K                2020-11-19  2949  
9a93b8b8eee4ac Kiran K                2020-11-19  2950  	btusb_setup_intel_newgen_get_fw_name(&version, ddcname, sizeof(ddcname),
9a93b8b8eee4ac Kiran K                2020-11-19  2951  					     "ddc");
0a3c1d45eca09c Kiran K                2020-11-19  2952  	/* Once the device is running in operational mode, it needs to
0a3c1d45eca09c Kiran K                2020-11-19  2953  	 * apply the device configuration (DDC) parameters.
0a3c1d45eca09c Kiran K                2020-11-19  2954  	 *
0a3c1d45eca09c Kiran K                2020-11-19  2955  	 * The device can work without DDC parameters, so even if it
0a3c1d45eca09c Kiran K                2020-11-19  2956  	 * fails to load the file, no need to fail the setup.
0a3c1d45eca09c Kiran K                2020-11-19  2957  	 */
0a3c1d45eca09c Kiran K                2020-11-19  2958  	btintel_load_ddc_config(hdev, ddcname);
0a3c1d45eca09c Kiran K                2020-11-19  2959  
0a3c1d45eca09c Kiran K                2020-11-19  2960  	/* Read the Intel supported features and if new exception formats
0a3c1d45eca09c Kiran K                2020-11-19  2961  	 * supported, need to load the additional DDC config to enable.
0a3c1d45eca09c Kiran K                2020-11-19  2962  	 */
0a3c1d45eca09c Kiran K                2020-11-19 @2963  	btintel_read_debug_features(hdev, &features);
0a3c1d45eca09c Kiran K                2020-11-19  2964  
0a3c1d45eca09c Kiran K                2020-11-19  2965  	/* Set DDC mask for available debug features */
0a3c1d45eca09c Kiran K                2020-11-19 @2966  	btintel_set_debug_features(hdev, &features);
0a3c1d45eca09c Kiran K                2020-11-19  2967  
0a3c1d45eca09c Kiran K                2020-11-19  2968  	/* Read the Intel version information after loading the FW  */
0a3c1d45eca09c Kiran K                2020-11-19  2969  	err = btintel_read_version_tlv(hdev, &version);
0a3c1d45eca09c Kiran K                2020-11-19  2970  	if (err)
0a3c1d45eca09c Kiran K                2020-11-19  2971  		return err;
0a3c1d45eca09c Kiran K                2020-11-19  2972  
0a3c1d45eca09c Kiran K                2020-11-19  2973  	btintel_version_info_tlv(hdev, &version);
0a3c1d45eca09c Kiran K                2020-11-19  2974  
0a3c1d45eca09c Kiran K                2020-11-19  2975  finish:
0a3c1d45eca09c Kiran K                2020-11-19  2976  	/* Set the event mask for Intel specific vendor events. This enables
0a3c1d45eca09c Kiran K                2020-11-19  2977  	 * a few extra events that are useful during general operation. It
0a3c1d45eca09c Kiran K                2020-11-19  2978  	 * does not enable any debugging related events.
0a3c1d45eca09c Kiran K                2020-11-19  2979  	 *
0a3c1d45eca09c Kiran K                2020-11-19  2980  	 * The device will function correctly without these events enabled
0a3c1d45eca09c Kiran K                2020-11-19  2981  	 * and thus no need to fail the setup.
0a3c1d45eca09c Kiran K                2020-11-19  2982  	 */
0a3c1d45eca09c Kiran K                2020-11-19  2983  	btintel_set_event_mask(hdev, false);
0a3c1d45eca09c Kiran K                2020-11-19  2984  
0a3c1d45eca09c Kiran K                2020-11-19  2985  	return 0;
0a3c1d45eca09c Kiran K                2020-11-19  2986  }
bfbd45e9acd2ef Tedd Ho-Jeong An       2015-02-13  2987  static int btusb_shutdown_intel(struct hci_dev *hdev)
bfbd45e9acd2ef Tedd Ho-Jeong An       2015-02-13  2988  {
bfbd45e9acd2ef Tedd Ho-Jeong An       2015-02-13  2989  	struct sk_buff *skb;
bfbd45e9acd2ef Tedd Ho-Jeong An       2015-02-13  2990  	long ret;
bfbd45e9acd2ef Tedd Ho-Jeong An       2015-02-13  2991  
1313bccf00f6df Amit K Bag             2018-08-03  2992  	/* In the shutdown sequence where Bluetooth is turned off followed
1313bccf00f6df Amit K Bag             2018-08-03  2993  	 * by WiFi being turned off, turning WiFi back on causes issue with
1313bccf00f6df Amit K Bag             2018-08-03  2994  	 * the RF calibration.
1313bccf00f6df Amit K Bag             2018-08-03  2995  	 *
1313bccf00f6df Amit K Bag             2018-08-03  2996  	 * To ensure that any RF activity has been stopped, issue HCI Reset
1313bccf00f6df Amit K Bag             2018-08-03  2997  	 * command to clear all ongoing activity including advertising,
1313bccf00f6df Amit K Bag             2018-08-03  2998  	 * scanning etc.
1313bccf00f6df Amit K Bag             2018-08-03  2999  	 */
1313bccf00f6df Amit K Bag             2018-08-03  3000  	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
1313bccf00f6df Amit K Bag             2018-08-03  3001  	if (IS_ERR(skb)) {
1313bccf00f6df Amit K Bag             2018-08-03  3002  		ret = PTR_ERR(skb);
1313bccf00f6df Amit K Bag             2018-08-03  3003  		bt_dev_err(hdev, "HCI reset during shutdown failed");
1313bccf00f6df Amit K Bag             2018-08-03  3004  		return ret;
1313bccf00f6df Amit K Bag             2018-08-03  3005  	}
1313bccf00f6df Amit K Bag             2018-08-03  3006  	kfree_skb(skb);
1313bccf00f6df Amit K Bag             2018-08-03  3007  
bfbd45e9acd2ef Tedd Ho-Jeong An       2015-02-13  3008  	/* Some platforms have an issue with BT LED when the interface is
bfbd45e9acd2ef Tedd Ho-Jeong An       2015-02-13  3009  	 * down or BT radio is turned off, which takes 5 seconds to BT LED
bfbd45e9acd2ef Tedd Ho-Jeong An       2015-02-13  3010  	 * goes off. This command turns off the BT LED immediately.
bfbd45e9acd2ef Tedd Ho-Jeong An       2015-02-13  3011  	 */
bfbd45e9acd2ef Tedd Ho-Jeong An       2015-02-13  3012  	skb = __hci_cmd_sync(hdev, 0xfc3f, 0, NULL, HCI_INIT_TIMEOUT);
bfbd45e9acd2ef Tedd Ho-Jeong An       2015-02-13  3013  	if (IS_ERR(skb)) {
bfbd45e9acd2ef Tedd Ho-Jeong An       2015-02-13  3014  		ret = PTR_ERR(skb);
85418feff6faa9 Marcel Holtmann        2018-08-03  3015  		bt_dev_err(hdev, "turning off Intel device LED failed");
bfbd45e9acd2ef Tedd Ho-Jeong An       2015-02-13  3016  		return ret;
bfbd45e9acd2ef Tedd Ho-Jeong An       2015-02-13  3017  	}
bfbd45e9acd2ef Tedd Ho-Jeong An       2015-02-13  3018  	kfree_skb(skb);
bfbd45e9acd2ef Tedd Ho-Jeong An       2015-02-13  3019  
bfbd45e9acd2ef Tedd Ho-Jeong An       2015-02-13  3020  	return 0;
bfbd45e9acd2ef Tedd Ho-Jeong An       2015-02-13  3021  }
bfbd45e9acd2ef Tedd Ho-Jeong An       2015-02-13  3022  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--VS++wcV0S1rZb1Fb
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
4P8AU1ZCrU6/AQA=

--VS++wcV0S1rZb1Fb--
