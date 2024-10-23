Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F4B1B86DC
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Oct 2024 19:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729710835; cv=none; b=byO8Wie1/JuUck5jazWnl45CY8NUK0djIAMRqTdDrOn611p16PfLjyoIZKF8kXWiOjxp3ZqCEflONDz5t+T2FaxM6VLvh1FEP2GR8/Rfqt0ZeKnG1mLJKHaVibMIl4WlLaFmN3KRLUu9Sy0CGeleNV9pUwj3Ag2rHGcyDP5g+0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729710835; c=relaxed/simple;
	bh=OPFssXs14O65PPHPAv1YE+Fbm37GrrOx5H5ka7irrvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ofj7Uk5BaZlh+yDuC/raVLFHfTr8C6IopusfeGUc1ntbMeWF2GKwQORocKVo9wVqvY1WUg0GbKJfjj002D9lMNUm0i8/Tx/2EIK12r96ioMafj6dypedlTxy11S2uj7Gw6X1N0HXkWrBUmDNF9n1Yyedmz1nMaktfoG4SJM22IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XFrM2K26; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XFrM2K26"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20F51C4CEC6;
	Wed, 23 Oct 2024 19:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729710835;
	bh=OPFssXs14O65PPHPAv1YE+Fbm37GrrOx5H5ka7irrvQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=XFrM2K260RlVWgN4zdprjzeii/lP65/cAiYRVZduc8d1rd1uj3Dj8PWmlCIju9eXf
	 2JBIGJ4bBa9eraMcj6cHC8ZOsLqQXOL2Z8uqxdRg7Ra7RzeF9RR+TxTMXg6gMlLLV5
	 mMwiW2dlOp05XrqilpJDapRvU/kki2k9rxgTRJtPpQWOr+dwdXZpzDgBm5ino2ZHqR
	 7VL0riIedtI7wU78xBIBB6uzmfAvkVZaT810SvSpVUVdzOTscRUUBpVh/z/1J+7qCg
	 YZM8xYl1usYg8rkPWoUu4ieHTlVSEZ0+OTuD46Q03biqdPC4rJj8MiWCc1uQ2L42gE
	 lWLNhH47amaDg==
Date: Wed, 23 Oct 2024 14:13:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: ChandraShekar <chandrashekar.devegowda@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com, Kiran K <kiran.k@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v1] Bluetooth: btintel_pcie: Device suspend-resume
 support added
Message-ID: <20241023191352.GA924610@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023114647.1011886-1-chandrashekar.devegowda@intel.com>

[+cc Paul]

On Wed, Oct 23, 2024 at 02:46:47PM +0300, ChandraShekar wrote:
> This patch contains the changes in driver to support the suspend and
> resume i.e move the controller to D3 state when the platform is entering
> into suspend and move the controller to D0 on resume.
> 
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: ChandraShekar <chandrashekar.devegowda@intel.com>
> ---
>  drivers/bluetooth/btintel_pcie.c | 52 ++++++++++++++++++++++++++++++++
>  drivers/bluetooth/btintel_pcie.h |  4 +++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/drivers/bluetooth/btintel_pcie.c b/drivers/bluetooth/btintel_pcie.c
> index fd4a8bd056fa..f2c44b9d7328 100644
> --- a/drivers/bluetooth/btintel_pcie.c
> +++ b/drivers/bluetooth/btintel_pcie.c
> @@ -273,6 +273,12 @@ static int btintel_pcie_reset_bt(struct btintel_pcie_data *data)
>  	return reg == 0 ? 0 : -ENODEV;
>  }
>  
> +static void btintel_pcie_set_persistence_mode(struct btintel_pcie_data *data)
> +{
> +	btintel_pcie_set_reg_bits(data, BTINTEL_PCIE_CSR_HW_BOOT_CONFIG,
> +				  BTINTEL_PCIE_CSR_HW_BOOT_CONFIG_KEEP_ON);
> +}
> +
>  /* This function enables BT function by setting BTINTEL_PCIE_CSR_FUNC_CTRL_MAC_INIT bit in
>   * BTINTEL_PCIE_CSR_FUNC_CTRL_REG register and wait for MSI-X with
>   * BTINTEL_PCIE_MSIX_HW_INT_CAUSES_GP0.
> @@ -297,6 +303,8 @@ static int btintel_pcie_enable_bt(struct btintel_pcie_data *data)
>  	 */
>  	data->boot_stage_cache = 0x0;
>  
> +	btintel_pcie_set_persistence_mode(data);
> +
>  	/* Set MAC_INIT bit to start primary bootloader */
>  	reg = btintel_pcie_rd_reg32(data, BTINTEL_PCIE_CSR_FUNC_CTRL_REG);
>  	reg &= ~(BTINTEL_PCIE_CSR_FUNC_CTRL_FUNC_INIT |
> @@ -1653,11 +1661,55 @@ static void btintel_pcie_remove(struct pci_dev *pdev)
>  	pci_set_drvdata(pdev, NULL);
>  }
>  
> +static int btintel_pcie_suspend(struct device *dev)
> +{
> +	struct btintel_pcie_data *data;
> +	int err;
> +	struct  pci_dev *pdev = to_pci_dev(dev);
> +
> +	data = pci_get_drvdata(pdev);
> +	btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D3_HOT);
> +	data->gp0_received = false;
> +	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
> +				 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));

The generic power management code already knows how to put standard
PCI devices in D3 at suspend.  So if you have to use device-specific
code like this, I guess the implication is that this device is not
spec-compliant?  That would surprise me a little bit since Intel is
pretty good about making their devices work correctly.

Some detail about exactly how this device is non-compliant would be
helpful here and in the commit log.

It looks wrong to me that you call btintel_pcie_wr_sleep_cntrl()
(which I assume starts something that will result in an interrupt that
causes gp0_received to be set to "true") *before* you set gp0_received
to "false".

That looks like a race because the interrupt could happen before
"data->gp0_received = false", and you would return -EBUSY when you
shouldn't.  You could test this by inserting a delay before setting
"data->gp0_received = false".  Adding a delay should never break this
functionality.

It looks to me like f4c8e876ef6b ("Bluetooth: btintel_pcie: Add
handshake between driver and firmware") (currently in linux-next) has
the same race, where btintel_pcie_send_frame() starts something that
will result in an interrupt, then sets "data->gp0_received = false".

But I don't understand the workings of this hardware or the driver.

> +	if (!err) {
> +		bt_dev_err(data->hdev, "failed to receive gp0 interrupt for suspend");
> +		goto fail;
> +	}
> +	return 0;
> +fail:
> +	return -EBUSY;

Since there's no cleanup, you could just return -EBUSY directly above
and there would be no need for the goto or the "fail" label.

> +}
> +
> +static int btintel_pcie_resume(struct device *dev)
> +{
> +	struct btintel_pcie_data *data;
> +	struct  pci_dev *pdev = to_pci_dev(dev);
> +	int err;
> +
> +	data = pci_get_drvdata(pdev);
> +	btintel_pcie_wr_sleep_cntrl(data, BTINTEL_PCIE_STATE_D0);
> +	data->gp0_received = false;
> +	err = wait_event_timeout(data->gp0_wait_q, data->gp0_received,
> +				 msecs_to_jiffies(BTINTEL_DEFAULT_INTR_TIMEOUT_MS));

Same potential race here.  And of course I'm still dubious about the
need for this device-specific code in the first place.

> +	if (!err) {
> +		bt_dev_err(data->hdev, "failed to receive gp0 interrupt for resume");
> +		goto fail;
> +	}
> +	return 0;
> +fail:
> +	return -EBUSY;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(btintel_pcie_pm_ops, btintel_pcie_suspend,
> +		btintel_pcie_resume);
> +
>  static struct pci_driver btintel_pcie_driver = {
>  	.name = KBUILD_MODNAME,
>  	.id_table = btintel_pcie_table,
>  	.probe = btintel_pcie_probe,
>  	.remove = btintel_pcie_remove,
> +	.driver.pm = &btintel_pcie_pm_ops,
>  };
>  module_pci_driver(btintel_pcie_driver);
>  
> diff --git a/drivers/bluetooth/btintel_pcie.h b/drivers/bluetooth/btintel_pcie.h
> index f9aada0543c4..38d0c8ea2b6f 100644
> --- a/drivers/bluetooth/btintel_pcie.h
> +++ b/drivers/bluetooth/btintel_pcie.h
> @@ -8,6 +8,7 @@
>  
>  /* Control and Status Register(BTINTEL_PCIE_CSR) */
>  #define BTINTEL_PCIE_CSR_BASE			(0x000)
> +#define BTINTEL_PCIE_CSR_HW_BOOT_CONFIG		(BTINTEL_PCIE_CSR_BASE + 0x000)
>  #define BTINTEL_PCIE_CSR_FUNC_CTRL_REG		(BTINTEL_PCIE_CSR_BASE + 0x024)
>  #define BTINTEL_PCIE_CSR_HW_REV_REG		(BTINTEL_PCIE_CSR_BASE + 0x028)
>  #define BTINTEL_PCIE_CSR_RF_ID_REG		(BTINTEL_PCIE_CSR_BASE + 0x09C)
> @@ -48,6 +49,9 @@
>  #define BTINTEL_PCIE_CSR_MSIX_IVAR_BASE		(BTINTEL_PCIE_CSR_MSIX_BASE + 0x0880)
>  #define BTINTEL_PCIE_CSR_MSIX_IVAR(cause)	(BTINTEL_PCIE_CSR_MSIX_IVAR_BASE + (cause))
>  
> +/* CSR HW BOOT CONFIG Register */
> +#define BTINTEL_PCIE_CSR_HW_BOOT_CONFIG_KEEP_ON		(BIT(31))
> +
>  /* Causes for the FH register interrupts */
>  enum msix_fh_int_causes {
>  	BTINTEL_PCIE_MSIX_FH_INT_CAUSES_0	= BIT(0),	/* cause 0 */
> -- 
> 2.34.1
> 
