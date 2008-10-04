Return-Path: <cyrus@holtmann.org>
Message-ID: <48E752A7.70600@pook.es>
Date: Sat, 04 Oct 2008 13:25:27 +0200
From: Stuart Pook <kernel6org@pook.es>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez-4.9 + 2.6.27-rc8 + SCO headset -> bluetoothd: connect:
 Operation not permitted
References: <48E29416.3030402@pook.es> <48E2B59A.7020600@dtsp.co.nz>	 <48E3B3BF.6070205@pook.es> <2d5a2c100810032047s47bec394w828852079d64e591@mail.gmail.com>
In-Reply-To: <2d5a2c100810032047s47bec394w828852079d64e591@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 04/10/08 05:47, Luiz Augusto von Dentz wrote:
> There is a regression on bluetoothd daemon, we introduce a SCO socket
> listen recently which is causing the problem, although it seem that
> the driver is also cooperating with the problem.

ok. Thanks for the information. Would installing bluez-4.10 help?

Or would changing my USB blueooth dongle help? I have an old Bluetooth 
1.2 Linksys USBBT100 dongle but have ordered a BELKIN F8T017ng 
(Bluetooth v2.1 + EDR + Class I) which should arrive in a few days. 
Perhaps it will work better though it appears that kernel 2.6.27-rc8 
does not include the required quirks (2.6.26-mh6 crashes for me).

I'm keen to get a Bluetooth headset working for VoIP so I could also 
change my headset if necessary. My Jabra JX10 Series II is however quite 
recent so I'd hope to be able to get it to work.

thanks
Stuart
