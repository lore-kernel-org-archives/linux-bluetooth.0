Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <14397664050321031963ce0576@mail.gmail.com>
From: maha k <maha.cedt@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Help for cross compilation of BlueZ
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
Date: Mon, 21 Mar 2005 16:49:52 +0530

 Hi,
>I have to add bluetooth functionality to my MIPS based hardware
> platform. Hardware has montavista linux kernel 2.4.20 without rfcomm
> and bnep support. I need help regarding compilation of rfcomm,bnep and
> BlueZ. For cross compilation whether i have to use cross compilers or
> native gcc which is available in file system?
>I am not the right person to ask about cross-compiling stuff, but I
>think you need to rebuild your whole kernel. Apply patch-2.4.20-mh18 to
>get RFCOMM and BNEP support. However be aware of that most of the fixes
>and future enhancements are only present in the 2.6 kernel series.

I am able to add RFCOMM support. Giving problem for BNEP and HIDP support.
I can't upgrade kernel version since it is a montavista custom linux
kernel for specific board.
Can any one help me out in cross compilation of BlueZ utils and libs
for MIPS flatform?
Regards
-- 
Maha


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
