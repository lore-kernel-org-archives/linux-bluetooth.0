Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] help regarding cross compilation
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1439766405032010173a6649b8@mail.gmail.com>
References: <1439766405032010173a6649b8@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1111343408.22872.1.camel@pegasus>
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
Date: Sun, 20 Mar 2005 19:30:08 +0100

Hi Maha,

> I have to add bluetooth functionality to my MIPS based hardware
> platform. Hardware has montavista linux kernel 2.4.20 without rfcomm
> and bnep support. I need help regarding compilation of rfcomm,bnep and
> BlueZ. For cross compilation whether i have to use cross compilers or
> native gcc which is available in file system?

I am not the right person to ask about cross-compiling stuff, but I
think you need to rebuild your whole kernel. Apply patch-2.4.20-mh18 to
get RFCOMM and BNEP support. However be aware of that most of the fixes
and future enhancements are only present in the 2.6 kernel series.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
