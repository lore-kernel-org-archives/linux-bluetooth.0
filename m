Return-Path: <cyrus@holtmann.org>
Subject: Re: Apple Bluetooth devices: Battery level?
From: Bastien Nocera <hadess@hadess.net>
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-bluetooth@vger.kernel.org,
	linux-input <linux-input@vger.kernel.org>
In-Reply-To: <alpine.LRH.2.00.0906081530330.31685@twin.jikos.cz>
References: <1244384236.30768.5690.camel@cookie.hadess.net>
	 <alpine.LRH.2.00.0906081530330.31685@twin.jikos.cz>
Content-Type: text/plain
Date: Wed, 10 Jun 2009 15:06:09 +0100
Message-Id: <1244642769.2690.51.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2009-06-08 at 15:33 +0200, Jiri Kosina wrote:
> On Sun, 7 Jun 2009, Bastien Nocera wrote:
> 
> > I just got an Apple Bluetooth Mighty Mouse, and was wondering whether 
> > anyone had information on how to get the battery level from the device 
> > (the keyboard apparently also allows that): 
> > http://support.apple.com/kb/TA27118?viewlocale=en_US
> > 
> > Anyone with an idea? An unparsed HID event? Does it need "poking"?
> 
> If the mouse is standard-compliant, it should be sending the battery level 
> strength in usage 0x20 of device controls page (0x06).
> 
> Could you please obtain HID debug dump (CONFIG_HID_DEBUG + modprobe hid 
> module with 'debug=2') and look at this usage both in the report 
> descriptor itself, and also check whether it is present in the received 
> reports?

This is the debug output:
http://pastebin.com/m256a4187

Doesn't look very useful, and I have no idea what the 00ff.00c0 part
does.

Cheers

