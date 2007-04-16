Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <57c68ddc0704160904u559bfc86n2933b86640a434a0@mail.gmail.com>
References: <57c68ddc0704160608p5daa06b8o73bad2bdb8a4fda@mail.gmail.com>
	<1176731130.30165.26.camel@aeonflux.holtmann.net>
	<57c68ddc0704160741y7399f051rd3aaf6fe885cd57c@mail.gmail.com>
	<1176737786.30165.29.camel@aeonflux.holtmann.net>
	<57c68ddc0704160904u559bfc86n2933b86640a434a0@mail.gmail.com>
Date: Mon, 16 Apr 2007 19:28:51 +0200
Message-Id: <1176744531.30165.40.camel@aeonflux.holtmann.net>
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

>     I will try to upgrade to 2.6 kernel but since this is arm Single
> Board Computer , i am not sure about the effort and time  that would
> be required to do so. 
> 
> I have another observation to share with you . 
> 
> When using two dongle , if i put hci0 down by hciconfig hci0 down
> and then put hci1 up by hciconfig  hci1 up 
> then hciconfig returns correct address for the second adapter as well.
> 
> Also if i try to put hci1 up  without putting hci0 down then same
> thing 
>  ----- "cannot contact hci1 connection timed out" message appears.
> 
> Please reply if you can give me some hints about whats happening after
> going through the above observation.

I am pretty sure that is the USB subsystem. Since when you down the
adapter all URBs will be canceled. So you can try to change the
constants for the number of URBs in hci_usb.h and recompile your kernel.
You can also try to disable ISOC transfers (SCO support for the driver)
and see if that takes the bandwidth pressure from the USB bus.

However, the 2.6 USB subsystem is really the way to go. No effort on
porting to 2.6 is wasted.

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
