Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth emulation
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <478d26d00601060519v1ac0f373h@mail.gmail.com>
References: <478d26d00601060519v1ac0f373h@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1136554019.4867.4.camel@localhost>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 06 Jan 2006 14:26:59 +0100

Hi Toni,

> Would it be possible to emulate a bluetooth device?

you can use the virtual HCI of Bluetooth for it.

> I think it seems to have no sense to emulate a bluetooth device i mean
> the usb adapter.
> But I think in many nokia phones would be useful to transfer deta
> through the data cable (DKU-2 in example) 
> I've installed the drivers to transfer data through a cable, and it
> installs obex-file transfer, and meny other obex protocols to tansfer
> through cable.
> I thin we could access to the phone in the same way as bluetooth, but
> faster... 

Not everything is about speed, but if you wanna do it, you have to write
it by yourself.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
