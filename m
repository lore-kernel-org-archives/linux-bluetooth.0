Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42F98174B
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Mar 2024 17:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645709; cv=none; b=EuKB4a+wyjCtr6PsiyIU2LVfr2ArRvl/3+ed1q2YjeNNAkTSj4jWIy+M+MTNgbATbk5xBOt6Lil9nB50SWz6JvlUhvC4JjfF0sd/iqccdebLkq/k6KTcGhSfOrxhPnrEe7prqZh42Rj021wHXHGfp1crURaV7wtKyN/O3v4dtto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645709; c=relaxed/simple;
	bh=wYnSugS+OCeV8w785A55CGsEtMcioenewgQ19fym63w=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=aSXW3Zidt5oiaMg5jQitDcQNq0l5+JGwQ733Y5P6BNitBP8u7HmZK5HJbADgLaJtpLLEm6b6+KK/eHJ58AChEVS6jL87x02vCZJcnUyblW5mXpFmZWj7gS0/dPbMv0QIEhIRYw+IM9VuUaTtihpvy4PF/Nj9MmJABx5k9UPNyCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSEddPuB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSEddPuB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DFBC433C7;
	Thu, 28 Mar 2024 17:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711645709;
	bh=wYnSugS+OCeV8w785A55CGsEtMcioenewgQ19fym63w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fSEddPuB68AIL6V4RvXRqGW3qJJYSV/hg4HRBjSvWGR0mPnpElKTIXKaAj9OpZ7w2
	 Noy96pfxTxLKhOpT2SdLZ3LGKwzm1nqjsNsD7EETGO+cOyu07T2HtE0fcq8SFkhtwb
	 Gvwnq4eUMvH/5qrYJTErjqjfq8KoKoDwqz61xJUrPBZw29FZKkQJjM604jBOL2ZWBg
	 BvjakgVHhKwRiixOWtQQSSX5XIpCdfnEChTtVbsjOW6WTOoW69BZaEIXrZ1MhLmU0P
	 +DoEg+TN+JAe4kp7A03Qf/2KfImY+fxM7NHUXpaBjzoeDCQC7rDG27cVnKbZpq+7q8
	 SJoUnspVg8hRQ==
Date: Thu, 28 Mar 2024 12:08:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
	chethan.tumkur.narayan@intel.com,
	Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: Re: [PATCH v1 2/3] Bluetooth: btintel_pcie: Add support for PCIE
 transport
Message-ID: <20240328170827.GA1570610@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328111904.992068-2-kiran.k@intel.com>

On Thu, Mar 28, 2024 at 04:49:03PM +0530, Kiran K wrote:
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
> 
> Add initial code to support Intel bluetooth devices based on PICE
> transport. This patch allocates memory for buffers, internal structures,
> initializes interrupts for TX & RX and initializes PCIE device.

s/PCIE/PCIe/ (subject, commit log, throughout)
s/PICE/PCIe/ (commit log typo)
s/This patch allocates/Allocate/
s/initializes/initialize/ (twice)

> +#if BTITNEL_PCIE_ENABLE_HCI_DUMP
> +static inline void btintel_pcie_hci_dump(const char *p, const void *b, int s)
> +{
> +	const unsigned char *ptr = (const unsigned char *)b;
> +	char str[64];
> +	int c, i;
> +
> +	for (i = c = 0; c < s; c++) {
> +		i += snprintf(str + i, sizeof(str) - i, "%02x ", ptr[c]);
> +		if ((c > 0 && (c + 1) % 8 == 0) || (c == s - 1)) {
> +			BT_DBG("%s: %s", p, str);
> +			i = 0;
> +		}
> +	}

Maybe print_hex_dump() or similar would save you some work here?

> +/* Poll internal in microseconds */

s/internal/interval/

> +#define POLL_INTERVAL			10

I think it's nice when the name of a timeout or interval includes the
units, e.g., POLL_INTERVAL_US.

> +/* Set the doorbell for RXQ to notify the device that @index(actually index-1)
> + * is available to receive the data

Typical style is to add a space before the opening paren in English
text (many occurrences).

> +static void btintel_pcie_set_rx_db(struct btintel_pcie_data *data, u16 index)
> +{
> +	u32 val;
> +
> +	val = index;
> +	val |= (513 << 16);

Where does 513 come from?  Maybe a #define or explanatory comment?

> +static void btintel_pcie_prepare_rx(struct rxq *rxq, u16 frbd_index)
> +{
> +	struct data_buf *buf;
> +	struct frbd *frbd;
> +
> +	/* Get the buffer of the frbd for DMA */

s/frbd/FRBD/ for consistency (several occurrences).

> +static void btintel_pcie_rx_work(struct work_struct *work)
> +{
> +	struct btintel_pcie_data *data = container_of(work,
> +					struct btintel_pcie_data, rx_work);
> +	struct sk_buff *skb;
> +	int err;
> +
> +	/* Process the sk_buf in queue and send to the hci layer */

s/hci/HCI/ for consistency.

> +/* create the sk_buff with data and save it to queue and start rx work
> + */
> +static int btintel_pcie_submit_rx_work(struct btintel_pcie_data *data, u8 status,
> +				       void *buf)

Comment would fit on one line.

There's a random mix of "rx" vs "RX" in comments, would be nice to be
consistent.

> +static void btintel_pcie_msix_rx_handle(struct btintel_pcie_data *data)
> +{
> +	u16 cr_hia, cr_tia;
> +	struct rxq *rxq;
> +	struct urbd1 *urbd1;
> +	struct frbd *frbd;
> +	struct data_buf *buf;
> +	int ret;
> +
> +	cr_hia = data->ia.cr_hia[RXQ_NUM];
> +	cr_tia = data->ia.cr_tia[RXQ_NUM];
> +
> +	BT_DBG("[RXQ] cr_hia=%u  cr_tia=%u", cr_hia, cr_tia);
> +
> +	/* Check CR_TIA and CR_HIA for change */
> +	if (cr_tia == cr_hia) {
> +		BT_ERR("[RXQ] no new CD found");
> +		return;
> +	}
> +
> +	rxq = &data->rxq;
> +
> +	/* The firmware sends multiple CD in a single MSIX and it needs to
> +	 * process all received CDs in this interrupt.
> +	 */
> +	while (cr_tia != cr_hia) {
> +		/* Get URBD1 pointed by cr_tia */
> +		urbd1 = &rxq->urbd1s[cr_tia];
> +		ipc_print_urbd1(urbd1, cr_tia);
> +
> +		/* Get FRBD poined by urbd1->frbd_tag */

s/poined/pointed to/ ?

> +	 * Before sending the interrupt the HW disables it to prevent
> +	 * a nested interrupt. This is done by writing 1 to the corresponding
> +	 * bit in the mask register. After handling the interrupt, it should be
> +	 * re-enabled by clearing this bit. This register is defined as
> +	 * write 1 clear (W1C) register, meaning that it's being clear
> +	 * by writing 1 to the bit.

s/being clear/cleared/

> +	num_irqs = pci_enable_msix_range(data->pdev, data->msix_entries,
> +					 MSIX_VEC_MIN,
> +					 MSIX_VEC_MAX);

pci_enable_msix_range() is deprecated; consider
pci_alloc_irq_vectors() instead.

> +static int btintel_pcie_config_pcie(struct pci_dev *pdev,
> +				    struct btintel_pcie_data *data)
> +{
> +	int err;
> +
> +	err = pcim_enable_device(pdev);
> +	if (err) {
> +		BT_ERR("Failed to enable pci device (%d)", err);
> +		return err;
> +	}
> +	pci_set_master(pdev);
> +
> +	/* Setup DMA mask */

Superfluous comment.

> +	BT_DBG("Set DMA_MASK(64)");
> +	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +	if (err) {
> +		BT_DBG("Set DMA_MASK(32)");
> +		err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +		/* Both attempt failed */
> +		if (err) {
> +			BT_ERR("No suitable DMA available");
> +			return err;
> +		}
> +	}
> +
> +	/* Get BAR to access CSR */

Superfluous.

> +	err = pcim_iomap_regions(pdev, BIT(0), KBUILD_MODNAME);
> +	if (err) {
> +		BT_ERR("Failed to get iomap regions (%d)", err);
> +		return err;
> +	}
> +
> +	data->base_addr = pcim_iomap_table(pdev)[0];
> +	if (!data->base_addr) {
> +		BT_ERR("Failed to get base address");
> +		return -ENODEV;
> +	}
> +
> +	err = btintel_pcie_setup_irq(data);
> +	if (err) {
> +		BT_ERR("Failed to setup irq for msix");
> +		return err;
> +	}
> +
> +	/* Configure MSI-X with causes list */

Random mix of "MSIX" and "MSI-X".  I think "MSI-X" is nicer.

> +static int btintel_pcie_setup_txq_bufs(struct btintel_pcie_data *data,
> +				       struct txq *txq)
> +{
> +	int err = 0, i;
> +	struct data_buf *buf;
> +
> +	if (txq->count == 0) {
> +		BT_ERR("invalid parameter: txq->count");
> +		err = -EINVAL;
> +		goto exit_error;

You do all the cleanup inline, so there's really no benefit to "err"
and the "exit_error" label.  You could "return -EINVAL" directly here
and similar below.

> +	}
> +
> +	/* Allocate the same number of buffers as the descriptor */
> +	txq->bufs = kmalloc_array(txq->count, sizeof(*buf), GFP_KERNEL);
> +	if (!txq->bufs) {
> +		err = -ENOMEM;
> +		goto exit_error;
> +	}
> +
> +	/* Allocate full chunk of data buffer for DMA first and do indexing and
> +	 * initialization next, so it can be freed easily
> +	 */
> +	txq->buf_v_addr = dma_alloc_coherent(&data->pdev->dev,
> +					     txq->count * BUFFER_SIZE,
> +					     &txq->buf_p_addr,
> +					     GFP_KERNEL | __GFP_NOWARN);
> +	if (!txq->buf_v_addr) {
> +		BT_ERR("Failed to allocate DMA buf");
> +		err = -ENOMEM;
> +		kfree(txq->bufs);
> +		goto exit_error;
> +	}
> +	memset(txq->buf_v_addr, 0, txq->count * BUFFER_SIZE);
> +
> +	BT_DBG("alloc bufs: p=0x%llx v=0x%p", txq->buf_p_addr, txq->buf_v_addr);
> +
> +	/* Setup the allocated DMA buffer to bufs. Each data_buf should
> +	 * have virtual address and physical address
> +	 */
> +	for (i = 0; i < txq->count; i++) {
> +		buf = &txq->bufs[i];
> +		buf->data_p_addr = txq->buf_p_addr + (i * BUFFER_SIZE);
> +		buf->data = txq->buf_v_addr + (i * BUFFER_SIZE);
> +	}
> +
> +exit_error:
> +	return err;
> +}

> +static int btintel_pcie_setup_rxq_bufs(struct btintel_pcie_data *data,
> +				       struct rxq *rxq)
> +{
> +	int err = 0, i;
> +	struct data_buf *buf;
> +
> +	if (rxq->count == 0) {
> +		BT_ERR("invalid parameter: rxq->count");
> +		err = -EINVAL;
> +		goto exit_error;

Same "err", "exit_error" comment.

> +	}
> +
> +	/* Allocate the same number of buffers as the descriptor */
> +	rxq->bufs = kmalloc_array(rxq->count, sizeof(*buf), GFP_KERNEL);
> +	if (!rxq->bufs) {
> +		err = -ENOMEM;
> +		goto exit_error;
> +	}
> +
> +	/* Allocate full chunk of data buffer for DMA first and do indexing and
> +	 * initialization next, so it can be freed easily
> +	 */
> +	rxq->buf_v_addr = dma_alloc_coherent(&data->pdev->dev,
> +					     rxq->count * BUFFER_SIZE,
> +					     &rxq->buf_p_addr,
> +					     GFP_KERNEL | __GFP_NOWARN);
> +	if (!rxq->buf_v_addr) {
> +		BT_ERR("Failed to allocate DMA buf");
> +		err = -ENOMEM;
> +		kfree(rxq->bufs);
> +		goto exit_error;
> +	}
> +	memset(rxq->buf_v_addr, 0, rxq->count * BUFFER_SIZE);
> +
> +	BT_DBG("alloc bufs: p=0x%llx v=0x%p", rxq->buf_p_addr, rxq->buf_v_addr);
> +
> +	/* Setup the allocated DMA buffer to bufs. Each data_buf should
> +	 * have virtual address and physical address
> +	 */
> +	for (i = 0; i < rxq->count; i++) {
> +		buf = &rxq->bufs[i];
> +		buf->data_p_addr = rxq->buf_p_addr + (i * BUFFER_SIZE);
> +		buf->data = rxq->buf_v_addr + (i * BUFFER_SIZE);
> +	}
> +
> +exit_error:
> +
> +	return err;
> +}

> +static void btintel_pcie_release_hdev(struct btintel_pcie_data *data)
> +{
> +	struct hci_dev *hdev;
> +
> +	hdev = data->hdev;
> +	if (hdev) {

This test shouldn't be necessary if the driver is written correctly.
We should never get here unless .probe() was successful.

> +		hci_unregister_dev(hdev);

There should be a corresponding hci_register_dev().  Since that's not
here yet, I don't think the hci_unregister_dev() should be in this
patch either.  Looks like maybe just incomplete code?

Oh, I see hci_register_dev() is added in patch 3/3.  They should be
added in the same patch.

> +		hci_free_dev(hdev);
> +	}
> +	data->hdev = NULL;
> +}

> +static int btintel_pcie_probe(struct pci_dev *pdev,
> +			      const struct pci_device_id *ent)
> +{
> +	int err;
> +	struct btintel_pcie_data *data;
> +
> +	if (!pdev)
> +		return -ENODEV;
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	/* initialize the btintel_pcie data struct */

Superfluous comment.

> +	data->pdev = pdev;
> +
> +	spin_lock_init(&data->irq_lock);
> +	spin_lock_init(&data->hci_rx_lock);
> +
> +	init_waitqueue_head(&data->gp0_wait_q);
> +	data->gp0_received = false;
> +
> +	init_waitqueue_head(&data->tx_wait_q);
> +	data->tx_wait_done = false;
> +
> +	data->workqueue = alloc_ordered_workqueue(KBUILD_MODNAME, WQ_HIGHPRI);
> +	if (!data->workqueue) {
> +		BT_ERR("Failed to create workqueue");
> +		return -ENOMEM;
> +	}
> +	skb_queue_head_init(&data->rx_skb_q);
> +	INIT_WORK(&data->rx_work, btintel_pcie_rx_work);
> +
> +	data->boot_stage_cache = 0x00;
> +	data->img_resp_cache = 0x00;
> +
> +	/* PCIe specific all to configure it for this device includes
> +	 * enabling pice device, setting master, reading BAR[0], configuring
> +	 * MSIx, setting DMA mask, and save the driver data.

s/pice/PCIe/
s/MSIx/MSI-X/
s/save the/saving the/

Whole comment is probably superfluous since this is common to all PCI
drivers.

> +	 */
> +	err = btintel_pcie_config_pcie(pdev, data);
> +	if (err) {
> +		BT_ERR("Failed to config pcie (%d)", err);
> +		goto exit_error;
> +	}
> +
> +	/* Set driver data for this PCI device */

Superfluous comment.

> +	pci_set_drvdata(pdev, data);
> +
> +	/* allocate the IPC struct */
> +	err = btintel_pcie_alloc(data);
> +	if (err) {
> +		BT_ERR("Failed to allocate queues(%d)", err);
> +		goto exit_error;
> +	}
> +
> +	/* Enable BT function */

Superfluous comment.

> +	err = btintel_pcie_enable_bt(data);
> +	if (err) {
> +		BT_ERR("Failed to start bluetooth device(%d)", err);
> +		goto exit_error;
> +	}
> +
> +	/* CNV information (CNVi and CNVr) is in CSR */
> +	data->cnvi = btintel_pcie_rd_reg32(data, CSR_HW_REV_REG);
> +	BT_DBG("cnvi:   0x%08x", data->cnvi);
> +
> +	data->cnvr = btintel_pcie_rd_reg32(data, CSR_RF_ID_REG);
> +	BT_DBG("cnvr:   0x%08x", data->cnvr);
> +
> +	err = btintel_pcie_start_rx(data);
> +	if (err) {
> +		BT_ERR("Failed to start rx (%d)", err);
> +		goto exit_error;
> +	}
> +
> +	err = btintel_pcie_setup_hdev(data);
> +	if (err) {
> +		BT_ERR("Failed to setup HCI module");
> +		goto exit_error;
> +	}
> +
> +	return 0;
> +
> +exit_error:
> +	/* reset device before leave */
> +	btintel_pcie_reset_bt(data);
> +
> +	/* clear bus mastering */

Superfluous comment.

> +	pci_clear_master(pdev);
> +
> +	/* Unset driver data for PCI device */

Superfluous comment.

> +	pci_set_drvdata(pdev, NULL);
> +
> +	return err;
> +}
> +
> +static void btintel_pcie_remove(struct pci_dev *pdev)
> +{
> +	struct btintel_pcie_data *data;
> +
> +	if (!pdev) {

Shouldn't need this check.  If you get here with "pdev == NULL", the
driver did something wrong and it's better to oops so the driver can
be fixed.

> +		BT_ERR("Invalid parameter: pdev");
> +		return;
> +	}
> +
> +	data = pci_get_drvdata(pdev);
> +	if (!data) {

Or this one.

> +		BT_ERR("data is empty");
> +		return;
> +	}
> +
> +	btintel_pcie_release_hdev(data);
> +
> +	flush_work(&data->rx_work);
> +
> +	destroy_workqueue(data->workqueue);
> +
> +	btintel_pcie_free(data);
> +
> +	/* reset device before leave */
> +	btintel_pcie_reset_bt(data);
> +
> +	/* clear bus mastering */

Superfluous comment.

> +	pci_clear_master(pdev);
> +
> +	/* Unset driver data for PCI device */

Superfluous comment.

> +	pci_set_drvdata(pdev, NULL);
> +}
> +
> +#ifdef CONFIG_PM
> +static int btintel_pcie_suspend(struct device *dev)
> +{
> +	/* TODO: Add support suspend */
> +	return 0;
> +}
> +
> +static int btintel_pcie_resume(struct device *dev)
> +{
> +	/* TODO: Add support resume */
> +	return 0;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(btintel_pcie_pm_ops, btintel_pcie_suspend,
> +							btintel_pcie_resume);
> +#endif /* CONFIG_PM */

Seems pointless to include this #ifdef CONFIG_PM code until you
implement it.

> +static struct pci_driver btintel_pcie_driver = {
> +	.name = KBUILD_MODNAME,
> +	.id_table = btintel_pcie_table,
> +	.probe = btintel_pcie_probe,
> +	.remove = btintel_pcie_remove,
> +#ifdef CONFIG_PM
> +	.driver.pm = &btintel_pcie_pm_ops,
> +#endif /* CONFIG_PM */
> +};

> +/* Default Poll time for MAC access during init*/
> +#define DEFAULT_MAC_ACCESS_TIMEOUT	200000

Would be nice to have units here in the name (us, ms, etc).

> +/* Default interrupt timeout in msec */
> +#define DEFAULT_INTR_TIMEOUT		3000

And here.

> +/* Enum for RBD buffer size mappting */

s/mappting/mapping/ ?

> + * @dbgc_addr: DBGC first fragmemt address
> + * @dbgc_size: DBGC buffer size
> + * @early_enable: Enarly debug enable

s/fragmemt/fragment/
s/Enarly/Early/

> + * @dbg_output_mode: Debug output mode
> + *	Bit[4] DBGC O/P { 0=SRAM, 1=DRAM(not relevant for NPK) }
> + *	Bit[5] DBGC I/P { 0=BDBG, 1=DBGI }
> + *	Bits[6:7] DBGI O/P(relevant if bit[5] = 1)
> + *	 0=BT DBGC, 1=WiFi DBGC, 2=NPK }
> + * @dbg_preset: Debug preset
> + * @ext_addr: Address of context information extension
> + * @ext_size: Size of context information part
> + *
> + * Total 38 DWords
> + *

Superfluous blank line

> + */

Bjorn
