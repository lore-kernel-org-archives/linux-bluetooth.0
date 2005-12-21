Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] connectionless L2CAP
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <43A95B0B.2040909@in.tum.de>
References: <43A94B7B.70906@in.tum.de> <1135169114.26233.66.camel@localhost>
	 <43A95B0B.2040909@in.tum.de>
Content-Type: text/plain
Message-Id: <1135173373.14627.0.camel@localhost>
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
Date: Wed, 21 Dec 2005 14:56:13 +0100

Hi Aleksandar,

> I'm actually trying to send a data packet between 2 bluetooth devices 
> over 100 meters. I haven't went really deep into the bluetooth specs, 
> but I assume that because of the long range a connection might not be 
> possible, so that's why I just want to broadcast some packets and hope 
> that some will arrive at the other end. Is this possible ?

what's the problem with 100 meters range. Use a pair of class 1 dongles
and you are fine.

> Btw./l2test with 00:00:00:00:00:00 fails too, but the bluetooth baseband 
> specification section 3.3 says that "ACL packets not addressed to a 
> specific slave are considered as broadcast packets and are read by every 
> slave". I have 1 device in range (I can see it with hcitool scan, l2test 
> succeeds with that device).

You still need the piconet. No piconet no data transfer over the air.

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
