Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <54DA40DB.7030806@lwfinger.net>
References: <1423522782-18956-1-git-send-email-drake@endlessm.com>
	<54DA40DB.7030806@lwfinger.net>
Date: Tue, 10 Feb 2015 19:01:15 -0600
Message-ID: <CAD8Lp44htOrbdXEC-xcjPYrZG8EAePkhTQGiUwZXw2VbSBfbJQ@mail.gmail.com>
Subject: Re: [PATCH v3] Bluetooth: btusb: Add Realtek 8723A/8723B/8761A/8821A support
From: Daniel Drake <drake@endlessm.com>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
	=?UTF-8?B?6ZmI6Imz6JCN?= <champion_chen@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Feb 10, 2015 at 11:33 AM, Larry Finger
<Larry.Finger@lwfinger.net> wrote:
> I have tested the patched driver on RTL8723AE, RTL8723BE, and RTL8821AE. I
> have no BT devices for extended testing, but all 3 could pair with my cell
> phone and discover a number of BT devices such as my TV, etc. I have an
> RTL8723AU that is part of a Radxa Rock SBC, but I have not yet tested it.

Thanks for testing!

> As you noted, there are some additional devices that are not included. I
> have firmware for them, but I think leaving them out for the moment is best.

I agree, those can happen in later patches.

I'll send a followup patch with the added comment and your tested-by,
but first I'll wait a couple more days to see if there is more
feedback.

> AFAIK, the firmware should be redistributable under the conditions of
> "LICENCE.rtlwifi_firmware.txt" from the linux-firmware repo. Are you
> planning to submit the firmware to that repo, or should I do it?

I'll do that too. Can you confirm which are the latest firmware files?
For example in the 'new' branch there seem to be 2 different firmwares
for rtl8723b at least.

Thanks
Daniel
