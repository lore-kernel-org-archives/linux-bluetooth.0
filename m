Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <421C9D0F.602@gmx.ch>
From: Marco Trudel <mtrudel@gmx.ch>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] sdp problem
References: <20050223142950.53110.qmail@web60907.mail.yahoo.com>
In-Reply-To: <20050223142950.53110.qmail@web60907.mail.yahoo.com>
Content-Type: text/plain; charset=Big5
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
Date: Wed, 23 Feb 2005 16:11:11 +0100

Hello Michael

I think you've to do this:
Write a program that listens on a rfcomm channel (let's assume channel 6).
then you can do: sdptool add --channel=6 OPUSH
-> the service is now registered and should be found

man sdptool and vi sdptool.c might help...


I just tried something that might help you too:
I work with kde. It has by default a obex service running.
On an image in my mobile phone, i selected "send via bluetooth". The mobile
searched for devices in rainge, showed me the list, I selected my laptop,
the mobilephone connected to the obex service, on the laptop I was informed
of a connection attemp and aceppted. I got the image.

Do you have the possibility to try this with kde? If yes, you could try to
achive the same thing. This way you might find out what's the problem of
connecting from the mobile to the pc.

hope this helps a little

regards
Marco


Ka Kin Cheung wrote:
> Hi!
>     The strange thing is here:
>     For Linux, when my phone searched for my PC, the PC can be found and 
> then added in the "My device" list, but when I looked at "Service list", 
> none service can be found. Then I opened Windows XP and the bluetooth 
> dongle driver was installed in my PC. Then I press "update" key to 
> update services, and I found headset, synchronisation, object push and 
> file transfer in the "Service list" for my Windows PC. So, how can I do 
> for sdp in my Linux PC as my project is done on Linux? Thank you very 
> much for your kindness.
> Michael
> 
> */Marco Trudel <mtrudel@gmx.ch>/* wrote:
> 
>     have you already found out how the phone will connect to the pc?
> 
>     regards
>     Marco
> 
> 
>     Ka Kin Cheung wrote:
>      > Hi all!
>      > Now I'm still thinking about how to implement sdp in my program so
>      > that the PC can let the bluetooth mobile devices connect to PC
>     and then
>      > involve in the program. I searched about sdptool.c, but it
>     doesn't help
>      > so much because I find no part that can really implement in my
>     program.
>      > Then I borrowed books about Bluetooth sdp, but I can't find any
>     method
>      > to write sdp C API. So, I wish to know that is there any
>     reference for
>      > me to write sdp C API? Or instead of sdptool.c, is there any file
>     that I
>      > can refer for SDP? Thank you very much.
>      > Michael
>      >
>      >
>      >
>     ------------------------------------------------------------------------
>      > Yahoo! 工具列 - 內置防止彈出視窗工能 ！
> 
> 
>     -------------------------------------------------------
>     SF email is sponsored by - The IT Product Guide
>     Read honest & candid reviews on hundreds of IT Products from real users.
>     Discover which products truly live up to the hype. Start reading now.
>     http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
>     _______________________________________________
>     Bluez-users mailing list
>     Bluez-users@lists.sourceforge.net
>     https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 
> ------------------------------------------------------------------------
> Yahoo! 工具列 - 內置防止彈出視窗工能 <http://hk.toolbar.yahoo.com>！


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
