Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20060412155415.62433.qmail@web61214.mail.yahoo.com>
From: deva seetharam <tagsense@yahoo.com>
Subject: Re: [Bluez-users] bluetooth remote control
To: bluez-users@lists.sourceforge.net
In-Reply-To: <fe0a97c20604111925t14594fa3y76f2794dfa92fbfc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1742247089-1144857255=:60573"
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
Date: Wed, 12 Apr 2006 08:54:15 -0700 (PDT)

--0-1742247089-1144857255=:60573
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

thank you for the pointer. you can find the video at the following site:
 http://www.windowsfordevices.com/news/NS5107313610.html
 
 

Sowmya Gattupalli <sowmya.gattupalli@gmail.com> wrote: Hi
 well... there is this video by Anil Dhawan which actually implemented in windows CE os I guess... probably u can look into the video to know more... He used COM ports get it working.. just look at his video... may be it rings a bell... (just give Anil Dhawan + Bluetooth in Google)

On 4/12/06, deva seetharam <tagsense@yahoo.com > wrote:hello all,
 i am building bluetooth based handheld remote control devices.   
 
 background information
 ===============
 the remote control devices are based on LMX9820 (National Semiconductor's single-chip bluetooth modules).  when buttons are pressed, these devices send messages to an application running on a debian linux box. bluetooth connectivity is added to this linux box using D-Link DBT-120 bluetooth dongle. 
  
 attempted architectures
 ==============
 i tried to implement this system using the following architectures:
 
 1. RFCOMM server
 the linux box runs a bluetooth socket server on a particular channel. the remote control device connects to the server over the specific channel and sends messages. 
 
 problems encountered: multiple remotes can't connect to the same server.
 
 i see that the accept method (unlike tcp implementation) returns the server port upon accepting an incoming connection. for instance, if the server is listening on port 16, when any remote connects to the server, the server port 16 is used to establish end-to-end connection with the client. now, another device cannot connect to the same server until the first remote disconnects. this problem stops us from using multiple remotes with a single linux server.
 
 
 2. Serial port 
 set up one or more bluetooth serial ports and the remote control devices can send messages to anyone of them by randomly selecting one of those channels. 
 
 so i setup a port as listed by rfcomm show:
 rfcomm0: 00:0D:88:C0:61:55 channel 16 clean

 > sdptool add --channel=16 sp
    Serial Port service registered
 
 > rfcomm listen 0 16 
 Waiting for connection on channel 16
 
 i tried to connect to rfcomm0 from a *different* linux machine. 
 
 problems encountered: can't connect...
 
 >rfcomm connect 00:0D:88:C0:61:55 16
 Can't connect RFCOMM  socket: Host is down
 
 (although, when i do a l2ping, the second machine gets replies from the first). 
 
 Questions
 ======
 1. what would be the best architecture for implementing bluetooth remote control? 
 2. is it possible to configure the accept function to return connection specific ports?
 3. what do i need to get the bluetooth serial port working?
 
 pls. let me know.
 
 thanks in advance,
 dave
 
 
 
 
 
    

---------------------------------
Love cheap thrills? Enjoy PC-to-Phone   calls to 30+ countries for just 2¢/min with Yahoo! Messenger with Voice. 



 

		
---------------------------------
Talk is cheap. Use Yahoo! Messenger to make PC-to-Phone calls.  Great rates starting at 1&cent;/min.
--0-1742247089-1144857255=:60573
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

thank you for the pointer. you can find the video at the following site:<br> http://www.windowsfordevices.com/news/NS5107313610.html<br> <br> <br><br><b><i>Sowmya Gattupalli &lt;sowmya.gattupalli@gmail.com&gt;</i></b> wrote:<blockquote class="replbq" style="border-left: 2px solid rgb(16, 16, 255); margin-left: 5px; padding-left: 5px;"> Hi<br> well... there is this video by Anil Dhawan which actually implemented in windows CE os I guess... probably u can look into the video to know more... He used COM ports get it working.. just look at his video... may be it rings a bell... (just give Anil Dhawan + Bluetooth in Google)<br><br><div><span class="gmail_quote">On 4/12/06, <b class="gmail_sendername">deva seetharam</b> &lt;<a href="mailto:tagsense@yahoo.com">tagsense@yahoo.com </a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div style="direction: ltr;">hello all,<br> i am
 building bluetooth based handheld remote control devices.&nbsp;  <br> <br> background information<br> ===============<br> the remote control devices are based on LMX9820 (National Semiconductor's single-chip bluetooth modules).&nbsp; when buttons are pressed, these devices send messages to an application running on a debian linux box. bluetooth connectivity is added to this linux box using D-Link DBT-120 bluetooth dongle. <br>  <br> attempted architectures<br> ==============<br> i tried to implement this system using the following architectures:<br> <br> 1. RFCOMM server<br> the linux box runs a bluetooth socket server on a particular channel. the remote control device connects to the server over the specific channel and sends messages. <br> <br> problems encountered: multiple remotes can't connect to the same server.<br> <br> i see that the accept method (unlike tcp implementation) returns the server port upon accepting an incoming connection. for instance, if the server
 is listening on port 16, when any remote connects to the server, the server port 16 is used to establish end-to-end connection with the client. now, another device cannot connect to the same server until the first remote disconnects. this problem stops us from using multiple remotes with a single linux server.<br> <br> <br> 2. Serial port <br> set up one or more bluetooth serial ports and the remote control devices can send messages to anyone of them by randomly selecting one of those channels. <br> <br> so i setup a port as listed by rfcomm show:<br> rfcomm0: 00:0D:88:C0:61:55 channel 16 clean<br><br> &gt; sdptool add --channel=16 sp<br> &nbsp;&nbsp; Serial Port service registered<br> <br> &gt; rfcomm listen 0 16 <br> Waiting for connection on channel 16<br> <br> i tried to connect to rfcomm0 from a *different* linux machine. <br> <br> problems encountered: can't connect...<br> <br> &gt;rfcomm connect 00:0D:88:C0:61:55 16<br> Can't connect RFCOMM  socket: Host is down<br>
 <br> (although, when i do a l2ping, the second machine gets replies from the first). <br> <br> Questions<br> ======<br> 1. what would be the best architecture for implementing bluetooth remote control? <br> 2. is it possible to configure the accept function to return connection specific ports?<br> 3. what do i need to get the bluetooth serial port working?<br> <br> pls. let me know.<br> <br> thanks in advance,<br> dave<br> </div><div style="direction: ltr;"><span class="ad"> <br> <br> <br> <br> <div>   </div><hr size="1">Love cheap thrills? Enjoy PC-to-Phone <a href="http://us.rd.yahoo.com/mail_us/taglines/postman9/*http://us.rd.yahoo.com/evt=39666/*http://beta.messenger.yahoo.com/" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">  calls to 30+ countries</a> for just 2¢/min with Yahoo! Messenger with Voice. <div></div></span></div></blockquote></div><br> </blockquote><br><p>
		<hr size=1>Talk is cheap. Use Yahoo! Messenger to make PC-to-Phone calls. <a href="http://us.rd.yahoo.com/mail_us/taglines/postman7/*http://us.rd.yahoo.com/evt=39666/*http://beta.messenger.yahoo.com"> Great rates starting at 1&cent;/min.
--0-1742247089-1144857255=:60573--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
