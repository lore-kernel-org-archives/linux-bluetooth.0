Return-Path: <cyrus@holtmann.org>
Message-ID: <555DB0F3.7020308@intel.com>
Date: Thu, 21 May 2015 12:18:27 +0200
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: bluetooth-next HCI user channel issue
References: <5534D661.1000703@intel.com> <A7E7D666-B172-4A02-A7E9-86483D630C81@holtmann.org> <4B296AC8-6E0A-4EB4-B1BD-892449AD4ED6@holtmann.org> <5555F464.7020404@intel.com>
In-Reply-To: <5555F464.7020404@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>> any chance you did git bisect this and tell us which patch broken this?
>
> I'll give you a answer/status before the end of next week.
>
> Regards,
> Loic
>

The following patch introduces the regression:
commit bfbd45e9acd2ef90ccc31ea02e08f82af392dbec
Bluetooth: Add device shutdown routine for Intel Bluetooth device

This patch sends the 0xFC3F vendor command from the shutdown callback.
Author says:
"For backward compatibility of this command  with old firmware, this
command was supported before, but it behaves same as HCI_RESET
internally. So, it won't be the problem even if the system doesn't have
the latest firmware patch."

However this patch introduces a HCI user channel regression:
- When hci interface is down/up with hciconfig, no problem.
- When hci interface is re-open via HCI user channel (bluemoon), first
command hangs.

After investigating, this is due to the "first HCI command" bug.
There is the following workaround in btusb_setup_intel:
/* The controller has a bug with the first HCI command sent to it
  * returning number of completed commands as zero. This would stall the
  * command processing in the Bluetooth core.
  *
  * As a workaround, send HCI Reset command first which will reset the
  * number of completed commands and allow normal command processing
  * from now on.
  */

Seems that the 0xFC3F command puts the device in the same kind of state
(Intel init state?).

So we need to apply the same workaround by sending HCI_RESET before any
other command, either in the open callback (QUIRK) or in the shutdown
one (after 0xFC3F).

We don't see the issue with "hciconfig up" because the first command is
always HCI_RESET.

Regards,
Loic

-- 
Intel Open Source Technology Center
http://oss.intel.com/
