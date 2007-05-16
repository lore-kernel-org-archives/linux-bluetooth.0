Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 16 May 2007 10:52:27 +0200
From: Ismael Valladolid Torres <ivalladt@punkass.com>
To: bluez-users@lists.sourceforge.net
Message-id: <20070516085227.GD4016@punkass.com>
MIME-version: 1.0
Subject: [Bluez-users] Is root needed to run this bluetooth related code
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

I'll copy and paste some code of the bluez utils in order for one of
my applications to be able to execute tasks similar to those run by
these commands.

$ hcitool scan

In order to get a list of devices within range.

$ sdptool browse ...

In order to get a list of active profiles in the device selected by
the user.

$ rfcomm connect ...

I order to enable a serial device between my application and the
needed profile in the selected device.

My question is: Will an application that needs to perform these task
be forced to be run as root?

Any pointers welcome.

Cordially, Ismael
-- 
Ismael Valladolid Torres  m. +34679156321
La media hostia           j. ivalladt@gmail.com

http://lamediahostia.blogspot.com/

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
