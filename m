Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] IP Forwarding
From: Marcel Holtmann <marcel@holtmann.org>
To: Lalith Chakravarthi <lalithvc@yahoo.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040305142714.44803.qmail@web40708.mail.yahoo.com>
References: <20040305142714.44803.qmail@web40708.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1078511952.19852.9.camel@pegasus>
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
Date: Fri, 05 Mar 2004 19:39:12 +0100

Hi Lalith,

> I just connected my laptop to my Pc and now I want to connect to the
> internet using my PC as the gateway. I already have the bluetooth PAN
> network between my laptop and PC. I am working on a linux 2.4.20-8
> kernel on both the laptop and the PC.  Also, I use proxies to connect
> to the internet from my PC. So, could anyone please tell me the files
> that have to be modified to enable the successful completion of my
> internet connection thru my laptop.

you have to enable IP forwarding and then use iptables to create your
NAT and masquerading for your device.

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
