Return-Path: <mohalik@india.hp.com>
Message-ID: <4101C6BE.3010707@india.hp.com>
Date: Sat, 24 Jul 2004 07:47:34 +0530
From: Swarup Mohalik <mohalik@india.hp.com>
Reply-To: mohalik@india.hp.com
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] rfcomm
References: <200401302209.52396.raydar@nwlink.com>	 <4100F85D.5080200@india.hp.com> <1090583514.4791.42.camel@pegasus>
Content-Type: multipart/alternative;
 boundary="------------050104010608060808010609"
List-ID: <bluez-users.lists.sourceforge.net>


--------------050104010608060808010609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I have upgraded the bluez-modules. But the problem persists:
To recap,
***********************************************************
Problem:
    lx1 runs rctest -s <bt_addr of lx2>
    lx2 freezes
   
    No problem with l2test.
***********************************************************

The current configuration of lx2 is :

usb dongles twin pack from amazing tech

==================================
Linux RH 8.0 running 2.6.0. kernel
# Bluetooth support
#
CONFIG_BT=m
CONFIG_BT_L2CAP=m
CONFIG_BT_SCO=m
CONFIG_BT_RFCOMM=m
CONFIG_BT_RFCOMM_TTY=y
CONFIG_BT_BNEP=m
CONFIG_BT_BNEP_MC_FILTER=y
CONFIG_BT_BNEP_PROTO_FILTER=y

#
# Bluetooth device drivers
#
CONFIG_BT_HCIUSB=m
CONFIG_BT_USB_SCO=y
# CONFIG_BT_USB_ZERO_PACKET is not set
# CONFIG_BT_HCIUART is not set
# CONFIG_BT_HCIVHCI is not set

[root@ebnt9638 bluetooth]# lsmod
Module                  Size  Used by
hci_usb                17152  2
rfcomm                 45720  0
l2cap                  31232  5 rfcomm
bluetooth              56420  7 hci_usb,rfcomm,l2cap
uhci_hcd               36232  0
ehci_hcd               26880  0


I have the following as well:
bluez-libs-2.8
bluez-utils-2.8
=============================================
hcidump (as root) data:
root@ebnt9638 swarup]# hcidump
HCIDump - HCI packet analyzer ver 1.9
device: hci0 snap_len: 1028 filter: 0xffffffff
 > HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
 > HCI Event: Command Status (0x0f) plen 4
 > HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
 > HCI Event: Max Slots Change (0x1b) plen 3
 > HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
 > HCI Event: Command Status (0x0f) plen 4
 > ACL data: handle 0x0028 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 3 scid 0x0040
 > HCI Event: Connection Packet Type Changed (0x1d) plen 5
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
 > ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1024
< ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
    MTU 1024
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > HCI Event: Number of Completed Packets (0x13) plen 5
 > ACL data: handle 0x0028 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
 > ACL data: handle 0x0028 flags 0x02 dlen 8
    L2CAP(d): cid 0x40 len 4 [psm 3]
      RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c

=============================================
At this point the machine freezes !!

Swarup

Marcel Holtmann wrote:

>Hi Swarup,
>
>  
>
>>I have bluez with bluez-utils-2.7 on two RH 8.0 systems (lx1 and lx2).
>>    
>>
>
>please upgrade to bluez-utils-2.8 first. What kernel do you use?
>
>  
>
>>When I start rctest -r on lx1 without starting rctest -s on lx2, lx2 hangs
>>and I have to switch it off and on to restart. This happens EVERY TIME
>>I try this.
>>    
>>
>
>I don't get the point how lx2 can hang when you listen at lx1. Are these
>two different machines or two dongles connected to the same machine?
>
>  
>
>>This does not happen when I run l2test in any way. Does it prove that
>>there is a problem with RFCOMM? I have not seen this problem in
>>the mailing list. If I have missed it, please inform.
>>    
>>
>
>Actually I don't know. Show us "hcidump -x" from both machines.
>
>Regards
>
>Marcel
>
>
>
>
>-------------------------------------------------------
>This SF.Net email is sponsored by BEA Weblogic Workshop
>FREE Java Enterprise J2EE developer tools!
>Get your free copy of BEA WebLogic Workshop 8.1 today.
>http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
>_______________________________________________
>Bluez-users mailing list
>Bluez-users@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/bluez-users
>
>
>  
>


--------------050104010608060808010609
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body>
I have upgraded the bluez-modules. But the problem persists:<br>
To recap,<br>
***********************************************************<br>
Problem: <br>
&nbsp;&nbsp;&nbsp; lx1 runs rctest -s &lt;bt_addr of lx2&gt;<br>
&nbsp;&nbsp;&nbsp; lx2 freezes<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; No problem with l2test.<br>
***********************************************************<br>
<br>
The current configuration of lx2 is :<br>
<br>
usb dongles twin pack from amazing tech<br>
<br>
==================================<br>
Linux RH 8.0 running 2.6.0. kernel<br>
# Bluetooth support<br>
#<br>
CONFIG_BT=m<br>
CONFIG_BT_L2CAP=m<br>
CONFIG_BT_SCO=m<br>
CONFIG_BT_RFCOMM=m<br>
CONFIG_BT_RFCOMM_TTY=y<br>
CONFIG_BT_BNEP=m<br>
CONFIG_BT_BNEP_MC_FILTER=y<br>
CONFIG_BT_BNEP_PROTO_FILTER=y<br>
<br>
#<br>
# Bluetooth device drivers<br>
#<br>
CONFIG_BT_HCIUSB=m<br>
CONFIG_BT_USB_SCO=y<br>
# CONFIG_BT_USB_ZERO_PACKET is not set<br>
# CONFIG_BT_HCIUART is not set<br>
# CONFIG_BT_HCIVHCI is not set<br>
<br>
[root@ebnt9638 bluetooth]# lsmod<br>
Module&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Size&nbsp; Used by<br>
hci_usb&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 17152&nbsp; 2 <br>
rfcomm&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 45720&nbsp; 0 <br>
l2cap&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 31232&nbsp; 5 rfcomm<br>
bluetooth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 56420&nbsp; 7 hci_usb,rfcomm,l2cap<br>
uhci_hcd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 36232&nbsp; 0 <br>
ehci_hcd&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 26880&nbsp; 0 <br>
<br>
<br>
I have the following as well:<br>
bluez-libs-2.8<br>
bluez-utils-2.8<br>
=============================================<br>
hcidump (as root) data:<br>
root@ebnt9638 swarup]# hcidump<br>
HCIDump - HCI packet analyzer ver 1.9<br>
device: hci0 snap_len: 1028 filter: 0xffffffff<br>
&gt; HCI Event: Connect Request (0x04) plen 10<br>
&lt; HCI Command: Accept Connection Request (0x01|0x0009) plen 7<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&gt; HCI Event: Connect Complete (0x03) plen 11<br>
&lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4<br>
&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>
&gt; HCI Event: Command Complete (0x0e) plen 6<br>
&lt; HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&gt; ACL data: handle 0x0028 flags 0x02 dlen 12<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm 3 scid 0x0040<br>
&gt; HCI Event: Connection Packet Type Changed (0x1d) plen 5<br>
&lt; ACL data: handle 0x0028 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0<br>
&gt; ACL data: handle 0x0028 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4<br>
&nbsp;&nbsp;&nbsp; MTU 1024 <br>
&lt; ACL data: handle 0x0028 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0<br>
&lt; ACL data: handle 0x0028 flags 0x02 dlen 16<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4<br>
&nbsp;&nbsp;&nbsp; MTU 1024 <br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; HCI Event: Number of Completed Packets (0x13) plen 5<br>
&gt; ACL data: handle 0x0028 flags 0x02 dlen 14<br>
&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0<br>
&gt; ACL data: handle 0x0028 flags 0x02 dlen 8<br>
&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x40 len 4 [psm 3]<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RFCOMM(s): SABM: cr 1 dlci 0 pf 1 ilen 0 fcs 0x1c <br>
<br>
=============================================<br>
At this point the machine freezes !!<br>
<br>
Swarup<br>
<br>
Marcel Holtmann wrote:<br>
<blockquote type="cite" cite="mid1090583514.4791.42.camel@pegasus">
  <pre wrap="">Hi Swarup,

  </pre>
  <blockquote type="cite">
    <pre wrap="">I have bluez with bluez-utils-2.7 on two RH 8.0 systems (lx1 and lx2).
    </pre>
  </blockquote>
  <pre wrap=""><!---->
please upgrade to bluez-utils-2.8 first. What kernel do you use?

  </pre>
  <blockquote type="cite">
    <pre wrap="">When I start rctest -r on lx1 without starting rctest -s on lx2, lx2 hangs
and I have to switch it off and on to restart. This happens EVERY TIME
I try this.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
I don't get the point how lx2 can hang when you listen at lx1. Are these
two different machines or two dongles connected to the same machine?

  </pre>
  <blockquote type="cite">
    <pre wrap="">This does not happen when I run l2test in any way. Does it prove that
there is a problem with RFCOMM? I have not seen this problem in
the mailing list. If I have missed it, please inform.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Actually I don't know. Show us "hcidump -x" from both machines.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
<a class="moz-txt-link-freetext" href="http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click">http://ads.osdn.com/?ad_id=4721&amp;alloc_id=10040&amp;op=click</a>
_______________________________________________
Bluez-users mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a>


  </pre>
</blockquote>
<br>
</body>
</html>

--------------050104010608060808010609--
