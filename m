Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <5d12691e0606031048o148ad92bre33d6efe2b280560@mail.gmail.com>
Date: Sat, 3 Jun 2006 12:48:17 -0500
From: "Aaron Miller" <armantic101@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1149334394.19311.17.camel@localhost>
MIME-Version: 1.0
References: <5d12691e0606021931hd95b058u38f464d30af8fd56@mail.gmail.com>
	<1149334394.19311.17.camel@localhost>
Subject: Re: [Bluez-users] bluez udev rules for Slackware 10.2
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2078532356=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============2078532356==
Content-Type: multipart/alternative;
	boundary="----=_Part_18381_24197891.1149356897528"

------=_Part_18381_24197891.1149356897528
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for the reply Marcel.

 I'm sorry I wasn't more specific, I didn't realize that there were other
devices then the rfcomm tty device node. This is actually the on I am after
sense it is needed for my device to work with p3nfs.

I have RFCOMM protocol support enabled in the kernel as a modules, and
RFCOMM TTY support hard coded. I had to 'modprobe rfcomm' but the bluetooth
module loaded automatically, both of which are listed in my 'lsmod'. How do
I get udev to create the rfcomm device node? I searched for files containing
"rfcomm" in the bluez build directory but didn't see anything relating to
udev rules. Am I supposed to build this node myself or should udev be
creating it automatically?

Thanks for the help!
...aaron

On 6/3/06, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Aaron,
>
> > First off I have to say I am somewhat of a Linux newbie so I apologize
> > if this question may seem obvious.
> >
> > I am trying to get bluetooth working on my Slackware 10.2 and udev
> > does not seem to be creating any devices for my usb dongle. When I
> > searched google, all I found in regards to the topic was a recent
> > patch which added some new files to the source for udev rules.
> >
> > So I downloaded bluez from the cvs (05/31/2006) and also dbus-0.61
> > since the ./configure was complaining about missing the headers. After
> > installing bluez-libs I built bluez-utils as so:
> >
> > ./configure --prefix=/usr/local --sysconfdir=/etc --localstatedir=/var
> > --enable-all
> > make
> > make install DESTDIR=<temporary build directory>
> >
> > From there I went to my build directory and changed the init script to
> > the Slackware standard (<BuildDIr>/etc/rc.d/rc.bluetooth) and modified
> > the file a bit to reflect these changes. I then proceeded to build
> > into a slack-package and installed it to my system.
> >
> > Now I can run 'sh /etc/rc.d/rc.bluetooth start' just fine and get the
> > following output:
> > Starting Bluetooth subsystem: hcid sdpd hidd hid2hci rfcomm.
> >
> > But still no device from udev.
>
> the Bluetooth subsystem doesn't need any device nodes (except for the
> RFCOMM TTY emulation). It will simply work and "hciconfig -a" should
> show your Bluetooth device.
>
> Regards
>
> Marcel
>
>
>
>
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_18381_24197891.1149356897528
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Thanks for the reply Marcel.<br><br>&nbsp;I'm sorry I wasn't more specific, I didn't realize that there were other devices then the rfcomm tty device node. This is actually the on I am after sense it is needed for my device to work with p3nfs.
<br><br>I have RFCOMM protocol support enabled in the kernel as a modules, and RFCOMM TTY support hard coded. I had to 'modprobe rfcomm' but the bluetooth module loaded automatically, both of which are listed in my 'lsmod'. How do I get udev to create the rfcomm device node? I searched for files containing &quot;rfcomm&quot; in the bluez build directory but didn't see anything relating to udev rules. Am I supposed to build this node myself or should udev be creating it automatically?
<br><br>Thanks for the help!<br>...aaron<br><br><div><span class="gmail_quote">On 6/3/06, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Aaron,<br><br>&gt; First off I have to say I am somewhat of a Linux newbie so I apologize<br>&gt; if this question may seem obvious.<br>&gt;<br>&gt; I am trying to get bluetooth working on my Slackware 10.2 and udev<br>
&gt; does not seem to be creating any devices for my usb dongle. When I<br>&gt; searched google, all I found in regards to the topic was a recent<br>&gt; patch which added some new files to the source for udev rules.<br>&gt;
<br>&gt; So I downloaded bluez from the cvs (05/31/2006) and also dbus-0.61<br>&gt; since the ./configure was complaining about missing the headers. After<br>&gt; installing bluez-libs I built bluez-utils as so:<br>&gt;<br>
&gt; ./configure --prefix=/usr/local --sysconfdir=/etc --localstatedir=/var<br>&gt; --enable-all<br>&gt; make<br>&gt; make install DESTDIR=&lt;temporary build directory&gt;<br>&gt;<br>&gt; From there I went to my build directory and changed the init script to
<br>&gt; the Slackware standard (&lt;BuildDIr&gt;/etc/rc.d/rc.bluetooth) and modified<br>&gt; the file a bit to reflect these changes. I then proceeded to build<br>&gt; into a slack-package and installed it to my system.<br>
&gt;<br>&gt; Now I can run 'sh /etc/rc.d/rc.bluetooth start' just fine and get the<br>&gt; following output:<br>&gt; Starting Bluetooth subsystem: hcid sdpd hidd hid2hci rfcomm.<br>&gt;<br>&gt; But still no device from udev.
<br><br>the Bluetooth subsystem doesn't need any device nodes (except for the<br>RFCOMM TTY emulation). It will simply work and &quot;hciconfig -a&quot; should<br>show your Bluetooth device.<br><br>Regards<br><br>Marcel<br>
<br><br><br><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br>

------=_Part_18381_24197891.1149356897528--


--===============2078532356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2078532356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2078532356==--
