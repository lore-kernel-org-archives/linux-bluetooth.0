Return-Path: <SRS0=GKuY=DE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 103CFC2D0A8
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Sep 2020 01:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B16AA22207
	for <linux-bluetooth@archiver.kernel.org>; Sun, 27 Sep 2020 01:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgI0BeV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Sep 2020 21:34:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:57765 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbgI0BeU (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Sep 2020 21:34:20 -0400
IronPort-SDR: LxyFhQbR02xwmjR5ggFwcRgA1blfUFOUB/662nStQpgnR32WRa+1OLH3eVF1WM0Vy0v2TdLN6y
 F+x4XYcv3k5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="225979063"
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="gz'50?scan'50,208,50";a="225979063"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2020 18:34:14 -0700
IronPort-SDR: 67fRxlFFH+IwrRNf5yOmdvNbnS1v/ZFUPbhsRfwNcm0O3VktK3Z1bbBMLjbEkTEBdjtsKEGo/C
 LFz2N42HGjSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="gz'50?scan'50,208,50";a="349406558"
Received: from lkp-server01.sh.intel.com (HELO 2dda29302fe3) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 26 Sep 2020 18:34:10 -0700
Received: from kbuild by 2dda29302fe3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kMLZp-0000dh-BB; Sun, 27 Sep 2020 01:34:09 +0000
Date:   Sun, 27 Sep 2020 09:33:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kiran K <kiraank@gmail.com>, linux-bluetooth@vger.kernel.org
Cc:     kbuild-all@lists.01.org, sathish.narasimman@intel.com,
        chethan.tumkur.narayan@intel.com, ravishankar.srivatsa@intel.com,
        kiraank@gmail.com, Kiran K <kiran.k@intel.com>,
        Amit K Bag <amit.k.bag@intel.com>,
        Raghuram Hegde <raghuram.hegde@intel.com>
Subject: Re: [PATCH v2 1/2] Bluetooth: btintel: Add helper function to
 download firmware
Message-ID: <202009270947.2PRlBMUg%lkp@intel.com>
References: <1601099322-9415-1-git-send-email-kiran.k@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
In-Reply-To: <1601099322-9415-1-git-send-email-kiran.k@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Kiran,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on bluetooth-next/master]
[also build test WARNING on v5.9-rc6 next-20200925]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Kiran-K/Bluetooth-btintel-Add-helper-function-to-download-firmware/20200926-135059
base:   https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git master
config: alpha-randconfig-r034-20200925 (attached as .config)
compiler: alpha-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/5bb97dc4287da6a927e38203604b1199021bb572
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Kiran-K/Bluetooth-btintel-Add-helper-function-to-download-firmware/20200926-135059
        git checkout 5bb97dc4287da6a927e38203604b1199021bb572
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=alpha 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/bluetooth/btusb.c:2374:5: warning: no previous prototype for 'btusb_intel_download_firmware_newgen' [-Wmissing-prototypes]
    2374 | int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/btusb_intel_download_firmware_newgen +2374 drivers/bluetooth/btusb.c

  2373	
> 2374	int btusb_intel_download_firmware_newgen(struct hci_dev *hdev,
  2375						 struct intel_version_tlv *ver,
  2376						 u32 *boot_param)
  2377	{
  2378		const struct firmware *fw;
  2379		char fwname[64];
  2380		int err;
  2381		struct btusb_data *data = hci_get_drvdata(hdev);
  2382	
  2383		if (!ver || !boot_param)
  2384			return -EINVAL;
  2385	
  2386		/* The hardware platform number has a fixed value of 0x37 and
  2387		 * for now only accept this single value.
  2388		 */
  2389		if (INTEL_HW_PLATFORM(ver->cnvi_bt) != 0x37) {
  2390			bt_dev_err(hdev, "Unsupported Intel hardware platform (0x%2x)",
  2391				   INTEL_HW_PLATFORM(ver->cnvi_bt));
  2392			return -EINVAL;
  2393		}
  2394	
  2395		/* The firmware variant determines if the device is in bootloader
  2396		 * mode or is running operational firmware. The value 0x03 identifies
  2397		 * the bootloader and the value 0x23 identifies the operational
  2398		 * firmware.
  2399		 *
  2400		 * When the operational firmware is already present, then only
  2401		 * the check for valid Bluetooth device address is needed. This
  2402		 * determines if the device will be added as configured or
  2403		 * unconfigured controller.
  2404		 *
  2405		 * It is not possible to use the Secure Boot Parameters in this
  2406		 * case since that command is only available in bootloader mode.
  2407		 */
  2408		if (ver->img_type == 0x03) {
  2409			clear_bit(BTUSB_BOOTLOADER, &data->flags);
  2410			btintel_check_bdaddr(hdev);
  2411			return 0;
  2412		}
  2413	
  2414		/* Check for supported iBT hardware variants of this firmware
  2415		 * loading method.
  2416		 *
  2417		 * This check has been put in place to ensure correct forward
  2418		 * compatibility options when newer hardware variants come along.
  2419		 */
  2420		switch (INTEL_HW_VARIANT(ver->cnvi_bt)) {
  2421		case 0x17:	/* TyP */
  2422		case 0x18:	/* Slr */
  2423		case 0x19:	/* Slr-F */
  2424			break;
  2425		default:
  2426			bt_dev_err(hdev, "Unsupported Intel hardware variant (0x%x)",
  2427				   INTEL_HW_VARIANT(ver->cnvi_bt));
  2428			return -EINVAL;
  2429		}
  2430	
  2431		/* If the device is not in bootloader mode, then the only possible
  2432		 * choice is to return an error and abort the device initialization.
  2433		 */
  2434		if (ver->img_type != 0x01) {
  2435			bt_dev_err(hdev, "Unsupported Intel firmware variant (0x%x)",
  2436				   ver->img_type);
  2437			return -ENODEV;
  2438		}
  2439	
  2440		/* It is required that every single firmware fragment is acknowledged
  2441		 * with a command complete event. If the boot parameters indicate
  2442		 * that this bootloader does not send them, then abort the setup.
  2443		 */
  2444		if (ver->limited_cce != 0x00) {
  2445			bt_dev_err(hdev, "Unsupported Intel firmware loading method (0x%x)",
  2446				   ver->limited_cce);
  2447			return -EINVAL;
  2448		}
  2449	
  2450		/* Secure boot engine type should be either 1 (ECDSA) or 0 (RSA) */
  2451		if (ver->sbe_type > 0x01) {
  2452			bt_dev_err(hdev, "Unsupported Intel secure boot engine type (0x%x)",
  2453				   ver->sbe_type);
  2454			return -EINVAL;
  2455		}
  2456	
  2457		/* If the OTP has no valid Bluetooth device address, then there will
  2458		 * also be no valid address for the operational firmware.
  2459		 */
  2460		if (!bacmp(&ver->otp_bd_addr, BDADDR_ANY)) {
  2461			bt_dev_info(hdev, "No device address configured");
  2462			set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
  2463		}
  2464	
  2465		err = btusb_setup_intel_newgen_get_fw_name(ver, fwname, sizeof(fwname),
  2466							   "sfi");
  2467		if (!err) {
  2468			bt_dev_err(hdev, "Unsupported Intel firmware naming");
  2469			return -EINVAL;
  2470		}
  2471	
  2472		err = request_firmware(&fw, fwname, &hdev->dev);
  2473		if (err < 0) {
  2474			bt_dev_err(hdev, "Failed to load Intel firmware file (%d)", err);
  2475			return err;
  2476		}
  2477	
  2478		bt_dev_info(hdev, "Found device firmware: %s", fwname);
  2479	
  2480		if (fw->size < 644) {
  2481			bt_dev_err(hdev, "Invalid size of firmware file (%zu)",
  2482				   fw->size);
  2483			err = -EBADF;
  2484			goto done;
  2485		}
  2486	
  2487		set_bit(BTUSB_DOWNLOADING, &data->flags);
  2488	
  2489		/* Start firmware downloading and get boot parameter */
  2490		err = btintel_download_firmware_newgen(hdev, fw, boot_param,
  2491						       INTEL_HW_VARIANT(ver->cnvi_bt),
  2492						       ver->sbe_type);
  2493		if (err < 0) {
  2494			/* When FW download fails, send Intel Reset to retry
  2495			 * FW download.
  2496			 */
  2497			btintel_reset_to_bootloader(hdev);
  2498			goto done;
  2499		}
  2500		set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
  2501	
  2502		bt_dev_info(hdev, "Waiting for firmware download to complete");
  2503	
  2504		/* Before switching the device into operational mode and with that
  2505		 * booting the loaded firmware, wait for the bootloader notification
  2506		 * that all fragments have been successfully received.
  2507		 *
  2508		 * When the event processing receives the notification, then the
  2509		 * BTUSB_DOWNLOADING flag will be cleared.
  2510		 *
  2511		 * The firmware loading should not take longer than 5 seconds
  2512		 * and thus just timeout if that happens and fail the setup
  2513		 * of this device.
  2514		 */
  2515		err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
  2516					  TASK_INTERRUPTIBLE,
  2517					  msecs_to_jiffies(5000));
  2518		if (err == -EINTR) {
  2519			bt_dev_err(hdev, "Firmware loading interrupted");
  2520			goto done;
  2521		}
  2522	
  2523		if (err) {
  2524			bt_dev_err(hdev, "Firmware loading timeout");
  2525			err = -ETIMEDOUT;
  2526			btintel_reset_to_bootloader(hdev);
  2527			goto done;
  2528		}
  2529	
  2530		if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
  2531			bt_dev_err(hdev, "Firmware loading failed");
  2532			err = -ENOEXEC;
  2533			goto done;
  2534		}
  2535	
  2536	done:
  2537		release_firmware(fw);
  2538		return err;
  2539	}
  2540	static int btusb_intel_download_firmware(struct hci_dev *hdev,
  2541						 struct intel_version *ver,
  2542						 struct intel_boot_params *params,
  2543						 u32 *boot_param)
  2544	{
  2545		const struct firmware *fw;
  2546		char fwname[64];
  2547		int err;
  2548		struct btusb_data *data = hci_get_drvdata(hdev);
  2549	
  2550		if (!ver || !params)
  2551			return -EINVAL;
  2552	
  2553		/* The hardware platform number has a fixed value of 0x37 and
  2554		 * for now only accept this single value.
  2555		 */
  2556		if (ver->hw_platform != 0x37) {
  2557			bt_dev_err(hdev, "Unsupported Intel hardware platform (%u)",
  2558				   ver->hw_platform);
  2559			return -EINVAL;
  2560		}
  2561	
  2562		/* Check for supported iBT hardware variants of this firmware
  2563		 * loading method.
  2564		 *
  2565		 * This check has been put in place to ensure correct forward
  2566		 * compatibility options when newer hardware variants come along.
  2567		 */
  2568		switch (ver->hw_variant) {
  2569		case 0x0b:	/* SfP */
  2570		case 0x0c:	/* WsP */
  2571		case 0x11:	/* JfP */
  2572		case 0x12:	/* ThP */
  2573		case 0x13:	/* HrP */
  2574		case 0x14:	/* CcP */
  2575			break;
  2576		default:
  2577			bt_dev_err(hdev, "Unsupported Intel hardware variant (%u)",
  2578				   ver->hw_variant);
  2579			return -EINVAL;
  2580		}
  2581	
  2582		btintel_version_info(hdev, ver);
  2583	
  2584		/* The firmware variant determines if the device is in bootloader
  2585		 * mode or is running operational firmware. The value 0x06 identifies
  2586		 * the bootloader and the value 0x23 identifies the operational
  2587		 * firmware.
  2588		 *
  2589		 * When the operational firmware is already present, then only
  2590		 * the check for valid Bluetooth device address is needed. This
  2591		 * determines if the device will be added as configured or
  2592		 * unconfigured controller.
  2593		 *
  2594		 * It is not possible to use the Secure Boot Parameters in this
  2595		 * case since that command is only available in bootloader mode.
  2596		 */
  2597		if (ver->fw_variant == 0x23) {
  2598			clear_bit(BTUSB_BOOTLOADER, &data->flags);
  2599			btintel_check_bdaddr(hdev);
  2600			return 0;
  2601		}
  2602	
  2603		/* If the device is not in bootloader mode, then the only possible
  2604		 * choice is to return an error and abort the device initialization.
  2605		 */
  2606		if (ver->fw_variant != 0x06) {
  2607			bt_dev_err(hdev, "Unsupported Intel firmware variant (%u)",
  2608				   ver->fw_variant);
  2609			return -ENODEV;
  2610		}
  2611	
  2612		/* Read the secure boot parameters to identify the operating
  2613		 * details of the bootloader.
  2614		 */
  2615		err = btintel_read_boot_params(hdev, params);
  2616		if (err)
  2617			return err;
  2618	
  2619		/* It is required that every single firmware fragment is acknowledged
  2620		 * with a command complete event. If the boot parameters indicate
  2621		 * that this bootloader does not send them, then abort the setup.
  2622		 */
  2623		if (params->limited_cce != 0x00) {
  2624			bt_dev_err(hdev, "Unsupported Intel firmware loading method (%u)",
  2625				   params->limited_cce);
  2626			return -EINVAL;
  2627		}
  2628	
  2629		/* If the OTP has no valid Bluetooth device address, then there will
  2630		 * also be no valid address for the operational firmware.
  2631		 */
  2632		if (!bacmp(&params->otp_bdaddr, BDADDR_ANY)) {
  2633			bt_dev_info(hdev, "No device address configured");
  2634			set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
  2635		}
  2636	
  2637		/* With this Intel bootloader only the hardware variant and device
  2638		 * revision information are used to select the right firmware for SfP
  2639		 * and WsP.
  2640		 *
  2641		 * The firmware filename is ibt-<hw_variant>-<dev_revid>.sfi.
  2642		 *
  2643		 * Currently the supported hardware variants are:
  2644		 *   11 (0x0b) for iBT3.0 (LnP/SfP)
  2645		 *   12 (0x0c) for iBT3.5 (WsP)
  2646		 *
  2647		 * For ThP/JfP and for future SKU's, the FW name varies based on HW
  2648		 * variant, HW revision and FW revision, as these are dependent on CNVi
  2649		 * and RF Combination.
  2650		 *
  2651		 *   17 (0x11) for iBT3.5 (JfP)
  2652		 *   18 (0x12) for iBT3.5 (ThP)
  2653		 *
  2654		 * The firmware file name for these will be
  2655		 * ibt-<hw_variant>-<hw_revision>-<fw_revision>.sfi.
  2656		 *
  2657		 */
  2658		err = btusb_setup_intel_new_get_fw_name(ver, params, fwname,
  2659							sizeof(fwname), "sfi");
  2660		if (!err) {
  2661			bt_dev_err(hdev, "Unsupported Intel firmware naming");
  2662			return -EINVAL;
  2663		}
  2664	
  2665		err = request_firmware(&fw, fwname, &hdev->dev);
  2666		if (err < 0) {
  2667			bt_dev_err(hdev, "Failed to load Intel firmware file (%d)", err);
  2668			return err;
  2669		}
  2670	
  2671		bt_dev_info(hdev, "Found device firmware: %s", fwname);
  2672	
  2673		if (fw->size < 644) {
  2674			bt_dev_err(hdev, "Invalid size of firmware file (%zu)",
  2675				   fw->size);
  2676			err = -EBADF;
  2677			goto done;
  2678		}
  2679	
  2680		set_bit(BTUSB_DOWNLOADING, &data->flags);
  2681	
  2682		/* Start firmware downloading and get boot parameter */
  2683		err = btintel_download_firmware(hdev, fw, boot_param);
  2684		if (err < 0) {
  2685			/* When FW download fails, send Intel Reset to retry
  2686			 * FW download.
  2687			 */
  2688			btintel_reset_to_bootloader(hdev);
  2689			goto done;
  2690		}
  2691		set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
  2692	
  2693		bt_dev_info(hdev, "Waiting for firmware download to complete");
  2694	
  2695		/* Before switching the device into operational mode and with that
  2696		 * booting the loaded firmware, wait for the bootloader notification
  2697		 * that all fragments have been successfully received.
  2698		 *
  2699		 * When the event processing receives the notification, then the
  2700		 * BTUSB_DOWNLOADING flag will be cleared.
  2701		 *
  2702		 * The firmware loading should not take longer than 5 seconds
  2703		 * and thus just timeout if that happens and fail the setup
  2704		 * of this device.
  2705		 */
  2706		err = wait_on_bit_timeout(&data->flags, BTUSB_DOWNLOADING,
  2707					  TASK_INTERRUPTIBLE,
  2708					  msecs_to_jiffies(5000));
  2709		if (err == -EINTR) {
  2710			bt_dev_err(hdev, "Firmware loading interrupted");
  2711			goto done;
  2712		}
  2713	
  2714		if (err) {
  2715			bt_dev_err(hdev, "Firmware loading timeout");
  2716			err = -ETIMEDOUT;
  2717			btintel_reset_to_bootloader(hdev);
  2718			goto done;
  2719		}
  2720	
  2721		if (test_bit(BTUSB_FIRMWARE_FAILED, &data->flags)) {
  2722			bt_dev_err(hdev, "Firmware loading failed");
  2723			err = -ENOEXEC;
  2724			goto done;
  2725		}
  2726	
  2727	done:
  2728		release_firmware(fw);
  2729		return err;
  2730	}
  2731	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--Kj7319i9nmIyA2yE
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--Kj7319i9nmIyA2yE--
