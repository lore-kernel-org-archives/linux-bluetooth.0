Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Bluetooth bandwidth (OT)
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <43F197B7.5060900@teleline.es>
References: <43F197B7.5060900@teleline.es>
Content-Type: text/plain
Message-Id: <1139992900.26072.19.camel@localhost>
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
Date: Wed, 15 Feb 2006 09:41:40 +0100

Hi Pedro,

> This is a rather off topic question. I am interested in any 
> research/papers/whatever related to bluetooth bandwidth. It is very 
> common in computer science or telecommunication engineering studies to 
> study the behaviour of Aloha, Slotted Aloha, CSMA/CD, etc. and I want 
> something similar for bluetooth: what happens with the bandwidth when 
> there are many devices/many piconets together.
> 
> I have been searching in the Internet, but have found very little. I 
> would greatly appreciate any pointers.

I don't know of any particular papers that are covering the bandwidth
behavior of Bluetooth when a lot of devices are around. However for
Bluetooth all of them must be active participating in a piconet and
sending data, because other they don't consume any "bandwidth" at all.

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
