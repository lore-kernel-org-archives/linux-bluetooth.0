Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
Message-ID: <OFFB852EAA.3DE1580F-ON87256E36.00730EA0-86256E36.00738AB6@us.ibm.com>
From: Torez Smith <torez@us.ibm.com>
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=08BBE4A5DFE088308f9e8a93df938690918c08BBE4A5DFE08830"
Subject: [Bluez-devel] usb to serial verification
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 10 Feb 2004 15:02:03 -0600

--0__=08BBE4A5DFE088308f9e8a93df938690918c08BBE4A5DFE08830
Content-type: text/plain; charset=US-ASCII





Hello,
is there a way to determine if your usb to serial profile is working?

I have a usb bluetooth dongle on one machine and a serial dongle
connected to comm1 on another machine. I am able to pair the two
dongles and have connected the usb dongle to  /dev/rfcomm0.

If expect that if I were to do ......   echo "hello world" > /dev/rfcomm0

I should see that on the second machine while cat'ting /dev/ttyS0.

No traffic comes across. The baud rate on the serial dongle is set
to 115200 which is the same baud rate used at /dev/ttyS0.

Any clues on how I might be able to echo into /dev/rfcomm0 and
be able to read the information through /dev/ttyS0?

thanks!
--0__=08BBE4A5DFE088308f9e8a93df938690918c08BBE4A5DFE08830
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p>Hello,<br>
is there a way to determine if your usb to serial profile is working?<br>
<br>
I have a usb bluetooth dongle on one machine and a serial dongle<br>
connected to comm1 on another machine. I am able to pair the two<br>
dongles and have connected the usb dongle to  /dev/rfcomm0.<br>
<br>
If expect that if I were to do ......   echo &quot;hello world&quot; &gt; /dev/rfcomm0<br>
<br>
I should see that on the second machine while cat'ting /dev/ttyS0.<br>
<br>
No traffic comes across. The baud rate on the serial dongle is set<br>
to 115200 which is the same baud rate used at /dev/ttyS0.<br>
<br>
Any clues on how I might be able to echo into /dev/rfcomm0 and<br>
be able to read the information through /dev/ttyS0?<br>
<br>
thanks!</body></html>
--0__=08BBE4A5DFE088308f9e8a93df938690918c08BBE4A5DFE08830--



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
