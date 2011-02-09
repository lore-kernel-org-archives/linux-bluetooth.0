Return-Path: <cyrus@holtmann.org>
Date: Wed, 9 Feb 2011 12:19:40 +0200
From: Ville Tervo <ville.tervo@nokia.com>
To: "ext pavan_savoy@ti.com" <pavan_savoy@ti.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi,
        marcel@holtmann.org
Subject: Re: [PATCH v10] Bluetooth: btwilink driver
Message-ID: <20110209101940.GG874@null>
References: <1297237177-5555-1-git-send-email-pavan_savoy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297237177-5555-1-git-send-email-pavan_savoy@ti.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Pavan,

On Wed, Feb 09, 2011 at 01:39:37AM -0600, ext pavan_savoy@ti.com wrote:
> From: Pavan Savoy <pavan_savoy@ti.com>
> 
> Gustavo,
> 
> v10,
> fixing the really long goto label.
> 
> Find below the patch version v9.
> Have taken care of Ville's comments.
> In addition fixed the issue seen when built as module, with
> repeated probe/remove of the platform driver.
> 
> patch v8 comments taken care,
> 
> As suggested, the modifications to TI ST driver to remove the bluetooth
> references have been made and the changes have been merged to the
> linux-next tree.
> 
> Find below the patch for the btwilink driver,
> I have taken care of your following comments,
> 1. channel IDs and the offsets are now being taken from the
> header file hci.h.
> 2. removed the un-necessary BT_ERR.
> 3. changed the order during return from st_register.
> 4. continue to unregister even if 1st unregister fails.
> 
> Please review and provide comments,

One more comment.

> +/* Called from HCI core to initialize the device */
> +static int ti_st_open(struct hci_dev *hdev)
> +{
> +	unsigned long timeleft;
> +	struct ti_st *hst;
> +	int err, i;
> +
> +	BT_DBG("%s %p", hdev->name, hdev);
> +
> +	if (test_and_set_bit(HCI_RUNNING, &hdev->flags))
> +		return -EBUSY;
> +
> +	/* provide contexts for callbacks from ST */
> +	hst = hdev->driver_data;
> +
> +	for (i = 0; i < MAX_BT_CHNL_IDS; i++) {
> +		ti_st_proto[i].priv_data = hst;
> +		ti_st_proto[i].max_frame_size = HCI_MAX_FRAME_SIZE;
> +		ti_st_proto[i].recv = st_receive;
> +		ti_st_proto[i].reg_complete_cb = st_reg_completion_cb;
> +
> +		/* Prepare wait-for-completion handler */
> +		init_completion(&hst->wait_reg_completion);
> +
> +		err = st_register(&ti_st_proto[i]);
> +		if (!err)
> +			goto done;
> +
> +		if (err != -EINPROGRESS) {
> +			clear_bit(HCI_RUNNING, &hdev->flags);
> +			BT_ERR("st_register failed %d", err);
> +			return err;
> +		}
> +
> +		/* ST is busy with either protocol
> +		 * registration or firmware download.
> +		 */
> +
> +		/* Reset ST registration callback status flag,
> +		 * this value will be updated in
> +		 * st_reg_completion_cb()
> +		 * function whenever it called from ST driver.
> +		 */
> +		hst->reg_status = -EINPROGRESS;

reg_status initialization should be moved also before st_register(). Reason is
again the same as for init_completion.


-- 
Ville
