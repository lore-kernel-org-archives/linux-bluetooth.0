Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Stefan Behlert <behlert@suse.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] hcitool bug
Message-ID: <20050223154857.GE5777@suse.de>
References: <Pine.LNX.4.58.0502231536460.9757@sphinx.mythic-beasts.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.58.0502231536460.9757@sphinx.mythic-beasts.com>
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
Date: Wed, 23 Feb 2005 16:48:58 +0100

On Feb 23, 05 15:41:45 +0000, Pete Stevens wrote:
> Hi,
> 
> This confuses me, can anyone explain why I get this?
> 
> [root@pstevens bluetooth-pc-tag]# hcitool dev
> Devices:
>         hci0    00:0C:76:47:6A:94
> 
> [root@pstevens bluetooth-pc-tag]# hcitool -i 00:0C:76:47:6A:94 info
> 00:0E:6D:13:D8:74
> Requesting information ...
> Get connection info failed: No such file or directory

> 
> [root@pstevens bluetooth-pc-tag]# hcitool info 00:0E:6D:13:D8:74
> Requesting information ...
>         BD Address:  00:0E:6D:13:D8:74

Nice. With version 2.15 this fails with me. Do you have more than one
Bluetooth dongle in your computer?
[...]

I think it has to fail, because '-i <dev>' explicitly says "send it out
using this interface" and only affects remote devices. I don't think you
should be able to ask local devices for information in this way. But I may
be wrong.

        ciao,
          Stefan

-- 
Stefan Behlert


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
