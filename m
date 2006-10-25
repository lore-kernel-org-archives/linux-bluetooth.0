Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Wed, 25 Oct 2006 15:47:26 -0700
Message-ID: <77ADC7D0C96B1F44A924DC4E952A5E0E01120781@AZ25EXM01.gddsi.com>
In-Reply-To: <1161318583.27585.24.camel@localhost>
From: "Turley, Scott-P27856" <Scott.Turley@gdc4s.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
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
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Doing a little more investigation, I found a library that sends/receives
data over a socket connection using rfcomm.  

However, if I use the client side of this library, doing a connect to
another bluetooth device that implements the Serial Port Profile, it
works beautifully, I'm able to send data that gets displayed on the
windows side hyperterminal.

When I try to run the server side library on the Linux machine, and
attempt to make a connection over the hyperterminal, I get an error
message:  "Connection attempt failed because the remote device does not
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
> and I attached a serial module to a windows PC.  This serial module 
> has the complete stack, and I just interface to it with ASCII commands

> over a serial port profile.  I want to simply send ASCII text across a

> bluetooth serial connection between the two computers.
> 
> I have been able to do this successfully with a windows host.  Here 
> are the steps I'm taking:
> 
>       * On the Windows side, I connect to the serial bluetooth module,
>         configure the baud rate to 9600, no HW flow control, etc.
>       * On the Linux side I start the hcid and sdpd services.
>       * Then I search for the remote bluetooth device using "hcitool
>         inq" and I see it.
>       * I establish a connection using "hcitool cc <bt address>".

this step is not needed at all.

>       * Finally I use rfcomm to make a serial connection:  "rfcomm
>         connect 0 <bt address> 1".

You might wanna use "rfcomm --raw connect 0 <bdaddr> 1".

> The windows side recognizes a connection is made, but I am unable to 
> get data across.
> 
> I have found no way to establish baud rate.  Is that necessary across 
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
