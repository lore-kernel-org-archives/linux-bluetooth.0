Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] pin code problem
From: Marcel Holtmann <marcel@holtmann.org>
To: guang <m9187@cn.ee.ccu.edu.tw>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <001c01c41ca2$2c4f4a10$7b6b7b8c@yaya>
References: <000c01c41a0c$b0441c80$7b6b7b8c@yaya>
	 <1081073411.2839.31.camel@pegasus>  <001c01c41ca2$2c4f4a10$7b6b7b8c@yaya>
Content-Type: text/plain
Message-Id: <1081348452.8755.1.camel@pegasus>
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
Date: Wed, 07 Apr 2004 16:34:12 +0200

Hi,

> I am very sure that it is only one hcid running, because i use "ps aux|grep
> hcid" to find hcid process.
> 
> Note , I can use sony-ericsson T610 to communication sony-ericsson HBH-65,
> but before communication I must enter "PIN code" on T610 to deliver this
> code  to HBH-65.
> So, I guess I can't "l2ping" HBH-65 is because  I must enter "PIN code " on
> my PC to translate this code to HBH-65.
> 
> Is my notion correct? If yes, how can I enter PIN code to deliver HBH-65? Or
> there are APIs that provide us to programing  on BlueZ?

look at the mailing list archive. You will find all answers about the
PIN helper stuff of the hcid there.

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
