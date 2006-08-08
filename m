Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <7b9ca310608071818v5871bb19y2593b7a693ca4ab6@mail.gmail.com>
Date: Mon, 7 Aug 2006 21:18:01 -0400
From: "Michael Ellis" <michael.f.ellis@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1154999049.3905.108.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
References: <7b9ca310608071427nb9b9d28u86251148f66d7bac@mail.gmail.com>
	<1154999049.3905.108.camel@aeonflux.holtmann.net>
Subject: Re: [Bluez-users] dbus-1.pc not found
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0643192425=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0643192425==
Content-Type: multipart/alternative;
	boundary="----=_Part_213284_2287369.1154999881633"

------=_Part_213284_2287369.1154999881633
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,

Thanks! That did the trick and it installed without error.

So, if I may be so bold as to ask a little more help :-),  I now have a
configuration that almost works.  I can plug a DBT-120 dongle into the linux
laptop and it seems to find and initialize it appropriately.  Similarly,  I
can use hcitool -inq and detect the embedded bluetooth device.  When I try
to connect with hcitool cc, I get an input/output error.  FWIW, I'm able to
connect the devices and exchange data if I plug the same dongle into a
Windows box.

Here are the outputs from the hci commands.

bash-3.00$ sudo /usr/sbin/hciconfig -a
hci0:   Type: USB
        BD Address: 00:11:95:50:30:6A ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING
        RX bytes:767 acl:0 sco:0 events:57 errors:0
        TX bytes:513 acl:0 sco:0 commands:35 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:
0x20d
        Manufacturer: Cambridge Silicon Radio (10)


bash-3.00$ hcitool inq
Inquiring ...
        00:0C:84:00:16:51       clock offset: 0x670f    class: 0x000000

bash-3.00$ sudo hcitool cc 00:0C:84:00:16:51
Can't create connection: Input/output error

Any recommendations for troubleshooting?

Thanks for your help.
Mike

On 8/7/06, Marcel Holtmann <marcel@holtmann.org> wrote:
>
> Hi Mike,
>
> > Apologies if this has already been discussed, but I've searched on
> > Google and Gmane and haven't found anything that seems to fit exactly.
> >
> > Trying to configure bluez-utils-3.2 on slackware 10.1 with a 2.6.11
> > kernel,  I get
> >
> > checking for DBUS... Package dbus-1 was not found in the pkg-config
> > search path.
> > Perhaps you should add the directory containing `dbus-1.pc'
> > to the PKG_CONFIG_PATH environment variable
> > No package 'dbus-1' found
> > configure: error: dbus > 0.35 is required
> >
> > Installing dbus-0.91, apparently successfully, does not cure the
> > error.  Is there something I needed to do other than the
> > usual ./configure;  make;  sudo make install?  My dbus executables
> > were installed in /usr/local/bin.
> >
> > I also tried building bluez-utils-3.2 with  ./configure
> > --disable-dbus.  No effect, same error.  FWIW, I'm using the FCE4
> > desktop rather than Gnome or KDE. I mention this because I get the
> > impression the need for dbus is typically associated with Desktop
> > support.
> >
> >  I very much need to get bluez-utils working for simple serial comm to
> > an embedded device and could care less about GUIs.  What's the most
> > straightforward way get past this hurdle?
>
> run "find /usr -name 'dbus*.pc'" to find the actual pkg-config file from
> your D-Bus installation.
>
> Regards
>
> Marcel
>
>
>
> -------------------------------------------------------------------------
> Using Tomcat but need to do more? Need to support web services, security?
> Get stuff done quickly with pre-integrated technology to make your job
> easier
> Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>



-- 
Michael F. Ellis
Managing Partner
Ellis & Grant, Inc.
Make Better Decisions with PeerTool!
http://www.peertools.com

------=_Part_213284_2287369.1154999881633
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel,<br>
<br>
Thanks! That did the trick and it installed without error.&nbsp; <br>
<br>
So, if I may be so bold as to ask a little more help :-),&nbsp; I now
have a configuration that almost works.&nbsp; I can plug a DBT-120
dongle into the linux laptop and it seems to find and initialize it
appropriately.&nbsp; Similarly,&nbsp; I can use hcitool -inq and detect
the embedded bluetooth device.&nbsp; When I try to connect with hcitool
cc, I get an input/output error.&nbsp; FWIW, I'm able to connect the
devices and exchange data if I plug the same dongle into a Windows box.<br>
<br>
Here are the outputs from the hci commands.<br>
<br>
bash-3.00$ sudo /usr/sbin/hciconfig -a<br>
hci0:&nbsp;&nbsp; Type: USB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:11:95:50:30:6A ACL MTU: 192:8 SCO MTU: 64:8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:767 acl:0 sco:0 events:57 errors:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:513 acl:0 sco:0 commands:35 errors:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF PARK <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT <br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'BlueZ (0)'<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x3e0100<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes: Networking, Rendering, Capturing<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Computer, Uncategorized<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver: 0x20d<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Cambridge Silicon Radio (10)<br>
<br>
<br>
bash-3.00$ hcitool
inq&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br>
Inquiring ...<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
00:0C:84:00:16:51&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clock offset:
0x670f&nbsp;&nbsp;&nbsp; class: 0x000000<br>
<br>
bash-3.00$ sudo hcitool cc 00:0C:84:00:16:51<br>
Can't create connection: Input/output error<br>
<br>
Any recommendations for troubleshooting?<br>
<br>
Thanks for your help.<br>
Mike<br><br><div><span class="gmail_quote">On 8/7/06, <b class="gmail_sendername">Marcel Holtmann</b> &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Mike,<br><br>&gt; Apologies if this has already been discussed, but I've searched on<br>&gt; Google and Gmane and haven't found anything that seems to fit exactly.<br>&gt;<br>&gt; Trying to configure bluez-utils-3.2 on slackware 
10.1 with a 2.6.11<br>&gt; kernel,&nbsp;&nbsp;I get<br>&gt;<br>&gt; checking for DBUS... Package dbus-1 was not found in the pkg-config<br>&gt; search path.<br>&gt; Perhaps you should add the directory containing `dbus-1.pc'<br>&gt; to the PKG_CONFIG_PATH environment variable
<br>&gt; No package 'dbus-1' found<br>&gt; configure: error: dbus &gt; 0.35 is required<br>&gt;<br>&gt; Installing dbus-0.91, apparently successfully, does not cure the<br>&gt; error.&nbsp;&nbsp;Is there something I needed to do other than the
<br>&gt; usual ./configure;&nbsp;&nbsp;make;&nbsp;&nbsp;sudo make install?&nbsp;&nbsp;My dbus executables<br>&gt; were installed in /usr/local/bin.<br>&gt;<br>&gt; I also tried building bluez-utils-3.2 with&nbsp;&nbsp;./configure<br>&gt; --disable-dbus.&nbsp;&nbsp;No effect, same error.&nbsp;&nbsp;FWIW, I'm using the FCE4
<br>&gt; desktop rather than Gnome or KDE. I mention this because I get the<br>&gt; impression the need for dbus is typically associated with Desktop<br>&gt; support.<br>&gt;<br>&gt;&nbsp;&nbsp;I very much need to get bluez-utils working for simple serial comm to
<br>&gt; an embedded device and could care less about GUIs.&nbsp;&nbsp;What's the most<br>&gt; straightforward way get past this hurdle?<br><br>run &quot;find /usr -name 'dbus*.pc'&quot; to find the actual pkg-config file from<br>your D-Bus installation.
<br><br>Regards<br><br>Marcel<br><br><br><br>-------------------------------------------------------------------------<br>Using Tomcat but need to do more? Need to support web services, security?<br>Get stuff done quickly with pre-integrated technology to make your job easier
<br>Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo<br><a href="http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642">http://sel.as-us.falkag.net/sel?cmd=lnk&amp;kid=120709&amp;bid=263057&amp;dat=121642
</a><br>_______________________________________________<br>Bluez-users mailing list<br><a href="mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br><a href="https://lists.sourceforge.net/lists/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br></blockquote></div><br><br clear="all"><br>-- <br>Michael F. Ellis<br>Managing Partner<br>Ellis &amp; Grant, Inc.<br>Make Better Decisions with PeerTool!<br>
<a href="http://www.peertools.com">http://www.peertools.com</a>

------=_Part_213284_2287369.1154999881633--


--===============0643192425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0643192425==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0643192425==--
