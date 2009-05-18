Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Reinstitute usb_detach_kernel_driver_np, but in the
 proper place.
From: Marcel Holtmann <marcel@holtmann.org>
To: Mario Limonciello <mario_limonciello@dell.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
In-Reply-To: <4A11A51A.7030109@dell.com>
References: <4A11A51A.7030109@dell.com>
Content-Type: text/plain
Date: Mon, 18 May 2009 11:20:50 -0700
Message-Id: <1242670850.3446.45.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mario,

> Testing a little more, I found that on fresh boots the latest bluez.git
> doesn't always work to switch dell BT adapters to HCI mode depending on
> the state of the killswitch on boot.  Whenever running hid2hci, the
> kernel driver should attempt to be released.  As long as this is done
> before trying to claim, each of the scenarios is successful.  The
> previous dmesg errors were coming up because the order of the
> usb_claim_interface and usb_detach_kernel_driver_np were reversed.

the patch has been applied. However I prefer if you stop making the code
so complex that my brain hurts. I changed that now. It should really
just to "if error then bail out of the function".

Regards

Marcel


