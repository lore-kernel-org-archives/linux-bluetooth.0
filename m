Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] hci_create_connection
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20060127081807.37283.qmail@web50509.mail.yahoo.com>
References: <20060127081807.37283.qmail@web50509.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1138356749.25397.14.camel@localhost>
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
Date: Fri, 27 Jan 2006 11:12:29 +0100

Hi Mahtab,

> I know this has been discussed a lot of times in this list and the
> conclusion was that, only use "hci_create_connection" for debugging
> purpose.

then stick with it.

> I created the connections with "hci_create_connection" and the
> connection gets lost everytime after 40-50 seconds just like the
> following email from this list (mine are BroadCom based Dongles):
> 
> "I am connecting a Armadillo CF card to a TDK PC card using "hcitool cc
>  <BD_ADDR>".  The connection appears fine, but after a short period (40 sec
>  or so) seems to drop off.  I am running a script to monitor the RSSI values.
>  This worked fine with a 3Com card, but connection drops with the TDK.
>  
>  Any ideas why?

we should a device keep a not used ACL link open. This costs power. I
also don't think that this is a problem of your card. It is a problem of
your target device. In general BlueZ doesn't drop connections.

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
