Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Microsoft  Mouse
From: Marcel Holtmann <marcel@holtmann.org>
To: Jonathan Sass <jsass@magnifeye.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <C21DDF6B-2D7B-11D9-ADC1-0005027BA2B7@magnifeye.com>
References: <C21DDF6B-2D7B-11D9-ADC1-0005027BA2B7@magnifeye.com>
Content-Type: text/plain
Message-Id: <1099476422.7125.91.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 03 Nov 2004 11:07:02 +0100

Hi Jonathan,

you know that there is a "Reply to All" button in your mail client ;)

> 	Thank you your info and a mouse howto  from 
> http://dev.gentoo.org/~puggy/btmouse-howto/btmousehowto.html I now have 
> my keyboard and mouse running. It was quite easy.

It is meant to be quite easy with any newer Linux distribution, where
the BlueZ packages and the kernel are up to date.

> 	My next step is a custom bluetooth device, are there documents that 
> show me where I can intercept the data from the device within the linux 
> kernel and route it to a particular application? Where does the data 
> from the bluetooth device "show up" in the kernel.

This is all about socket programming. There is no need to look inside
the kernel.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
