Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050322150335.73224.qmail@web60910.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Subject: [Bluez-users] connect T610 to PC problem
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
Date: Tue, 22 Mar 2005 23:03:35 +0800 (CST)

Hi all!
    I can connect T610 from PC successfully! The key
point is: you have to set the same channel of SDP and
rfcomm, and set the class in hciconfig as 0x200404
i.e. headset. Then after typing "rfcomm listen 0
<channel>", the phone can connect to Pc successfully.
But then, I face a new problem. When I put the socket
programming part in my main program, after I
successfully connect T610 to the PC, it showed
"dev/rfcomm0: no such device". Why is that?
    Then I looked at rfcomm/main.c, and put the
cmd_listen part in my main program, but after that,
when I tried to connect T610 to PC, the T610 always
showed "Bluetooth connection failed". Why is that?
Please give any suggestion about it. If neccessary,
any user can ask me to send my programs to you to have
a look. Thank you very much for your kindness.
Michael 

_______________________________________________________________________
Yahoo! 工具列 - 內置防止彈出視窗工能！
http://toolbar.yahoo.com.hk


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
