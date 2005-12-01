Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] l2cap Connection refused
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <438EBCF9.4090909@web.de>
References: <1481541716@web.de> <1133210301.31513.60.camel@blade>
	 <438EBCF9.4090909@web.de>
Content-Type: text/plain
Message-Id: <1133429120.1190.18.camel@blade>
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
Date: Thu, 01 Dec 2005 10:25:20 +0100

Hi Orkan,

> Thanks for the support.  Meanwhile I updated to Ubuntu 5.10 but had the same problem.
> 
> By luck I found a way to get the USB-Bluetootch run but it is not the most convenient one.
> 
> When I type as root the command: sudo /etc/init.d/bluez-utils restart
> 
> and after that the sudo ciptool search 
> 
> suddenly the bluetooth connection is establishe and I can connect to the internet.

file a Ubuntu bug report, because this is working fine for me.

> By the way I also have to run the command capiinit to start internet connection.  Is 
> there a way to automise the complete procedure and without root privileges?  My wife 
> should also connect to the internet without my help.

Not really, but you can always use sudo.

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
