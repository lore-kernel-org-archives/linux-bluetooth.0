Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <54DE472E.7070207@lwfinger.net>
References: <1423786087-7354-1-git-send-email-drake@endlessm.com>
	<54DD4502.6000304@lwfinger.net>
	<CAD8Lp46wqiiK0h=6kCKh8mVFAUqVEwojo1DKja2h_3ugJZ6vGg@mail.gmail.com>
	<54DE472E.7070207@lwfinger.net>
Date: Fri, 13 Feb 2015 12:54:11 -0600
Message-ID: <CAD8Lp47jtibCTbDHG_p2bmMy-tWACOocVKQSRfxxqKO-3p1r4g@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: btusb: Add Realtek 8723A/8723B/8761A/8821A support
From: Daniel Drake <drake@endlessm.com>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
	=?UTF-8?B?6ZmI6Imz6JCN?= <champion_chen@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Feb 13, 2015 at 12:49 PM, Larry Finger
<Larry.Finger@lwfinger.net> wrote:
>>> I just got a report for an lmp_subversion of 0x4ce1 on an RTL8723BE. The
>>> above list and the table below may need expanding. We are still testing.
>>
>>
>> Keep in mind, it is normal for the lmp_subversion to change once the
>> firmware has been uploaded.
>> That list is only a list of firmware versions that must be replaced.
>
>
> I think the report was for a device for which firmware was not loaded as the
> lmp_subversion was not recognized. I will be rechecking the full dmesg
> output.

What do you mean by "not recognized"?

Just to confirm: the ones recognized (listed) in the driver are the
IDs where no firmware has been loaded, but where the firmware is
needed.
Once the firmware is loaded, it will come back with a different ID
that is *not* present in the driver at all, which will cause the
driver not to upload any more firmware.

For example my device starts as RTL_ROM_LMP_8723B but once the
firmware is loaded it comes back as 0x3083 (which is not mentioned in
the driver anywhere); at that point, bluetooth works fine.

It is possible that the RTL8723A starts as RTL_ROM_LMP_8723A but then
comes back as 0x4ce1 when the firmware is loaded. This is not
conclusive but FWIW I can see the byte string "0xe14c" inside the
rtl8723a_fw.bin firmware file.

> I have a few minor comments. My log shows the following:
>
> [ 4262.901871] Bluetooth: hci0: hci_ver=06 hci_rev=000b lmp_ver=06
> lmp_subver=8723
> [ 4262.901874] Bluetooth: hci0: rtl: examining hci_ver=06 hci_rev=000b
> lmp_ver=06 lmp_subver=8723
>
> Those two show the same information. The one in btusb_setup_realtek() should
> be removed.
>
> I would prefer to see a logging of the file name of the firmware that was
> loaded in btusb_setup_rtl8723b(). That will make it easier to interpret any
> "rtl: assuming no firmware upload needed." messages in
> btusb_setup_realtek().

Thanks, I'll make these changes in the next revision.

> When bringing my laptop out of sleep, the firmware was reloaded, but
> Bluetooth did not work until the driver was unloaded and reloaded. If you
> have any thoughts please let me know.

I haven't tested suspend/resume this side.

Daniel
