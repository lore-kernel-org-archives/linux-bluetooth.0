Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <57c68ddc0704160741y7399f051rd3aaf6fe885cd57c@mail.gmail.com>
References: <57c68ddc0704160608p5daa06b8o73bad2bdb8a4fda@mail.gmail.com>
	<1176731130.30165.26.camel@aeonflux.holtmann.net>
	<57c68ddc0704160741y7399f051rd3aaf6fe885cd57c@mail.gmail.com>
Date: Mon, 16 Apr 2007 17:36:26 +0200
Message-Id: <1176737786.30165.29.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] problem using two bluetooth dongles together
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Siddhant,

>                  I am using using kernel 2.4.26. 
>                  cant find anything with dmesg output.
> 
>                  When trying to run hcid at the prompt i am getting
> message 
>                 
>                   Can't init device hci1 : Connection time out.
> 
>                  What can be the possible reasons for this ???

the USB stack in 2.4.26 is very old. So is the Bluetooth stack. You
should really start using a 2.6 kernel.

My guess is that you have problems with the USB support in this ancient
kernel.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
