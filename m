Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] BCSP not working
From: Carlos AM <Carlos@naxus.biz>
To: bluez-devel lista <bluez-devel@lists.sourceforge.net>
In-Reply-To: <001201c48529$3b309710$5000005a@naxus>
References: <001201c48529$3b309710$5000005a@naxus>
Content-Type: text/plain
Message-Id: <1092837623.28955.120.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 18 Aug 2004 16:00:24 +0200

Hi

The machine is an arm running uclinux. I used the linux kernel version
2.4.22 and bluez-2.7. Yesterday I patched the kernel with this patch:

http://www.holtmann.org/linux/kernel/patch-2.4.22-mh7.gz

And got the following kernel log:

<3>bcsp_recv: Out-of-order packet arrived, got 1 expected 0
<3>bcsp_recv: Out-of-order packet arrived, got 1 expected 0
<4>Warning: kfree_skb passed an skb still on a list (from 00093a14).
<2>kernel BUG at skbuff.c:319!
(hanged)

The only difference with the last kernel messages was:
 "<3>bcsp_recv: Short BCSP packet" that didn't appear anymore.
According to the kernel patch changelog this is normal.

I execute the following script to start all the bluetooth stuff:
------------------------------------------------------------
#!/bin/sh
/bluez/hcid -n &
/bluez/bluezmain hciattach -n /dev/tts/2 csr 115200 &
/bluez/bluezmain hciconfig hci0 up
/bluez/sdpd -n &
/bluez/bluezmain sdptool add sp
#my own program
/bluez/rfcomm-server 1
------------------------------------------------------------
I used "-n" because the uclinux fork call does not behave as normal linux.
The uclinux hangs in hciattach.


I successfully executed this script with the same bluetooth hardware in a Linux 2.6 PC with bluez 2.7.
Everything worked fine.

Regards.
Carlos.




> > These messages appear on the kernel log when I am using BCSP:
> >  
> > <3>bcsp_recv: Out-of-order packet arrived, got 1 expected 0
> > <3>bcsp_recv: Checksum failed: computed b237 received 0000
> > <4>Warning: kfree_skb passed an skb still on a list (from 000f77a4).
> > <2>kernel BUG at skbuff.c:319!
> > <3>bcsp_recv: Short BCSP packet
> >  
> > Then the computer hangs.
> >  
> > I enabled "Send CRC with every hci packet" in the kernel and in the
> > bluetooth device.
> 
> I asked for more information not some extra text. What kernel version
> are using, what library version, what tools. What hardware, what command
> for reproducing etc. Is there an oops?
> 
> Regards
> 
> Marcel
> 



-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
