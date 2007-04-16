Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <57c68ddc0704160608p5daa06b8o73bad2bdb8a4fda@mail.gmail.com>
References: <57c68ddc0704160608p5daa06b8o73bad2bdb8a4fda@mail.gmail.com>
Date: Mon, 16 Apr 2007 15:45:30 +0200
Message-Id: <1176731130.30165.26.camel@aeonflux.holtmann.net>
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

Hi,

>     I am using bluez on arm single board computer and i am facing this
> strange problem. 
> 
> When i am using only one bluetooth dongle , hciconfig correctly
> reports the bluetooth address of the dongle but when i insert a second
> dongle then the second dongles bt address is reported as
> 00:00:00:00:00:00 . 
> 
> Both the dongles individually work fine.
> 
> Can anyone tell me what can be the cause for such a problem ????

never tried it on ARM machines. Check the output of dmesg. Maybe your
USB stack has a problem on ARM. Do you run the latest 2.6 kernel?

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
