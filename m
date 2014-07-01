Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <53B2C954.3070900@lwfinger.net>
References: <1404205896-25742-1-git-send-email-drake@endlessm.com>
	<BABA9B45-3DA7-40E4-9850-56CE967013BD@holtmann.org>
	<CAD8Lp46KFEbqi2eAotwa+J++Qo_p6cZR-KdmpWbDPcMavTPYzg@mail.gmail.com>
	<A9B54F0C-0D75-4C80-8AC1-B0EE71D6C8FF@holtmann.org>
	<53B2C954.3070900@lwfinger.net>
Date: Tue, 1 Jul 2014 17:15:19 +0100
Message-ID: <CAD8Lp46myv1zCes4X=3mQvdpLhDDwvp7HHaE6t=-piNuNz7K6w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add Realtek 8723/8761 support
From: Daniel Drake <drake@endlessm.com>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jul 1, 2014 at 3:44 PM, Larry Finger <Larry.Finger@lwfinger.net> wrote:
> I would prefer that you add the firmware to /lib/firmware/rtlwifi. That way
> all the Realtek firmware will be in the same place. In addition as discussed
> on GitHub, I would prefer the extension .bin on all firmware files.

The firmware files already have extension .bin with this code, I'll
move them to rtlwifi if you like.
I'll add _bt to the BT firmware filenames, otherwise we'll have
/lib/firmware/rtlwifi/rtl8723fw.bin (wifi) and
/lib/firmware/rtlwifi/rtl8723a_fw.bin (bluetooth), could be confusing.

Daniel
