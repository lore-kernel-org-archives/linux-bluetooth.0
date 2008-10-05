Return-Path: <cyrus@holtmann.org>
Message-Id: <48B8929D-29F9-4352-9C81-E95FDBC09876@gmail.com>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <48E7FB1E.8000504@pook.es>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: bluez-4.11 + 2.6.27-rc8 + SCO headset -> bluetoothd: connect(): Connection timed out (110)
Date: Sun, 5 Oct 2008 19:50:43 +0200
References: <48E29416.3030402@pook.es> <48E2B59A.7020600@dtsp.co.nz>	 <48E3B3BF.6070205@pook.es>	 <2d5a2c100810032047s47bec394w828852079d64e591@mail.gmail.com>	 <48E752A7.70600@pook.es> <1223121068.11272.46.camel@violet.holtmann.net> <48E7FB1E.8000504@pook.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Oct 5, 2008, at 1:24, Stuart Pook wrote:
> not for me :-( I am once again getting the "aplay: set_params:979:
> Unable to install hw params:" message after a 40 second delay.
>
> The headset hisses softly to me during these 40 seconds.
>
> The error message from bluetoothd is "connect(): Connection timed  
> out (110)"

This seems to be some other error than the one that was fixed in 4.11.  
Could you try to get a hcidump of when this happens. It might be able  
to tell more about what's going on.

> Sometimes bluetoothd segfaults.

That's something more serious. Could you please try to produce a  
backtrace, either with gdb or valgrind. Thanks!

Johan
