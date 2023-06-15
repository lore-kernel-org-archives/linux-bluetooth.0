Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F43EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Jun 2023 12:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241642AbjFOMrk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Jun 2023 08:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFOMrj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Jun 2023 08:47:39 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A817C2120
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jun 2023 05:47:37 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1q9mNx-0005yB-U7; Thu, 15 Jun 2023 14:47:33 +0200
Message-ID: <a88e0534-2983-3e51-325e-94389f704f3f@leemhuis.info>
Date:   Thu, 15 Jun 2023 14:47:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 2/4] Bluetooth: Rework le_scan_restart for hci_sync
Content-Language: en-US, de-DE
To:     Stefan Agner <stefan@agner.ch>, Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, Regressions <regressions@lists.linux.dev>,
        =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>
References: <20220727135834.294184-1-brian.gix@intel.com>
 <20220727135834.294184-3-brian.gix@intel.com>
 <578e6d7afd676129decafba846a933f5@agner.ch>
From:   "Linux regression tracking #adding (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <578e6d7afd676129decafba846a933f5@agner.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1686833257;9b621c71;
X-HE-SMSGID: 1q9mNx-0005yB-U7
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

[TLDR: I'm adding this report to the list of tracked Linux kernel
regressions; the text you find below is based on a few templates
paragraphs you might have encountered already in similar form.
See link in footer if these mails annoy you.]

On 15.06.23 14:06, Stefan Agner wrote:
> Hi Brian, hi all,
> 
> We experienced quite some Bluetooth issues after moving from Linux 5.15
> to 6.1 on Home Assistant OS, especially on Intel NUC type systems (which
> is a popular choice in our community, so it might just be that). When
> continuously scanning/listening for BLE packets, the packet flow
> suddenly ends. Depending on which and how many devices (possibly also
> other factors) within minutes or hours.
> 
> Jan (in cc) was able to bisect the issue, and was able to pinpoint the
> problem to this change.
> 
> Meanwhile I was able to confirm, that reverting this single commit on
> the latest 6.1.34 seems to resolve the issue.

FWIW & BTW: might be wise to also check if latest mainline still shows
the problem, as explained on this page:

https://linux-regtracking.leemhuis.info/post/frequent-reasons-why-linux-kernel-bug-reports-are-ignored/

> I've reviewed the change and surrounding code, and one thing I've
> noticed is that the if statement to set cp.filter_dup in
> hci_le_set_ext_scan_enable_sync and hci_le_set_scan_enable_sync are
> different. Not sure if that needs to be the way it is, but my outside
> gut feeling says hci_le_set_ext_scan_enable_sync should use "if (val &&
> hci_dev_test_flag(hdev, HCI_MESH))" as well. 
> 
> However, that did not fix the problem (but maybe it is wrong
> nonetheless?).
> 
> Anyone has an idea what could be the problem here?

Thanks for the report. To be sure the issue doesn't fall through the
cracks unnoticed, I'm adding it to regzbot, the Linux kernel regression
tracking bot:

#regzbot ^introduced 27d54b778ad
#regzbot title net/bluetooth: packet flow suddenly ends when
continuously scanning/listening for BLE packets
#regzbot ignore-activity

This isn't a regression? This issue or a fix for it are already
discussed somewhere else? It was fixed already? You want to clarify when
the regression started to happen? Or point out I got the title or
something else totally wrong? Then just reply and tell me -- ideally
while also telling regzbot about it, as explained by the page listed in
the footer of this mail.

Developers: When fixing the issue, remember to add 'Link:' tags pointing
to the report (the parent of this mail). See page linked in footer for
details.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
That page also explains what to do if mails like this annoy you.

> On 2022-07-27 15:58, Brian Gix wrote:
>> le_scan_restart delayed work queue was running as a deprecated
>> hci_request instead of on the newer thread-safe hci_sync mechanism.
>>
>> Signed-off-by: Brian Gix <brian.gix@intel.com>
>> ---
>>  net/bluetooth/hci_request.c | 89 -------------------------------------
>>  net/bluetooth/hci_sync.c    | 75 +++++++++++++++++++++++++++++++
>>  2 files changed, 75 insertions(+), 89 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
>> index 32fefaa0d3ca..114af7350363 100644
>> --- a/net/bluetooth/hci_request.c
>> +++ b/net/bluetooth/hci_request.c
>> @@ -1975,92 +1975,6 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
>>  	return 0;
>>  }
>>  
>> -static int le_scan_restart(struct hci_request *req, unsigned long opt)
>> -{
>> -	struct hci_dev *hdev = req->hdev;
>> -
>> -	/* If controller is not scanning we are done. */
>> -	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
>> -		return 0;
>> -
>> -	if (hdev->scanning_paused) {
>> -		bt_dev_dbg(hdev, "Scanning is paused for suspend");
>> -		return 0;
>> -	}
>> -
>> -	hci_req_add_le_scan_disable(req, false);
>> -
>> -	if (use_ext_scan(hdev)) {
>> -		struct hci_cp_le_set_ext_scan_enable ext_enable_cp;
>> -
>> -		memset(&ext_enable_cp, 0, sizeof(ext_enable_cp));
>> -		ext_enable_cp.enable = LE_SCAN_ENABLE;
>> -		ext_enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
>> -
>> -		hci_req_add(req, HCI_OP_LE_SET_EXT_SCAN_ENABLE,
>> -			    sizeof(ext_enable_cp), &ext_enable_cp);
>> -	} else {
>> -		struct hci_cp_le_set_scan_enable cp;
>> -
>> -		memset(&cp, 0, sizeof(cp));
>> -		cp.enable = LE_SCAN_ENABLE;
>> -		cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
>> -		hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>> -static void le_scan_restart_work(struct work_struct *work)
>> -{
>> -	struct hci_dev *hdev = container_of(work, struct hci_dev,
>> -					    le_scan_restart.work);
>> -	unsigned long timeout, duration, scan_start, now;
>> -	u8 status;
>> -
>> -	bt_dev_dbg(hdev, "");
>> -
>> -	hci_req_sync(hdev, le_scan_restart, 0, HCI_CMD_TIMEOUT, &status);
>> -	if (status) {
>> -		bt_dev_err(hdev, "failed to restart LE scan: status %d",
>> -			   status);
>> -		return;
>> -	}
>> -
>> -	hci_dev_lock(hdev);
>> -
>> -	if (!test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks) ||
>> -	    !hdev->discovery.scan_start)
>> -		goto unlock;
>> -
>> -	/* When the scan was started, hdev->le_scan_disable has been queued
>> -	 * after duration from scan_start. During scan restart this job
>> -	 * has been canceled, and we need to queue it again after proper
>> -	 * timeout, to make sure that scan does not run indefinitely.
>> -	 */
>> -	duration = hdev->discovery.scan_duration;
>> -	scan_start = hdev->discovery.scan_start;
>> -	now = jiffies;
>> -	if (now - scan_start <= duration) {
>> -		int elapsed;
>> -
>> -		if (now >= scan_start)
>> -			elapsed = now - scan_start;
>> -		else
>> -			elapsed = ULONG_MAX - scan_start + now;
>> -
>> -		timeout = duration - elapsed;
>> -	} else {
>> -		timeout = 0;
>> -	}
>> -
>> -	queue_delayed_work(hdev->req_workqueue,
>> -			   &hdev->le_scan_disable, timeout);
>> -
>> -unlock:
>> -	hci_dev_unlock(hdev);
>> -}
>> -
>>  bool hci_req_stop_discovery(struct hci_request *req)
>>  {
>>  	struct hci_dev *hdev = req->hdev;
>> @@ -2158,7 +2072,6 @@ int hci_req_configure_datapath(struct hci_dev
>> *hdev, struct bt_codec *codec)
>>  
>>  void hci_request_setup(struct hci_dev *hdev)
>>  {
>> -	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
>>  	INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expire);
>>  	INIT_DELAYED_WORK(&hdev->interleave_scan, interleave_scan_work);
>>  }
>> @@ -2167,8 +2080,6 @@ void hci_request_cancel_all(struct hci_dev *hdev)
>>  {
>>  	__hci_cmd_sync_cancel(hdev, ENODEV);
>>  
>> -	cancel_delayed_work_sync(&hdev->le_scan_restart);
>> -
>>  	if (hdev->adv_instance_timeout) {
>>  		cancel_delayed_work_sync(&hdev->adv_instance_expire);
>>  		hdev->adv_instance_timeout = 0;
>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>> index 7dae2ee1bb82..19d57ec0feb8 100644
>> --- a/net/bluetooth/hci_sync.c
>> +++ b/net/bluetooth/hci_sync.c
>> @@ -392,6 +392,79 @@ static void le_scan_disable(struct work_struct *work)
>>  	hci_dev_unlock(hdev);
>>  }
>>  
>> +static int hci_le_set_scan_enable_sync(struct hci_dev *hdev, u8 val,
>> +				       u8 filter_dup);
>> +static int hci_le_scan_restart_sync(struct hci_dev *hdev)
>> +{
>> +	/* If controller is not scanning we are done. */
>> +	if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
>> +		return 0;
>> +
>> +	if (hdev->scanning_paused) {
>> +		bt_dev_dbg(hdev, "Scanning is paused for suspend");
>> +		return 0;
>> +	}
>> +
>> +	hci_le_set_scan_enable_sync(hdev, LE_SCAN_DISABLE, 0x00);
>> +	return hci_le_set_scan_enable_sync(hdev, LE_SCAN_ENABLE,
>> +					   LE_SCAN_FILTER_DUP_ENABLE);
>> +}
>> +
>> +static int le_scan_restart_sync(struct hci_dev *hdev, void *data)
>> +{
>> +	return hci_le_scan_restart_sync(hdev);
>> +}
>> +
>> +static void le_scan_restart(struct work_struct *work)
>> +{
>> +	struct hci_dev *hdev = container_of(work, struct hci_dev,
>> +					    le_scan_restart.work);
>> +	unsigned long timeout, duration, scan_start, now;
>> +	int status;
>> +
>> +	bt_dev_dbg(hdev, "");
>> +
>> +	hci_dev_lock(hdev);
>> +
>> +	status = hci_cmd_sync_queue(hdev, le_scan_restart_sync, NULL, NULL);
>> +	if (status) {
>> +		bt_dev_err(hdev, "failed to restart LE scan: status %d",
>> +			   status);
>> +		goto unlock;
>> +	}
>> +
>> +	if (!test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks) ||
>> +	    !hdev->discovery.scan_start)
>> +		goto unlock;
>> +
>> +	/* When the scan was started, hdev->le_scan_disable has been queued
>> +	 * after duration from scan_start. During scan restart this job
>> +	 * has been canceled, and we need to queue it again after proper
>> +	 * timeout, to make sure that scan does not run indefinitely.
>> +	 */
>> +	duration = hdev->discovery.scan_duration;
>> +	scan_start = hdev->discovery.scan_start;
>> +	now = jiffies;
>> +	if (now - scan_start <= duration) {
>> +		int elapsed;
>> +
>> +		if (now >= scan_start)
>> +			elapsed = now - scan_start;
>> +		else
>> +			elapsed = ULONG_MAX - scan_start + now;
>> +
>> +		timeout = duration - elapsed;
>> +	} else {
>> +		timeout = 0;
>> +	}
>> +
>> +	queue_delayed_work(hdev->req_workqueue,
>> +			   &hdev->le_scan_disable, timeout);
>> +
>> +unlock:
>> +	hci_dev_unlock(hdev);
>> +}
>> +
>>  void hci_cmd_sync_init(struct hci_dev *hdev)
>>  {
>>  	INIT_WORK(&hdev->cmd_sync_work, hci_cmd_sync_work);
>> @@ -400,6 +473,7 @@ void hci_cmd_sync_init(struct hci_dev *hdev)
>>  
>>  	INIT_WORK(&hdev->cmd_sync_cancel_work, hci_cmd_sync_cancel_work);
>>  	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable);
>> +	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart);
>>  }
>>  
>>  void hci_cmd_sync_clear(struct hci_dev *hdev)
>> @@ -4488,6 +4562,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>>  	cancel_delayed_work(&hdev->power_off);
>>  	cancel_delayed_work(&hdev->ncmd_timer);
>>  	cancel_delayed_work(&hdev->le_scan_disable);
>> +	cancel_delayed_work(&hdev->le_scan_restart);
>>  
>>  	hci_request_cancel_all(hdev);
> 
> 
