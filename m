Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <1999a7e40608271848u75892dd0q251f973cfd2133b7@mail.gmail.com>
Date: Sun, 27 Aug 2006 22:48:09 -0300
From: "Dalmo Oliveira" <dalmo2004@gmail.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-devel] HCI host
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0639626840=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============0639626840==
Content-Type: multipart/alternative;
	boundary="----=_Part_170833_24256868.1156729689613"

------=_Part_170833_24256868.1156729689613
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>>>     Hi, i am in a group that is developing a bluetooth firmware (in C
>>> language). We are developing the hci host, baseband, lmp.

>is this an open project? What hardware are you using for the radio and
>the baseband?

>>>    I would like to test the hci host with bluez, to see if the packets
>>> that i am expecting are right. How can i use bluez to do this?

>If you have USB or UART as transport then you don't need anything
>special. If you only have the raw HCI packets, then you might wanna look
>at the hci_vhci kernel module which allows you to write a virtual
>Bluetooth adapter. The hciemu program for example is using it to emulate
>a HCI device.

>Regards

>Marcel

Hi Marcel, i would like to know if is possible to create a program in C that
receive HCI packet from bluez. Is it possible?

------=_Part_170833_24256868.1156729689613
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>&gt;&gt;&gt; &nbsp; &nbsp; Hi, i am in a group that is developing a bluetooth firmware (in C<br>&gt;&gt;&gt; language). We are developing the hci host, baseband, lmp.<br><br>&gt;is this an open project? What hardware are you using for the radio and
<br>&gt;the baseband?<br><br>&gt;&gt;&gt; &nbsp; &nbsp;I would like to test the hci host with bluez, to see if the packets<br>&gt;&gt;&gt; that i am expecting are right. How can i use bluez to do this?<br><br>&gt;If you have USB or UART as transport then you don't need anything
<br>&gt;special. If you only have the raw HCI packets, then you might wanna look<br>&gt;at the hci_vhci kernel module which allows you to write a virtual<br>&gt;Bluetooth adapter. The hciemu program for example is using it to emulate
<br>&gt;a HCI device.<br><br>&gt;Regards<br><br>&gt;Marcel</div>
<div>&nbsp;</div>
<div>Hi Marcel, i would like to know if is possible to create a program in C that receive HCI packet from bluez. Is it possible?</div>
<div>&nbsp;</div>
<div><br>&nbsp;</div>

------=_Part_170833_24256868.1156729689613--


--===============0639626840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0639626840==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0639626840==--
