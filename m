Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Fintan McEvoy" <fintan.mcevoy@ul.ie>
To: <bluez-users@lists.sourceforge.net>
Subject: RE: [Bluez-users] Bluetooth 1.2 device
Message-ID: <002501c54bef$4c4feae0$d24bc988@computernetworks>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <4270D347.1030204@gmx.ch>
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
Date: Thu, 28 Apr 2005 13:39:19 +0100

Thanks a million Marco,
You have answered all my questions,
Help is much appreciated.

Regards,
Fintan

-----Original Message-----
From: bluez-users-admin@lists.sourceforge.net
[mailto:bluez-users-admin@lists.sourceforge.net] On Behalf Of Marco
Trudel
Sent: 28 April 2005 13:13
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth 1.2 device

Hello Fintan

Fintan McEvoy wrote:
> Hi, 
>   I'm sure this is a common question but I'm looking for a bluetooth
> version 1.2 device that works well with bluez and under a kernel not
> over 2.4.29 . Can anyone make a good suggestion. Options I have looked
> at so far include DBT-120 and upgrading firmware.

The D-Link DBT-120 will probably be the best choice.
After an firmware update you have to reset it to hci bootmode (or use 
hid2hci). Marcel wrote the pskey tool for this, it's in the cvs.

 > Questions I have about
> that include, do I need a MAC to do this

No. There are a lot of utilities for windows to do that. Widcomm (I
think > 
3.0) has an updater included. I always use that.
There's also the btdfu tool for linux, but as much as I know it's not
that 
recommended. I would suggest the widcomm one.

 > and will it work with 2.4.29 .

yes.

> In fact will it work with Bluez at all this way. The other device I
have
> looked at is the newly SIG approved F8T009 belkin device. This seems
to
> use Broadcom BCM2035 chipset.

Broadcom's don't work that great with bluez. If you can, you really
should 
avoid them.

 > I think Bluez works when this chipset uses
> Bluetooth v1.1 . Is this correct? Will it work if it is using v 1.2 .

there are problem with both.

>             I really do need to get a bluetooth 1.2 device that works
as
> I'm setting up a testbed for research here in University of Limerick,
> Ireland. Any suggestions on what device to buy will be greatly
> appreciated.


regards
Marco


-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
SF.Net email is sponsored by: Tell us your software development plans!
Take this survey and enter to win a one-year sub to SourceForge.net
Plus IDC's 2005 look-ahead and a copy of this survey
Click here to start!  http://www.idcswdc.com/cgi-bin/survey?id=105hix
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
