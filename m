Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050228060454.2107.qmail@web60910.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
Subject: Re: [Bluez-users] Re: sdp problem
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050228054041.GG5210@snoopy.src.ricoh.co.jp>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-942176916-1109570694=:99794"
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
Date: Mon, 28 Feb 2005 14:04:54 +0800 (CST)

--0-942176916-1109570694=:99794
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Hi Alain,
    Actually, I've tried to do for "sdptool add <service>", and it was success. But what I found disappointing is I cannot find any service in the "sdptool --help" that the T610 can show "synchronization" in the "service list". So, even thoguh I could add "system(...)" syntax followed by "sdp_main()" and then "socket()", "listen()", "bind()" and then "accept()" functions, I still can't see any desired results. So, my question now becomes "how can I link the SDP setting and socket programming of the server together so that the SDP service can be added in my Linux PC followed by waiting the devices, especially T610, and then accept the connections?" Thank you very much.
Michael
Alain Volmat <avolmat@src.ricoh.co.jp> wrote:
Hi Michael,

I'm not sure to understand all your saying but, I'll try to describe you
what I think should be done. (I don't think I'm the first one to tell you 
that but ... still).

Saying simply, you need two thing, a little program which listen to a 
specific RFCOMM channel (lets say channel 1). This part, you have to 
write it by yourself using rfcomm socket interface (or tty interface
if that's enough for you to test). So now that you have your program
listen on RFCOMM channel 1, you need to advertise this new service you
are providing. This is done by using SDP.
If you don't do that, nobody (for example your phone) will know that
you have a program listening the channel 1 of RFCOMM.

So you need to register a new SDP service, by either including
some code in your program (based for example on sdptool) or 
if it's enough for testing, you can use the sdptool command line.
One parameter when registering a new service is the RFCOMM channel
(well, in case of HS or HF) is the channel.
you can try the command: sdptool add
this shows you the command line to add a new service, allowing
you to set the channel. If here you say that your HF service is
one channel 1, I guess your phone should be happy with that and should
let you connect to the PC....

Alain


---------------------------------
Yahoo! 工具列 - 內置防止彈出視窗工能！

--0-942176916-1109570694=:99794
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

<DIV>Hi Alain,</DIV>
<DIV>&nbsp;&nbsp;&nbsp; Actually, I've tried to do for "sdptool add &lt;service&gt;", and it was success. But what I found disappointing is I cannot find any service in the "sdptool --help" that the T610 can show "synchronization" in the "service list". So, even thoguh I could add "system(...)" syntax followed by "sdp_main()" and then "socket()", "listen()", "bind()" and then "accept()" functions, I still can't see any desired results. So, my question now becomes "how can I link the SDP setting and socket programming of the server together so that the SDP service can be added in my Linux PC followed by waiting the devices, especially T610, and then accept the connections?" Thank you very much.</DIV>
<DIV>Michael<BR><B><I>Alain Volmat &lt;avolmat@src.ricoh.co.jp&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hi Michael,<BR><BR>I'm not sure to understand all your saying but, I'll try to describe you<BR>what I think should be done. (I don't think I'm the first one to tell you <BR>that but ... still).<BR><BR>Saying simply, you need two thing, a little program which listen to a <BR>specific RFCOMM channel (lets say channel 1). This part, you have to <BR>write it by yourself using rfcomm socket interface (or tty interface<BR>if that's enough for you to test). So now that you have your program<BR>listen on RFCOMM channel 1, you need to advertise this new service you<BR>are providing. This is done by using SDP.<BR>If you don't do that, nobody (for example your phone) will know that<BR>you have a program listening the channel 1 of RFCOMM.<BR><BR>So you need to register a new SDP service, by either including<BR>some code in your program (based for example on sdptool) or <BR>if it's enough 
 for
 testing, you can use the sdptool command line.<BR>One parameter when registering a new service is the RFCOMM channel<BR>(well, in case of HS or HF) is the channel.<BR>you can try the command: sdptool add<BR>this shows you the command line to add a new service, allowing<BR>you to set the channel. If here you say that your HF service is<BR>one channel 1, I guess your phone should be happy with that and should<BR>let you connect to the PC....<BR><BR>Alain</BLOCKQUOTE><p><br><hr size=1>Yahoo! 工具列 - <a href=http://hk.toolbar.yahoo.com>內置防止彈出視窗工能</a>！<br>
--0-942176916-1109570694=:99794--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
