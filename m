Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 556C1C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 19:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32F1760EC0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 19:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhG2TpV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 15:45:21 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:49368 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbhG2TpV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 15:45:21 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 9D42ACED1E;
        Thu, 29 Jul 2021 21:45:16 +0200 (CEST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: [PATCH v5 08/11] Bluetooth: btintel: Refactoring setup routine
 for legacy bootloader
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20210729183600.281586-9-hj.tedd.an@gmail.com>
Date:   Thu, 29 Jul 2021 21:45:16 +0200
Cc:     linux-bluetooth@vger.kernel.org,
        Tedd Ho-Jeong An <tedd.an@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <13F008D5-B446-4E03-B397-6AF5E9821193@holtmann.org>
References: <20210729183600.281586-1-hj.tedd.an@gmail.com>
 <20210729183600.281586-9-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

> This patch refactors the setup routines for legacy bootloader devices
> into combined setup, and move the related functions from btusb to
> btintel.
> 
> Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
> ---
> drivers/bluetooth/btintel.c | 419 +++++++++++++++++++++++++++++++++++-
> drivers/bluetooth/btintel.h |  12 ++
> drivers/bluetooth/btusb.c   | 377 +++++---------------------------
> 3 files changed, 479 insertions(+), 329 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 24b79f449527..944203cae8e0 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -1675,6 +1675,392 @@ static int btintel_legacy_rom_setup(struct hci_dev *hdev,
> 	return 0;
> }
> 
> +static int btintel_download_wait(struct hci_dev *hdev, ktime_t calltime, int msec)
> +{
> +	struct btintel_data *intel = hci_get_priv(hdev);
> +	ktime_t delta, rettime;
> +	unsigned long long duration;
> +	int err;
> +
> +	set_bit(INTEL_FIRMWARE_LOADED, &intel->flags);
> +
> +	bt_dev_info(hdev, "Waiting for firmware download to complete");
> +
> +	err = wait_on_bit_timeout(&intel->flags, INTEL_DOWNLOADING,
> +				  TASK_INTERRUPTIBLE,
> +				  msecs_to_jiffies(msec));
> +	if (err == -EINTR) {
> +		bt_dev_err(hdev, "Firmware loading interrupted");
> +		return err;
> +	}
> +
> +	if (err) {
> +		bt_dev_err(hdev, "Firmware loading timeout");
> +		return -ETIMEDOUT;
> +	}
> +
> +	if (test_bit(INTEL_FIRMWARE_FAILED, &intel->flags)) {
> +		bt_dev_err(hdev, "Firmware loading failed");
> +		return -ENOEXEC;
> +	}
> +
> +	rettime = ktime_get();
> +	delta = ktime_sub(rettime, calltime);
> +	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
> +
> +	bt_dev_info(hdev, "Firmware loaded in %llu usecs", duration);
> +
> +	return 0;
> +}
> +
> +static int btintel_boot_wait(struct hci_dev *hdev, ktime_t calltime, int msec)
> +{
> +	struct btintel_data *intel = hci_get_priv(hdev);
> +	ktime_t delta, rettime;
> +	unsigned long long duration;
> +	int err;
> +
> +	bt_dev_info(hdev, "Waiting for device to boot");
> +
> +	err = wait_on_bit_timeout(&intel->flags, INTEL_BOOTING,
> +				  TASK_INTERRUPTIBLE, msecs_to_jiffies(msec));
> +	if (err == -EINTR) {
> +		bt_dev_err(hdev, "Device boot interrupted");
> +		return -EINTR;
> +	}
> +
> +	if (err) {
> +		bt_dev_err(hdev, "Device boot timeout");
> +		return -ETIMEDOUT;
> +	}
> +
> +	rettime = ktime_get();
> +	delta = ktime_sub(rettime, calltime);
> +	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
> +
> +	bt_dev_info(hdev, "Device booted in %llu usecs", duration);
> +
> +	return 0;
> +}
> +
> +static int btintel_boot(struct hci_dev *hdev, u32 boot_addr)
> +{
> +	struct btintel_data *intel = hci_get_priv(hdev);
> +	ktime_t calltime;
> +	int err;
> +
> +	calltime = ktime_get();
> +
> +	set_bit(INTEL_BOOTING, &intel->flags);
> +
> +	err = btintel_send_intel_reset(hdev, boot_addr);
> +	if (err) {
> +		bt_dev_err(hdev, "Intel Soft Reset failed (%d)", err);
> +		btintel_reset_to_bootloader(hdev);
> +		return err;
> +	}
> +
> +	/* The bootloader will not indicate when the device is ready. This
> +	 * is done by the operational firmware sending bootup notification.
> +	 *
> +	 * Booting into operational firmware should not take longer than
> +	 * 1 second. However if that happens, then just fail the setup
> +	 * since something went wrong.
> +	 */
> +	err = btintel_boot_wait(hdev, calltime, 1000);
> +	if (err == -ETIMEDOUT)
> +		btintel_reset_to_bootloader(hdev);
> +
> +	return err;
> +}
> +
> +static int btintel_get_fw_name(struct intel_version *ver,
> +					     struct intel_boot_params *params,
> +					     char *fw_name, size_t len,
> +					     const char *suffix)
> +{
> +	switch (ver->hw_variant) {
> +	case 0x0b:	/* SfP */
> +	case 0x0c:	/* WsP */
> +		snprintf(fw_name, len, "intel/ibt-%u-%u.%s",
> +			le16_to_cpu(ver->hw_variant),
> +			le16_to_cpu(params->dev_revid),
> +			suffix);
> +		break;
> +	case 0x11:	/* JfP */
> +	case 0x12:	/* ThP */
> +	case 0x13:	/* HrP */
> +	case 0x14:	/* CcP */
> +		snprintf(fw_name, len, "intel/ibt-%u-%u-%u.%s",
> +			le16_to_cpu(ver->hw_variant),
> +			le16_to_cpu(ver->hw_revision),
> +			le16_to_cpu(ver->fw_revision),
> +			suffix);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int btintel_download_fw(struct hci_dev *hdev,
> +					 struct intel_version *ver,
> +					 struct intel_boot_params *params,
> +					 u32 *boot_param)
> +{
> +	const struct firmware *fw;
> +	char fwname[64];
> +	int err;
> +	struct btintel_data *intel = hci_get_priv(hdev);
> +	ktime_t calltime;
> +
> +	if (!ver || !params)
> +		return -EINVAL;
> +
> +	/* The firmware variant determines if the device is in bootloader
> +	 * mode or is running operational firmware. The value 0x06 identifies
> +	 * the bootloader and the value 0x23 identifies the operational
> +	 * firmware.
> +	 *
> +	 * When the operational firmware is already present, then only
> +	 * the check for valid Bluetooth device address is needed. This
> +	 * determines if the device will be added as configured or
> +	 * unconfigured controller.
> +	 *
> +	 * It is not possible to use the Secure Boot Parameters in this
> +	 * case since that command is only available in bootloader mode.
> +	 */
> +	if (ver->fw_variant == 0x23) {
> +		clear_bit(INTEL_BOOTLOADER, &intel->flags);
> +		btintel_check_bdaddr(hdev);
> +
> +		/* SfP and WsP don't seem to update the firmware version on file
> +		 * so version checking is currently possible.
> +		 */
> +		switch (ver->hw_variant) {
> +		case 0x0b:	/* SfP */
> +		case 0x0c:	/* WsP */
> +			return 0;
> +		}
> +
> +		/* Proceed to download to check if the version matches */
> +		goto download;
> +	}
> +
> +	/* Read the secure boot parameters to identify the operating
> +	 * details of the bootloader.
> +	 */
> +	err = btintel_read_boot_params(hdev, params);
> +	if (err)
> +		return err;
> +
> +	/* It is required that every single firmware fragment is acknowledged
> +	 * with a command complete event. If the boot parameters indicate
> +	 * that this bootloader does not send them, then abort the setup.
> +	 */
> +	if (params->limited_cce != 0x00) {
> +		bt_dev_err(hdev, "Unsupported Intel firmware loading method (%u)",
> +			   params->limited_cce);
> +		return -EINVAL;
> +	}
> +
> +	/* If the OTP has no valid Bluetooth device address, then there will
> +	 * also be no valid address for the operational firmware.
> +	 */
> +	if (!bacmp(&params->otp_bdaddr, BDADDR_ANY)) {
> +		bt_dev_info(hdev, "No device address configured");
> +		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
> +	}
> +
> +download:
> +	/* With this Intel bootloader only the hardware variant and device
> +	 * revision information are used to select the right firmware for SfP
> +	 * and WsP.
> +	 *
> +	 * The firmware filename is ibt-<hw_variant>-<dev_revid>.sfi.
> +	 *
> +	 * Currently the supported hardware variants are:
> +	 *   11 (0x0b) for iBT3.0 (LnP/SfP)
> +	 *   12 (0x0c) for iBT3.5 (WsP)
> +	 *
> +	 * For ThP/JfP and for future SKU's, the FW name varies based on HW
> +	 * variant, HW revision and FW revision, as these are dependent on CNVi
> +	 * and RF Combination.
> +	 *
> +	 *   17 (0x11) for iBT3.5 (JfP)
> +	 *   18 (0x12) for iBT3.5 (ThP)
> +	 *
> +	 * The firmware file name for these will be
> +	 * ibt-<hw_variant>-<hw_revision>-<fw_revision>.sfi.
> +	 *
> +	 */
> +	err = btintel_get_fw_name(ver, params, fwname, sizeof(fwname), "sfi");
> +	if (err < 0) {
> +		if (!test_bit(INTEL_BOOTLOADER, &intel->flags)) {
> +			/* Firmware has already been loaded */
> +			set_bit(INTEL_FIRMWARE_LOADED, &intel->flags);
> +			return 0;
> +		}
> +
> +		bt_dev_err(hdev, "Unsupported Intel firmware naming");
> +		return -EINVAL;
> +	}
> +
> +	err = firmware_request_nowarn(&fw, fwname, &hdev->dev);
> +	if (err < 0) {
> +		if (!test_bit(INTEL_BOOTLOADER, &intel->flags)) {
> +			/* Firmware has already been loaded */
> +			set_bit(INTEL_FIRMWARE_LOADED, &intel->flags);
> +			return 0;
> +		}
> +
> +		bt_dev_err(hdev, "Failed to load Intel firmware file %s (%d)",
> +			   fwname, err);
> +		return err;
> +	}
> +
> +	bt_dev_info(hdev, "Found device firmware: %s", fwname);
> +
> +	if (fw->size < 644) {
> +		bt_dev_err(hdev, "Invalid size of firmware file (%zu)",
> +			   fw->size);
> +		err = -EBADF;
> +		goto done;
> +	}
> +
> +	calltime = ktime_get();
> +
> +	set_bit(INTEL_DOWNLOADING, &intel->flags);
> +
> +	/* Start firmware downloading and get boot parameter */
> +	err = btintel_download_firmware(hdev, ver, fw, boot_param);
> +	if (err < 0) {
> +		if (err == -EALREADY) {
> +			/* Firmware has already been loaded */
> +			set_bit(INTEL_FIRMWARE_LOADED, &intel->flags);
> +			err = 0;
> +			goto done;
> +		}
> +
> +		/* When FW download fails, send Intel Reset to retry
> +		 * FW download.
> +		 */
> +		btintel_reset_to_bootloader(hdev);
> +		goto done;
> +	}
> +
> +	/* Before switching the device into operational mode and with that
> +	 * booting the loaded firmware, wait for the bootloader notification
> +	 * that all fragments have been successfully received.
> +	 *
> +	 * When the event processing receives the notification, then the
> +	 * INTEL_DOWNLOADING flag will be cleared.
> +	 *
> +	 * The firmware loading should not take longer than 5 seconds
> +	 * and thus just timeout if that happens and fail the setup
> +	 * of this device.
> +	 */
> +	err = btintel_download_wait(hdev, calltime, 5000);
> +	if (err == -ETIMEDOUT)
> +		btintel_reset_to_bootloader(hdev);
> +
> +done:
> +	release_firmware(fw);
> +	return err;
> +}
> +
> +static int btintel_bootloader_setup(struct hci_dev *hdev,
> +				    struct intel_version *ver)
> +{
> +	struct btintel_data *intel = hci_get_priv(hdev);
> +	struct intel_version new_ver;
> +	struct intel_boot_params params;
> +	u32 boot_param;
> +	char ddcname[64];
> +	int err;
> +	struct intel_debug_features features;
> +
> +	BT_DBG("%s", hdev->name);
> +
> +	/* Set the default boot parameter to 0x0 and it is updated to
> +	 * SKU specific boot parameter after reading Intel_Write_Boot_Params
> +	 * command while downloading the firmware.
> +	 */
> +	boot_param = 0x00000000;
> +
> +	set_bit(INTEL_BOOTLOADER, &intel->flags);
> +
> +	err = btintel_download_fw(hdev, ver, &params, &boot_param);
> +	if (err)
> +		return err;
> +
> +	/* controller is already having an operational firmware */
> +	if (ver->fw_variant == 0x23)
> +		goto finish;
> +
> +	err = btintel_boot(hdev, boot_param);
> +	if (err)
> +		return err;
> +
> +	clear_bit(INTEL_BOOTLOADER, &intel->flags);
> +
> +	err = btintel_get_fw_name(ver, &params, ddcname,
> +						sizeof(ddcname), "ddc");
> +
> +	if (err < 0) {
> +		bt_dev_err(hdev, "Unsupported Intel firmware naming");
> +	} else {
> +		/* Once the device is running in operational mode, it needs to
> +		 * apply the device configuration (DDC) parameters.
> +		 *
> +		 * The device can work without DDC parameters, so even if it
> +		 * fails to load the file, no need to fail the setup.
> +		 */
> +		btintel_load_ddc_config(hdev, ddcname);
> +	}
> +
> +	/* Read the Intel supported features and if new exception formats
> +	 * supported, need to load the additional DDC config to enable.
> +	 */
> +	err = btintel_read_debug_features(hdev, &features);
> +	if (!err) {
> +		/* Set DDC mask for available debug features */
> +		btintel_set_debug_features(hdev, &features);
> +	}
> +
> +	/* Read the Intel version information after loading the FW  */
> +	err = btintel_read_version(hdev, &new_ver);
> +	if (err)
> +		return err;
> +
> +	btintel_version_info(hdev, &new_ver);
> +
> +finish:
> +	/* All Intel controllers that support the Microsoft vendor
> +	 * extension are using 0xFC1E for VsMsftOpCode.
> +	 */
> +	switch (ver->hw_variant) {
> +	case 0x11:	/* JfP */
> +	case 0x12:	/* ThP */
> +	case 0x13:	/* HrP */
> +	case 0x14:	/* CcP */
> +		hci_set_msft_opcode(hdev, 0xFC1E);
> +		break;
> +	}
> +
> +	/* Set the event mask for Intel specific vendor events. This enables
> +	 * a few extra events that are useful during general operation. It
> +	 * does not enable any debugging related events.
> +	 *
> +	 * The device will function correctly without these events enabled
> +	 * and thus no need to fail the setup.
> +	 */
> +	btintel_set_event_mask(hdev, false);
> +
> +	return 0;
> +}
> +
> int btintel_setup_combined(struct hci_dev *hdev)
> {
> 	struct btintel_data *intel = hci_get_priv(hdev);
> @@ -1750,7 +2136,7 @@ int btintel_setup_combined(struct hci_dev *hdev)
> 		case 0x12:      /* ThP */
> 		case 0x13:      /* HrP */
> 		case 0x14:      /* CcP */
> -			/* TODO: call setup routine for bootloader product */
> +			err = btintel_bootloader_setup(hdev, &ver);
> 			break;
> 		default:
> 			bt_dev_err(hdev, "Unsupported Intel hw variant (%u)",
> @@ -1818,6 +2204,37 @@ void btintel_set_flags(struct hci_dev *hdev, unsigned int flag)
> }
> EXPORT_SYMBOL_GPL(btintel_set_flags);
> 
> +void btintel_bootup(struct hci_dev *hdev, const void *ptr, unsigned int len)
> +{
> +	struct btintel_data *intel = hci_get_priv(hdev);
> +	const struct intel_bootup *evt = ptr;
> +
> +	if (len != sizeof(*evt))
> +		return;
> +
> +	if (test_and_clear_bit(INTEL_BOOTING, &intel->flags))
> +		wake_up_bit(&intel->flags, INTEL_BOOTING);
> +}
> +EXPORT_SYMBOL_GPL(btintel_bootup);
> +
> +void btintel_secure_send_result(struct hci_dev *hdev,
> +				const void *ptr, unsigned int len)
> +{
> +	struct btintel_data *intel = hci_get_priv(hdev);
> +	const struct intel_secure_send_result *evt = ptr;
> +
> +	if (len != sizeof(*evt))
> +		return;
> +
> +	if (evt->result)
> +		set_bit(INTEL_FIRMWARE_FAILED, &intel->flags);
> +
> +	if (test_and_clear_bit(INTEL_DOWNLOADING, &intel->flags) &&
> +	    test_bit(INTEL_FIRMWARE_LOADED, &intel->flags))
> +		wake_up_bit(&intel->flags, INTEL_DOWNLOADING);
> +}
> +EXPORT_SYMBOL_GPL(btintel_secure_send_result);
> +
> MODULE_AUTHOR("Marcel Holtmann <marcel@holtmann.org>");
> MODULE_DESCRIPTION("Bluetooth support for Intel devices ver " VERSION);
> MODULE_VERSION(VERSION);
> diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
> index abc438b9c62e..f02ccd7e76fb 100644
> --- a/drivers/bluetooth/btintel.h
> +++ b/drivers/bluetooth/btintel.h
> @@ -191,6 +191,9 @@ int btintel_read_debug_features(struct hci_dev *hdev,
> 				struct intel_debug_features *features);
> int btintel_set_debug_features(struct hci_dev *hdev,
> 			       const struct intel_debug_features *features);
> +void btintel_bootup(struct hci_dev *hdev, const void *ptr, unsigned int len);
> +void btintel_secure_send_result(struct hci_dev *hdev,
> +				const void *ptr, unsigned int len);
> #else
> 
> static inline int btintel_check_bdaddr(struct hci_dev *hdev)
> @@ -337,4 +340,13 @@ static inline int btintel_set_debug_features(struct hci_dev *hdev,
> 	return -EOPNOTSUPP;
> }
> 
> +static inline void btintel_bootup(struct hci_dev *hdev,
> +				  const void *ptr, unsigned int len)
> +{
> +}
> +
> +static inline void btintel_secure_send_result(struct hci_dev *hdev,
> +				const void *ptr, unsigned int len)
> +{
> +}
> #endif
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 01ec2a2d0a1a..4b1e6504f187 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -365,12 +365,12 @@ static const struct usb_device_id blacklist_table[] = {
> 	{ USB_DEVICE(0x1286, 0x204e), .driver_info = BTUSB_MARVELL },
> 
> 	/* Intel Bluetooth devices */
> -	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_NEW |
> +	{ USB_DEVICE(0x8087, 0x0025), .driver_info = BTUSB_INTEL_COMBINED |
> 						     BTUSB_WIDEBAND_SPEECH |
> 						     BTUSB_VALID_LE_STATES },
> -	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_NEW |
> +	{ USB_DEVICE(0x8087, 0x0026), .driver_info = BTUSB_INTEL_COMBINED |
> 						     BTUSB_WIDEBAND_SPEECH },
> -	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_NEW |
> +	{ USB_DEVICE(0x8087, 0x0029), .driver_info = BTUSB_INTEL_COMBINED |
> 						     BTUSB_WIDEBAND_SPEECH },
> 	{ USB_DEVICE(0x8087, 0x0032), .driver_info = BTUSB_INTEL_NEWGEN |
> 						     BTUSB_WIDEBAND_SPEECH},
> @@ -384,13 +384,13 @@ static const struct usb_device_id blacklist_table[] = {
> 	{ USB_DEVICE(0x8087, 0x0a2a), .driver_info = BTUSB_INTEL_COMBINED |
> 						     BTUSB_INTEL_BROKEN_READ_VERSION |
> 						     BTUSB_INTEL_BROKEN_LED },
> -	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_NEW |
> +	{ USB_DEVICE(0x8087, 0x0a2b), .driver_info = BTUSB_INTEL_COMBINED |
> 						     BTUSB_WIDEBAND_SPEECH },
> 	{ USB_DEVICE(0x8087, 0x0aa7), .driver_info = BTUSB_INTEL_COMBINED |
> 						     BTUSB_INTEL_BROKEN_READ_VERSION |
> 						     BTUSB_INTEL_BROKEN_LED |
> 						     BTUSB_WIDEBAND_SPEECH },
> -	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_NEW |
> +	{ USB_DEVICE(0x8087, 0x0aaa), .driver_info = BTUSB_INTEL_COMBINED |
> 						     BTUSB_WIDEBAND_SPEECH |
> 						     BTUSB_VALID_LE_STATES },

while this has nothing to do with this patch, however we need to get rid of the other BTUSB_ flags here. Here we should only have BTUSB_INTEL_COMBINED and something that we need to know before we send the HCI_Intel_Read_Version command. Everything else should be handled internally in btintel.c vendor functions.

So the setup routine should set HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED and HCI_QUIRK_VALID_LE_STATES if supported. Same as with MSFT extensions and anything else we might want to support.

My wish is that you add a new VID/PID here with BTUSB_INTEL_COMBINED and then only modify one place in btintel.c to add the hw_variant to the list. I don’t want to add flags and features in different locations.

Regards

Marcel

