Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Oct 2013 16:02:48 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Hans de Goede <hdegoede@redhat.com>
Cc: USB list <linux-usb@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org, Shuah Khan <shuah.kh@samsung.com>,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
	stable@vger.kernel.org
Subject: Re: [PATCH] Regression fix revert: "Bluetooth: Add missing
 reset_resume dev_pm_ops"
Message-ID: <20131002190248.GB3130@joana>
References: <1380374739-11581-1-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1380374739-11581-1-git-send-email-hdegoede@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

2013-09-28 Hans de Goede <hdegoede@redhat.com>:

> Many btusb devices have 2 modes, a hid mode and a bluetooth hci mode. These
> devices default to hid mode for BIOS use. This means that after having been
> reset they will revert to HID mode, and are no longer usable as a HCI.
> 
> Therefor it is a very bad idea to just blindly make reset_resume point to
> the regular resume handler. Note that the btusb driver has no clue how to
> switch these devices from hid to hci mode, this is done in userspace through
> udev rules, so the proper way to deal with this is to not have a reset-resume
> handler and instead let the usb-system re-enumerate the device, and re-run
> the udev rules.
> 
> I must also note, that the commit message for the commit causing this
> problem has a very weak motivation for the change:
> 
> "Add missing reset_resume dev_pm_ops. Missing reset_resume results in the
> following message after power management device test. This change sets
> reset_resume to btusb_resume().
> 
> [ 2506.936134] btusb 1-1.5:1.0: no reset_resume for driver btusb?
> [ 2506.936137] btusb 1-1.5:1.1: no reset_resume for driver btusb?"
> 
> Making a change solely to silence a warning while also changing important
> behavior (normal resume handling versus re-enumeration) requires a commit
> message with a proper explanation why it is safe to do so, which clearly lacks
> here, and unsurprisingly it turns out to not be safe to make this change.
> 
> Reverting the commit in question fixes bt no longer working on my Dell
> E6430 after a suspend/resume, and I believe it likely also fixes the
> following bugs:
> https://bugzilla.redhat.com/show_bug.cgi?id=988481
> https://bugzilla.redhat.com/show_bug.cgi?id=1010649
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1213239
> 
> This reverts commit 502f769662978a2fe99d0caed5e53e3006107381.
> 
> Cc: Shuah Khan <shuah.kh@samsung.com>
> Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/bluetooth/btusb.c | 1 -
>  1 file changed, 1 deletion(-)

Patch has been applied to bluetooth.git. Thanks.

	Gustavo
