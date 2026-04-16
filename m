Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E9D397E6F
	for <linux-bluetooth@vger.kernel.org>; Thu, 16 Apr 2026 23:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776383498; cv=none; b=FxS9QEUiBz3D9C+w8Uk1xoVaeR275428y7s/pqM6i2VEhMqkjoSJmNZd8B6/Czc70IlaMs5hke7Wtg/SbGMKscKLY82nKNLpR5N4uuNR9tgc9Ax2rH6J1aYBJOUwhHjZ/RTSfQSTWLa5Ut+eCKLztCBBeXdwC9p+xKcUcu2qDR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776383498; c=relaxed/simple;
	bh=CDzhtQ5NGechP9M/AT0T6ReMPrmDg9Tzee39gUXJDjo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RTuZEPZl7p4trfSaGmPk20DvWuXJC4mbQCiRIcECPebL6KCVz/N1Nsy6lXY0DDZf4rgwtoEExHdrFFbGUPsAHIzngokBjh3AA+x+lt15zXhkfxuQ9RtuIr08ctHDo7oigJYB6rDIshyxxDj8EHfwHhe8vqv7aY44fMREca8ZB7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OwDiBXPH; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OwDiBXPH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776383496; x=1807919496;
  h=date:from:to:cc:subject:message-id;
  bh=CDzhtQ5NGechP9M/AT0T6ReMPrmDg9Tzee39gUXJDjo=;
  b=OwDiBXPHt9jCLIwGs1VXn3kUK2DIfD/6PLG+6rJ6gIeiLMG7d9rC3AGo
   AxhjBgXbAIL7Lkzo7pOPpdHsiNT/R7E6KyK8rJXMrdKVlcl7+xTHoV8J2
   +Hoh28Frgydx5cOyLaAxLxh5f/Bdv/ZKQOsVn8SSkykLUCY4Q6XCG9JeO
   O2Y887HAAmaBnkCW9xjL4KI5lr5vy2pWYwWmFu0L5fK8Z15vw/bA7G3zm
   vAMCxXl16dJI+rlGlIhuCTcv00vtbNjTB09gNfRvZMv5nzmeDQ5Kx5mI2
   AAWmeXN0H9delu6oL25F+pAmRIrEwf6CaTR+0JIk+NLUxCkF6hnlvuZE5
   A==;
X-CSE-ConnectionGUID: qC/j8hLsRkGPBnURpSSqlA==
X-CSE-MsgGUID: fbdlPXRjTN2pL0UGphzJJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="88781200"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="88781200"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 16:51:35 -0700
X-CSE-ConnectionGUID: dMFHRvmKQDCr2CJjsxtD2g==
X-CSE-MsgGUID: +1VopU1nQRmtWE2pl3od9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="235245567"
Received: from lkp-server01.sh.intel.com (HELO 7f3b36e5d6a5) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 16 Apr 2026 16:51:33 -0700
Received: from kbuild by 7f3b36e5d6a5 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wDWUd-0000000026w-0Iq5;
	Thu, 16 Apr 2026 23:51:31 +0000
Date: Fri, 17 Apr 2026 07:50:39 +0800
From: kernel test robot <lkp@intel.com>
To: Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 linux-bluetooth@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [bluetooth-next:master /72]
 drivers/bluetooth/btintel_pcie.c:2309:7: error: call to undeclared function
 'acpi_has_method'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202604170717.KYieBeVa-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
head:   b57b0f27cb05c5a9dac9eeb2cb2798a4c189a685
commit: 912a499a7955a2773a20f33e495a5ce24d7279f0 [/72] Bluetooth: btintel_pcie: Support Product level reset
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20260417/202604170717.KYieBeVa-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260417/202604170717.KYieBeVa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604170717.KYieBeVa-lkp@intel.com/

Note: the bluetooth-next/master HEAD b57b0f27cb05c5a9dac9eeb2cb2798a4c189a685 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from drivers/bluetooth/btintel_pcie.c:13:
   In file included from include/linux/pci.h:38:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:24:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1209:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1209 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
>> drivers/bluetooth/btintel_pcie.c:2309:7: error: call to undeclared function 'acpi_has_method'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    2309 |         if (!acpi_has_method(handle, "_PRR")) {
         |              ^
   drivers/bluetooth/btintel_pcie.c:2309:7: note: did you mean 'acpi_has_watchdog'?
   include/linux/acpi.h:1494:20: note: 'acpi_has_watchdog' declared here
    1494 | static inline bool acpi_has_watchdog(void) { return false; }
         |                    ^
   1 warning and 1 error generated.


vim +/acpi_has_method +2309 drivers/bluetooth/btintel_pcie.c

  2282	
  2283	static int btintel_pcie_acpi_reset_method(struct btintel_pcie_data *data)
  2284	{
  2285		union acpi_object *obj, argv4;
  2286		acpi_handle handle;
  2287		int ret;
  2288		struct pldr_mode {
  2289			__le16	cmd_type;
  2290			__le16	cmd_payload;
  2291		} __packed;
  2292	
  2293		/* set 1 for _PRR mode
  2294		 * Product Reset (PLDR Abort flow)
  2295		 */
  2296		static const struct pldr_mode mode = {
  2297			.cmd_type = cpu_to_le16(1),
  2298			.cmd_payload = cpu_to_le16(BTINTEL_PCIE_DSM_PLDR_MODE_EN_PROD_RESET |
  2299				       BTINTEL_PCIE_DSM_PLDR_MODE_EN_WIFI_FLR),
  2300		};
  2301		struct hci_dev *hdev = data->hdev;
  2302	
  2303		handle = ACPI_HANDLE(GET_HCIDEV_DEV(data->hdev));
  2304		if (!handle) {
  2305			bt_dev_err(data->hdev, "No support for bluetooth device in ACPI firmware");
  2306			return -EACCES;
  2307		}
  2308	
> 2309		if (!acpi_has_method(handle, "_PRR")) {
  2310			bt_dev_err(data->hdev, "No support for _PRR ACPI method, cold boot");
  2311			return -ENODEV;
  2312		}
  2313	
  2314		argv4.buffer.type = ACPI_TYPE_BUFFER;
  2315		argv4.buffer.length = sizeof(mode);
  2316		argv4.buffer.pointer = (void *)&mode;
  2317	
  2318		obj = acpi_evaluate_dsm(handle, &btintel_guid_dsm, 0,
  2319					BTINTEL_PCIE_DSM_DYNAMIC_PLDR, &argv4);
  2320		if (!obj) {
  2321			bt_dev_err(data->hdev, "Failed to call dsm to set reset method");
  2322			return -EIO;
  2323		}
  2324		ACPI_FREE(obj);
  2325	
  2326		pci_dev_lock(data->pdev);
  2327		pci_save_state(data->pdev);
  2328		ret = btintel_acpi_reset_method(hdev);
  2329		if (ret)
  2330			bt_dev_err(data->hdev, "ACPI _PRR reset failed (%d), PLDR incomplete",
  2331				   ret);
  2332		pci_restore_state(data->pdev);
  2333		pci_dev_unlock(data->pdev);
  2334		return ret;
  2335	}
  2336	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
