Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D0C3AFAE0
	for <linux-bluetooth@vger.kernel.org>; Wed,  2 Sep 2026 07:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788332516; cv=none; b=kLirE0iGPVpWPltnUQs1Xs0R1dEUayOklrQFb8bYavUgL8B1vXjGZkULBbiSO5WCRIf1/7yDTPwsz4/LvNNKqr197fBWaW5m/GqGHm6zg2JanCZR6PSFRXdMjKtb3WzdBTTp0/adKrgvqR4BBwBV9DBjpYSm2vIQGS2ukgBtoRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788332516; c=relaxed/simple;
	bh=VMRewD0ml44GcpQZp8EC4HDF7fiaLhWf3BYwtcILoS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HtCFjm59vZk6xnYfxujAKIvEPIjvQbT+8f/75Q4GsBcHtkCwk7hCoBev74uQNSR+4/U1ULpx4r8DCRG1aqG2INwE6aHRK0hbxFjX6ftbMR9FZhRpCPwnrarFSJ9JYQK3duyF1nZt1CK2bBAi1u9CRl5EbxRTdgopBPcLdjaotto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.14.124] (v124.vpnx.molgen.mpg.de [141.14.14.124])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4AFBF4C2C37D64;
	Wed, 02 Sep 2026 09:01:35 +0200 (CEST)
Message-ID: <461c5d78-c99e-4e74-9097-4cc0ecc54b97@molgen.mpg.de>
Date: Wed, 2 Sep 2026 09:01:34 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: btintel_pcie: fix PM flow for S0ix, S3 and
 S4
To: Ravindra <ravindra@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
 chethan.tumkur.narayan@intel.com, kiran.k@intel.com
References: <20260902042840.2432862-1-ravindra@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260902042840.2432862-1-ravindra@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Ravindra,


Thank you for your patch.

Am 02.09.26 um 06:28 schrieb Ravindra:

Please start by describing the problem.

> Use pm_suspend_target_state to differentiate S0ix from S3/S4. Set the
> controller to D3_HOT for S0ix (PM_SUSPEND_TO_IDLE) and D3_COLD for
> S3/S4, freeze and hibernate to prevent post-resume instability.
> 
> Register .freeze, .thaw, .poweroff and .restore callbacks for proper
> hibernation support. The freeze and poweroff (hibernate) paths set
> D3_COLD via btintel_pcie_suspend_late. The thaw path resumes with a
> normal D0 transition, while .restore forces FLR-based firmware recovery
> after S4 since power is lost. S3 (PM_SUSPEND_MEM) resume also triggers
> FLR. S0ix resumes via a normal D0 transition.

Please add how you tested this.

> Fixes: e57362f4911b ("Bluetooth: btintel_pcie: Add support for _suspend() / _resume()")
> Assisted-by: GitHub-Copilot:GPT5
> Signed-off-by: Ravindra <ravindra@intel.com>
> ---
>   drivers/bluetooth/btintel_pcie.c | 64 ++++++++++++++++++++++----------
>   drivers/bluetooth/btintel_pcie.h |  2 -
>   2 files changed, 44 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index 30923eaabed7..90d4a3596f80 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -16,6 +16,7 @@
>   #include <linux/delay.h>
>   #include <linux/interrupt.h>
>   #include <linux/acpi.h>
> +#include <linux/suspend.h>
>   
>   #include <linux/unaligned.h>
>   #include <linux/devcoredump.h>
> @@ -3515,11 +3516,16 @@ static void btintel_pcie_coredump(struct device *dev)
>   
>   static int btintel_pcie_set_dxstate(struct btintel_pcie_data *data, u32 dxstate)
>   {
> -	int retry = 0, status;
> +	int retry = 0;
> +	long status;
>   	u32 dx_intr_timeout_ms = 200;
>   
> +	/* Not reset per retry: dxstate is unchanged, so a late interrupt from
> +	 * an earlier attempt still confirms the target state.
> +	 */
> +	data->gp0_received = false;
> +
>   	do {
> -		data->gp0_received = false;
>   
>   		btintel_pcie_wr_sleep_cntrl(data, dxstate);
>   

gemini/gemini-3.1-pro-preview comments [1]:

> Can a late interrupt from a previous retry attempt cause wait_event_timeout()
> to return immediately?
> If a previous attempt times out, the loop will issue a new
> btintel_pcie_wr_sleep_cntrl() call. If a dangling interrupt from the first
> attempt fires concurrently, it will set data->gp0_received to true. This
> would spuriously satisfy the wait condition while the hardware is actively
> processing the second transition, potentially causing the driver to access
> the device before it is fully initialized.

> @@ -3565,18 +3571,23 @@ static int btintel_pcie_suspend_late(struct device *dev, pm_message_t mesg)
>   
>   	data = pci_get_drvdata(pdev);
>   
> -	dxstate = (mesg.event == PM_EVENT_SUSPEND ?
> -		   BTINTEL_PCIE_STATE_D3_HOT : BTINTEL_PCIE_STATE_D3_COLD);
> -
> -	data->pm_sx_event = mesg.event;
> +	/* S0ix (s2idle) uses D3_HOT; S3, freeze and hibernate use D3_COLD. */
> +	if (mesg.event == PM_EVENT_SUSPEND &&
> +	    pm_suspend_target_state == PM_SUSPEND_TO_IDLE)
> +		dxstate = BTINTEL_PCIE_STATE_D3_HOT;
> +	else
> +		dxstate = BTINTEL_PCIE_STATE_D3_COLD;
>   
>   	start = ktime_get();
>   
>   	/* Refer: 6.4.11.7 -> Platform power management */
>   	err = btintel_pcie_set_dxstate(data, dxstate);
>   
> -	if (err)
> +	if (err) {
> +		bt_dev_err(data->hdev, "Failed to set dxstate:%u (%d)",
> +			   dxstate, err);
>   		return err;
> +	}
>   
>   	bt_dev_dbg(data->hdev,
>   		   "device entered into d3 state from d0 in %lld us",
> @@ -3599,7 +3610,7 @@ static int btintel_pcie_freeze(struct device *dev)
>   	return btintel_pcie_suspend_late(dev, PMSG_FREEZE);
>   }
>   
> -static int btintel_pcie_resume(struct device *dev)
> +static int btintel_pcie_resume_event(struct device *dev, pm_message_t mesg)
>   {
>   	struct pci_dev *pdev = to_pci_dev(dev);
>   	struct btintel_pcie_data *data;
> @@ -3607,19 +3618,15 @@ static int btintel_pcie_resume(struct device *dev)
>   	int err;
>   
>   	data = pci_get_drvdata(pdev);
> -	data->gp0_received = false;
>   
>   	start = ktime_get();
>   
> -	/* When the system enters S4 (hibernate) mode, bluetooth device loses
> -	 * power, which results in the erasure of its loaded firmware.
> -	 * Consequently, function level reset (flr) is required on system
> -	 * resume to bring the controller back into an operational state by
> -	 * initiating a new firmware download.
> +	/* S3 and S4 may cut power, erasing the firmware. Force FLR to recover
> +	 * instead of a normal D0 transition.
>   	 */
> -
> -	if (data->pm_sx_event == PM_EVENT_FREEZE ||
> -	    data->pm_sx_event == PM_EVENT_HIBERNATE) {
> +	if (mesg.event == PM_EVENT_RESTORE ||
> +	    (mesg.event == PM_EVENT_RESUME &&
> +	     pm_suspend_target_state == PM_SUSPEND_MEM)) {
>   		set_bit(BTINTEL_PCIE_CORE_HALTED, &data->flags);
>   		btintel_pcie_request_reset(data, BTINTEL_PCIE_IOSF_PRR_FLR);
>   		return 0;
> @@ -3628,7 +3635,9 @@ static int btintel_pcie_resume(struct device *dev)
>   	/* Refer: 6.4.11.7 -> Platform power management */
>   	err = btintel_pcie_set_dxstate(data, BTINTEL_PCIE_STATE_D0);
>   
> -	if (err == 0) {
> +	if (err) {
> +		bt_dev_err(data->hdev, "Failed to set D0 state (%d)", err);
> +	} else {
>   		bt_dev_dbg(data->hdev,
>   			   "device entered into d0 state from d3 in %lld us",
>   			   ktime_to_us(ktime_get() - start));
> @@ -3653,13 +3662,28 @@ static int btintel_pcie_resume(struct device *dev)
>   	return err;
>   }
>   
> +static int btintel_pcie_resume(struct device *dev)
> +{
> +	return btintel_pcie_resume_event(dev, PMSG_RESUME);
> +}
> +
> +static int btintel_pcie_restore(struct device *dev)
> +{
> +	return btintel_pcie_resume_event(dev, PMSG_RESTORE);
> +}
> +
> +static int btintel_pcie_thaw(struct device *dev)
> +{
> +	return btintel_pcie_resume_event(dev, PMSG_THAW);
> +}
> +
>   static const struct dev_pm_ops btintel_pcie_pm_ops = {
>   	.suspend = btintel_pcie_suspend,
>   	.resume = btintel_pcie_resume,
>   	.freeze = btintel_pcie_freeze,
> -	.thaw = btintel_pcie_resume,
> +	.thaw = btintel_pcie_thaw,
>   	.poweroff = btintel_pcie_hibernate,
> -	.restore = btintel_pcie_resume,
> +	.restore = btintel_pcie_restore,
>   };
>   
>   static struct pci_driver btintel_pcie_driver = {
> diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
> index 9baa214d9bbe..290679f45652 100644
> --- a/drivers/bluetooth/btintel_pcie.h
> +++ b/drivers/bluetooth/btintel_pcie.h
> @@ -541,7 +541,6 @@ struct btintel_pcie_dump_header {
>    * @txq: TX Queue struct
>    * @rxq: RX Queue struct
>    * @alive_intr_ctxt: Alive interrupt context
> - * @pm_sx_event: PM event on which system got suspended
>    */
>   struct btintel_pcie_data {
>   	struct pci_dev	*pdev;
> @@ -600,7 +599,6 @@ struct btintel_pcie_data {
>   	enum btintel_pcie_reset_type	reset_type;
>   	struct btintel_pcie_dbgc	dbgc;
>   	struct btintel_pcie_dump_header dmp_hdr;
> -	u8	pm_sx_event;
>   	u32	debug_evt_addr;
>   	u32	debug_evt_size;
>   	dma_addr_t	debug_table_addr;


Kind regards,

Paul


[1]: 
https://sashiko.dev/#/patchset/20260902042840.2432862-1-ravindra%40intel.com
