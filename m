Return-Path: <ramon@us.ibm.com>
To: marcel@holtmann.org, bluez-users@lists.sourceforge.net
Cc: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: Can't Connect RFCOMM Socket. Too many links.
From: Ramon A Reveron <ramon@us.ibm.com>
Message-ID: <OF0E2A126C.4B39339D-ON85256EE7.00754A22-85256EE7.0076A7D2@us.ibm.com>
Date: Wed, 4 Aug 2004 17:36:03 -0400
Content-Type: multipart/alternative; boundary="=_alternative 0076A44C85256EE7_="
List-ID: <bluez-users.lists.sourceforge.net>

This is a multipart message in MIME format.
--=_alternative 0076A44C85256EE7_=
Content-Type: text/plain; charset="US-ASCII"

Hello There,

I'm having some problems while connecting to a serial profile device. If I 
connect to a device using:

rfcomm connect 0 "device address" 1

the connection works perfectly. If by some reason the device disconnects 
(i.e. out of range), I need to wait around 50 seconds to reconnect to it 
providing that it is back in range. 
If i try before the 50 seconds have pass, I get this error: "Can't Connect 
RFCOMM Socket. Too many links." 

Is this a normal behavior?

Is there a way of connecting to the device as soon as it comes back in 
range? 

How can you specify a "Link Timeout" with BlueZ? 



Thanks for your time and help!



Kernel: 2.4.19
BlueZ utils 2.3

Best Regards,
Ramon
--=_alternative 0076A44C85256EE7_=
Content-Type: text/html; charset="US-ASCII"


<br><font size=2 face="sans-serif">Hello There,</font>
<br>
<br><font size=2 face="sans-serif">I'm having some problems while connecting
to a serial profile device. If I connect to a device using:</font>
<br>
<br><font size=2 face="sans-serif">rfcomm connect 0 &quot;device address&quot;
1</font>
<br>
<br><font size=2 face="sans-serif">the connection works perfectly. If by
some reason the device disconnects &nbsp;(i.e. out of range), I need to
wait around 50 seconds to reconnect to it providing that it is back in
range. </font>
<br><font size=2 face="sans-serif">If i try before the 50 seconds have
pass, I get this error: &quot;Can't Connect RFCOMM Socket. Too many links.&quot;
</font>
<br>
<br><font size=2 face="sans-serif">Is this a normal behavior?</font>
<br>
<br><font size=2 face="sans-serif">Is there a way of connecting to the
device as soon as it comes back in range? &nbsp;</font>
<br>
<br><font size=2 face="sans-serif">How can you specify a &quot;Link Timeout&quot;
with BlueZ? </font>
<br>
<br>
<br>
<br><font size=2 face="sans-serif">Thanks for your time and help!</font>
<br>
<br>
<br>
<br><font size=2 face="sans-serif">Kernel: 2.4.19</font>
<br><font size=2 face="sans-serif">BlueZ utils 2.3</font>
<br>
<br><font size=2 face="sans-serif">Best Regards,</font>
<br><font size=2 face="sans-serif">Ramon</font>
--=_alternative 0076A44C85256EE7_=--
