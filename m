Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050228052232.66579.qmail@web60902.mail.yahoo.com>
From: Ka Kin Cheung <michaelhku2002@yahoo.com.hk>
Subject: Re: [Bluez-users] Re: sdp problem
To: bluez-users@lists.sourceforge.net
In-Reply-To: <20050228042032.GB5210@snoopy.src.ricoh.co.jp>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-699969925-1109568152=:64845"
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
Date: Mon, 28 Feb 2005 13:22:32 +0800 (CST)

--0-699969925-1109568152=:64845
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit

Hi Alain,
    Thanks for your comment. But I have questions about headset/handsfree part. You said that I can directly use RFCOMM socket i.e. use the functions socket(), bind(), listen() and accept(). But when I implemented in my program and then run it, there isn't anything that I can see. Then I asked my project's tutor, and he said that SDP is needed. Then I tried to add SDP services in my Linux PC, but the strange thing is, the T610 cannot show "synchronisation" in the "My device" list's "service list" so that even though I can add my Linux PC in my "handsfree device" list, the T610 cannot connect to the PC by showing "Nluetooth connection failed". So, what can I do for SDP? And how the program for the phone and even other mobile devices can be listened in a specific channel can be written? Is there any example code for it? I provide the information here so that you can know what I mean and I can do.
Channel for connecting T610: 1
code for sdp implemented into my program: 
system("sdptool add SAP");
sdp_main(argc, argv); //sdp_main is the main function in sdptool.c
                                //and I modified it for implementing in my main program
    I do hope that you can help me according to my provided information.
Michael


Alain Volmat <avolmat@src.ricoh.co.jp> wrote:
Hi Michael,

as Luis wrote you need to write a little program which listen as a specific
(protocol/channel).

As far as file transfer/object push, I think both are located on the top
of the OBEX layer what you should do is to play a bit with openobex.

As far as headset/handsfree are concerned, it needs SCO and AT commands
directly on the top of RFCOMM (if I remember correctly), so for handling
of AT commands, you can directly use RFCOMM socket (socket,bind,listen,accept).

Regards,

Alain


* Ka Kin Cheung [Mon, 28 Feb 2005 at 12:06 +0800]

> Hi Soraberri!
> I wish to know how to implement the basic service profiles such as SIM Access, headset, handsfree, file transfer and Object Push so that the Linux PC can listen for the T610 client to connect to the PC? Thank you very much.
> Michael
> 
> soraberri <421246@posta.unizar.es> wrote:
> Hi,
> 
> Ka Kin Cheung wrote:
> > Hi!
> > The strange thing is here:
> > For Linux, when my phone searched for my PC, the PC can be found and 
> > then added in the "My device" list, but when I looked at "Service list", 
> > none service can be found. Then I opened Windows XP and the bluetooth 
> > dongle driver was installed in my PC. Then I press "update" key to 
> > update services, and I found headset, synchronisation, object push and 
> > file transfer in the "Service list" for my Windows PC. So, how can I do 
> > for sdp in my Linux PC as my project is done on Linux? Thank you very 
> > much for your kindness.
> > Michael
> 
> You can advertise standard services in Linux using 'sdptool add ...' but
> advertising is not the same as offering... To offer a real service, an
> application has to be implemented and listening for clients at the
> appropiate network protocols and ports. Maybe what it is happening in
> windows is that most basic profiles are already implemented and
> correctly advertised. With BlueZ you can also advertise them in order
> to be seen by a remote device, but they won't work until you don't
> implement them. I hope this helps.
> 
> regards,
> Luis
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
> 
> 
> 
> ---------------------------------
> Yahoo! 工具列 - 內置防止彈出視窗工能！



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_ide95&alloc_id396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users



---------------------------------
Yahoo! 工具列 - 內置防止彈出視窗工能！

--0-699969925-1109568152=:64845
Content-Type: text/html; charset=big5
Content-Transfer-Encoding: 8bit

<DIV>Hi Alain,</DIV>
<DIV>&nbsp;&nbsp;&nbsp; Thanks for your comment. But I have questions about headset/handsfree part. You said that I can directly use RFCOMM socket i.e. use the functions socket(), bind(), listen() and accept(). But when I implemented in my program and then run it, there isn't anything that I can see. Then I asked my project's tutor, and he said that SDP is needed. Then I tried to add SDP services in my Linux PC, but the strange thing is, the T610 cannot show "synchronisation" in the "My device" list's "service list" so that even though I can add my Linux PC in my "handsfree device" list, the T610 cannot connect to the PC by showing "Nluetooth connection failed". So, what can I do for SDP? And how the program for the phone and even other mobile devices can be listened in a specific channel can be written? Is there any example code for it? I provide the information here so that you can know what I mean and I can do.</DIV>
<DIV>Channel for connecting T610: 1</DIV>
<DIV>code for sdp implemented into my program: </DIV>
<DIV>system("sdptool add SAP");</DIV>
<DIV><FONT size=2>sdp_main(argc, argv); //sdp_main is the main function in sdptool.c</FONT></DIV>
<DIV><FONT size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; //and I modified it for implementing in my main program</FONT></DIV>
<DIV>&nbsp;&nbsp;&nbsp; I do hope that you can help me according to my provided information.</DIV>
<DIV>Michael<FONT size=2></DIV>
<DIV></FONT><BR><BR><B><I>Alain Volmat &lt;avolmat@src.ricoh.co.jp&gt;</I></B> wrote:</DIV>
<BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Hi Michael,<BR><BR>as Luis wrote you need to write a little program which listen as a specific<BR>(protocol/channel).<BR><BR>As far as file transfer/object push, I think both are located on the top<BR>of the OBEX layer what you should do is to play a bit with openobex.<BR><BR>As far as headset/handsfree are concerned, it needs SCO and AT commands<BR>directly on the top of RFCOMM (if I remember correctly), so for handling<BR>of AT commands, you can directly use RFCOMM socket (socket,bind,listen,accept).<BR><BR>Regards,<BR><BR>Alain<BR><BR><BR>* Ka Kin Cheung [Mon, 28 Feb 2005 at 12:06 +0800]<BR><QUOTE><BR>&gt; Hi Soraberri!<BR>&gt; I wish to know how to implement the basic service profiles such as SIM Access, headset, handsfree, file transfer and Object Push so that the Linux PC can listen for the T610 client to connect to the PC? Thank you very much.<BR>&gt; Michael<BR>&gt; <B
 R>&gt;
 soraberri &lt;421246@posta.unizar.es&gt; wrote:<BR>&gt; Hi,<BR>&gt; <BR>&gt; Ka Kin Cheung wrote:<BR>&gt; &gt; Hi!<BR>&gt; &gt; The strange thing is here:<BR>&gt; &gt; For Linux, when my phone searched for my PC, the PC can be found and <BR>&gt; &gt; then added in the "My device" list, but when I looked at "Service list", <BR>&gt; &gt; none service can be found. Then I opened Windows XP and the bluetooth <BR>&gt; &gt; dongle driver was installed in my PC. Then I press "update" key to <BR>&gt; &gt; update services, and I found headset, synchronisation, object push and <BR>&gt; &gt; file transfer in the "Service list" for my Windows PC. So, how can I do <BR>&gt; &gt; for sdp in my Linux PC as my project is done on Linux? Thank you very <BR>&gt; &gt; much for your kindness.<BR>&gt; &gt; Michael<BR>&gt; <BR>&gt; You can advertise standard services in Linux using 'sdptool add ...' but<BR>&gt; advertising is not the same as offering... To offer a real service, an<BR>&gt; applicati
 on has
 to be implemented and listening for clients at the<BR>&gt; appropiate network protocols and ports. Maybe what it is happening in<BR>&gt; windows is that most basic profiles are already implemented and<BR>&gt; correctly advertised. With BlueZ you can also advertise them in order<BR>&gt; to be seen by a remote device, but they won't work until you don't<BR>&gt; implement them. I hope this helps.<BR>&gt; <BR>&gt; regards,<BR>&gt; Luis<BR>&gt; <BR>&gt; <BR>&gt; <BR>&gt; -------------------------------------------------------<BR>&gt; SF email is sponsored by - The IT Product Guide<BR>&gt; Read honest &amp; candid reviews on hundreds of IT Products from real users.<BR>&gt; Discover which products truly live up to the hype. Start reading now.<BR>&gt; http://ads.osdn.com/?ad_id=6595&amp;alloc_id=14396&amp;op=click<BR>&gt; _______________________________________________<BR>&gt; Bluez-users mailing list<BR>&gt; Bluez-users@lists.sourceforge.net<BR>&gt;
 https://lists.sourceforge.net/lists/listinfo/bluez-users<BR>&gt; <BR>&gt; <BR>&gt; <BR>&gt; ---------------------------------<BR>&gt; Yahoo! 工具列 - 內置防止彈出視窗工能！<BR></QUOTE><BR><BR><BR>-------------------------------------------------------<BR>SF email is sponsored by - The IT Product Guide<BR>Read honest &amp; candid reviews on hundreds of IT Products from real users.<BR>Discover which products truly live up to the hype. Start reading now.<BR>http://ads.osdn.com/?ad_ide95&amp;alloc_id396&amp;op=click<BR>_______________________________________________<BR>Bluez-users mailing list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR></BLOCKQUOTE><p><br><hr size=1>Yahoo! 工具列 - <a href=http://hk.toolbar.yahoo.com>內置防止彈出視窗工能</a>！<br>
--0-699969925-1109568152=:64845--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
