Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] How does data flow from USB Core to the
	bluetooth protocol stack
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20060209125112.12551.qmail@web36111.mail.mud.yahoo.com>
References: <20060209125112.12551.qmail@web36111.mail.mud.yahoo.com>
Content-Type: text/plain
Message-Id: <1139533252.17280.40.camel@localhost>
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
Date: Fri, 10 Feb 2006 02:00:52 +0100

Hi Swathi,

> I am a research student and i am trying to trace the
> working of Bluez. 
> I was able to find out how the communication between
> the bluetooth USB adapter and host takes place. ie how
> the bluetooth device driver gets loaded and how the
> data collected in the bluetooth device driver is being
> passed onto the actual USB driver. 
> I was not able to find out how the USB core passes the
> data which it collected from the bluetooth device
> driver onto the bluetooth protocol stack. ie how the
> kernel knows that this data belongs to bluez

the hci_usb driver attaches to the USB core and the Bluetooth core and
deals with all these things. Start looking at the source code.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
