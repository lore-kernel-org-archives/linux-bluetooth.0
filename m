Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6C557880;
	Tue, 14 May 2024 09:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715680106; cv=none; b=f6vu/R8UEMRT3pYhbiKh1GcBzj9CeEhEq60pj/ofqzfBF2t87pVeSq2o7xwryz9dyCDYkTenetwNRkZ7+qQ9OS/4H75abcoBCsAZm4rEGLrdBG1GAcfx+iai5hTXMzupn+sQUbeM6VDme4q6oMh8honAN9KdAWAYkTwnyVLBuro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715680106; c=relaxed/simple;
	bh=hk2QxtvkTlDVBYcg1+ezs1QsfrM4jY5sDpRXMmVDJ94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I2AzZ4IeuvCr50+DiZpUP6COpjV/Mp7042+aff1dU5zqsvfzGN+Vzrv8cwMF7eA8TozVJ3VjT12ocPzsBxn3IsoB3YTPi35cGVUUh2s54BHCHoiaI0bu/tESrioleUb9pDBE0OKtIE2KHM+kM7XN0pWJLMz16rpsoUKcs02LGf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.56] (g56.guest.molgen.mpg.de [141.14.220.56])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D731A61E5FE06;
	Tue, 14 May 2024 11:20:06 +0200 (CEST)
Message-ID: <5d7f5918-d821-4757-bce9-2fede79d7fe4@molgen.mpg.de>
Date: Tue, 14 May 2024 11:20:06 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: btnxpuart: Enable status prints for
 firmware download
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
 ziniu.wang_1@nxp.com, haibo.chen@nxp.com, LnxRevLi@nxp.com,
 guillaume.legoupil@nxp.com, salim.chebbo@nxp.com
References: <20240514091444.1508033-1-neeraj.sanjaykale@nxp.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240514091444.1508033-1-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Neeraj,


Thank you for the patch.

Am 14.05.24 um 11:14 schrieb Neeraj Sanjay Kale:
> This enables prints for firmware download which can help automation
> tests to verify firmware download functionality.

Please paste the old and new log messages to the commit message.

> A new flag BTNXPUART_FW_DOWNLOAD_ABORT is added which handles the
> situation where driver is removed while firmware download is in
> progress.

Could this be a separate patch?

> This also adds a check before freeing the rx->skb in flush and close
> functions to handle the kernel crash seen in case of firmware download
> timeout.

Please make this a separate commit with a Fixes: tag.


Kind regrads,

Paul


> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> Tested-by: Guillaume Legoupil <guillaume.legoupil@nxp.com>
> ---
> v2: Handle firmware download abort scenario. (Guillaume Legoupil)
> v3: Minor corrections. Add details to commit message.
> ---
>   drivers/bluetooth/btnxpuart.c | 67 +++++++++++++++++++++++------------
>   1 file changed, 45 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
> index 0b93c2ff29e4..7aed5298ee6f 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -29,6 +29,7 @@
>   #define BTNXPUART_CHECK_BOOT_SIGNATURE	3
>   #define BTNXPUART_SERDEV_OPEN		4
>   #define BTNXPUART_IR_IN_PROGRESS	5
> +#define BTNXPUART_FW_DOWNLOAD_ABORT	6
>   
>   /* NXP HW err codes */
>   #define BTNXPUART_IR_HW_ERR		0xb0
> @@ -159,6 +160,7 @@ struct btnxpuart_dev {
>   	u8 fw_name[MAX_FW_FILE_NAME_LEN];
>   	u32 fw_dnld_v1_offset;
>   	u32 fw_v1_sent_bytes;
> +	u32 fw_dnld_v3_offset;
>   	u32 fw_v3_offset_correction;
>   	u32 fw_v1_expected_len;
>   	u32 boot_reg_offset;
> @@ -550,6 +552,7 @@ static int nxp_download_firmware(struct hci_dev *hdev)
>   	nxpdev->fw_v1_sent_bytes = 0;
>   	nxpdev->fw_v1_expected_len = HDR_LEN;
>   	nxpdev->boot_reg_offset = 0;
> +	nxpdev->fw_dnld_v3_offset = 0;
>   	nxpdev->fw_v3_offset_correction = 0;
>   	nxpdev->baudrate_changed = false;
>   	nxpdev->timeout_changed = false;
> @@ -564,14 +567,23 @@ static int nxp_download_firmware(struct hci_dev *hdev)
>   					       !test_bit(BTNXPUART_FW_DOWNLOADING,
>   							 &nxpdev->tx_state),
>   					       msecs_to_jiffies(60000));
> +
> +	release_firmware(nxpdev->fw);
> +	memset(nxpdev->fw_name, 0, sizeof(nxpdev->fw_name));
> +
>   	if (err == 0) {
> -		bt_dev_err(hdev, "FW Download Timeout.");
> +		bt_dev_err(hdev, "FW Download Timeout. offset: %d",
> +				nxpdev->fw_dnld_v1_offset ?
> +				nxpdev->fw_dnld_v1_offset :
> +				nxpdev->fw_dnld_v3_offset);
>   		return -ETIMEDOUT;
>   	}
> +	if (test_bit(BTNXPUART_FW_DOWNLOAD_ABORT, &nxpdev->tx_state)) {
> +		bt_dev_err(hdev, "FW Download Aborted");
> +		return -EINTR;
> +	}
>   
>   	serdev_device_set_flow_control(nxpdev->serdev, true);
> -	release_firmware(nxpdev->fw);
> -	memset(nxpdev->fw_name, 0, sizeof(nxpdev->fw_name));
>   
>   	/* Allow the downloaded FW to initialize */
>   	msleep(1200);
> @@ -693,7 +705,7 @@ static int nxp_request_firmware(struct hci_dev *hdev, const char *fw_name)
>   	if (!strlen(nxpdev->fw_name)) {
>   		snprintf(nxpdev->fw_name, MAX_FW_FILE_NAME_LEN, "%s", fw_name);
>   
> -		bt_dev_dbg(hdev, "Request Firmware: %s", nxpdev->fw_name);
> +		bt_dev_info(hdev, "Request Firmware: %s", nxpdev->fw_name);
>   		err = request_firmware(&nxpdev->fw, nxpdev->fw_name, &hdev->dev);
>   		if (err < 0) {
>   			bt_dev_err(hdev, "Firmware file %s not found", nxpdev->fw_name);
> @@ -781,7 +793,7 @@ static int nxp_recv_fw_req_v1(struct hci_dev *hdev, struct sk_buff *skb)
>   	}
>   
>   	if (!len) {
> -		bt_dev_dbg(hdev, "FW Downloaded Successfully: %zu bytes",
> +		bt_dev_info(hdev, "FW Download Complete: %zu bytes",
>   			   nxpdev->fw->size);
>   		if (nxp_data->helper_fw_name && !nxpdev->helper_downloaded) {
>   			nxpdev->helper_downloaded = true;
> @@ -934,7 +946,7 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
>   	}
>   
>   	if (req->len == 0) {
> -		bt_dev_dbg(hdev, "FW Downloaded Successfully: %zu bytes",
> +		bt_dev_info(hdev, "FW Download Complete: %zu bytes",
>   			   nxpdev->fw->size);
>   		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
>   		wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
> @@ -954,8 +966,9 @@ static int nxp_recv_fw_req_v3(struct hci_dev *hdev, struct sk_buff *skb)
>   		goto free_skb;
>   	}
>   
> -	serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data + offset -
> -				nxpdev->fw_v3_offset_correction, len);
> +	nxpdev->fw_dnld_v3_offset = offset - nxpdev->fw_v3_offset_correction;
> +	serdev_device_write_buf(nxpdev->serdev, nxpdev->fw->data +
> +				nxpdev->fw_dnld_v3_offset, len);
>   
>   free_skb:
>   	kfree_skb(skb);
> @@ -1037,7 +1050,7 @@ static int nxp_setup(struct hci_dev *hdev)
>   		if (err < 0)
>   			return err;
>   	} else {
> -		bt_dev_dbg(hdev, "FW already running.");
> +		bt_dev_info(hdev, "FW already running.");
>   		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
>   	}
>   
> @@ -1253,8 +1266,10 @@ static int btnxpuart_close(struct hci_dev *hdev)
>   	ps_wakeup(nxpdev);
>   	serdev_device_close(nxpdev->serdev);
>   	skb_queue_purge(&nxpdev->txq);
> -	kfree_skb(nxpdev->rx_skb);
> -	nxpdev->rx_skb = NULL;
> +	if (!IS_ERR_OR_NULL(nxpdev->rx_skb)) {
> +		kfree_skb(nxpdev->rx_skb);
> +		nxpdev->rx_skb = NULL;
> +	}
>   	clear_bit(BTNXPUART_SERDEV_OPEN, &nxpdev->tx_state);
>   	return 0;
>   }
> @@ -1269,8 +1284,10 @@ static int btnxpuart_flush(struct hci_dev *hdev)
>   
>   	cancel_work_sync(&nxpdev->tx_work);
>   
> -	kfree_skb(nxpdev->rx_skb);
> -	nxpdev->rx_skb = NULL;
> +	if (!IS_ERR_OR_NULL(nxpdev->rx_skb)) {
> +		kfree_skb(nxpdev->rx_skb);
> +		nxpdev->rx_skb = NULL;
> +	}
>   
>   	return 0;
>   }
> @@ -1385,16 +1402,22 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
>   	struct btnxpuart_dev *nxpdev = serdev_device_get_drvdata(serdev);
>   	struct hci_dev *hdev = nxpdev->hdev;
>   
> -	/* Restore FW baudrate to fw_init_baudrate if changed.
> -	 * This will ensure FW baudrate is in sync with
> -	 * driver baudrate in case this driver is re-inserted.
> -	 */
> -	if (nxpdev->current_baudrate != nxpdev->fw_init_baudrate) {
> -		nxpdev->new_baudrate = nxpdev->fw_init_baudrate;
> -		nxp_set_baudrate_cmd(hdev, NULL);
> +	if (is_fw_downloading(nxpdev)) {
> +		set_bit(BTNXPUART_FW_DOWNLOAD_ABORT, &nxpdev->tx_state);
> +		clear_bit(BTNXPUART_FW_DOWNLOADING, &nxpdev->tx_state);
> +		wake_up_interruptible(&nxpdev->check_boot_sign_wait_q);
> +		wake_up_interruptible(&nxpdev->fw_dnld_done_wait_q);
> +	} else {
> +		/* Restore FW baudrate to fw_init_baudrate if changed.
> +		 * This will ensure FW baudrate is in sync with
> +		 * driver baudrate in case this driver is re-inserted.
> +		 */
> +		if (nxpdev->current_baudrate != nxpdev->fw_init_baudrate) {
> +			nxpdev->new_baudrate = nxpdev->fw_init_baudrate;
> +			nxp_set_baudrate_cmd(hdev, NULL);
> +		}
> +		ps_cancel_timer(nxpdev);
>   	}
> -
> -	ps_cancel_timer(nxpdev);
>   	hci_unregister_dev(hdev);
>   	hci_free_dev(hdev);
>   }
