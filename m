Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <54DD4502.6000304@lwfinger.net>
References: <1423786087-7354-1-git-send-email-drake@endlessm.com>
	<54DD4502.6000304@lwfinger.net>
Date: Thu, 12 Feb 2015 18:31:54 -0600
Message-ID: <CAD8Lp46wqiiK0h=6kCKh8mVFAUqVEwojo1DKja2h_3ugJZ6vGg@mail.gmail.com>
Subject: Re: [PATCH v4] Bluetooth: btusb: Add Realtek 8723A/8723B/8761A/8821A support
From: Daniel Drake <drake@endlessm.com>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
	=?UTF-8?B?6ZmI6Imz6JCN?= <champion_chen@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Feb 12, 2015 at 6:27 PM, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>> +#define RTL_EPATCH_SIGNATURE   "Realtech"
>
>
> Typo here. It should be Realtek.

If it is a typo, it is a typo from Realtek :)
The firmware includes this signature and it is what the vendor code checks for.

const uint8_t RTK_EPATCH_SIGNATURE[8] = {0x52, 0x65, 0x61, 0x6C, 0x74,
0x65, 0x63, 0x68};

>> +#define RTL_ROM_LMP_3499       0x3499
>> +#define RTL_ROM_LMP_8723A      0x1200
>> +#define RTL_ROM_LMP_8723B      0x8723
>> +#define RTL_ROM_LMP_8821A      0x8821
>> +#define RTL_ROM_LMP_8761A      0x8761
>
>
> I just got a report for an lmp_subversion of 0x4ce1 on an RTL8723BE. The
> above list and the table below may need expanding. We are still testing.

Keep in mind, it is normal for the lmp_subversion to change once the
firmware has been uploaded.
That list is only a list of firmware versions that must be replaced.

Daniel
