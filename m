Return-Path: <cyrus@holtmann.org>
Subject: Re: Apple Bluetooth devices: Battery level?
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org,
	linux-input <linux-input@vger.kernel.org>
In-Reply-To: <1244384236.30768.5690.camel@cookie.hadess.net>
References: <1244384236.30768.5690.camel@cookie.hadess.net>
Content-Type: text/plain
Date: Sun, 07 Jun 2009 17:52:13 +0200
Message-Id: <1244389933.23850.104.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> I just got an Apple Bluetooth Mighty Mouse, and was wondering whether
> anyone had information on how to get the battery level from the device
> (the keyboard apparently also allows that):
> http://support.apple.com/kb/TA27118?viewlocale=en_US
> 
> Anyone with an idea? An unparsed HID event? Does it need "poking"?

I think that Apple ones used an actually HID HUT conform descriptor for
that. I did reverser engineered that a long time ago, but then never got
around to do anything with it. Can't find my notes right now. Just run
hcidump and eventually you will see the report.

Regards

Marcel


