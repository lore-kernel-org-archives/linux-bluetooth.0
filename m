Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: "beatriz.hargrave" <beatriz.hargrave@uol.com.br>,
   bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth - USB adapters
References: <HVI9GX$IDS3gDUdf06VCb6ODUPlAa2l6e7HJtg5g8qTWg3_jM6V@uol.com.br>
From: "Christoph Torens" <c.torens@web.de>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
Message-ID: <opr5snzxgceocfdv@debian>
In-Reply-To: <HVI9GX$IDS3gDUdf06VCb6ODUPlAa2l6e7HJtg5g8qTWg3_jM6V@uol.com.br>
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
Date: Thu, 01 Apr 2004 22:17:47 +0200

Hi Beatriz,

> I would like to know if there is a bluetooth-USB adapter for
> Linux Red Hat 7.1, and where can I buy it (Internet or in
> Brazil) . The adapters I have found so far are only for
> Windows (Leadership and Apple).

Thats quite exactly what I asked a few days ago. I'll post the answer I  
got from the list.
Hope this helps you...

My question was exactly:
>> I'd like to buy an additional Bluetooth Dongle,
>> because my Zeevo Chip Dongles don't work properly and I stressed my  
>> friend to long now by borrowing his CSR Dongle.
>> So which chipsets exist at all, and is CSR the "all-time-best-solution"  
>> for linux?
>> And last but not least, how can I buy a Dongle with the desired  
>> chipset? You normaly just see the manufacturers as Acer for example,  
>> not the chipset, don't you? Is it absolutely unimportant at all, if its  
>> Acer, Belkin, D-Link or what ever?


And here the answer from Marcel Holtmann, who does the developing on the  
bluez stack:

> the problem is the community support with chips from Zeevo and Broadcom
> for example. We already know that their chips not behave very well under
> some circumstances. On the other side we have CSR and if you ask me I
> would always decide to use one of their chips, because their chips are
> known to work very well and their community support is very good. They
> really support Linux and try to help people that have problems. But
> there are more companies than Zeevo, Broadcom and CSR. For example I
> also use devices from AVM and ST Microelectronics and some others.
>Actually my current policy is to tell everyone to try a CSR dongle first
> if you see hardware problems like TX timeouts. Some companies should do
> their homework or pay people to do it for them.
>For finding out what kind of chip is inside the dongles you can use this
> webpage					
>http://www.holtmann.org/linux/bluetooth/features.html

There is no special RedHat USB-Dongle. Well, bluez should work on your  
Linux, of course. If it does not run already, I suggest you should read  
some of the howto's on www.holtmann.org/linux/bluetooth/

By the way, I bought the "Epox DG02A" (CSR Chipset)
and I think it works better with Linux than my "Acer BT510" (Zeevo Chipset)

--
Christoph


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
