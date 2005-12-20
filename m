Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43A74C87.1070407@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] No sound with SonyEricsson HBH-PV700
References: <43A74833.90804@david-geiger.de>
In-Reply-To: <43A74833.90804@david-geiger.de>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Mon, 19 Dec 2005 17:12:55 -0700

David

>     * Output from hciconfig hci0 revision (Run hciconfig as root)
> hci0:   Type: USB
>         BD Address: 00:0B:0D:32:5B:1A ACL MTU: 120:20 SCO MTU: 64:0
>         Unsupported manufacturer
> 
>           o If it prints "SCO mapping: HCI" then your adapter should work.
>           o If it prints "SCO mapping: PCM" then you might permanently
> change the setting using a command like "pskey mapsco 0" using
> bluez-utils-cvs but this is at your own risk.
>           o If it doesn't print either of those, you probably need a
> different bluetooth adapter (preferably "CSR" based)
> Seems like it doesn't print either of those...? What exactly is the SCO
> mapping and do I really need another bluetooth adapter?

yes, you need a different adapter to do sco on linux. bluez only has
drivers for csr chips, so "unsupported manufacterer" is all about the
level of support in the kernel driver.

brad


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
