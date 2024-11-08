Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EF31E0E11
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Nov 2024 09:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731057554; cv=none; b=cMvcM0dABrw+jp/IAxp9RqkEEp/C0wfAdE35sLifzkOzD1hS4YVSQEcemCSH6y/3bS1xnMzvbF61W2nqBiGA4A7A7AB9lewWVwCSG+PV+zljdzf/NDs5rf4CZhNPUMx3y6HudurKkH3xq5NQ0CvAXLohafhPfb8rbK9/hewvUzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731057554; c=relaxed/simple;
	bh=6LIZA17IxHyNRa14Hhb08DVFQNTv1QaYKV0xM6GEHc8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aOuiMjmdfETd7Iqg1gvvIyNg5tYnmldTo0p/MNTG2Mxpkt0kqr14mpzKXTyJ8MimA7/gJmKj38G159sRgHQh1ErxhJ9th9g3Nt4VItWhd89eU3Ku+RTF+XcNGh+v3xM2hHI9krvex0IsLSh5yBXrNYO4vx4OdN6B+zsaZWkc+k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (unknown [95.90.242.139])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6DD5A600AA6A1;
	Fri, 08 Nov 2024 10:18:55 +0100 (CET)
Message-ID: <693d09b6-edab-4ed4-8df5-11ca74bb02e6@molgen.mpg.de>
Date: Fri, 8 Nov 2024 10:18:54 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: Support suspend-resume
To: Chandra Shekar Devegowda <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, Kiran K <kiran.k@intel.com>
References: <20241108143931.2422947-1-chandrashekar.devegowda@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241108143931.2422947-1-chandrashekar.devegowda@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Chandra,


Thank you for sending the second iteration. Please also include the 
previous reviewers in the Cc: list.


Am 08.11.24 um 15:39 schrieb ChandraShekar Devegowda:

The space in your name is still missing.

> This patch contains the changes in driver for vendor specific handshake
> during enter of D3 and D0 exit.

Please document the datasheet name and revision.

> Command to test host initiated wake up after 60seconds

Please remove the space in wakeup, and add a space in 60 seconds.

>      sudo rtcwake -m mem-s 60

Please add space before the switch -s.

> logs from testing:
>      Bluetooth: hci0: BT device resumed to D0 in 1016 usecs

Thank you for providing the logs.

> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: ChandraShekar Devegowda <chandrashekar.devegowda@intel.com>
> ---

It’s common to add a change-log between the different versions below the 
`---` line.

>   drivers/bluetooth/btintel_pcie.c | 58 ++++++++++++++++++++++++++++++++
>   drivers/bluetooth/btintel_pcie.h |  4 +++
>   2 files changed, 62 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 2b79952f3628..49b78d3ecdf9 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -273,6 +273,12 @@ static int btintel_pcie_reset_bt(struct btintel_pcie_data *data)
>   	return reg == 0 ? 0 : -ENODEV;
>   }
>   
> +static void btintel_pcie_set_persistence_mode(struct btintel_pcie_data *data)
> +{
> +	btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_HW_BOOT_CONFIG,
> +				  BTINTEL_PCIE_CSR_HW_BOOT_CONFIG_KEEP_ON);
> +}
> +
>   /* This function enables BT function by setting BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT bit in
>    * BTINTEL_PCIE_CSR_FUNC_CTRL_REG register and wait for MSI-X with
>    * BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0.
> @@ -297,6 +303,8 @@ static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
>   	 */
>   	data->boot_stage_cache = 0x0;
>   
> +	btintel_pcie_set_persistence_mode(data);
> +
>   	/* Set MAC_INIT bit to start primary bootloader */
>   	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
>   	reg &= ~(BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT |
> @@ -1647,11 +1655,61 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
>   	pci_set_drvdata(pdev, NULL);
>   }
>   
> +static int btintel_pcie_suspend(struct device *dev)
> +{
> +	struct btintel_pcie_data *data;
> +	int err;
> +	struct  pci_dev *pdev = to_pci_dev(dev);
> +
> +	data = pci_get_drvdata(pdev);
> +	data->gp0_received = false;
> +	btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D3_HOT);
> +	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
> +				 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
> +	if (!err) {
> +		bt_dev_err(data->hdev, "failed to receive gp0 interrupt for suspend in %lu msecs",
> +			   BTINTEL_DEFAULT_INTR_TIMEOUT_MS);
> +		return -EBUSY;
> +	}
> +	return 0;
> +}
> +
> +static int btintel_pcie_resume(struct device *dev)
> +{
> +	struct btintel_pcie_data *data;
> +	struct  pci_dev *pdev = to_pci_dev(dev);
> +	ktime_t calltime, delta, rettime;
> +	unsigned long long duration;
> +	int err;
> +
> +	data = pci_get_drvdata(pdev);
> +	data->gp0_received = false;
> +	calltime = ktime_get();
> +	btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D0);
> +	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
> +				 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));
> +	if (!err) {
> +		bt_dev_err(data->hdev, "failed to receive gp0 interrupt for resume in %lu msecs",
> +			   BTINTEL_DEFAULT_INTR_TIMEOUT_MS);
> +		return -EBUSY;
> +	}
> +	rettime = ktime_get();
> +	delta = ktime_sub(rettime, calltime);
> +	duration = (unsigned long long)ktime_to_ns(delta) >> 10;
> +	bt_dev_info(data->hdev, "BT device resumed to D0 in %llu usecs", duration);
> +
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(btintel_pcie_pm_ops, btintel_pcie_suspend,
> +		btintel_pcie_resume);
> +
>   static struct pci_driver btintel_pcie_driver = {
>   	.name = KBUILD_MODNAME,
>   	.id_table = btintel_pcie_table,
>   	.probe = btintel_pcie_probe,
>   	.remove = btintel_pcie_remove,
> +	.driver.pm = &btintel_pcie_pm_ops,
>   };
>   module_pci_driver(btintel_pcie_driver);
>   
> diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
> index f9aada0543c4..38d0c8ea2b6f 100644
> --- a/drivers/bluetooth/btintel_pcie.h
> +++ b/drivers/bluetooth/btintel_pcie.h
> @@ -8,6 +8,7 @@
>   
>   /* Control and Status Register(BTINTEL_PCIE_CSR) */
>   #define BTINTEL_PCIE_CSR_BASE			(0x000)
> +#define BTINTEL_PCIE_CSR_HW_BOOT_CONFIG		(BTINTEL_PCIE_CSR_BASE + 0x000)
>   #define BTINTEL_PCIE_CSR_FUNC_CTRL_REG		(BTINTEL_PCIE_CSR_BASE + 0x024)
>   #define BTINTEL_PCIE_CSR_HW_REV_REG		(BTINTEL_PCIE_CSR_BASE + 0x028)
>   #define BTINTEL_PCIE_CSR_RF_ID_REG		(BTINTEL_PCIE_CSR_BASE + 0x09C)
> @@ -48,6 +49,9 @@
>   #define BTINTEL_PCIE_CSR_MSIX_IVAR_BASE		(BTINTEL_PCIE_CSR_MSIX_BASE + 0x0880)
>   #define BTINTEL_PCIE_CSR_MSIX_IVAR(cause)	(BTINTEL_PCIE_CSR_MSIX_IVAR_BASE + (cause))
>   
> +/* CSR HW BOOT CONFIG Register */
> +#define BTINTEL_PCIE_CSR_HW_BOOT_CONFIG_KEEP_ON		(BIT(31))
> +
>   /* Causes for the FH register interrupts */
>   enum msix_fh_int_causes {
>   	BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0	= BIT(0),	/* cause 0 */


Kind regards,

Paul
