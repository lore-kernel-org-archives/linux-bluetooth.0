Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Subject: Re: [PATCH] Regression fix revert: "Bluetooth: Add missing reset_resume dev_pm_ops"
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20131002190248.GB3130@joana>
Date: Thu, 3 Oct 2013 05:39:31 +0200
Cc: Hans de Goede <hdegoede@redhat.com>,
	USB list <linux-usb@vger.kernel.org>,
	linux-bluetooth@vger.kernel.org, Shuah Khan <shuah.kh@samsung.com>,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
	stable@vger.kernel.org
Message-Id: <508150F6-D142-4406-8CC9-57DDE754F391@holtmann.org>
References: <1380374739-11581-1-git-send-email-hdegoede@redhat.com> <20131002190248.GB3130@joana>
To: Gustavo Padovan <gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

>> Many btusb devices have 2 modes, a hid mode and a bluetooth hci mode. These
>> devices default to hid mode for BIOS use. This means that after having been
>> reset they will revert to HID mode, and are no longer usable as a HCI.
>> 
>> Therefor it is a very bad idea to just blindly make reset_resume point to
>> the regular resume handler. Note that the btusb driver has no clue how to
>> switch these devices from hid to hci mode, this is done in userspace through
>> udev rules, so the proper way to deal with this is to not have a reset-resume
>> handler and instead let the usb-system re-enumerate the device, and re-run
>> the udev rules.
>> 
>> I must also note, that the commit message for the commit causing this
>> problem has a very weak motivation for the change:
>> 
>> "Add missing reset_resume dev_pm_ops. Missing reset_resume results in the
>> following message after power management device test. This change sets
>> reset_resume to btusb_resume().
>> 
>> [ 2506.936134] btusb 1-1.5:1.0: no reset_resume for driver btusb?
>> [ 2506.936137] btusb 1-1.5:1.1: no reset_resume for driver btusb?"
>> 
>> Making a change solely to silence a warning while also changing important
>> behavior (normal resume handling versus re-enumeration) requires a commit
>> message with a proper explanation why it is safe to do so, which clearly lacks
>> here, and unsurprisingly it turns out to not be safe to make this change.
>> 
>> Reverting the commit in question fixes bt no longer working on my Dell
>> E6430 after a suspend/resume, and I believe it likely also fixes the
>> following bugs:
>> https://bugzilla.redhat.com/show_bug.cgi?id=988481
>> https://bugzilla.redhat.com/show_bug.cgi?id=1010649
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1213239
>> 
>> This reverts commit 502f769662978a2fe99d0caed5e53e3006107381.
>> 
>> Cc: Shuah Khan <shuah.kh@samsung.com>
>> Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>> drivers/bluetooth/btusb.c | 1 -
>> 1 file changed, 1 deletion(-)
> 
> Patch has been applied to bluetooth.git. Thanks.

why? Because we have one broken Dell Bluetooth dongle. Do we actually know how this affects other chips. The dell HID Proxy thing has always been special case and that is Dell's fault. Look at the extra code that we have in hid2hci tool and its udev rules for Dell hardware. Is anybody actually willing to investigate this one properly.

Regards

Marcel

