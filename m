Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: bluetooth-next HCI user channel issue
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <555DB0F3.7020308@intel.com>
Date: Thu, 21 May 2015 14:22:23 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <87123BA8-F06B-40DB-8E1A-39EFBF5DDE54@holtmann.org>
References: <5534D661.1000703@intel.com> <A7E7D666-B172-4A02-A7E9-86483D630C81@holtmann.org> <4B296AC8-6E0A-4EB4-B1BD-892449AD4ED6@holtmann.org> <5555F464.7020404@intel.com> <555DB0F3.7020308@intel.com>
To: Loic Poulain <loic.poulain@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

>>> any chance you did git bisect this and tell us which patch broken this?
>> 
>> I'll give you a answer/status before the end of next week.
>> 
>> Regards,
>> Loic
>> 
> 
> The following patch introduces the regression:
> commit bfbd45e9acd2ef90ccc31ea02e08f82af392dbec
> Bluetooth: Add device shutdown routine for Intel Bluetooth device

perfect. Thanks for bi-secting this.

The real offending commit is actually the one before introducing hdev->shutdown() call. Which is commit a44fecbd52a4. We are checking for HCI_UNREGISTER set, but we should also be checking for HCI user channel. If the dev_do_close is triggered from an open HCI user channel, we should not call hdev->shutdown(). That is a function that should only be called if we are indeed running BlueZ as stack.

I however think the patch is a bit trickier since the flag has already been cleared at that point. So it might needs an interim flag or placing of the hdev->shutdown() at a different location.

> This patch sends the 0xFC3F vendor command from the shutdown callback.
> Author says:
> "For backward compatibility of this command  with old firmware, this
> command was supported before, but it behaves same as HCI_RESET
> internally. So, it won't be the problem even if the system doesn't have
> the latest firmware patch."
> 
> However this patch introduces a HCI user channel regression:
> - When hci interface is down/up with hciconfig, no problem.
> - When hci interface is re-open via HCI user channel (bluemoon), first
> command hangs.
> 
> After investigating, this is due to the "first HCI command" bug.
> There is the following workaround in btusb_setup_intel:
> /* The controller has a bug with the first HCI command sent to it
> * returning number of completed commands as zero. This would stall the
> * command processing in the Bluetooth core.
> *
> * As a workaround, send HCI Reset command first which will reset the
> * number of completed commands and allow normal command processing
> * from now on.
> */
> 
> Seems that the 0xFC3F command puts the device in the same kind of state
> (Intel init state?).
> 
> So we need to apply the same workaround by sending HCI_RESET before any
> other command, either in the open callback (QUIRK) or in the shutdown
> one (after 0xFC3F).

My feeling is that this should be in the shutdown callback. So sending another HCI Reset afterwards.

Tedd, would that actually work and have the right affect?

> We don't see the issue with "hciconfig up" because the first command is
> always HCI_RESET.

And btw. I think we need both patches. Not calling hdev->shutdown() when leaving HCI user channel and adding the extra HCI Reset to the Intel shutdown so that we can go from normal stack operation into a HCI user channel and are not caught by the first HCI command bug.

Regards

Marcel

