Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050304091649.92513.qmail@web60910.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Subject: [Bluez-users] Adding SDP profiles
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
Date: Fri, 4 Mar 2005 17:16:48 +0800 (CST)

Hi all!
    Now I got the way to do for connecting T610 to
Linux PC. It is to add SDP profile for headset into a
program including main function in sdptool.c. But I
don't have any idea of how to do it i.e. add the
profile. So, can anyone tell me how I can add the
profile? Here is the information when I typed "sdptool
browse" for T610.
Service Name: Voice gateway
Service RecHandle: 0x10002
Service Class ID List:
  "Headset Audio Gateway" (0x1112)
  "Generic Audio" (0x1203)
Protocol Descriptor List:
  "L2CAP" (0x0100)
  "RFCOMM" (0x0003)
    Channel: 3
Profile Descriptor List:
  "Headset" (0x1108)
    Version: 0x0100



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
