Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47AA7C3DA40
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jun 2023 12:15:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344742AbjFOMPN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Jun 2023 08:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344764AbjFOMOz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Jun 2023 08:14:55 -0400
X-Greylist: delayed 513 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Jun 2023 05:14:48 PDT
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FA2272C
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jun 2023 05:14:47 -0700 (PDT)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id DD5A05C937B;
        Thu, 15 Jun 2023 14:06:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1686830764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BuSOcacf6bipcG0yeVX/bAQE4aXDdf290GE8zEFgwto=;
        b=kgVZENEAelhDiiUj9PQCLMUmsEc5WcUW/UL3QhwZP1+gii9CZhMJr1MVzmAHBnS7/3nKCd
        A0BsUVejWFcgMMfN1CHPaqKEXPnaZxNE8THUtqwHJfBmpjUfvrxdDyvSAJdPeEpzyb03d6
        rtZxmaBU+dRu5qvbjMLCeTT1/up/gO8=
MIME-Version: 1.0
Date:   Thu, 15 Jun 2023 14:06:04 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, Regressions <regressions@lists.linux.dev>,
        =?UTF-8?Q?Jan_=C4=8Cerm=C3=A1k?= <sairon@sairon.cz>
Subject: Re: [PATCH v4 2/4] Bluetooth: Rework le_scan_restart for hci_sync
In-Reply-To: <20220727135834.294184-3-brian.gix@intel.com>
References: <20220727135834.294184-1-brian.gix@intel.com>
 <20220727135834.294184-3-brian.gix@intel.com>
Message-ID: <578e6d7afd676129decafba846a933f5@agner.ch>
X-Sender: stefan@agner.ch
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian, hi all,

We experienced quite some Bluetooth issues after moving from Linux 5.15
to 6.1 on Home Assistant OS, especially on Intel NUC type systems (which
is a popular choice in our community, so it might just be that). When
continuously scanning/listening for BLE packets, the packet flow
suddenly ends. Depending on which and how many devices (possibly also
other factors) within minutes or hours.

Jan (in cc) was able to bisect the issue, and was able to pinpoint the
problem to this change.

Meanwhile I was able to confirm, that reverting this single commit on
the latest 6.1.34 seems to resolve the issue.

I've reviewed the change and surrounding code, and one thing I've
noticed is that the if statement to set cp.filter_dup in
hci_le_set_ext_scan_enable_sync and hci_le_set_scan_enable_sync are
different. Not sure if that needs to be the way it is, but my outside
gut feeling says hci_le_set_ext_scan_enable_sync should use "if (val &&
hci_dev_test_flag(hdev, HCI_MESH))" as well. 

However, that did not fix the problem (but maybe it is wrong
nonetheless?).

Anyone has an idea what could be the problem here?

--
Stefan

On 2022-07-27 15:58, Brian Gix wrote:
> le_scan_restart delayed work queue was running as a deprecated
> hci_request instead of on the newer thread-safe hci_sync mechanism.
> 
> Signed-off-by: Brian Gix <brian.gix@intel.com>
> ---
>  net/bluetooth/hci_request.c | 89 -------------------------------------
>  net/bluetooth/hci_sync.c    | 75 +++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+), 89 deletions(-)
> 
> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
> index 32fefaa0d3ca..114af7350363 100644
> --- a/net/bluetooth/hci_request.c
> +++ b/net/bluetooth/hci_request.c
> @@ -1975,92 +1975,6 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
>  	return 0;
>  }
>  
> -static int le_scan_restart(struct hci_request *req, unsigned long opt)
> -{
> -	struct hci_dev *hdev = req->hdev;
> -
> -	/* If controller is not scanning we are done. */
> -	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
> -		return 0;
> -
> -	if (hdev->scanning_paused) {
> -		bt_dev_dbg(hdev, "Scanning is paused for suspend");
> -		return 0;
> -	}
> -
> -	hci_req_add_le_scan_disable(req, false);
> -
> -	if (use_ext_scan(hdev)) {
> -		struct hci_cp_le_set_ext_scan_enable ext_enable_cp;
> -
> -		memset(&ext_enable_cp, 0, sizeof(ext_enable_cp));
> -		ext_enable_cp.enable = LE_SCAN_ENABLE;
> -		ext_enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
> -
> -		hci_req_add(req, HCI_OP_LE_SET_EXT_SCAN_ENABLE,
> -			    sizeof(ext_enable_cp), &ext_enable_cp);
> -	} else {
> -		struct hci_cp_le_set_scan_enable cp;
> -
> -		memset(&cp, 0, sizeof(cp));
> -		cp.enable = LE_SCAN_ENABLE;
> -		cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
> -		hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
> -	}
> -
> -	return 0;
> -}
> -
> -static void le_scan_restart_work(struct work_struct *work)
> -{
> -	struct hci_dev *hdev = container_of(work, struct hci_dev,
> -					    le_scan_restart.work);
> -	unsigned long timeout, duration, scan_start, now;
> -	u8 status;
> -
> -	bt_dev_dbg(hdev, "");
> -
> -	hci_req_sync(hdev, le_scan_restart, 0, HCI_CMD_TIMEOUT, &status);
> -	if (status) {
> -		bt_dev_err(hdev, "failed to restart LE scan: status %d",
> -			   status);
> -		return;
> -	}
> -
> -	hci_dev_lock(hdev);
> -
> -	if (!test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks) ||
> -	    !hdev->discovery.scan_start)
> -		goto unlock;
> -
> -	/* When the scan was started, hdev->le_scan_disable has been queued
> -	 * after duration from scan_start. During scan restart this job
> -	 * has been canceled, and we need to queue it again after proper
> -	 * timeout, to make sure that scan does not run indefinitely.
> -	 */
> -	duration = hdev->discovery.scan_duration;
> -	scan_start = hdev->discovery.scan_start;
> -	now = jiffies;
> -	if (now - scan_start <= duration) {
> -		int elapsed;
> -
> -		if (now >= scan_start)
> -			elapsed = now - scan_start;
> -		else
> -			elapsed = ULONG_MAX - scan_start + now;
> -
> -		timeout = duration - elapsed;
> -	} else {
> -		timeout = 0;
> -	}
> -
> -	queue_delayed_work(hdev->req_workqueue,
> -			   &hdev->le_scan_disable, timeout);
> -
> -unlock:
> -	hci_dev_unlock(hdev);
> -}
> -
>  bool hci_req_stop_discovery(struct hci_request *req)
>  {
>  	struct hci_dev *hdev = req->hdev;
> @@ -2158,7 +2072,6 @@ int hci_req_configure_datapath(struct hci_dev
> *hdev, struct bt_codec *codec)
>  
>  void hci_request_setup(struct hci_dev *hdev)
>  {
> -	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
>  	INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expire);
>  	INIT_DELAYED_WORK(&hdev->interleave_scan, interleave_scan_work);
>  }
> @@ -2167,8 +2080,6 @@ void hci_request_cancel_all(struct hci_dev *hdev)
>  {
>  	__hci_cmd_sync_cancel(hdev, ENODEV);
>  
> -	cancel_delayed_work_sync(&hdev->le_scan_restart);
> -
>  	if (hdev->adv_instance_timeout) {
>  		cancel_delayed_work_sync(&hdev->adv_instance_expire);
>  		hdev->adv_instance_timeout = 0;
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 7dae2ee1bb82..19d57ec0feb8 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -392,6 +392,79 @@ static void le_scan_disable(struct work_struct *work)
>  	hci_dev_unlock(hdev);
>  }
>  
> +static int hci_le_set_scan_enable_sync(struct hci_dev *hdev, u8 val,
> +				       u8 filter_dup);
> +static int hci_le_scan_restart_sync(struct hci_dev *hdev)
> +{
> +	/* If controller is not scanning we are done. */
> +	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
> +		return 0;
> +
> +	if (hdev->scanning_paused) {
> +		bt_dev_dbg(hdev, "Scanning is paused for suspend");
> +		return 0;
> +	}
> +
> +	hci_le_set_scan_enable_sync(hdev, LE_SCAN_DISABLE, 0x00);
> +	return hci_le_set_scan_enable_sync(hdev, LE_SCAN_ENABLE,
> +					   LE_SCAN_FILTER_DUP_ENABLE);
> +}
> +
> +static int le_scan_restart_sync(struct hci_dev *hdev, void *data)
> +{
> +	return hci_le_scan_restart_sync(hdev);
> +}
> +
> +static void le_scan_restart(struct work_struct *work)
> +{
> +	struct hci_dev *hdev = container_of(work, struct hci_dev,
> +					    le_scan_restart.work);
> +	unsigned long timeout, duration, scan_start, now;
> +	int status;
> +
> +	bt_dev_dbg(hdev, "");
> +
> +	hci_dev_lock(hdev);
> +
> +	status = hci_cmd_sync_queue(hdev, le_scan_restart_sync, NULL, NULL);
> +	if (status) {
> +		bt_dev_err(hdev, "failed to restart LE scan: status %d",
> +			   status);
> +		goto unlock;
> +	}
> +
> +	if (!test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks) ||
> +	    !hdev->discovery.scan_start)
> +		goto unlock;
> +
> +	/* When the scan was started, hdev->le_scan_disable has been queued
> +	 * after duration from scan_start. During scan restart this job
> +	 * has been canceled, and we need to queue it again after proper
> +	 * timeout, to make sure that scan does not run indefinitely.
> +	 */
> +	duration = hdev->discovery.scan_duration;
> +	scan_start = hdev->discovery.scan_start;
> +	now = jiffies;
> +	if (now - scan_start <= duration) {
> +		int elapsed;
> +
> +		if (now >= scan_start)
> +			elapsed = now - scan_start;
> +		else
> +			elapsed = ULONG_MAX - scan_start + now;
> +
> +		timeout = duration - elapsed;
> +	} else {
> +		timeout = 0;
> +	}
> +
> +	queue_delayed_work(hdev->req_workqueue,
> +			   &hdev->le_scan_disable, timeout);
> +
> +unlock:
> +	hci_dev_unlock(hdev);
> +}
> +
>  void hci_cmd_sync_init(struct hci_dev *hdev)
>  {
>  	INIT_WORK(&hdev->cmd_sync_work, hci_cmd_sync_work);
> @@ -400,6 +473,7 @@ void hci_cmd_sync_init(struct hci_dev *hdev)
>  
>  	INIT_WORK(&hdev->cmd_sync_cancel_work, hci_cmd_sync_cancel_work);
>  	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable);
> +	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart);
>  }
>  
>  void hci_cmd_sync_clear(struct hci_dev *hdev)
> @@ -4488,6 +4562,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>  	cancel_delayed_work(&hdev->power_off);
>  	cancel_delayed_work(&hdev->ncmd_timer);
>  	cancel_delayed_work(&hdev->le_scan_disable);
> +	cancel_delayed_work(&hdev->le_scan_restart);
>  
>  	hci_request_cancel_all(hdev);
