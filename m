Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] problems using rfcomm device
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <87is82hzp6.fsf@khaberz.net>
References: <87r7mqidhb.fsf@khaberz.net> <1100861511.7213.0.camel@pegasus>
	 <87is82hzp6.fsf@khaberz.net>
Content-Type: text/plain
Message-Id: <1100862575.7213.6.camel@pegasus>
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
Date: Fri, 19 Nov 2004 12:09:35 +0100

Hi Kai,

> >> Trying to get bluetooth running under Debian Testing here. Connecting
> >> to my device (Nokia 6600 cell) works fine, but whenever I try to
> >> access the device using pppd or minicom I get something like this:
> >> 
> >> Nov 19 06:18:01 arthur pppd[1382]: Failed to open /dev/rfcomm0:
> >> Invalid argument
> >
> > run "hcidump -X" as root and see what happens.
> 
> arthur:/home/khaberz# hcidump -X
> HCIDump - HCI packet analyzer ver 1.12
> device: hci0 snap_len: 1028 filter: 0xffffffff
> 
> ...and that's it, even if I try to connect with pppd.

I overlooked your real mistake. You set the channel to the value 0 for
the /dev/rfcomm0 and this is not a valid one. Use 1 for the channel
number.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
