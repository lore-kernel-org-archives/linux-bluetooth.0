Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <BAY104-F1261B7B9CB6D8EDED8F36CC1A30@phx.gbl>
In-Reply-To: <I92JZQ$4438CF5CD46EDB224256583706BE5074@libero.it>
From: "blookk -" <blookk@hotmail.com>
To: bluez-users@lists.sourceforge.net
Subject: RE: [Bluez-users] Piconet problems
Mime-Version: 1.0
Content-Type: text/html; charset=iso-8859-1; format=flowed
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
Date: Tue, 21 Dec 2004 20:21:44 +0000

<html><div style='background-color:'><DIV class=RTE>
<P>Hello.</P>
<P>I am with the same problem.<BR></P></DIV>
<DIV></DIV>
<DIV></DIV>
<DIV></DIV>&gt;I'm trying to create a simple piconet consisting of a master and two slaves. I'm using three Digicom Palladio
<DIV></DIV>&gt;dongles.
<DIV></DIV>&gt;My packages list is:
<DIV></DIV>&gt;&nbsp;&nbsp;- bluez-libs-2.8-1.i386.rpm
<DIV></DIV>&gt;&nbsp;&nbsp;- bluez-bluefw-1.0-1.i386.rpm
<DIV></DIV>&gt;&nbsp;&nbsp;- bluez-hcidump-1.10-1.i386.rpm
<DIV></DIV>&gt;&nbsp;&nbsp;- bluez-sdp-1.5-1.i386.rpm
<DIV></DIV>&gt;&nbsp;&nbsp;- bluez-pan-1.1-1.i386.rpm
<DIV></DIV>&gt;&nbsp;&nbsp;- bluez-utils-2.8-1.i386.rpm
<DIV></DIV>&gt;&nbsp;&nbsp;- bridge-utils-0.9.6-1.i386.rpm
<DIV></DIV>&gt;
<DIV></DIV>&gt;&nbsp;&nbsp;On master side I type:
<DIV></DIV>&gt;&nbsp;&nbsp;# hciconfig hci0 up
<DIV></DIV>&gt;&nbsp;&nbsp;# pand --listen --master --role GN
<DIV></DIV>&gt;
<DIV></DIV>&gt;&nbsp;&nbsp;On the first slave I type:
<DIV></DIV>&gt;&nbsp;&nbsp;# hciconfig hci0 up
<DIV></DIV>&gt;&nbsp;&nbsp;# hcitool inq
<DIV></DIV>&gt;&nbsp;&nbsp;# pand --connect &lt;master_bt_addr&gt;
<DIV></DIV>&gt;&nbsp;&nbsp;# ifconfig bnep0 10.10.10.2 broadcast 10.10.10.255 netmask 255.255.255.0
<DIV></DIV>&gt;
<DIV></DIV>&gt;&nbsp;&nbsp;if I type
<DIV></DIV>&gt;&nbsp;&nbsp;# hcitool inq
<DIV></DIV>&gt;&nbsp;&nbsp;I obtain:
<DIV></DIV>&gt;
<DIV></DIV>
<P>&gt;&nbsp;&nbsp;Inquiry failed.: Device or resource busy </P>
<P>In this point I don't have this problem&nbsp; "inquiry failed"</P>
<DIV></DIV>&gt;
<DIV></DIV>&gt;&nbsp;&nbsp;On the second slave I type:
<DIV></DIV>&gt;&nbsp;&nbsp;# hciconfig hci0 up
<DIV></DIV>&gt;&nbsp;&nbsp;# hcitool inq
<DIV></DIV>&gt;&nbsp;&nbsp;I only obtain the master bt_addr.
<DIV></DIV>
<P>&gt;&nbsp;&nbsp;# pand --connect &lt;master_bt_addr&gt; </P>
<P>In this point I obtain other devices bluetooth except the master bt_addr, and then i can´t create a network connection with this master.&nbsp; I can only have a master and a slave.</P>
<DIV></DIV>&gt;
<DIV></DIV>&gt;&nbsp;&nbsp;and
<DIV></DIV>&gt;&nbsp;&nbsp;# ifconfig bnep0 10.10.10.3 broadcast 10.10.10.255 netmask 255.255.255.0
<DIV></DIV>&gt;
<DIV></DIV>&gt;&nbsp;&nbsp;Unfortunally I obtain:
<DIV></DIV>&gt;
<DIV></DIV>&gt;&nbsp;&nbsp;SIOCSIFADDR: No such device
<DIV></DIV>&gt;&nbsp;&nbsp;bnep0: unknown interface: No such device
<DIV></DIV>&gt;&nbsp;&nbsp;SIOCSIFBRDADDR: No such device
<DIV></DIV>&gt;&nbsp;&nbsp;bnep0: unknown interface: No such device
<DIV></DIV>&gt;&nbsp;&nbsp;SIOCSIFNETMASK: No such device
<DIV></DIV>&gt;
<DIV></DIV>&gt;&nbsp;&nbsp;Can someone tell me what is wrong? Thanks.
<DIV></DIV>&gt;&nbsp;&nbsp;Jers
<DIV></DIV>&gt;
<DIV></DIV>&gt;
<DIV></DIV>
<DIV>&nbsp;</DIV>
<DIV>I don't know if i help you.</DIV>
<DIV>&nbsp;</DIV>
<DIV>bay</DIV></div></html>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
