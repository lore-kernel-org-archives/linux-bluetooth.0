Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] l2cap Connection refused
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1481541716@web.de>
References: <1481541716@web.de>
Content-Type: text/plain
Message-Id: <1133210301.31513.60.camel@blade>
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
Date: Mon, 28 Nov 2005 21:38:21 +0100

Hi Orkan,

> this is the first time that I post a question to the mailing list.
> A couple of days ago I bought an AVM Bluefritz Bluetooth set to connect my PC to the internet.
> Unfortunately I was not able to set this up for my Ubuntu Linux (5.04).
> After a serious internet research I achieved a point where I do need help by "linux professionals" because I tried out alot.
> 
> When I type following:
> 
> orkan@ubuntu:~$ sudo hcitool scan
> Scanning ...
>         00:04:03:02:93:41       Bluetooth ISDN Access Point
> orkan@ubuntu:~$
> 
> I find an access point.
> 
> When I type following: 
> 
> orkan@ubuntu:~$ sudo ciptool search
> Searching ...
>         Checking service for 00:04:0E:8B:74:E1
>         Connecting to device 00:04:0E:8B:74:E1
> Can't connect L2CAP socket: Connection refused
> orkan@ubuntu:~$
> 
> I receive that L2CAP connection was refused.  
> My pin is set in the file /etc/bluetooth/pin and I also tried to edit the bluepin-perl-skript.  For Ubuntu it is /usr/bin/bluepin.  I followed the instructions from Marcel Holtmann.
> 
> Would you be so kind and can give me support that I can connect via Linux and bluetooth to the internet?

run "hcidump -X -V" as in root in another terminal window and see what
happens.

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
