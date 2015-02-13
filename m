Return-Path: <cyrus@holtmann.org>
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <54DE472E.7070207@lwfinger.net>
Date: Fri, 13 Feb 2015 12:49:18 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Daniel Drake <drake@endlessm.com>
CC: Marcel Holtmann <marcel@holtmann.org>,
 "Gustavo F. Padovan" <gustavo@padovan.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
 =?UTF-8?B?6ZmI6Imz6JCN?= <champion_chen@realsil.com.cn>
Subject: Re: [PATCH v4] Bluetooth: btusb: Add Realtek 8723A/8723B/8761A/8821A
 support
References: <1423786087-7354-1-git-send-email-drake@endlessm.com>	<54DD4502.6000304@lwfinger.net> <CAD8Lp46wqiiK0h=6kCKh8mVFAUqVEwojo1DKja2h_3ugJZ6vGg@mail.gmail.com>
In-Reply-To: <CAD8Lp46wqiiK0h=6kCKh8mVFAUqVEwojo1DKja2h_3ugJZ6vGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 02/12/2015 06:31 PM, Daniel Drake wrote:
> On Thu, Feb 12, 2015 at 6:27 PM, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>> +#define RTL_EPATCH_SIGNATURE   "Realtech"
>>
>>
>> Typo here. It should be Realtek.
>
> If it is a typo, it is a typo from Realtek :)
> The firmware includes this signature and it is what the vendor code checks for.
>
> const uint8_t RTK_EPATCH_SIGNATURE[8] = {0x52, 0x65, 0x61, 0x6C, 0x74,
> 0x65, 0x63, 0x68};

Sorry, I should have decoded that string.

>
>>> +#define RTL_ROM_LMP_3499       0x3499
>>> +#define RTL_ROM_LMP_8723A      0x1200
>>> +#define RTL_ROM_LMP_8723B      0x8723
>>> +#define RTL_ROM_LMP_8821A      0x8821
>>> +#define RTL_ROM_LMP_8761A      0x8761
>>
>>
>> I just got a report for an lmp_subversion of 0x4ce1 on an RTL8723BE. The
>> above list and the table below may need expanding. We are still testing.
>
> Keep in mind, it is normal for the lmp_subversion to change once the
> firmware has been uploaded.
> That list is only a list of firmware versions that must be replaced.

I think the report was for a device for which firmware was not loaded as the 
lmp_subversion was not recognized. I will be rechecking the full dmesg output.

I have a few minor comments. My log shows the following:

[ 4262.901871] Bluetooth: hci0: hci_ver=06 hci_rev=000b lmp_ver=06 lmp_subver=8723
[ 4262.901874] Bluetooth: hci0: rtl: examining hci_ver=06 hci_rev=000b 
lmp_ver=06 lmp_subver=8723

Those two show the same information. The one in btusb_setup_realtek() should be 
removed.

I would prefer to see a logging of the file name of the firmware that was loaded 
in btusb_setup_rtl8723b(). That will make it easier to interpret any "rtl: 
assuming no firmware upload needed." messages in btusb_setup_realtek().

When bringing my laptop out of sleep, the firmware was reloaded, but Bluetooth 
did not work until the driver was unloaded and reloaded. If you have any 
thoughts please let me know.

Larry
