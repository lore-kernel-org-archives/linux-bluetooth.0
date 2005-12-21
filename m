Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] connectionless L2CAP
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <43A94B7B.70906@in.tum.de>
References: <43A94B7B.70906@in.tum.de>
Content-Type: text/plain
Message-Id: <1135169114.26233.66.camel@localhost>
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
Date: Wed, 21 Dec 2005 13:45:14 +0100

Hi Aleksandar,

> how can I broadcast a data packet ?
> And the connectionless mode of the l2test isn't actually connectionless, 
> for example:
> $ ./l2test -D -N 1 -s 00:04:3E:81:14:F8
> l2test[1279]: Can't connect: Host is down (112)
> 
> I just want to broadcast a data packet and I don't care if the remote 
> end got it or not (i.e. connectionless ACL). Will someone  please 
> explain me how can I do that and also a programming example would be great.

this is not really working, because if there is no ACL link, then there
exists no piconet. And without a piconet no air transmission.

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
