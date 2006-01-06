Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth emulation
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <478d26d00601060746l70513c8cj@mail.gmail.com>
References: <478d26d00601060519v1ac0f373h@mail.gmail.com>
	 <1136554019.4867.4.camel@localhost>
	 <478d26d00601060746l70513c8cj@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1136563459.4867.17.camel@localhost>
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
Date: Fri, 06 Jan 2006 17:04:19 +0100

Hi Toni,

>         > Would it be possible to emulate a bluetooth device?
>         
>         you can use the virtual HCI of Bluetooth for it.
> 
> How can I do it? (a howto would be useful) 

the source code of hciemu.c inside bluez-utils show how this interface
can be used.

>         Not everything is about speed, but if you wanna do it, you
>         have to write
>         it by yourself.
> 
> That's true, but my phone  doesn't accept files larger than 8MB
> through bluetooth 

Complain to the manufacturer, because this sounds like a bug in the
phone software/firmware.

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
