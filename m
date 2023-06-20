Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B55AEB64D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jun 2023 14:41:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjFTOle (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jun 2023 10:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbjFTOla (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jun 2023 10:41:30 -0400
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC5F170C
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 07:41:25 -0700 (PDT)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 4CE485C9438;
        Tue, 20 Jun 2023 16:41:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1687272077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FknwGDYCeGnib0E/LN1OlrgdrW2GyW68G+f9kApQ9dM=;
        b=IJmIrWlR59qN1RaBfq09nUcnp+W7CF7jQSnoHhz6Z5lfef9scY+XDw9iiWDl8fpj8UHdun
        JLarWupCasoIDBT98Li0GjO10aE7hXsWGaAFfNVz1u4Mmj5qxASeDB/q0MXWYNBTcQvABp
        I4IDSAoIbP193X1NvGb+euXxooXz4/8=
MIME-Version: 1.0
Date:   Tue, 20 Jun 2023 16:41:17 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Brian Gix <brian.gix@gmail.com>
Cc:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Brian Gix <brian.gix@intel.com>,
        linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        Regressions <regressions@lists.linux.dev>,
        =?UTF-8?Q?Jan_=C4=8Cerm?= =?UTF-8?Q?=C3=A1k?= <sairon@sairon.cz>
Subject: Re: [PATCH v4 2/4] Bluetooth: Rework le_scan_restart for hci_sync
In-Reply-To: <CABUQxGxBdAFncJ6YVb7a9gnU-_YZDGFDmpHJTtm5K1tDGEGRDQ@mail.gmail.com>
References: <20220727135834.294184-1-brian.gix@intel.com>
 <20220727135834.294184-3-brian.gix@intel.com>
 <578e6d7afd676129decafba846a933f5@agner.ch>
 <CABBYNZJGKfwTQM8WAdUGXueTPnFyus1a65UO5mg2g4PXVuCnpA@mail.gmail.com>
 <CABBYNZLgG+zTsk-6ceqzLXXyVRnN6p-m8sFq9Ss7mveD0f9BsQ@mail.gmail.com>
 <CABUQxGxBdAFncJ6YVb7a9gnU-_YZDGFDmpHJTtm5K1tDGEGRDQ@mail.gmail.com>
Message-ID: <0de3f0d0d5eb6d83cfc8d90cbb2b1ba1@agner.ch>
X-Sender: stefan@agner.ch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 2023-06-16 03:22, Brian Gix wrote:

> On Thu, Jun 15, 2023 at 11:28 AM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote: 
> 
>> +Brian Gix
>> 
>> On Thu, Jun 15, 2023 at 10:27 AM Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> 
>>> Hi Stefan,
>>> 
>>> On Thu, Jun 15, 2023 at 5:06 AM Stefan Agner <stefan@agner.ch> wrote:
>>>> 
>>>> Hi Brian, hi all,
>>>> 
>>>> We experienced quite some Bluetooth issues after moving from Linux 5.15
>>>> to 6.1 on Home Assistant OS, especially on Intel NUC type systems (which
>>>> is a popular choice in our community, so it might just be that). When
>>>> continuously scanning/listening for BLE packets, the packet flow
>>>> suddenly ends. Depending on which and how many devices (possibly also
>>>> other factors) within minutes or hours.
>>>> 
>>>> Jan (in cc) was able to bisect the issue, and was able to pinpoint the
>>>> problem to this change.
>>>> 
>>>> Meanwhile I was able to confirm, that reverting this single commit on
>>>> the latest 6.1.34 seems to resolve the issue.
>>>> 
>>>> I've reviewed the change and surrounding code, and one thing I've
>>>> noticed is that the if statement to set cp.filter_dup in
>>>> hci_le_set_ext_scan_enable_sync and hci_le_set_scan_enable_sync are
>>>> different. Not sure if that needs to be the way it is, but my outside
>>>> gut feeling says hci_le_set_ext_scan_enable_sync should use "if (val &&
>>>> hci_dev_test_flag(hdev, HCI_MESH))" as well.
>>>> 
>>>> However, that did not fix the problem (but maybe it is wrong
>>>> nonetheless?).
>>>> 
>>>> Anyone has an idea what could be the problem here?
>>> 
>>> Are there any logs of the problem? Does any HCI command fails or
>>> anything so that we can track down what could be wrong?

No HCI command fails, there is also no issue reported in the kernel log.
BlueZ just stops receiving BLE packets, at least from certain devices.

>> 
>> @Brian Gix perhaps you have a better idea what is going wrong here?
> 
> It seems unlikely that this is Mesh related. Mesh does need for filtering to
> be FALSE, and Mesh does not use extended scanning in any case. 
> 
> But this was part of the final rewrite to retire the hci_req mechanism in
> favor of the hci_sync mechanism. So my best guess off the top of my head is
> that there was an unintended race condition that worked better than the
> synchronous single-threading mechanism?  Filtering (or not) should not

After review the code I concluded the same. What is a bit surprising to
me is that it is so well reproducible. I guess it is nicer to have a
reproducible one than a hard to reproduce one :)

> prevent advertising packets from permanently wedging.  Does anyone have an
> HCI flow log with and without the offending patch?  Ideally they should be
> identical...  If they are not then I obviously did something wrong. As this
> was not specifically Mesh related, I may have missed some non-mesh corner
> cases.


I've taken two btmon captures, I created them using:
btmon -i hci0 -w /config/hcidump-hci-req-working.log

You can find them at:
https://os-builds.home-assistant.io/hcidump-hci-req-working.log
https://os-builds.home-assistant.io/hcidump-hci-sync-non-working.log

This is while running our user space software (Home Assistant with
Bluetooth integration). Besides some BLE devices (e.g. Xioami Mi
Temperature & Humidity sensor) I have a ESP32 running which sends SPAM
advertisements every 100ms (this accelerates the issue). In the
non-working case you'll see that the system doesn't receive any SPAM
advertisements after around 27 seconds. The working log shows that it
continuously receives the same packets (capture 120s).

Hope this helps.

--
Stefan



> 
>>>> --
>>>> Stefan
>>>> 
>>>> On 2022-07-27 15:58, Brian Gix wrote:
>>>>> le_scan_restart delayed work queue was running as a deprecated
>>>>> hci_request instead of on the newer thread-safe hci_sync mechanism.
>>>>>
>>>>> Signed-off-by: Brian Gix <brian.gix@intel.com>
>>>>> ---
>>>>>  net/bluetooth/hci_request.c | 89 -------------------------------------
>>>>>  net/bluetooth/hci_sync.c    | 75 +++++++++++++++++++++++++++++++
>>>>>  2 files changed, 75 insertions(+), 89 deletions(-)
>>>>>
>>>>> diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
>>>>> index 32fefaa0d3ca..114af7350363 100644
>>>>> --- a/net/bluetooth/hci_request.c
>>>>> +++ b/net/bluetooth/hci_request.c
>>>>> @@ -1975,92 +1975,6 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
>>>>>       return 0;
>>>>>  }
>>>>>
>>>>> -static int le_scan_restart(struct hci_request *req, unsigned long opt)
>>>>> -{
>>>>> -     struct hci_dev *hdev = req->hdev;
>>>>> -
>>>>> -     /* If controller is not scanning we are done. */
>>>>> -     if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
>>>>> -             return 0;
>>>>> -
>>>>> -     if (hdev->scanning_paused) {
>>>>> -             bt_dev_dbg(hdev, "Scanning is paused for suspend");
>>>>> -             return 0;
>>>>> -     }
>>>>> -
>>>>> -     hci_req_add_le_scan_disable(req, false);
>>>>> -
>>>>> -     if (use_ext_scan(hdev)) {
>>>>> -             struct hci_cp_le_set_ext_scan_enable ext_enable_cp;
>>>>> -
>>>>> -             memset(&ext_enable_cp, 0, sizeof(ext_enable_cp));
>>>>> -             ext_enable_cp.enable = LE_SCAN_ENABLE;
>>>>> -             ext_enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
>>>>> -
>>>>> -             hci_req_add(req, HCI_OP_LE_SET_EXT_SCAN_ENABLE,
>>>>> -                         sizeof(ext_enable_cp), &ext_enable_cp);
>>>>> -     } else {
>>>>> -             struct hci_cp_le_set_scan_enable cp;
>>>>> -
>>>>> -             memset(&cp, 0, sizeof(cp));
>>>>> -             cp.enable = LE_SCAN_ENABLE;
>>>>> -             cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
>>>>> -             hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
>>>>> -     }
>>>>> -
>>>>> -     return 0;
>>>>> -}
>>>>> -
>>>>> -static void le_scan_restart_work(struct work_struct *work)
>>>>> -{
>>>>> -     struct hci_dev *hdev = container_of(work, struct hci_dev,
>>>>> -                                         le_scan_restart.work);
>>>>> -     unsigned long timeout, duration, scan_start, now;
>>>>> -     u8 status;
>>>>> -
>>>>> -     bt_dev_dbg(hdev, "");
>>>>> -
>>>>> -     hci_req_sync(hdev, le_scan_restart, 0, HCI_CMD_TIMEOUT, &status);
>>>>> -     if (status) {
>>>>> -             bt_dev_err(hdev, "failed to restart LE scan: status %d",
>>>>> -                        status);
>>>>> -             return;
>>>>> -     }
>>>>> -
>>>>> -     hci_dev_lock(hdev);
>>>>> -
>>>>> -     if (!test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks) ||
>>>>> -         !hdev->discovery.scan_start)
>>>>> -             goto unlock;
>>>>> -
>>>>> -     /* When the scan was started, hdev->le_scan_disable has been queued
>>>>> -      * after duration from scan_start. During scan restart this job
>>>>> -      * has been canceled, and we need to queue it again after proper
>>>>> -      * timeout, to make sure that scan does not run indefinitely.
>>>>> -      */
>>>>> -     duration = hdev->discovery.scan_duration;
>>>>> -     scan_start = hdev->discovery.scan_start;
>>>>> -     now = jiffies;
>>>>> -     if (now - scan_start <= duration) {
>>>>> -             int elapsed;
>>>>> -
>>>>> -             if (now >= scan_start)
>>>>> -                     elapsed = now - scan_start;
>>>>> -             else
>>>>> -                     elapsed = ULONG_MAX - scan_start + now;
>>>>> -
>>>>> -             timeout = duration - elapsed;
>>>>> -     } else {
>>>>> -             timeout = 0;
>>>>> -     }
>>>>> -
>>>>> -     queue_delayed_work(hdev->req_workqueue,
>>>>> -                        &hdev->le_scan_disable, timeout);
>>>>> -
>>>>> -unlock:
>>>>> -     hci_dev_unlock(hdev);
>>>>> -}
>>>>> -
>>>>>  bool hci_req_stop_discovery(struct hci_request *req)
>>>>>  {
>>>>>       struct hci_dev *hdev = req->hdev;
>>>>> @@ -2158,7 +2072,6 @@ int hci_req_configure_datapath(struct hci_dev
>>>>> *hdev, struct bt_codec *codec)
>>>>>
>>>>>  void hci_request_setup(struct hci_dev *hdev)
>>>>>  {
>>>>> -     INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
>>>>>       INIT_DELAYED_WORK(&hdev->adv_instance_expire, adv_timeout_expire);
>>>>>       INIT_DELAYED_WORK(&hdev->interleave_scan, interleave_scan_work);
>>>>>  }
>>>>> @@ -2167,8 +2080,6 @@ void hci_request_cancel_all(struct hci_dev *hdev)
>>>>>  {
>>>>>       __hci_cmd_sync_cancel(hdev, ENODEV);
>>>>>
>>>>> -     cancel_delayed_work_sync(&hdev->le_scan_restart);
>>>>> -
>>>>>       if (hdev->adv_instance_timeout) {
>>>>>               cancel_delayed_work_sync(&hdev->adv_instance_expire);
>>>>>               hdev->adv_instance_timeout = 0;
>>>>> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
>>>>> index 7dae2ee1bb82..19d57ec0feb8 100644
>>>>> --- a/net/bluetooth/hci_sync.c
>>>>> +++ b/net/bluetooth/hci_sync.c
>>>>> @@ -392,6 +392,79 @@ static void le_scan_disable(struct work_struct *work)
>>>>>       hci_dev_unlock(hdev);
>>>>>  }
>>>>>
>>>>> +static int hci_le_set_scan_enable_sync(struct hci_dev *hdev, u8 val,
>>>>> +                                    u8 filter_dup);
>>>>> +static int hci_le_scan_restart_sync(struct hci_dev *hdev)
>>>>> +{
>>>>> +     /* If controller is not scanning we are done. */
>>>>> +     if (!hci_dev_test_flag(hdev, HCI_LE_SCAN))
>>>>> +             return 0;
>>>>> +
>>>>> +     if (hdev->scanning_paused) {
>>>>> +             bt_dev_dbg(hdev, "Scanning is paused for suspend");
>>>>> +             return 0;
>>>>> +     }
>>>>> +
>>>>> +     hci_le_set_scan_enable_sync(hdev, LE_SCAN_DISABLE, 0x00);
>>>>> +     return hci_le_set_scan_enable_sync(hdev, LE_SCAN_ENABLE,
>>>>> +                                        LE_SCAN_FILTER_DUP_ENABLE);
>>>>> +}
>>>>> +
>>>>> +static int le_scan_restart_sync(struct hci_dev *hdev, void *data)
>>>>> +{
>>>>> +     return hci_le_scan_restart_sync(hdev);
>>>>> +}
>>>>> +
>>>>> +static void le_scan_restart(struct work_struct *work)
>>>>> +{
>>>>> +     struct hci_dev *hdev = container_of(work, struct hci_dev,
>>>>> +                                         le_scan_restart.work);
>>>>> +     unsigned long timeout, duration, scan_start, now;
>>>>> +     int status;
>>>>> +
>>>>> +     bt_dev_dbg(hdev, "");
>>>>> +
>>>>> +     hci_dev_lock(hdev);
>>>>> +
>>>>> +     status = hci_cmd_sync_queue(hdev, le_scan_restart_sync, NULL, NULL);
>>>>> +     if (status) {
>>>>> +             bt_dev_err(hdev, "failed to restart LE scan: status %d",
>>>>> +                        status);
>>>>> +             goto unlock;
>>>>> +     }
>>>>> +
>>>>> +     if (!test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks) ||
>>>>> +         !hdev->discovery.scan_start)
>>>>> +             goto unlock;
>>>>> +
>>>>> +     /* When the scan was started, hdev->le_scan_disable has been queued
>>>>> +      * after duration from scan_start. During scan restart this job
>>>>> +      * has been canceled, and we need to queue it again after proper
>>>>> +      * timeout, to make sure that scan does not run indefinitely.
>>>>> +      */
>>>>> +     duration = hdev->discovery.scan_duration;
>>>>> +     scan_start = hdev->discovery.scan_start;
>>>>> +     now = jiffies;
>>>>> +     if (now - scan_start <= duration) {
>>>>> +             int elapsed;
>>>>> +
>>>>> +             if (now >= scan_start)
>>>>> +                     elapsed = now - scan_start;
>>>>> +             else
>>>>> +                     elapsed = ULONG_MAX - scan_start + now;
>>>>> +
>>>>> +             timeout = duration - elapsed;
>>>>> +     } else {
>>>>> +             timeout = 0;
>>>>> +     }
>>>>> +
>>>>> +     queue_delayed_work(hdev->req_workqueue,
>>>>> +                        &hdev->le_scan_disable, timeout);
>>>>> +
>>>>> +unlock:
>>>>> +     hci_dev_unlock(hdev);
>>>>> +}
>>>>> +
>>>>>  void hci_cmd_sync_init(struct hci_dev *hdev)
>>>>>  {
>>>>>       INIT_WORK(&hdev->cmd_sync_work, hci_cmd_sync_work);
>>>>> @@ -400,6 +473,7 @@ void hci_cmd_sync_init(struct hci_dev *hdev)
>>>>>
>>>>>       INIT_WORK(&hdev->cmd_sync_cancel_work, hci_cmd_sync_cancel_work);
>>>>>       INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable);
>>>>> +     INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart);
>>>>>  }
>>>>>
>>>>>  void hci_cmd_sync_clear(struct hci_dev *hdev)
>>>>> @@ -4488,6 +4562,7 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>>>>>       cancel_delayed_work(&hdev->power_off);
>>>>>       cancel_delayed_work(&hdev->ncmd_timer);
>>>>>       cancel_delayed_work(&hdev->le_scan_disable);
>>>>> +     cancel_delayed_work(&hdev->le_scan_restart);
>>>>>
>>>>>       hci_request_cancel_all(hdev);
>>> 
>>> 
>>> 
>>> --
>>> Luiz Augusto von Dentz
>> 
>> -- 
>> Luiz Augusto von Dentz
