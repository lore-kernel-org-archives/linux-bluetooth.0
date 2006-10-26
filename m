Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <20061026053406.20806.qmail@web52008.mail.yahoo.com>
Date: Wed, 25 Oct 2006 22:34:06 -0700 (PDT)
From: anoop <ee02m043@yahoo.com>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <77ADC7D0C96B1F44A924DC4E952A5E0E01120781@AZ25EXM01.gddsi.com>
MIME-Version: 1.0
Subject: Re: [Bluez-users] Bluez/bluetooth newbie
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1016574004=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1016574004==
Content-Type: multipart/alternative; boundary="0-1422231224-1161840846=:19938"
Content-Transfer-Encoding: 8bit

--0-1422231224-1161840846=:19938
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

Hi Scott,
   
  I am also in the search for  such a library.
  Can you point me to this?.
   
  Anoop

"Turley, Scott-P27856" <Scott.Turley@gdc4s.com> wrote:
  Doing a little more investigation, I found a library that sends/receives
data over a socket connection using rfcomm. 

However, if I use the client side of this library, doing a connect to
another bluetooth device that implements the Serial Port Profile, it
works beautifully, I'm able to send data that gets displayed on the
windows side hyperterminal.

When I try to run the server side library on the Linux machine, and
attempt to make a connection over the hyperterminal, I get an error
message: "Connection attempt failed because the remote device does not
support the Serial Port Profile".

How do I get a listener on a Linux host to accept serial port profile
connections?

-Scott

-----Original Message-----
From: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Thursday, October 19, 2006 9:30 PM
To: BlueZ users
Subject: Re: [Bluez-users] Bluez/bluetooth newbie

Hi Scott,

> I'm trying to do something really simple in the bluetooth environment.
> I attached a USB bluetooth module (from A7 engineering) to a Linx PC, 
> and I attached a serial module to a windows PC. This serial module 
> has the complete stack, and I just interface to it with ASCII commands

> over a serial port profile. I want to simply send ASCII text across a

> bluetooth serial connection between the two computers.
> 
> I have been able to do this successfully with a windows host. Here 
> are the steps I'm taking:
> 
> * On the Windows side, I connect to the serial bluetooth module,
> configure the baud rate to 9600, no HW flow control, etc.
> * On the Linux side I start the hcid and sdpd services.
> * Then I search for the remote bluetooth device using "hcitool
> inq" and I see it.
> * I establish a connection using "hcitool cc ".

this step is not needed at all.

> * Finally I use rfcomm to make a serial connection: "rfcomm
> connect 0 1".

You might wanna use "rfcomm --raw connect 0 1".

> The windows side recognizes a connection is made, but I am unable to 
> get data across.
> 
> I have found no way to establish baud rate. Is that necessary across 
> bluetooth?

No. The baud rate is for the physical interface of the module and not
the RFCOMM connection.

Regards

Marcel



------------------------------------------------------------------------
-
Using Tomcat but need to do more? Need to support web services,
security?
Get stuff done quickly with pre-integrated technology to make your job
easier Download IBM WebSphere Application Server v.1.0.1 based on Apache
Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


 		
---------------------------------
Stay in the know. Pulse on the new Yahoo.com.  Check it out. 
--0-1422231224-1161840846=:19938
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: 8bit

<div>Hi Scott,</div>  <div>&nbsp;</div>  <div>I am also in the&nbsp;search for&nbsp; such a library.</div>  <div>Can you point me to this?.</div>  <div>&nbsp;</div>  <div>Anoop<BR><BR><B><I>"Turley, Scott-P27856" &lt;Scott.Turley@gdc4s.com&gt;</I></B> wrote:</div>  <BLOCKQUOTE class=replbq style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px solid">Doing a little more investigation, I found a library that sends/receives<BR>data over a socket connection using rfcomm. <BR><BR>However, if I use the client side of this library, doing a connect to<BR>another bluetooth device that implements the Serial Port Profile, it<BR>works beautifully, I'm able to send data that gets displayed on the<BR>windows side hyperterminal.<BR><BR>When I try to run the server side library on the Linux machine, and<BR>attempt to make a connection over the hyperterminal, I get an error<BR>message: "Connection attempt failed because the remote device does not<BR>support the Serial Port
 Profile".<BR><BR>How do I get a listener on a Linux host to accept serial port profile<BR>connections?<BR><BR>-Scott<BR><BR>-----Original Message-----<BR>From: bluez-users-bounces@lists.sourceforge.net<BR>[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Marcel<BR>Holtmann<BR>Sent: Thursday, October 19, 2006 9:30 PM<BR>To: BlueZ users<BR>Subject: Re: [Bluez-users] Bluez/bluetooth newbie<BR><BR>Hi Scott,<BR><BR>&gt; I'm trying to do something really simple in the bluetooth environment.<BR>&gt; I attached a USB bluetooth module (from A7 engineering) to a Linx PC, <BR>&gt; and I attached a serial module to a windows PC. This serial module <BR>&gt; has the complete stack, and I just interface to it with ASCII commands<BR><BR>&gt; over a serial port profile. I want to simply send ASCII text across a<BR><BR>&gt; bluetooth serial connection between the two computers.<BR>&gt; <BR>&gt; I have been able to do this successfully with a windows host. Here <BR>&gt; are the
 steps I'm taking:<BR>&gt; <BR>&gt; * On the Windows side, I connect to the serial bluetooth module,<BR>&gt; configure the baud rate to 9600, no HW flow control, etc.<BR>&gt; * On the Linux side I start the hcid and sdpd services.<BR>&gt; * Then I search for the remote bluetooth device using "hcitool<BR>&gt; inq" and I see it.<BR>&gt; * I establish a connection using "hcitool cc <BT address>".<BR><BR>this step is not needed at all.<BR><BR>&gt; * Finally I use rfcomm to make a serial connection: "rfcomm<BR>&gt; connect 0 <BT address>1".<BR><BR>You might wanna use "rfcomm --raw connect 0 <BDADDR>1".<BR><BR>&gt; The windows side recognizes a connection is made, but I am unable to <BR>&gt; get data across.<BR>&gt; <BR>&gt; I have found no way to establish baud rate. Is that necessary across <BR>&gt; bluetooth?<BR><BR>No. The baud rate is for the physical interface of the module and not<BR>the RFCOMM
 connection.<BR><BR>Regards<BR><BR>Marcel<BR><BR><BR><BR>------------------------------------------------------------------------<BR>-<BR>Using Tomcat but need to do more? Need to support web services,<BR>security?<BR>Get stuff done quickly with pre-integrated technology to make your job<BR>easier Download IBM WebSphere Application Server v.1.0.1 based on Apache<BR>Geronimo<BR>http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642<BR>_______________________________________________<BR>Bluez-users mailing list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR><BR>-------------------------------------------------------------------------<BR>Using Tomcat but need to do more? Need to support web services, security?<BR>Get stuff done quickly with pre-integrated technology to make your job easier<BR>Download IBM WebSphere Application Server v.1.0.1 based on Apache
 Geronimo<BR>http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642<BR>_______________________________________________<BR>Bluez-users mailing list<BR>Bluez-users@lists.sourceforge.net<BR>https://lists.sourceforge.net/lists/listinfo/bluez-users<BR></BLOCKQUOTE><BR><p>&#32;
		<hr size=1>Stay in the know. Pulse on the new Yahoo.com. <a href="http://us.rd.yahoo.com/evt=42974/*http://www.yahoo.com/preview"> Check it out.</a> 

--0-1422231224-1161840846=:19938--


--===============1016574004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1016574004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1016574004==--
