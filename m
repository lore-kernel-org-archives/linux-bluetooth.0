Return-Path: <cyrus@holtmann.org>
Date: Wed, 20 Aug 2008 09:29:17 -0700 (PDT)
From: hong zhang <henryzhang62@yahoo.com>
Reply-To: henryzhang62@yahoo.com
Subject: Re: [Bluez-users] should I use hciattach for my USB dongle?
To: BlueZ users <bluez-users@lists.sourceforge.net>,
  Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1219227530.7591.320.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <350540.27361.qm@web57908.mail.re3.yahoo.com>
List-ID: <bluez-users.lists.sourceforge.net>

Marcel,

Yes, it does not complain after loading hci_usb. 
Where can I get howto document to do send/receive picture, voice, etc. with other bluetooth device?

I google but do not get good information.


---henry


--- On Wed, 8/20/08, Marcel Holtmann <marcel@holtmann.org> wrote:

> From: Marcel Holtmann <marcel@holtmann.org>
> Subject: Re: [Bluez-users] should I use hciattach for my USB dongle?
> To: henryzhang62@yahoo.com, "BlueZ users" <bluez-users@lists.sourceforge.net>
> Date: Wednesday, August 20, 2008, 5:18 AM
> Hi,
> 
> > I have a USB dongle connected to my desktop.
> "hciconfig hci0 up" returns "can't open
> HCI socket.:Address family not supported by protocol". 
> > 
> > For serial port, run "hciattach /dev/ttyS1 bcsp
> 115200". But my dongle is self initialized with its own
> eeprom with USB port. 
> > 
> > What should I do to setup my dongle and make it work
> with my cell phone?
> 
> either the hci_usb or btusb driver will be used. Make sure
> that all
> modules are loaded.
> 
> Regards
> 
> Marcel


      
