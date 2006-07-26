Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44C7CB38.2090104@gmail.com>
Date: Wed, 26 Jul 2006 16:06:16 -0400
From: JP Freeley <jpf321@gmail.com>
MIME-Version: 1.0
To: Filippo Giunchedi <filippo@esaurito.net>
References: <44C73308.3010903@gmail.com> <20060726181802.GC6678@esaurito.net>
In-Reply-To: <20060726181802.GC6678@esaurito.net>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Unable to get on on the D-Bus
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1700715875=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============1700715875==
Content-Type: multipart/alternative;
	boundary="------------040800010808030006070603"

This is a multi-part message in MIME format.
--------------040800010808030006070603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Thanks for your reply.

I tried as you suggested:
    # /etc/init.d/dbus restart
    Stopping system message bus: dbus.
    Starting system message bus: dbus.
    # /etc/init.d/bluetooth restart
    Restarting bluetooth: hcid sdpd.

Here is my log (/var/log/daemon.log) (nothing in /var/log/messages)
Jul 27 15:59:36  hcid[1549]: Bluetooth HCI daemon
Jul 27 15:59:36  hcid[1549]: Service could not become the primary owner.
Jul 27 15:59:36  hcid[1549]: Unable to get on D-Bus
Jul 27 15:59:36  sdpd[1551]: Bluetooth SDP daemon

I am happy to try 3.1-3, where will it be available? for "sid"? 
mirrors.kernel.org/debian?

I am unfamliar with "reportbug" so if you point me to the correct place, 
I would be happy to utilize it.

Thanks for your help,

jpf

Filippo Giunchedi wrote:
> Hi,
>
> On Wed, Jul 26, 2006 at 05:16:56AM -0400, JP Freeley wrote:
>   
>> I have moved to the debian "sid" branch as it has 3.1 bluez included.
>>
>> When I first apt-get'd the necessary packages everything seemed to work OK.
>> After REBOOT I am getting the following messages about HCID:
>>
>> Jul 27 03:41:37  hcid[1460]: Bluetooth HCI daemon
>> Jul 27 03:41:37 sdpd[1462]: Bluetooth SDP daemon
>> Jul 27 03:41:37 hcid[1460]: Service could not become the primary owner.
>> Jul 27 03:41:37 hcid[1460]: Unable to get on D-Bus
>> Jul 27 03:41:38 dund[1481]: Bluetooth DUN daemon version 3.1
>>     
>
> try to restart dbus (/etc/init.d/dbus restart) and bluetooth
> (/etc/init.d/bluetooth restart).
> Also could you please retry with 3.1-3 (available from tomorrow I hope).
>
> Last remark: please use the 'reportbug' utility when reporting a bug on a debian
> system: it will go through the proper channels and we can easily keep track of
> them.
>
> thanks,
> filippo
> --
> Filippo Giunchedi - http://esaurito.net
> PGP key: 0x6B79D401
> random quote follows:
>
> What a strange illusion it is to suppose that beauty is goodness.
> -- Lev Tolstoj
>   

--------------040800010808030006070603
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Thanks for your reply. <br>
<br>
I tried as you suggested: <br>
&nbsp;&nbsp;&nbsp; # /etc/init.d/dbus restart<br>
&nbsp;&nbsp;&nbsp; Stopping system message bus: dbus.<br>
&nbsp;&nbsp;&nbsp; Starting system message bus: dbus.<br>
&nbsp;&nbsp;&nbsp; # /etc/init.d/bluetooth restart<br>
&nbsp;&nbsp;&nbsp; Restarting bluetooth: hcid sdpd.<br>
<br>
Here is my log (/var/log/daemon.log) (nothing in /var/log/messages)<br>
Jul 27 15:59:36&nbsp; hcid[1549]: Bluetooth HCI daemon<br>
Jul 27 15:59:36&nbsp; hcid[1549]: Service could not become the primary owner.<br>
Jul 27 15:59:36&nbsp; hcid[1549]: Unable to get on D-Bus<br>
Jul 27 15:59:36&nbsp; sdpd[1551]: Bluetooth SDP daemon <br>
<br>
I am happy to try 3.1-3, where will it be available? for "sid"?
mirrors.kernel.org/debian?<br>
<br>
I am unfamliar with "reportbug" so if you point me to the correct
place, I would be happy to utilize it. <br>
<br>
Thanks for your help,<br>
<br>
jpf<br>
<br>
Filippo Giunchedi wrote:
<blockquote cite="mid20060726181802.GC6678@esaurito.net" type="cite">
  <pre wrap="">Hi,

On Wed, Jul 26, 2006 at 05:16:56AM -0400, JP Freeley wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I have moved to the debian "sid" branch as it has 3.1 bluez included.

When I first apt-get'd the necessary packages everything seemed to work OK.
After REBOOT I am getting the following messages about HCID:

Jul 27 03:41:37  hcid[1460]: Bluetooth HCI daemon
Jul 27 03:41:37 sdpd[1462]: Bluetooth SDP daemon
Jul 27 03:41:37 hcid[1460]: Service could not become the primary owner.
Jul 27 03:41:37 hcid[1460]: Unable to get on D-Bus
Jul 27 03:41:38 dund[1481]: Bluetooth DUN daemon version 3.1
    </pre>
  </blockquote>
  <pre wrap=""><!---->
try to restart dbus (/etc/init.d/dbus restart) and bluetooth
(/etc/init.d/bluetooth restart).
Also could you please retry with 3.1-3 (available from tomorrow I hope).

Last remark: please use the 'reportbug' utility when reporting a bug on a debian
system: it will go through the proper channels and we can easily keep track of
them.

thanks,
filippo
--
Filippo Giunchedi - <a class="moz-txt-link-freetext" href="http://esaurito.net">http://esaurito.net</a>
PGP key: 0x6B79D401
random quote follows:

What a strange illusion it is to suppose that beauty is goodness.
-- Lev Tolstoj
  </pre>
</blockquote>
</body>
</html>

--------------040800010808030006070603--


--===============1700715875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1700715875==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1700715875==--
