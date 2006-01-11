Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] broadcast packets
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <43C4C236.5060100@in.tum.de>
References: <BAY24-F20084DBFE3577D788A970CF82F0@phx.gbl>
	 <1136420779.6652.30.camel@localhost> <dpotfk$832$1@sea.gmane.org>
	 <43C1356C.60109@in.tum.de>  <43C4C236.5060100@in.tum.de>
Content-Type: text/plain
Message-Id: <1136968575.26114.8.camel@localhost.localdomain>
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
Date: Wed, 11 Jan 2006 09:36:15 +0100

Hi Aleksandar,

> Marcel, could you please answer me that ? :)

I already told you everything I know and I have no idea why you still
stick to the broadcast thing. Once you have established the piconet
between two devices, you can use it to transfer data. Doing everything
on HCI level is not a good idea. Use at least the L2CAP level for it,
but you might need to add some kernel code to make it work properly. The
broadcast stuff is not really used in any Bluetooth application so far.

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
