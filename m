Return-Path: <cyrus@holtmann.org>
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <5547C7C7.2080909@lwfinger.net>
Date: Mon, 04 May 2015 14:25:59 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
MIME-Version: 1.0
To: Daniel Drake <drake@endlessm.com>, marcel@holtmann.org,
 gustavo@padovan.org, johan.hedberg@gmail.com
CC: linux-bluetooth@vger.kernel.org, champion_chen@realsil.com.cn,
 carlo@endlessm.com
Subject: Re: [PATCH v8] Bluetooth: btusb: Add Realtek 8723A/8723B/8761A/8821A
 support
References: <1429214995-11833-1-git-send-email-drake@endlessm.com>
In-Reply-To: <1429214995-11833-1-git-send-email-drake@endlessm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 04/16/2015 03:09 PM, Daniel Drake wrote:
> Realtek ship a variety of bluetooth USB devices that identify
> themselves with standard USB Bluetooth device class values, but
> require a special driver to actually work. Without that driver,
> you never get any scan results.
>
> More recently however, Realtek appear to have wisened up and simply
> posted a firmware update that makes these devices comply with
> normal btusb protocols. The firmware needs to be uploaded on each boot.
>
> Based on Realtek code from https://github.com/lwfinger/rtl8723au_bt
> ('new' branch).

Daniel,

I am told that these changes have now landed in linux-next, and it is time to 
think about firmware. Are you sending it to linux-firmware, or should I do it?

Thanks,

Larry
