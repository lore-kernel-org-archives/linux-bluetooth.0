Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] headset connection problem
From: Marcel Holtmann <marcel@holtmann.org>
To: Guang <m9187@cn.ee.ccu.edu.tw>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <001101c3f630$bd389150$7b6b7b8c@guang>
References: <002801c3f55d$e5c9d800$7b6b7b8c@guang>
	 <1077032640.2665.14.camel@pegasus>  <003301c3f5c1$9e11b640$7b6b7b8c@guang>
	 <1077086400.2665.168.camel@pegasus>  <001101c3f630$bd389150$7b6b7b8c@guang>
Content-Type: text/plain
Message-Id: <1077119221.2676.14.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 18 Feb 2004 16:47:01 +0100

Hi Guang,

> I already run "hcidump -w dumpfile ",but I don't know whether the file "
> dumpfile " is correct ?
> The dumpfile  as attache file .
> 
> Could you help me to check it ?

you can read it with "hcidump -r dumpfile". Why does nobody read the man
pages :(

However the PIN request fails and I think this because the PIN helper
program can't be executed. And you should count your number of hcid's
running. There should be only one.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
