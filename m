Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <BAY104-F26DF0EC77B64C9B3E01302C1670@phx.gbl>
In-Reply-To: <d1f423d3050226200521a6d7a@mail.gmail.com>
From: "blookk -" <blookk@hotmail.com>
To: bluez-users@lists.sourceforge.net
Subject: RE: [Bluez-users] RFCOMM Device
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
Date: Sun, 27 Feb 2005 12:05:34 +0000

<html><div style='background-color:'><DIV class=RTE>
<P>Hello</P>
<P>Have you created the node rfcomm0? It makes with command: <STRONG>mknod -m 666 /dev/rfcomm0 c 216 0.</STRONG></P>
<P>Regards<BR></P></DIV>
<DIV></DIV>&gt;From: Anderson Rodrigues &lt;rodrigues.anderson@gmail.com&gt;
<DIV></DIV>&gt;Reply-To: bluez-users@lists.sourceforge.net
<DIV></DIV>&gt;To: bluez-users@lists.sourceforge.net
<DIV></DIV>&gt;Subject: [Bluez-users] RFCOMM Device
<DIV></DIV>&gt;Date: Sat, 26 Feb 2005 23:05:12 -0500
<DIV></DIV>&gt;
<DIV></DIV>&gt;Hi Folks,
<DIV></DIV>&gt;
<DIV></DIV>&gt;I am new with Bluez&nbsp;&nbsp;and I trying to set up a rfcomm device but the
<DIV></DIV>&gt;/dev/rfcomm0 is not being created or does not exist.
<DIV></DIV>&gt;
<DIV></DIV>&gt;# rfcomm bind 0 aa:aa:aa:aa:aa 1 (works)
<DIV></DIV>&gt;#rfcomm
<DIV></DIV>&gt;rfcomm0: aa:aa:aa:aa:aa clean (is it right?)
<DIV></DIV>&gt;
<DIV></DIV>&gt;but when i try to use pppd it does not work, it does not recognize the
<DIV></DIV>&gt;/dev/rfcomm0
<DIV></DIV>&gt;
<DIV></DIV>&gt;i will appreciate any help
<DIV></DIV>&gt;
<DIV></DIV>&gt;cheers,
<DIV></DIV>&gt;
<DIV></DIV>&gt;--
<DIV></DIV>&gt;Anderson Clayton B. Rodrigues
<DIV></DIV>&gt;Eng. de Software
<DIV></DIV>&gt;Instituto Nokia de Tecnologia - INdT
<DIV></DIV>&gt;
<DIV></DIV>&gt;
<DIV></DIV>&gt;-------------------------------------------------------
<DIV></DIV>&gt;SF email is sponsored by - The IT Product Guide
<DIV></DIV>&gt;Read honest &amp; candid reviews on hundreds of IT Products from real users.
<DIV></DIV>&gt;Discover which products truly live up to the hype. Start reading now.
<DIV></DIV>&gt;http://ads.osdn.com/?ad_id=6595&amp;alloc_id=14396&amp;op=click
<DIV></DIV>&gt;_______________________________________________
<DIV></DIV>&gt;Bluez-users mailing list
<DIV></DIV>&gt;Bluez-users@lists.sourceforge.net
<DIV></DIV>&gt;https://lists.sourceforge.net/lists/listinfo/bluez-users
<DIV></DIV></div></html>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
