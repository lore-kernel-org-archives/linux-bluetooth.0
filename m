Return-Path: <trexx@pobox.com>
Subject: Re: [Bluez-users] Logitech Bluetooth  Mx900+keyboard support.
From: Terence Rudkin <trexx@pobox.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1074514935.6070.80.camel@pegasus>
References: <1074457244.3254.17.camel@localhost.localdomain>
	 <1074458664.6070.73.camel@pegasus>
	 <1074480891.2817.10.camel@localhost.localdomain>
	 <1074514935.6070.80.camel@pegasus>
Content-Type: text/plain
Message-Id: <1074568150.7831.5.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Mon, 19 Jan 2004 20:09:10 -0700
List-ID: <bluez-users.lists.sourceforge.net>

Marcel,

On Mon, 2004-01-19 at 05:22, Marcel Holtmann wrote:


> do you have patched the USB HID driver?
I am not sure.

I cvs'ed the Makefile.  Modified the SRCDIRS to include libs2 and
utils2,  removed hciemu.   Did a make update, to get every thing.  Then
made all the dirs and installed the executables  generated. 

Still the same error.s   Do I need something else to get the USB HID
driver?  


Thanks for your support! 
-- 
