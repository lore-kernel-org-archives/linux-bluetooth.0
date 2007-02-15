Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <dcbc35340702151444r2daece73x6d98f70d19cb92a9@mail.gmail.com>
Date: Thu, 15 Feb 2007 22:44:59 +0000
From: "=?ISO-8859-1?Q?Paulo_Gon=E7alves?=" <paf.goncalves@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1171442378.14869.1.camel@violet>
MIME-Version: 1.0
References: <dcbc35340702131508m11f35e92hb912ccc1a3d087a0@mail.gmail.com>
	<1171442378.14869.1.camel@violet>
Subject: Re: [Bluez-users] help installing bluez 3.9
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0444521185=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0444521185==
Content-Type: multipart/alternative;
	boundary="----=_Part_147046_2460072.1171579499798"

------=_Part_147046_2460072.1171579499798
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

thanks for your help.

I follow your instructions and enabled all the options in the configure
script.
That brought me some problems with package dependencies and I couldn't find
a way to enable input (--enable-input). Gave me a compilation erros during
the make.

But know i have another problem. When i run the startup script this happens:
root@dell:/etc/rc.d# ./rc.bluetooth start
Starting Bluetooth subsystem: hcidCan't open HIDP control socket: No such
file o
r directory
 hidd hid2hci.

then i tried to run the daemon by hand:
root@dell:/etc/rc.d# hcid -s -n
hcid[8966]: Bluetooth HCI daemon
hcid[8966]: Can't connect to system message bus: Failed to connect to socket
/va
r/run/dbus/system_bus_socket: No such file or directory
hcid[8966]: Unable to get on D-Bus

then i tried to run dbus:
root@dell:/etc/rc.d# dbus-launch
DBUS_SESSION_BUS_ADDRESS=unix:abstract=/tmp/dbus-tgLJRkHKME,guid=10bbf88aa0edd6f
92444310045d4df22
DBUS_SESSION_BUS_PID=8772

2 problems here:
   - the bus address should be /var/run/dbus/system_bus_socket as configured
in /etc/dbus-1/system.conf
   - the file =/tmp/dbus-tgLJRkHKME doesn't exists

Can you help me one more time ?


On 2/14/07, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Paulo,
>
> > I just installed bluez 3.9 (patched the kernel and build the modules,
> > installed bluez-libs-3.9 and bluez-utils-3.9)
> > but i can't find the script to start|stop|restart the service
> > (/etc/init.d/bluetooth).
> > Where can I find it ?
>
> by default they are not installed since all distributions provide their
> own. Check "./configure --help" for the correct option.
>
> > After i finish the instalation i checked that the modules ware loaded:
> > root@xxxx:~/bluez-utils-3.9# lsmod
> > Module                  Size  Used by    Not tainted
> > bnep                    8020   0  (autoclean)
> > l2cap                  15120   0  (autoclean) [bnep]
> > hci_usb                 8376   0  (unused)
> > bluez                  27812   1  [bnep l2cap hci_usb]
> >
> > so i run hciconfig:
> > root@xxxx:/etc/bluetooth# /usr/sbin/hciconfig -a
> > hci0:   Type: USB
> >  BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0
> >  DOWN
> >  RX bytes:0 acl:0 sco:0 events:0 errors:0
> >  TX bytes:0 acl:0 sco:0 commands:0 errors:0
> >
> > but where is the BD Address ?
> > and all the other data that i saw in some examples
>
> You have to run "hcid" to bring up the adapter.
>
> > then i run the pan daemon:
> > root@dell:/etc/bluetooth# pand -s -M --role=NAP -n
> > pand[18321]: Bluetooth PAN daemon version 3.9
> > pand[18321]: Failed to connect to the local SDP server. No such file
> > or directory(2)
> >
> > is this error normal ?
>
> You either have to start sdpd or tell hcid with the -s option to act as
> SDP server.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share
> your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_147046_2460072.1171579499798
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Marcel,</div>
<div>&nbsp;</div>
<div>thanks for your help.</div>
<div>&nbsp;</div>
<div>I follow your instructions and enabled all the options in the configure script.</div>
<div>That&nbsp;brought me some problems with package dependencies and I couldn&#39;t find a way to enable input (--enable-input). Gave me a compilation erros during the make.</div>
<div>&nbsp;</div>
<div>But know i have another problem. When i run the startup script this happens:</div>
<div><a href="mailto:root@dell:/etc/rc.d">root@dell:/etc/rc.d</a># ./rc.bluetooth start<br>Starting Bluetooth subsystem: hcidCan&#39;t open HIDP control socket: No such file o<br>r directory<br>&nbsp;hidd hid2hci.</div>
<div>&nbsp;</div>
<div>then i tried to run the daemon by hand:</div>
<div><a href="mailto:root@dell:/etc/rc.d">root@dell:/etc/rc.d</a># hcid -s -n<br>hcid[8966]: Bluetooth HCI daemon<br>hcid[8966]: Can&#39;t connect to system message bus: Failed to connect to socket /va<br>r/run/dbus/system_bus_socket: No such file or directory
<br>hcid[8966]: Unable to get on D-Bus</div>
<div>&nbsp;</div>
<div>then i tried to run dbus:</div>
<div><a href="mailto:root@dell:/etc/rc.d">root@dell:/etc/rc.d</a># dbus-launch<br>DBUS_SESSION_BUS_ADDRESS=unix:abstract=/tmp/dbus-tgLJRkHKME,guid=10bbf88aa0edd6f<br>92444310045d4df22<br>DBUS_SESSION_BUS_PID=8772</div>
<div>&nbsp;</div>
<div>2 problems here:</div>
<div>&nbsp;&nbsp; - the bus address should be /var/run/dbus/system_bus_socket as configured in&nbsp;/etc/dbus-1/system.conf</div>
<div>&nbsp;&nbsp; - the file =/tmp/dbus-tgLJRkHKME doesn&#39;t exists</div>
<div>&nbsp;</div>
<div>Can you help me one more time ?</div>
<div><br>&nbsp;</div>
<div><span class="gmail_quote">On 2/14/07, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Hi Paulo,<br><br>&gt; I just installed bluez 3.9 (patched the kernel and build the modules,<br>&gt; installed 
bluez-libs-3.9 and bluez-utils-3.9)<br>&gt; but i can&#39;t find the script to start|stop|restart the service<br>&gt; (/etc/init.d/bluetooth).<br>&gt; Where can I find it ?<br><br>by default they are not installed since all distributions provide their
<br>own. Check &quot;./configure --help&quot; for the correct option.<br><br>&gt; After i finish the instalation i checked that the modules ware loaded:<br>&gt; root@xxxx:~/bluez-utils-3.9# lsmod<br>&gt; Module&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Size&nbsp;&nbsp;Used by&nbsp;&nbsp;&nbsp;&nbsp;Not tainted
<br>&gt; bnep&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8020&nbsp;&nbsp; 0&nbsp;&nbsp;(autoclean)<br>&gt; l2cap&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;15120&nbsp;&nbsp; 0&nbsp;&nbsp;(autoclean) [bnep]<br>&gt; hci_usb&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 8376&nbsp;&nbsp; 0&nbsp;&nbsp;(unused)<br>&gt; bluez&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;27812&nbsp;&nbsp; 1&nbsp;&nbsp;[bnep l2cap hci_usb]
<br>&gt;<br>&gt; so i run hciconfig:<br>&gt; root@xxxx:/etc/bluetooth# /usr/sbin/hciconfig -a<br>&gt; hci0:&nbsp;&nbsp; Type: USB<br>&gt;&nbsp;&nbsp;BD Address: 00:00:00:00:00:00 ACL MTU: 0:0 SCO MTU: 0:0<br>&gt;&nbsp;&nbsp;DOWN<br>&gt;&nbsp;&nbsp;RX bytes:0 acl:0 sco:0 events:0 errors:0
<br>&gt;&nbsp;&nbsp;TX bytes:0 acl:0 sco:0 commands:0 errors:0<br>&gt;<br>&gt; but where is the BD Address ?<br>&gt; and all the other data that i saw in some examples<br><br>You have to run &quot;hcid&quot; to bring up the adapter.
<br><br>&gt; then i run the pan daemon:<br>&gt; root@dell:/etc/bluetooth# pand -s -M --role=NAP -n<br>&gt; pand[18321]: Bluetooth PAN daemon version 3.9<br>&gt; pand[18321]: Failed to connect to the local SDP server. No such file
<br>&gt; or directory(2)<br>&gt;<br>&gt; is this error normal ?<br><br>You either have to start sdpd or tell hcid with the -s option to act as<br>SDP server.<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------
<br>Take Surveys. Earn Cash. Influence the Future of IT<br>Join SourceForge.net&#39;s Techsay panel and you&#39;ll get the chance to share your<br>opinions on IT &amp; business topics through brief surveys-and earn cash<br>
<a href="http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV">http://www.techsay.com/default.php?page=join.php&amp;p=sourceforge&amp;CID=DEVDEV</a><br>_______________________________________________
<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourceforge.net/lists/listinfo/bluez-users
</a><br></blockquote></div><br>

------=_Part_147046_2460072.1171579499798--


--===============0444521185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0444521185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0444521185==--
