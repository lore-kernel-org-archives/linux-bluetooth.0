Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050226132251.53743.qmail@web60904.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
Subject: Re: [Bluez-users] sdp problem
To: bluez-users@lists.sourceforge.net
In-Reply-To: <421C9D77.7040606@gmx.ch>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1897401739-1109424171=:53255"
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
Date: Sat, 26 Feb 2005 21:22:51 +0800 (CST)

--0-1897401739-1109424171=:53255
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Hi all!
    I've waited for the reply on my question in these few days, but I can't see any reply about it. But today I found something about SDP, and hope that it may be help for my project.
   The good news is as follows: I can connect my T610 to my home's Windows PC by adding "Handsfree device" and then connect it. But the connection period is very short, with about 3-5 seconds as I don't have any other operation for T610. So, I wish to know how can I do so that the connection period will be longer and disconnect by myself?
   But the bad news is: I can't find HF (Handsfree) service in my home's Linux PC. The configuration of BlueZ in my Linux PC is the most updated version. The list follow is the libaries and tools that I've installed:
bluez-utils-2.15
bluez-libs-2.15
bluez-pan-1.1-1.i386.rpm
bluez-sdp-1.5-1.i386.rpm
bluez-hcidump-1.18
bluez-firmware-1.0
   Let's see if the above installations are correct. If so, why can't I find the HF service in "sdptool --help" in my home's PC, but can in my Lab's PC? 
   By the way, I've my thought about SDP and socket programming in my main program. I think that in order to accept connection from T610 and then iPAQ to Linux PC, the sequence should be follows: add_service()-->bind()-->listen()-->accept()-->the parts that I've done before. Am I right? Please give evaluation here. It is noted that it is not only the programming question, but also a question for Bluetooth connection from outside devices to Linux PC as the reference books stated about sdp and socket programming are not so clear together.
   Thank you very much.
Michael



---------------------------------
Yahoo! 工具列 - 內置防止彈出視窗工能！

--0-1897401739-1109424171=:53255
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

<DIV>Hi all!</DIV>
<DIV>&nbsp;&nbsp;&nbsp; I've waited for the reply on my question in these few days, but I can't see any reply about it. But today I found something about SDP, and hope that it may be help for my project.</DIV>
<DIV>&nbsp;&nbsp;&nbsp;The good news is as follows: I can connect my T610 to my home's Windows PC by adding "Handsfree device" and then connect it. But the connection period is very short, with about 3-5 seconds as I don't have any other operation for T610. So, I wish to know how can I do so that the connection period will be longer and disconnect by myself?</DIV>
<DIV>&nbsp;&nbsp; But the bad news is: I can't find HF (Handsfree) service in my home's Linux PC. The configuration of BlueZ in my Linux PC is the most updated version. The list follow is the libaries and tools that I've installed:</DIV>
<DIV>bluez-utils-2.15</DIV>
<DIV>bluez-libs-2.15</DIV>
<DIV>bluez-pan-1.1-1.i386.rpm</DIV>
<DIV>bluez-sdp-1.5-1.i386.rpm</DIV>
<DIV>bluez-hcidump-1.18</DIV>
<DIV>bluez-firmware-1.0</DIV>
<DIV>&nbsp;&nbsp; Let's see if the above installations are correct. If so, why can't I find the HF service in "sdptool --help" in my home's PC, but&nbsp;can in my Lab's PC? </DIV>
<DIV>&nbsp;&nbsp; By the way, I've my thought about SDP and socket programming in my main program. I think that in order to accept connection from T610 and then&nbsp;iPAQ to Linux PC, the sequence should be follows: add_service()--&gt;bind()--&gt;listen()--&gt;accept()--&gt;the parts that I've done before. Am I right? Please give evaluation here. It is noted that it is not only the programming question, but also a question for Bluetooth connection from outside devices to Linux PC as the reference books stated about sdp and socket programming are not so clear together.</DIV>
<DIV>&nbsp;&nbsp; Thank you very much.</DIV>
<DIV>Michael</DIV><p><br><hr size=1>Yahoo! 工具列 - <a href=http://hk.toolbar.yahoo.com>內置防止彈出視窗工能</a>！<br>
--0-1897401739-1109424171=:53255--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
