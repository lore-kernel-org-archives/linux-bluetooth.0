Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Alexandre Coser Monteiro" <coser@cos.ufrj.br>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] sniff & pand
Message-Id: <20060407192338.M18487@cos.ufrj.br>
In-Reply-To: <44367EEE.708@csr.com>
References: <Pine.LNX.4.64.0603181246420.738@data.home> <Pine.LNX.4.64.0604020439250.738@data.home> <20060406200923.M10379@cos.ufrj.br> <44367EEE.708@csr.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
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
Date: Fri, 7 Apr 2006 17:26:19 -0200


  
   Thank you for your attention Steven.
   
  With a detailed eye in my sniff command line, I agree whith you that I introduce wrong
parameters, but I still doesn`t understand why a pand connection doesn`t accept my sniff
command line after my correction.
  I`ve been introduced the sniff commando through the linux shell using hcitool

[root@helio script]# hcitool cmd 0x02 0x0003 0x00 0x06 0x00 0x8E 0x25 0x8D 0x25 0x62
0x04 0x62 0X04
< HCI Command: ogf 0x02, ocf 0x0003, plen 11
  00 06 00 8E 25 8E 24 62 04 62 04
> HCI Event: 0x0f plen 4
  02 01 03 08

Sniff Interval = 6 seg.
Sniff Attempt = 0.7 seg.
    Connection handle:  0x0006
    Sniff Max Interval: 0x258E
    Sniff Min Interval: 0x258D
    Sniff Attempts:     0x0062
    Sniff Timeout:      0x0062

The notation for sniff command line is LSB-MSB ? How can I do sniff work in a pand
connection ?
 I work with FedoraCore-3, Linux kernel 2.6.9-1.667smp and a usb bluetooth dongle BT3030
from BroadCom

Sds, 
  Alexandre

On Fri, 07 Apr 2006 16:02:06 +0100, Steven Singer wrote
> Alexandre Coser Monteiro wrote:
> > < HCI Command: ogf 0x02, ocf 0x0003, plen 9
> >  06 10 00 00 10 FF F7 00 07
> > > HCI Event: 0x0f plen 4
> > 12 01 03 08
> 
> The Command Status event shows error code 0x12 = Invalid HCI Command
> Parameters.
> 
> This means that the controller didn't like one of the parameters to the
> sniff mode command.
> 
> The sniff mode command you gave had the parameters:
> 
>    Connection handle:  0x1006
>    Sniff Max Interval: 0x0000
>    Sniff Min Interval: 0xff10
>    Sniff Attempts:     0x00f7
>    Sniff Timeout:      0x??07
> 
> Notes:
> 
>   The connection handle is invalid. The valid range is 0x0000..0x0eff
> 
>   The maximum interval is invalid. The valid range is 0x0002..0xfffe
> 
>   The minimum interval is invalid. The valid range is 0x0002..max
>   interval.
> 
>   The sniff attempts is highly unusual (but not actually invalid).
> 
>   The sniff timeout field is truncated, it should be two bytes.
> 
> So, it's not surprising that the controller is rejecting it.
> 
> Where is the sniff mode command being generated? How is it getting
> through the BlueZ APIs to generate such an invalid event? Are the
> normal APIs being bypassed and is a raw command being sent.
> 
> 	- Steven
> --
> 
> To access the latest news from CSR copy this link into a web browser: 
http://www.csr.com/email_sig.php
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live webcast
> and join the prime developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


--
Sds,
 Alexandre
Tel.:+55 21 9312-7293



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
