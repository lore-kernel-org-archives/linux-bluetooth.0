Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44C97AE1.3090908@gmail.com>
Date: Thu, 27 Jul 2006 22:48:01 -0400
From: JP Freeley <jpf321@gmail.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <44C697FF.3040702@gmail.com> <1154051700.7650.18.camel@localhost>
In-Reply-To: <1154051700.7650.18.camel@localhost>
Subject: Re: [Bluez-devel] Can't read local name on hci0: Connection	timed
 out (110)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1758980312=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============1758980312==
Content-Type: multipart/alternative;
	boundary="------------020105030804090203040506"

This is a multi-part message in MIME format.
--------------020105030804090203040506
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Everything seems dandy right now. I re-started everything with a 
completely clean install of debian sid. (Which now has the new 
bluez-utils 3.1-3)

I will try to not bother anyone again. Seems like it was my unkempt 
distro install.

Thanks,

jpf

Marcel Holtmann wrote:
> Hi,
>
>   
>> OK.. so I built from source 3.1 source last night and everything was 
>> going well.
>>
>> Today I come to find this pesky little error:
>>     % hciconfig -a
>>         ......
>>        before REOBOOT
>>        Can't read local name on hci0: Out of available memory space (or 
>> something close to that)
>>        after REBOOT:
>>        Can't read local name on hci0: Connection timed out (110)
>>
>>     ERROR ON CONSOLE:
>>        hci_cmd_task: hci0 command tx timeout
>>
>>     RESULTS OF hcidump -X -V:
>>         HCI sniffer - Bluetooth packet analyzer ver 1.31
>>         device: hci0 snap_len: 1028 filter: 0xffffffff
>>         < HCI Command: Read Local Name (0x03|0x0014) plen 0
>>
>>
>> So I unplugged/replugged the USB  dongle
>>
>>    usb.c: USB disconnect on device 00:0f.4-1 address 2
>>    hub.c: new USB device 00:0f.4-1, assigned address 3
>>
>> and NOW everything is working fine again.
>>
>> Can anyone shed any light on this?
>>     
>
> looks like a strange and broken adapter (what was "hciconfig -a" saying
> again) or simply a bad day.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>   

--------------020105030804090203040506
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Everything seems dandy right now. I re-started everything with a
completely clean install of debian sid. (Which now has the new
bluez-utils 3.1-3)<br>
<br>
I will try to not bother anyone again. Seems like it was my unkempt
distro install. <br>
<br>
Thanks, <br>
<br>
jpf<br>
<br>
Marcel Holtmann wrote:
<blockquote cite="mid1154051700.7650.18.camel@localhost" type="cite">
  <pre wrap="">Hi,

  </pre>
  <blockquote type="cite">
    <pre wrap="">OK.. so I built from source 3.1 source last night and everything was 
going well.

Today I come to find this pesky little error:
    % hciconfig -a
        ......
       before REOBOOT
       Can't read local name on hci0: Out of available memory space (or 
something close to that)
       after REBOOT:
       Can't read local name on hci0: Connection timed out (110)

    ERROR ON CONSOLE:
       hci_cmd_task: hci0 command tx timeout

    RESULTS OF hcidump -X -V:
        HCI sniffer - Bluetooth packet analyzer ver 1.31
        device: hci0 snap_len: 1028 filter: 0xffffffff
        &lt; HCI Command: Read Local Name (0x03|0x0014) plen 0


So I unplugged/replugged the USB  dongle

   usb.c: USB disconnect on device 00:0f.4-1 address 2
   hub.c: new USB device 00:0f.4-1, assigned address 3

and NOW everything is working fine again.

Can anyone shed any light on this?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
looks like a strange and broken adapter (what was "hciconfig -a" saying
again) or simply a bad day.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT &amp; business topics through brief surveys -- and earn cash
<a class="moz-txt-link-freetext" href="http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a>
_______________________________________________
Bluez-devel mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Bluez-devel@lists.sourceforge.net">Bluez-devel@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/bluez-devel">https://lists.sourceforge.net/lists/listinfo/bluez-devel</a>

  </pre>
</blockquote>
</body>
</html>

--------------020105030804090203040506--


--===============1758980312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1758980312==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1758980312==--
