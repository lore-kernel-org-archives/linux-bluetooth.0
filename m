Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBE9C6FD19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Mar 2023 23:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjCMXB1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 19:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjCMXBW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 19:01:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B0A5BDA4
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Mar 2023 16:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678748426; x=1710284426;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MdwhS/fy7ChF/duuTrs/VEPfJyrERgmoiRJftpdQphM=;
  b=ZQlY1bI8KMwVIKFlD15w2nC0A6sFVDZgRbbGk+AHVCQ1lXm+WF+/Qd+u
   ZvbRk/pMC9i8irBnw1GqB48QeLBIvqKhvQ+PGmLSLzCcgOoM11JNavNiA
   FaNU1qoWLkRqGzfY7bAeMQAyhOYJIgaJQyOS8zAJJ83kyH9jgktge3cJm
   jbvLraZIQDWTGHIQPqSx4vcQjZeZsa6ow5mvPWpGctnRIzvbJrhoijCiy
   zQvtspkftRDza8Y1KhmI4GnQnMG+Ywxba2HDr4yUgXmR3Mr4YDF9hVp7+
   58Gm8hVh7dEDJfIvfm0+3lfIozYs1Nmu0cuOUO2uM0RB7NWhampyexuHo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="317664686"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="317664686"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 15:57:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="747770053"
X-IronPort-AV: E=Sophos;i="5.98,258,1673942400"; 
   d="scan'208";a="747770053"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 13 Mar 2023 15:57:50 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pbr6z-0006DM-25;
        Mon, 13 Mar 2023 22:57:49 +0000
Date:   Tue, 14 Mar 2023 06:57:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kiran K <kiran.k@intel.com>, linux-bluetooth@vger.kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: Re: [PATCH v1] Bluetooth: btintel: Add support to reset bluetooth
 via ACPI DSM
Message-ID: <202303140618.ncRRCBV2-lkp@intel.com>
References: <20230313151549.15791-1-kiran.k@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313151549.15791-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on bluetooth-next/master]
[also build test ERROR on linus/master v6.3-rc2 next-20230310]
[cannot apply to bluetooth/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kiran-K/Bluetooth-btintel-Add-support-to-reset-bluetooth-via-ACPI-DSM/20230313-230800
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
patch link:    https://lore.kernel.org/r/20230313151549.15791-1-kiran.k%40intel.com
patch subject: [PATCH v1] Bluetooth: btintel: Add support to reset bluetooth via ACPI DSM
config: hexagon-randconfig-r045-20230313 (https://download.01.org/0day-ci/archive/20230314/202303140618.ncRRCBV2-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6a89221ddaa7b13fa1da2d345e61b2bf8efd5a87
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kiran-K/Bluetooth-btintel-Add-support-to-reset-bluetooth-via-ACPI-DSM/20230313-230800
        git checkout 6a89221ddaa7b13fa1da2d345e61b2bf8efd5a87
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/bluetooth/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202303140618.ncRRCBV2-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/bluetooth/btintel.c:11:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:547:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:560:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/bluetooth/btintel.c:11:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:573:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/bluetooth/btintel.c:11:
   In file included from include/linux/regmap.h:20:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/hexagon/include/asm/io.h:334:
   include/asm-generic/io.h:584:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:594:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:604:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
>> drivers/bluetooth/btintel.c:2450:7: error: call to undeclared function 'acpi_has_method'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           if (!acpi_has_method(handle, "_PRR")) {
                ^
   drivers/bluetooth/btintel.c:2450:7: note: did you mean 'acpi_has_watchdog'?
   include/linux/acpi.h:1442:20: note: 'acpi_has_watchdog' declared here
   static inline bool acpi_has_watchdog(void) { return false; }
                      ^
   6 warnings and 1 error generated.


vim +/acpi_has_method +2450 drivers/bluetooth/btintel.c

  2430	
  2431	static void btintel_set_dsm_reset_method(struct hci_dev *hdev,
  2432						 struct intel_version_tlv *ver_tlv)
  2433	{
  2434		struct btintel_data *data = hci_get_priv(hdev);
  2435		acpi_handle handle = ACPI_HANDLE(GET_HCIDEV_DEV(hdev));
  2436		u8 reset_payload[4] = {0x01, 0x00, 0x01, 0x00};
  2437		union acpi_object *obj, argv4;
  2438		enum {
  2439			RESET_TYPE_WDISABLE2,
  2440			RESET_TYPE_VSEC
  2441		};
  2442	
  2443		handle = ACPI_HANDLE(GET_HCIDEV_DEV(hdev));
  2444	
  2445		if (!handle) {
  2446			bt_dev_dbg(hdev, "No support for bluetooth device in ACPI firmware");
  2447			return;
  2448		}
  2449	
> 2450		if (!acpi_has_method(handle, "_PRR")) {
  2451			bt_dev_err(hdev, "No support for _PRR ACPI method");
  2452			return;
  2453		}
  2454	
  2455		switch (ver_tlv->cnvi_top & 0xfff) {
  2456		case 0x910: /* GalePeak2 */
  2457			reset_payload[2] = RESET_TYPE_VSEC;
  2458			break;
  2459		default:
  2460			/* WDISABLE2 is the default reset method */
  2461			reset_payload[2] = RESET_TYPE_WDISABLE2;
  2462	
  2463			if (!acpi_check_dsm(handle, &btintel_guid_dsm, 0,
  2464					    BIT(DSM_SET_WDISABLE2_DELAY))) {
  2465				bt_dev_err(hdev, "No dsm support to set reset delay");
  2466				return;
  2467			}
  2468			argv4.integer.type = ACPI_TYPE_INTEGER;
  2469			/* delay required to toggle BT power */
  2470			argv4.integer.value = 160;
  2471			obj = acpi_evaluate_dsm(handle, &btintel_guid_dsm, 0,
  2472						DSM_SET_WDISABLE2_DELAY, &argv4);
  2473			if (!obj) {
  2474				bt_dev_err(hdev, "Failed to call dsm to set reset delay");
  2475				return;
  2476			}
  2477			ACPI_FREE(obj);
  2478		}
  2479	
  2480		bt_dev_info(hdev, "DSM reset method type: 0x%02x", reset_payload[2]);
  2481	
  2482		if (!acpi_check_dsm(handle, &btintel_guid_dsm, 0,
  2483				    DSM_SET_RESET_METHOD)) {
  2484			bt_dev_warn(hdev, "No support for dsm to set reset method");
  2485			return;
  2486		}
  2487		argv4.buffer.type = ACPI_TYPE_BUFFER;
  2488		argv4.buffer.length = sizeof(reset_payload);
  2489		argv4.buffer.pointer = reset_payload;
  2490	
  2491		obj = acpi_evaluate_dsm(handle, &btintel_guid_dsm, 0,
  2492					DSM_SET_RESET_METHOD, &argv4);
  2493		if (!obj) {
  2494			bt_dev_err(hdev, "Failed to call dsm to set reset method");
  2495			return;
  2496		}
  2497		ACPI_FREE(obj);
  2498		data->acpi_reset_method = btintel_acpi_reset_method;
  2499	}
  2500	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
