Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] pin code problem
From: Marcel Holtmann <marcel@holtmann.org>
To: guang <m9187@cn.ee.ccu.edu.tw>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <001301c41a44$77a46fa0$7b6b7b8c@yaya>
References: <000c01c41a0c$b0441c80$7b6b7b8c@yaya>
	 <1081073411.2839.31.camel@pegasus>  <001301c41a44$77a46fa0$7b6b7b8c@yaya>
Content-Type: text/plain
Message-Id: <1081100087.3032.4.camel@pegasus>
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
Date: Sun, 04 Apr 2004 19:34:47 +0200

Hi,

> I am sure only one hcid running .
> I typed " hcid -f /etc/bluetooth/hcid.conf

check it with "ps x | grep hcid". I am pretty sure that there are more
than one running. Otherwise you can't get your hcidump output.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
