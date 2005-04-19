Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42655077.7080609@metalan.net>
From: Andre Baron <andre@metalan.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Apple BT Keyboard and Ubuntu Linux
References: <42649E3C.1080608@metalan.net>	 <1113907413.16233.167.camel@pegasus>  <42654471.7090804@metalan.net> <1113934141.2469.53.camel@pegasus>
In-Reply-To: <1113934141.2469.53.camel@pegasus>
Content-Type: multipart/alternative;
 boundary="------------040001030501090500090509"
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
Date: Tue, 19 Apr 2005 11:39:51 -0700

This is a multi-part message in MIME format.
--------------040001030501090500090509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Marcel Holtmann wrote:

>Hi Andre,
>
>  
>
>>hcidump -X -V gave me an error message that -V was an invalid option. 
>>However I ran it without that option and here's the output.
>>    
>>
>
>install the latest version, because I am not going to decode the HCI
>parts by myself anytime again.
>
>Regards
>
>Marcel
>  
>
Understood, I made sure I grabbed the latest libs and utils as well.
hcidump:

lampshade:/# hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.19
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Write Authentication Enable (0x03|0x0020) plen 1
  0000: 01                                                .
 > HCI Event: Command Complete (0x0e) plen 4
    Write Authentication Enable (0x03|0x0020) ncmd 1
    0000: 00                                                .
< HCI Command: Inquiry (0x01|0x0001) plen 5
    lap 0x9e8b33 len 8 num 0
 > HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
 > HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:0A:95:3E:CC:74 mode 1 clkoffset 0x705c class 0x002540
 > HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0A:95:3E:CC:74 ptype 0xcc18 rswitch 0x01 clkoffset 0x705c 
(valid)
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0A:95:3E:CC:74
 > HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:0A:95:3E:CC:74
 > HCI Event: Connect Complete (0x03) plen 11
    status 0x10 handle 41 bdaddr 00:0A:95:3E:CC:74 type ACL encrypt 0x00
    Error: Connection Accept Timeout Exceeded
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0A:95:3E:CC:74 ptype 0xcc18 rswitch 0x01 clkoffset 0x705c 
(valid)
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0A:95:3E:CC:74
 > HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:0A:95:3E:CC:74
 > HCI Event: Connect Complete (0x03) plen 11
    status 0x10 handle 42 bdaddr 00:0A:95:3E:CC:74 type ACL encrypt 0x00
    Error: Connection Accept Timeout Exceeded

Commands:
lampshade:/etc/network# hciconfig hic0 auth
lampshade:/etc/network# hidd --conn 00:0A:95:3E:CC:74
Can't create HID control channel: Host is down
lampshade:/etc/network# hciconfig hic0 auth
You have new mail in /var/mail/andre
lampshade:/etc/network# hidd --search
Searching ...
        Connecting to device 00:0A:95:3E:CC:74
Can't create HID control channel: Connection timed out
lampshade:/etc/network# hidd --conn 00:0A:95:3E:CC:74
Can't create HID control channel: Connection timed out
lampshade:/etc/network#

Andre
(Hmm... should watch StarTrek TNG while composing emails, thier speach 
infultrates the email)

--------------040001030501090500090509
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Marcel Holtmann wrote:
<blockquote cite="mid1113934141.2469.53.camel@pegasus" type="cite">
  <pre wrap="">Hi Andre,

  </pre>
  <blockquote type="cite">
    <pre wrap="">hcidump -X -V gave me an error message that -V was an invalid option. 
However I ran it without that option and here's the output.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
install the latest version, because I am not going to decode the HCI
parts by myself anytime again.

Regards

Marcel
  </pre>
</blockquote>
Understood, I made sure I grabbed the latest libs and utils as well.<br>
hcidump:<br>
<br>
lampshade:/# hcidump -X -V<br>
HCI sniffer - Bluetooth packet analyzer ver 1.19<br>
device: hci0 snap_len: 1028 filter: 0xffffffff<br>
&lt; HCI Command: Write Authentication Enable (0x03|0x0020) plen 1<br>
&nbsp; 0000: 01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .<br>
&gt; HCI Event: Command Complete (0x0e) plen 4<br>
&nbsp;&nbsp;&nbsp; Write Authentication Enable (0x03|0x0020) ncmd 1<br>
&nbsp;&nbsp;&nbsp; 0000: 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .<br>
&lt; HCI Command: Inquiry (0x01|0x0001) plen 5<br>
&nbsp;&nbsp;&nbsp; lap 0x9e8b33 len 8 num 0<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp;&nbsp;&nbsp; Inquiry (0x01|0x0001) status 0x00 ncmd 1<br>
&gt; HCI Event: Inquiry Result (0x02) plen 15<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:0A:95:3E:CC:74 mode 1 clkoffset 0x705c class 0x002540<br>
&gt; HCI Event: Inquiry Complete (0x01) plen 1<br>
&nbsp;&nbsp;&nbsp; status 0x00<br>
&lt; HCI Command: Create Connection (0x01|0x0005) plen 13<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:0A:95:3E:CC:74 ptype 0xcc18 rswitch 0x01 clkoffset 0x705c
(valid)<br>
&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp;&nbsp;&nbsp; Create Connection (0x01|0x0005) status 0x00 ncmd 1<br>
&gt; HCI Event: Link Key Request (0x17) plen 6<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:0A:95:3E:CC:74<br>
&gt; HCI Event: PIN Code Request (0x16) plen 6<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:0A:95:3E:CC:74<br>
&gt; HCI Event: Connect Complete (0x03) plen 11<br>
&nbsp;&nbsp;&nbsp; status 0x10 handle 41 bdaddr 00:0A:95:3E:CC:74 type ACL encrypt 0x00<br>
&nbsp;&nbsp;&nbsp; Error: Connection Accept Timeout Exceeded<br>
&lt; HCI Command: Create Connection (0x01|0x0005) plen 13<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:0A:95:3E:CC:74 ptype 0xcc18 rswitch 0x01 clkoffset 0x705c
(valid)<br>
&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp;&nbsp;&nbsp; Create Connection (0x01|0x0005) status 0x00 ncmd 1<br>
&gt; HCI Event: Link Key Request (0x17) plen 6<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:0A:95:3E:CC:74<br>
&gt; HCI Event: PIN Code Request (0x16) plen 6<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:0A:95:3E:CC:74<br>
&gt; HCI Event: Connect Complete (0x03) plen 11<br>
&nbsp;&nbsp;&nbsp; status 0x10 handle 42 bdaddr 00:0A:95:3E:CC:74 type ACL encrypt 0x00<br>
&nbsp;&nbsp;&nbsp; Error: Connection Accept Timeout Exceeded<br>
<br>
Commands:<br>
lampshade:/etc/network# hciconfig hic0 auth<br>
lampshade:/etc/network# hidd --conn 00:0A:95:3E:CC:74<br>
Can't create HID control channel: Host is down<br>
lampshade:/etc/network# hciconfig hic0 auth<br>
You have new mail in /var/mail/andre<br>
lampshade:/etc/network# hidd --search<br>
Searching ...<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connecting to device 00:0A:95:3E:CC:74<br>
Can't create HID control channel: Connection timed out<br>
lampshade:/etc/network# hidd --conn 00:0A:95:3E:CC:74<br>
Can't create HID control channel: Connection timed out<br>
lampshade:/etc/network#<br>
<br>
Andre<br>
(Hmm... should watch StarTrek TNG while composing emails, thier speach
infultrates the email)<br>
</body>
</html>

--------------040001030501090500090509--


-------------------------------------------------------
This SF.Net email is sponsored by: New Crystal Reports XI.
Version 11 adds new functionality designed to reduce time involved in
creating, integrating, and deploying reporting solutions. Free runtime info,
new features, or free trial, at: http://www.businessobjects.com/devxi/728
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
