Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360793ED105
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774032543; cv=none; b=tVb6kxRsVveh5Aw0atsYabNQUV722khKuZhyh/tO+gM1bzMMTMUgpd3o7ny/tI8lAS81DNTha4Y2zInBhJSeaeb8to6OFUXSiuowxaalRO+2SPIxifDgzyIdCJsP98wTOFjrzPGfxbAiGAfFYXDze2pZCHMovqEh2yxofMxje/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774032543; c=relaxed/simple;
	bh=tpMzAlGtGi4PSNYcd2DE6yvYxeEb/RTDQPmTaSJd+t4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mx6UjH4O9isnGJWRVAxF72helikTJZDrW+bW5dWCiyE8zxQtrfXcEjzn5qpTbrZLG17sHZS9wjs7TzmXwS3wv8R5uTZrXQDv8OGvW+mAWAXiMHWQ+nkExk6pXcvtrdgm9uwd3+3tWfOoN/4cXBHkdUFi0NajZ/ZWeeUpJbleP1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=OxYFHBXl; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="OxYFHBXl"
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 407BE240028
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 19:48:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1774032538; bh=BG+nzpvqXXLBzlbEim4d5tQaeYkY+/fwEua1GIZRfPM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:Content-Type:
	 Content-Transfer-Encoding:From;
	b=OxYFHBXl3faUF0DRSwSksQhVlitT4EHForFeseuY1I/3rVcAlxIO5ueLOmAQvky4p
	 bgE+HuxWCyu9Ca3WOsmQFqmmH6fv2xC7gJocrO98TgFwrL9VjABtacr3VhnwZHAdnR
	 aHsCjNarPZeCvocVAas0bSP2NmIXp04d2slN7da6AjNzi2rCUhNOplXDHN7qX6PqQr
	 dA9IILFPPU9M3kOwrgCfBNrqccqN9+FsfF7Y2/ts60cLXb9J2ssAxYp4tScFF9eGGU
	 Z7JDHZDQrN0UQUjD5upYrViilgka/02XQJFnvHI2jU4NkZ22buTbJGjewWdloGKAyU
	 xKpcekqmo0kew==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4fcs6K2tT9z9rxM;
	Fri, 20 Mar 2026 19:48:57 +0100 (CET)
Message-ID: <7862fd8b-1fbc-424b-8d91-a64889e715fc@posteo.de>
Date: Fri, 20 Mar 2026 18:48:57 +0000
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Bluetooth: btusb: cancel pending HCI commands before USB
 suspend
Content-Language: en-MW
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <cd1ec531-1603-4788-952d-ff256c898e0b@posteo.de>
 <20260320114347.2340528-1-fberg@posteo.de>
 <CABBYNZLxZ+=5Zg6269+DbsE=Q9KQefZQXqacyn1iOR3nYnLuig@mail.gmail.com>
From: Frederik Berg <fberg@posteo.de>
In-Reply-To: <CABBYNZLxZ+=5Zg6269+DbsE=Q9KQefZQXqacyn1iOR3nYnLuig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luiz,

Thank you for the quick and thorough feedback.

You're right that HCI_QUIRK_NO_SUSPEND_NOTIFIER is not set for Intel, so 
hci_suspend_dev() should be running and completing before 
btusb_suspend(). I missed that the PM notifier ordering guarantees this.

Looking at the logs again more carefully, the error message is 
specifically "Error when powering off device on rfkill (-19)" which 
points to the hci_rfkill_set_block() -> hci_dev_do_poweroff() path, not 
the PM notifier's hci_suspend_sync(). So you're right that something in 
userspace appears to be triggering rfkill to power off bluetooth around 
the same time as system suspend.

I had a custom systemd user service running that did "rfkill block 
bluetooth" followed by "rfkill unblock bluetooth" on resume, which was 
an earlier workaround attempt. That rfkill block could have been racing 
with USB suspend. I've since removed it and will test a few 
suspend/resume cycles without it to see if the issue still reproduces.

I'll report back with results. If the issue persists without the rfkill 
workaround, I'll capture btmon traces and dmesg with more detail around 
the suspend path.

Thanks,
Frederik

On 3/20/26 19:31, Luiz Augusto von Dentz wrote:
> Hi Frederik,
>
> On Fri, Mar 20, 2026 at 7:44 AM Frederik Berg <fberg@posteo.de> wrote:
>> During system suspend, the PM notifier and USB subsystem suspend run
>> concurrently without synchronization. If the PM notifier's
>> hci_power_off_sync() is blocked waiting for an HCI command response
>> (e.g., Write Scan Enable, opcode 0x0c1a) when the USB subsystem tears
>> down the device, the command fails with -ENODEV.
>>
>> Unlike a timeout (-ETIMEDOUT), an ENODEV cancellation does not trigger
>> hci_cmd_timeout(), which means hdev->reset() is never called and the
>> Intel ACPI reset method (_PRR/_RST) that would recover the device is
>> bypassed. The device then fails to re-enumerate on resume (detected as
>> low-speed instead of full-speed, error -71) and is permanently lost
>> until the xHCI host controller is reset or the system is rebooted.
>>
>> Cancel any pending synchronous HCI commands in btusb_suspend() before
>> btusb_stop_traffic() kills the URBs, but only for non-autosuspend
>> (system suspend). This matches the pattern used by hci_suspend_dev()
>> which calls hci_cancel_cmd_sync(hdev, EHOSTDOWN) before proceeding
>> with HCI-level suspend.
>>
>> Signed-off-by: Frederik Berg <fberg@posteo.de>
>> ---
>> Proposed fix for the race described in the parent email. This cancels
>> any pending synchronous HCI commands in btusb_suspend() before
>> btusb_stop_traffic() kills the URBs, preventing the race. Only for
>> system suspend, not autosuspend. Same pattern used by hci_suspend_dev()
>> which calls hci_cancel_cmd_sync(hdev, EHOSTDOWN).
>>
>> I haven't been able to build-test this against a running kernel yet,
>> so consider this an RFC.
>>
>>   drivers/bluetooth/btusb.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
>> index a1c5eb993e4..acec484b495 100644
>> --- a/drivers/bluetooth/btusb.c
>> +++ b/drivers/bluetooth/btusb.c
>> @@ -4497,6 +4497,9 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
>>
>>          cancel_work_sync(&data->work);
>>
>> +       if (!PMSG_IS_AUTO(message))
>> +               hci_cmd_sync_cancel_sync(data->hdev, EHOSTDOWN);
>> +
>>          if (data->suspend)
>>                  data->suspend(data->hdev);
>>
>> --
>> 2.53.0
> Have to agree with a few points over here:
>
> https://sashiko.dev/#/patchset/20260320114347.2340528-1-fberg%40posteo.de
>
> Specially the first point: if hci_suspend_sync (which should be
> pending not hci_power_off_sync ) had run, then there shouldn't be
> anything to cancel at btusb_suspend and hdev should be suspended.
> Perhaps something is trying to power off bluetooth (e.g. userspace)?
> Anyway hci_suspend_dev does already perform
> hci_cmd_sync_cancel_sync(data->hdev, EHOSTDOWN); or do you have
> HCI_QUIRK_NO_SUSPEND_NOTIFIER set for it, which is why it doesn't run?
>
> The other option would be to call hci_suspend_dev directly from the
> driver, but then again the register_pm_notifier guarantee that the
> notifier completed before calling the driver suspend, or am I missing
> something?
>
