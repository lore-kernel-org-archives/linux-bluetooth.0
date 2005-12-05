Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] RFCOMM disconnect command from slave device
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20051205103257.18037.qmail@web32409.mail.mud.yahoo.com>
References: <20051205103257.18037.qmail@web32409.mail.mud.yahoo.com>
Content-Type: text/plain
Message-Id: <1133818369.4559.5.camel@localhost.localdomain>
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
Date: Mon, 05 Dec 2005 22:32:49 +0100

Hi Arch,

> I would like to ask if it is okay for a slave device to be the first
> to issue a disconnect command in the RFCOMM layer rather than the
> master device. Usually, after the OBEX Disconnect request of the
> master device and the corresponding response of the slave device, the
> master issues a disconnect command in the RFCOMM layer. However, the
> slave device (running on BlueZ) is the first one to issue a disconnect
> command in the RFCOMM layer, and the master device issues a disconnect
> command (RFCOMM) after that of the slave device. Is this okay?

I don't see any problem with that and so far there were no problems at
all. However the ownership of connections is something that is unclear
within the Bluetooth specification.

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
