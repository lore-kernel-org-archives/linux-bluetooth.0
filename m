Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: [bluetooth-alsa] and [libao-devel]
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <cpmeu8$9qu$1@sea.gmane.org>
References: <cpk3v3$4bb$1@sea.gmane.org> <1102948606.8750.159.camel@pegasus>
	 <cpkc1i$tpn$1@sea.gmane.org> <cpkdsa$3qu$1@sea.gmane.org>
	 <cpkf63$8up$1@sea.gmane.org>  <cpmeu8$9qu$1@sea.gmane.org>
Content-Type: text/plain
Message-Id: <1103020215.2143.146.camel@pegasus>
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
Date: Tue, 14 Dec 2004 11:30:15 +0100

Hi,

> I migth be doing something wrong... It should be easier to load it. I've 
> checked the path and the snd_bt_sco.ko file is placed at 
> /lib/modules/`uname -r`/extra. Why in extra?
> 
> If I use insmod /lib/modules/`uname -r`/extra/snd_bt_sco.k, it claims 
> for dependencies, and well, I have seen in some thread that someone just 
>   use modprobe snd_bt_sco.

after the "make install" maybe a "depmod -e" is needed.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
