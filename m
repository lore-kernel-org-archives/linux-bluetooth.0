Return-Path: <cyrus@holtmann.org>
Date: Sun, 9 Mar 2008 06:27:25 -0700 (PDT)
From: binta sidibe <sidibebinta@yahoo.com>
Reply-To: sidibebinta@yahoo.com
Subject: Re: SDP discovery not working
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>,
  bintasidibeh@hotmail.com
In-Reply-To: <611B2C34-999E-411F-802F-95867D6E9DA0@holtmann.org>
MIME-Version: 1.0
Content-Type: text/html; charset=us-ascii
Message-ID: <167025.31999.qm@web57405.mail.re1.yahoo.com>
List-ID: <bluez-users.lists.sourceforge.net>

<table cellspacing='0' cellpadding='0' border='0' ><tr><td style='font: inherit;'><P><A href="mailto:root@ts7000:root">root@ts7000:root</A># modprobe rfcomm<BR><A href="mailto:root@ts7000:root">root@ts7000:root</A># modprobe l2cap<BR><A href="mailto:root@ts7000:root">root@ts7000:root</A># modprobe bluez<BR><A href="mailto:root@ts7000:root">root@ts7000:root</A># hciconfig hci0 up<BR><A href="mailto:root@ts7000:root">root@ts7000:root</A># hciconfig<BR>hci0:&nbsp;&nbsp; Type: USB<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: XX:XX:XX:XX:86:8A ACL MTU: 384:8&nbsp; SCO MTU: 64:8<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:69 acl:0 sco:0 events:8 errors:0<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:27 acl:0 sco:0 commands:7 errors:0</P>
<P><A href="mailto:root@ts7000:root">root@ts7000:root</A># sdptool browse local<BR>Failed to connect to SDP server on FF:FF:FF:00:00:00: No such file or directory<BR></P>
<P>&nbsp;</P>
<P>that failed also. For the application that i am writing, only my client will be connecting to my server so i do not need the services advertised to other clients. Since rfcomm transport protocol has 30 channels, can i have my server listening to more than one channel at a time (a channel&nbsp;for each service offered) &nbsp;and then hardcode those channels in the client code so that my client can connect to the server based on the service it needs?</P>
<P>Thanks Binta<BR>--- On <B>Fri, 3/7/08, Marcel Holtmann <I>&lt;marcel@holtmann.org&gt;</I></B> wrote:<BR></P>
<BLOCKQUOTE style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: rgb(16,16,255) 2px solid">From: Marcel Holtmann &lt;marcel@holtmann.org&gt;<BR>Subject: Re: SDP discovery not working<BR>To: sidibebinta@yahoo.com<BR>Cc: "bluez-users@lists.sourceforge.net" &lt;bluez-users@lists.sourceforge.net&gt;, bintasidibeh@hotmail.com<BR>Date: Friday, March 7, 2008, 11:38 AM<BR><BR><PRE>Hi,

&gt; i need help with my bluetooth project. i have two boards TS7300 and  
&gt; i have attached Dlink DT-120 on both. For my project, one is the  
&gt; server and the other is the client. i want to have sevices offered  
&gt; by my server so that my client can just connect to my servers SDP  
&gt; server to get the port numbers. When i hard code the port number i  
&gt; am using, my client can send message to my service...good. Now i  
&gt; went a step ahead and tried to register a service on my server but  
&gt; it fails to connect to local sdp server.
&gt;

you have to use "sdptool browse local" for that.

Regards

Marcel</PRE></BLOCKQUOTE></td></tr></table><br>

      <hr size=1>Never miss a thing.  <a href="http://us.rd.yahoo.com/evt=51438/*http://www.yahoo.com/r/hs"> Make Yahoo your homepage.</a>
