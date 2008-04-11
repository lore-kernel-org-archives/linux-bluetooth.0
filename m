Return-Path: <cyrus@holtmann.org>
Message-Id: <F85F736F-D3E4-4E4C-AC08-1EF0B6792B12@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <47FF8DAE.5070108@cchtml.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Date: Sat, 12 Apr 2008 01:44:16 +0200
References: <47FF8DAE.5070108@cchtml.com>
Subject: Re: [Bluez-users] bluetooth obex is extremely slow, mtu too low
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Mike,

> I began a discussion in the Fedora-devel list about why Bluetooth 2.0
> OBEX transfers are so ridiculously slow. From my understanding,  
> OpenOBEX
> is no longer actively developing, and this list was the recommended
> destination of my findings.
>
> Here is my original post on the fedora-devel list
>
>> Hi all,
>>
>> I've lived with slow transfer speeds long enough. Ever since I  
>> purchased
>> an ASUS Bluetooth 2.0+EDR USB adapter it has always taken *minutes*
>> instead of *seconds* to transfer files from my cell phone to my  
>> computer
>> and vice versa.
>>
>> Fedora 8, latest updates.
>> Nokia N95-1, latest firmware.
>>
>> Both are Bluetooth 2.0+EDR devices.
>>
>> It took *40 seconds* to transfer a 1 megabyte picture. I timed this  
>> with
>> 'watch -n 1 date' for grins, so I can't give you nanosecond  
>> numbers, but
>> even a rough estimate shows that transfer speeds are *abysmal* and  
>> need
>> to be addressed. Ideally it should be taking less than 10 seconds to
>> transfer the same image file on a true 2.0+EDR setup. I have two
>> different computers with two of the same Asus adapter. Same speeds.
>>
>> I saw someone fixed this by forcing larger MTUs.
>> http://lists.freebsd.org/pipermail/...ary/000847.html
>> <http://lists.freebsd.org/pipermail/freebsd-bluetooth/2007-January/000847.html 
>> >
>>
>>
>> Before modifying the OpenOBEX sources, I posted a message on their
>> board, but I haven't heard anything yet. Does anyone have any  
>> experience
>> with this?
> I am using the "gnome-obex-server" program under XFCE to receive JPEG
> pictures from my Nokia N95. Under Windows XP, with the latest updates
> and drivers, the transfer time of the same JPEG pictures took 1/4th  
> the
> time: from 40 seconds (Linux) to 10 seconds (Windows).
>
> I tried adjusting the MTU and found out these results:
>
>> After further testing I've created a proper patch. These are my
>> results based on the attached patch. Each MTU was tested twice using
>> "open_push" as the receiver program and using the "gnome-obex-server"
>> program.
>>
>> Bluetooth 2.0 - 1070k file transfer from phone to computer
>> 1024 MTU - 40 seconds (default MTU)
>> 8192 MTU - 20 seconds
>> 16384 MTU - 10 seconds
>> 32768 MTU - 11 seconds
>> 65535 MTU - 12 seconds
>>
>> Bluetooth 1.1 - 1070k file transfer from phone to computer
>> 1024 MTU - 52 seconds (default MTU)
>> 8192 MTU - 30 seconds
>> 16384 MTU - 34 seconds
>>
>> I revised the patch to not change the minimum MTU. It had no effect  
>> on
>> speeds. 16k seems to be the sweet spot. This makes *huge* differences
>> for both 1.1 and 2.0.
> As you can see, the MTU is not being adjusted correctly, and by  
> forcing
> a higher default MTU, it solves the issue - both Bluetooth 1.1/1.2  
> and 2.0.
>
> Is there a better way of handling this? I don't see any drawbacks of a
> higher MTU.

the best is to submit patches for obex-data-server to set a bigger  
MTU. It is really not OpenOBEX's job to get MTU setup correctly.  
However I might be willing to simply add a patch for it if it doesn't  
lead to any kind of regression.

Regards

Marcel


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
